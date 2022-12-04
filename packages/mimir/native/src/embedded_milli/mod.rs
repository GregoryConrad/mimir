use std::{collections::HashMap, fs, path::Path};

use anyhow::Result;
use lazy_static::lazy_static;
use milli_v1::heed;
use parking_lot::RwLock;

use crate::api::{Filter, MimirIndexSettings, SortBy, TermsMatchingStrategy};

// The available implementations of embedded milli
mod v1;

// The following need to be updated whenever a new embedded milli is available
use milli_v1::Index;
use v1::EmbeddedMilli as CurrEmbeddedMilli;
const CURR_EMBEDDED_MILLI_VERSION: u32 = 1;
fn get_milli_dump_function(milli_version: u32) -> fn(&Path) -> Result<Dump> {
    match milli_version {
        1 => v1::EmbeddedMilli::create_dump,
        _ => panic!("Forgot to add new version into get_milli_dump_function!"),
    }
}

/// Represents a document in a milli index
pub(crate) type Document = serde_json::Map<String, serde_json::Value>;

// Represents a dump from a milli index
type Dump = (MimirIndexSettings, Vec<Document>);

// This is 2^30, so it will be a multiple of whatever the system page size is
const MAX_MAP_SIZE: usize = 1_073_741_824;

/// Defines what an embedded instance of milli should be able to do.
/// Essentially a wrapper around different versions of milli to expose a common API.
pub(crate) trait EmbeddedMilli<Index> {
    fn create_index(dir: &Path) -> Result<Index>;

    fn add_documents(index: &Index, documents: Vec<Document>) -> Result<()>;

    fn delete_documents(index: &Index, document_ids: Vec<String>) -> Result<()>;

    fn delete_all_documents(index: &Index) -> Result<()>;

    fn set_documents(index: &Index, documents: Vec<Document>) -> Result<()>;

    fn get_document(index: &Index, document_id: String) -> Result<Option<Document>>;

    fn get_all_documents(index: &Index) -> Result<Vec<Document>>;

    fn search_documents(
        index: &Index,
        query: Option<String>,
        limit: Option<u32>,
        sort_criteria: Option<Vec<SortBy>>,
        filter: Option<Filter>,
        matching_strategy: Option<TermsMatchingStrategy>,
    ) -> Result<Vec<Document>>;

    fn get_settings(index: &Index) -> Result<MimirIndexSettings>;

    fn set_settings(index: &Index, settings: MimirIndexSettings) -> Result<()>;

    fn create_dump(dir: &Path) -> Result<Dump>;

    fn import_dump(dir: &Path, dump: Dump) -> Result<()>;
}

lazy_static! {
    /// The mapping of instance paths (directories) to instances
    static ref INSTANCES: RwLock<HashMap<String, Instance>> = RwLock::new(HashMap::new());
}

struct Instance {
    env: heed::Env,
    indexes: HashMap<String, RwLock<Index>>,
    index_milli_versions: heed::Database<heed::types::Str, heed::types::OwnedType<u32>>,
}

impl Instance {
    const INSTANCE_DATA_DB_DIR_NAME: &str = "mimir_instance_data.mdb";
    const INDEX_MILLI_VERSIONS_DB_NAME: &str = "index_versions";

    fn new(instance_dir: &str) -> Result<Self> {
        let path = Path::new(instance_dir).join(Self::INSTANCE_DATA_DB_DIR_NAME);
        fs::create_dir_all(&path)?;
        let env = heed::EnvOpenOptions::new()
            .map_size(MAX_MAP_SIZE)
            .max_dbs(128)
            .max_readers(4096)
            .open(&path)?;

        Ok(Self {
            indexes: HashMap::new(),
            index_milli_versions: env.create_database(Some(Self::INDEX_MILLI_VERSIONS_DB_NAME))?,
            env,
        })
    }

    fn milli_index_version(&self, index_name: &str) -> Result<Option<u32>> {
        let rtxn = self.env.read_txn()?;
        self.index_milli_versions
            .get(&rtxn, index_name)
            .map_err(anyhow::Error::from)
    }

    // &mut self so that we are forced to grab write lock to use this method
    fn update_milli_index_version(&mut self, index_name: &str) -> Result<()> {
        let mut wtxn = self.env.write_txn()?;
        self.index_milli_versions
            .put(&mut wtxn, index_name, &CURR_EMBEDDED_MILLI_VERSION)?;
        wtxn.commit().map_err(anyhow::Error::from)
    }
}

pub(crate) fn ensure_instance_initialized(instance_dir: &str) -> Result<()> {
    let instances = INSTANCES.read();

    // If this instance does not yet exist, create it
    if !instances.contains_key(instance_dir) {
        drop(instances); // prevent deadlock with the prev read lock and now write lock
        let mut instances = INSTANCES.write();

        // Perhaps the instance was initialized while we were waiting to get the lock
        // Now that we have the write lock, check that we actually need to do anything
        if !instances.contains_key(instance_dir) {
            fs::create_dir_all(instance_dir)?;
            instances.insert(instance_dir.to_string(), Instance::new(instance_dir)?);
        }
    }

    Ok(())
}

fn ensure_index_migrated(instance_dir: &str, index_name: &str) -> Result<()> {
    let instances = INSTANCES.read();
    let instance = instances.get(instance_dir).unwrap();
    let milli_version = instance.milli_index_version(index_name)?;
    match milli_version {
        Some(CURR_EMBEDDED_MILLI_VERSION) => Ok(()), // already at latest version
        None => {
            // Registering a new index, let's put it in the database
            drop(instances);
            let mut instances = INSTANCES.write();
            let instance = instances.get_mut(instance_dir).unwrap();
            instance.update_milli_index_version(index_name)
        }
        Some(old_milli_version) => {
            // Index using an old version of milli, let's migrate it to the latest
            drop(instances);
            let mut instances = INSTANCES.write();
            let instance = instances.get_mut(instance_dir).unwrap();

            // First, let's check to see if the index was already migrated
            // while we were waiting for the write lock
            if Some(CURR_EMBEDDED_MILLI_VERSION) == instance.milli_index_version(index_name)? {
                return Ok(());
            }

            // Let's perform the migration!
            let path = Path::new(instance_dir).join(index_name);
            let backup_path = Path::new(instance_dir).join(index_name.to_string() + ".mimir_bak");
            let migration_status: Result<()> = (|| {
                let dump = get_milli_dump_function(old_milli_version)(&path)?;

                fs::rename(&path, &backup_path)?; // create backup of old version
                fs::create_dir_all(&path)?; // create directory again for new (current) version

                CurrEmbeddedMilli::import_dump(&path, dump)?;
                instance.update_milli_index_version(index_name)?;
                Ok(())
            })();

            // Perform some cleanup based on the status of the migration
            match migration_status {
                // If all went well, delete the backup
                Ok(_) => {
                    _ = fs::remove_dir_all(&backup_path);
                }
                // If migration failed, restore the backup
                Err(_) => {
                    if backup_path.is_dir() {
                        _ = fs::remove_dir_all(&path); // in case we failed after the rename
                        _ = fs::rename(&backup_path, &path);
                    }
                }
            };

            migration_status
        }
    }
}

pub(crate) fn ensure_index_initialized(instance_dir: &str, index_name: &str) -> Result<()> {
    ensure_instance_initialized(instance_dir)?;
    ensure_index_migrated(instance_dir, index_name)?;

    // If this index does not yet exist in memory or on disk, create it
    let instances = INSTANCES.read();
    let indexes = &instances.get(instance_dir).unwrap().indexes;
    if !indexes.contains_key(index_name) {
        drop(instances); // prevent deadlock with the prev read lock and now write lock
        let mut instances = INSTANCES.write();
        let indexes = &mut instances.get_mut(instance_dir).unwrap().indexes;

        // Perhaps the index was initialized while we were waiting to get the lock
        // Now that we have the write lock, check that we actually need to do anything
        if !indexes.contains_key(index_name) {
            let path = Path::new(instance_dir).join(index_name);
            fs::create_dir_all(&path)?;
            let mut options = heed::EnvOpenOptions::new();
            options.map_size(MAX_MAP_SIZE);
            let index = Index::new(options, &path)?;
            indexes.insert(index_name.to_string(), RwLock::new(index));
        }
    }

    Ok(())
}

fn run_with_index_lock<T>(
    instance_dir: &str,
    index_name: &str,
    to_run: impl FnOnce(&RwLock<Index>) -> Result<T>,
) -> Result<T> {
    ensure_index_initialized(instance_dir, index_name)?;
    let instances = INSTANCES.read();
    let instance = instances.get(instance_dir).unwrap();
    let index_lock = instance.indexes.get(index_name).unwrap();
    to_run(index_lock)
}

pub(crate) fn add_documents(
    instance_dir: &str,
    index_name: &str,
    documents: Vec<Document>,
) -> Result<()> {
    run_with_index_lock(instance_dir, index_name, |index_lock| {
        CurrEmbeddedMilli::add_documents(&index_lock.write(), documents)
    })
}

pub(crate) fn delete_documents(
    instance_dir: &str,
    index_name: &str,
    document_ids: Vec<String>,
) -> Result<()> {
    run_with_index_lock(instance_dir, index_name, |index_lock| {
        CurrEmbeddedMilli::delete_documents(&index_lock.write(), document_ids)
    })
}

pub(crate) fn delete_all_documents(instance_dir: &str, index_name: &str) -> Result<()> {
    run_with_index_lock(instance_dir, index_name, |index_lock| {
        CurrEmbeddedMilli::delete_all_documents(&index_lock.write())
    })
}

pub(crate) fn set_documents(
    instance_dir: &str,
    index_name: &str,
    documents: Vec<Document>,
) -> Result<()> {
    run_with_index_lock(instance_dir, index_name, |index_lock| {
        CurrEmbeddedMilli::set_documents(&index_lock.write(), documents)
    })
}

pub(crate) fn get_document(
    instance_dir: &str,
    index_name: &str,
    document_id: String,
) -> Result<Option<Document>> {
    run_with_index_lock(instance_dir, index_name, |index_lock| {
        CurrEmbeddedMilli::get_document(&index_lock.read(), document_id)
    })
}

pub(crate) fn get_all_documents(instance_dir: &str, index_name: &str) -> Result<Vec<Document>> {
    run_with_index_lock(instance_dir, index_name, |index_lock| {
        CurrEmbeddedMilli::get_all_documents(&index_lock.read())
    })
}

pub(crate) fn search_documents(
    instance_dir: &str,
    index_name: &str,
    query: Option<String>,
    limit: Option<u32>,
    sort_criteria: Option<Vec<SortBy>>,
    filter: Option<Filter>,
    matching_strategy: Option<TermsMatchingStrategy>,
) -> Result<Vec<Document>> {
    run_with_index_lock(instance_dir, index_name, |index_lock| {
        CurrEmbeddedMilli::search_documents(
            &index_lock.read(),
            query,
            limit,
            sort_criteria,
            filter,
            matching_strategy,
        )
    })
}

pub(crate) fn get_settings(instance_dir: &str, index_name: &str) -> Result<MimirIndexSettings> {
    run_with_index_lock(instance_dir, index_name, |index_lock| {
        CurrEmbeddedMilli::get_settings(&index_lock.read())
    })
}

pub(crate) fn set_settings(
    instance_dir: &str,
    index_name: &str,
    settings: MimirIndexSettings,
) -> Result<()> {
    run_with_index_lock(instance_dir, index_name, |index_lock| {
        CurrEmbeddedMilli::set_settings(&index_lock.write(), settings)
    })
}
