use std::{fs::create_dir_all, path::Path};

use anyhow::Result;

use crate::api;

// The available implementations of embedded milli
mod v1;

/// The current embedded milli implementation
pub type CurrEmbeddedMilli = crate::embedded_milli::v1::EmbeddedMilli;

/// The current embedded milli implementation version number
const CURR_EMBEDDED_MILLI_VERSION: u32 = 1;

use milli::heed;

/// Represents a document in a milli index
pub type Document = serde_json::Map<String, serde_json::Value>;

/// Defines what an embedded instance of milli should be able to do
pub trait EmbeddedMilli {
    fn ensure_instance_initialized(instace_dir: &str) -> Result<()>;
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

// This is 2^30, so it will be a multiple of whatever the system page size is
const MAX_MAP_SIZE: usize = 1_073_741_824;

fn _messin_around(instance_dir: &str) -> Result<()> {
    const INSTANCE_DB_DIR_NAME: &str = "mimir_instance_data.mdb";
    const INSTANCE_U32_OPTS_DB_NAME: &str = "u32_options";
    const INSTANCE_MILLI_VERSION_KEY: &str = "milli_version";

    let path = Path::new(instance_dir).join(INSTANCE_DB_DIR_NAME);
    create_dir_all(&path)?;
    let env = heed::EnvOpenOptions::new()
        .map_size(MAX_MAP_SIZE)
        .max_dbs(128)
        .max_readers(4096)
        .open(&path)?;
    let db: heed::Database<heed::types::Str, heed::types::OwnedType<u32>> =
        env.create_database(Some(INSTANCE_U32_OPTS_DB_NAME))?;

    let mut wtxn = env.write_txn()?;
    db.put(
        &mut wtxn,
        INSTANCE_MILLI_VERSION_KEY,
        &CURR_EMBEDDED_MILLI_VERSION,
    )?;
    wtxn.commit()?;

    let rtxn = env.read_txn()?;
    let milli_version = db.get(&rtxn, INSTANCE_MILLI_VERSION_KEY)?;
    assert_eq!(milli_version, Some(3));

    Ok(())
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
