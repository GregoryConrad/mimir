use std::{collections::HashMap, fs, path::Path};

use anyhow::Result;
use lazy_static::lazy_static;
use milli_v1::heed;
use parking_lot::RwLock;

use crate::api;

// The available implementations of embedded milli
mod v1;

/// The current embedded milli implementation
pub type CurrEmbeddedMilli = v1::EmbeddedMilli;
const CURR_EMBEDDED_MILLI_VERSION: u32 = 1;
fn get_milli_dump_function(milli_version: u32) -> fn(&str, &str) -> Result<MilliDump> {
    match milli_version {
        1 => v1::EmbeddedMilli::dump,
        _ => panic!("Forgot to add new version into get_milli_dump_function!"),
    }
}

/// Represents a document in a milli index
pub type Document = serde_json::Map<String, serde_json::Value>;

// This is 2^30, so it will be a multiple of whatever the system page size is
const MAX_MAP_SIZE: usize = 1_073_741_824;

// Represents a dump from a milli index
type MilliDump = (api::MimirIndexSettings, Vec<Document>);

/// Defines what an embedded instance of milli should be able to do.
/// Essentially a wrapper around different versions of milli to expose a common API.
pub trait EmbeddedMilli {
    /// Implementers of this method *must* call super::ensure_instance_dbs_initialized first!
    fn ensure_instance_initialized(instace_dir: &str) -> Result<()>;

    /// Implementers of this method *must* call super::ensure_index_migrated first!
    fn ensure_index_initialized(instance_dir: &str, index_name: &str) -> Result<()>;

    fn add_documents(
        instance_dir: String,
        index_name: String,
        documents: Vec<Document>,
    ) -> Result<()>;

    fn delete_documents(
        instance_dir: String,
        index_name: String,
        document_ids: Vec<String>,
    ) -> Result<()>;

    fn delete_all_documents(instance_dir: String, index_name: String) -> Result<()>;

    fn set_documents(
        instance_dir: String,
        index_name: String,
        documents: Vec<Document>,
    ) -> Result<()>;

    fn get_document(
        instance_dir: String,
        index_name: String,
        document_id: String,
    ) -> Result<Option<Document>>;

    fn get_all_documents(instance_dir: String, index_name: String) -> Result<Vec<Document>>;

    fn search_documents(
        instance_dir: String,
        index_name: String,
        query: Option<String>,
        limit: Option<u32>,
        sort_criteria: Option<Vec<api::SortBy>>,
        filter: Option<api::Filter>,
        matching_strategy: Option<api::TermsMatchingStrategy>,
    ) -> Result<Vec<Document>>;

    fn get_settings(instance_dir: String, index_name: String) -> Result<api::MimirIndexSettings>;

    fn set_settings(
        instance_dir: String,
        index_name: String,
        settings: api::MimirIndexSettings,
    ) -> Result<()>;

    fn dump(instance_dir: &str, index_name: &str) -> Result<MilliDump>;

    fn import_dump(instance_dir: &str, index_name: &str, dump: MilliDump) -> Result<()>;
}

lazy_static! {
    /// A mapping of each instance to the InstaceDbs for that instance.
    /// Holds information like the milli version of each index (needed for migration).
    static ref INSTANCES_DBS: RwLock<HashMap<String, RwLock<InstanceDbs>>> = RwLock::new(HashMap::new());
}

/// Ensures an instance's InstanceDbs is initialized
fn ensure_instance_dbs_initialized(instance_dir: &str) -> Result<()> {
    // First, check to see if we need to attempt to make any changes
    let instances_dbs = INSTANCES_DBS.read();
    if !instances_dbs.contains_key(instance_dir) {
        // Second, let's drop our read lock and grab a write lock to make changes
        drop(instances_dbs);
        let mut instances_dbs = INSTANCES_DBS.write();

        // Third, check to see if we still need to initialize the databases, because
        // instances_dbs could have changed while we were wating for the write lock
        if !instances_dbs.contains_key(instance_dir) {
            instances_dbs.insert(
                instance_dir.to_string(),
                RwLock::new(InstanceDbs::new(instance_dir)?),
            );
        }
    }
    Ok(())
}

/// Ensures an instance's index is migrated to the latest version
fn ensure_index_migrated(instance_dir: &str, index_name: &str) -> Result<()> {
    ensure_instance_dbs_initialized(instance_dir)?;
    let instances_dbs = INSTANCES_DBS.read();
    let instance_dbs_lock = instances_dbs.get(instance_dir).unwrap();
    let instance_dbs = instance_dbs_lock.read();
    let milli_version = instance_dbs.milli_index_version(index_name)?;

    match milli_version {
        Some(CURR_EMBEDDED_MILLI_VERSION) => Ok(()), // already at latest version
        None => {
            // Registering a new index, let's put it in the database
            drop(instance_dbs);
            let mut instance_dbs = instance_dbs_lock.write();
            instance_dbs.update_milli_index_version(index_name)
        }
        Some(old_milli_version) => {
            // Index using an old version of milli, let's migrate it to the latest
            drop(instance_dbs);
            let mut instance_dbs = instance_dbs_lock.write();

            // First, let's check to see if it wasn't already migrated
            // while we were waiting for the write lock
            if Some(CURR_EMBEDDED_MILLI_VERSION) == instance_dbs.milli_index_version(index_name)? {
                return Ok(());
            }

            // Let's perform the migration!
            let path = Path::new(instance_dir).join(index_name);
            let backup_path = Path::new(instance_dir).join(index_name.to_string() + ".mimir_bak");
            let migration_status: Result<()> = (|| {
                let dump = get_milli_dump_function(old_milli_version)(instance_dir, index_name)?;

                fs::rename(&path, &backup_path)?; // create backup of old version
                fs::create_dir_all(&path)?; // create directory again for new (current) version

                CurrEmbeddedMilli::import_dump(instance_dir, index_name, dump)?;
                instance_dbs.update_milli_index_version(index_name)?;
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

struct InstanceDbs {
    env: heed::Env,
    index_milli_versions: heed::Database<heed::types::Str, heed::types::OwnedType<u32>>,
}

impl InstanceDbs {
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
        Ok(InstanceDbs {
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

pub trait StringExt {
    fn to_document(&self) -> Result<Document>;
}

impl StringExt for String {
    fn to_document(&self) -> Result<Document> {
        serde_json::from_str(self).map_err(anyhow::Error::from)
    }
}

pub trait DocumentExt {
    fn to_string(&self) -> Result<String>;
}

impl DocumentExt for Document {
    fn to_string(&self) -> Result<String> {
        serde_json::to_string(self).map_err(anyhow::Error::from)
    }
}
