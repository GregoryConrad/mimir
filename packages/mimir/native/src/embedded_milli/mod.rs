use std::{collections::HashMap, fs::create_dir_all, path::Path};

use anyhow::Result;
use lazy_static::lazy_static;
use milli::heed;
use parking_lot::RwLock;

use crate::api;

// The available implementations of embedded milli
mod v1;

/// The current embedded milli implementation
pub type CurrEmbeddedMilli = crate::embedded_milli::v1::EmbeddedMilli;
const CURR_EMBEDDED_MILLI_VERSION: u32 = 1;

/// Represents a document in a milli index
pub type Document = serde_json::Map<String, serde_json::Value>;

// This is 2^30, so it will be a multiple of whatever the system page size is
const MAX_MAP_SIZE: usize = 1_073_741_824;

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
}

lazy_static! {
    /// A mapping of each instance to the InstaceDbs for that instance.
    /// Holds information like the milli version of each index (needed for migration).
    static ref INSTANCES_DBS: RwLock<HashMap<String, InstanceDbs>> = RwLock::new(HashMap::new());
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
            instances_dbs.insert(instance_dir.to_string(), InstanceDbs::new(instance_dir)?);
        }
    }
    Ok(())
}

/// Ensures an instance's index is migrated to the latest version
fn ensure_index_migrated(instance_dir: &str, index_name: &str) -> Result<()> {
    ensure_instance_dbs_initialized(instance_dir)?;
    // TODO ensure thread safety here.
    // if index not in db, add it and we done!
    // if index in db, check to see if latest version
    // if latest version, we done!
    // if not latest version, perform migration
    todo!();
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
        create_dir_all(&path)?;

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

    fn _messin_around(&self) -> Result<()> {
        let mut wtxn = self.env.write_txn()?;
        let db = self.index_milli_versions;
        db.put(&mut wtxn, "some index name", &CURR_EMBEDDED_MILLI_VERSION)?;
        wtxn.commit()?;

        let rtxn = self.env.read_txn()?;
        let milli_version = db.get(&rtxn, "some index name")?;
        assert_eq!(milli_version, Some(3));

        Ok(())
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
