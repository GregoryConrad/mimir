use std::{
    collections::HashMap,
    fs::create_dir_all,
    io::Cursor,
    path::Path,
    sync::{Mutex, RwLock},
};

use anyhow::Result;
use lazy_static::lazy_static;
use milli::{
    documents::{DocumentsBatchBuilder, DocumentsBatchReader},
    heed::EnvOpenOptions,
    update::{IndexDocuments, IndexDocumentsConfig, IndexDocumentsMethod, IndexerConfig},
    Index,
};

lazy_static! {
    /// The mapping of instance paths (directories) to instances.
    static ref INSTANCES: RwLock<HashMap<String, Instance>> = RwLock::new(HashMap::new());
}

struct Instance {
    indexes: RwLock<HashMap<String, Mutex<Index>>>,
}

/// Ensures an instance of milli (represented by just a directory) is initialized.
pub fn ensure_instance_initialized(instance_dir: String) -> Result<()> {
    let instances = INSTANCES.read().unwrap();

    // If this instance does not yet exist, create it
    if !instances.contains_key(&instance_dir) {
        let mut instances = INSTANCES.write().unwrap();
        create_dir_all(&instance_dir)?;
        let new_instance = Instance {
            indexes: RwLock::new(HashMap::new()),
        };
        instances.insert(instance_dir.clone(), new_instance);
    }

    Ok(())
}

/// Ensures a milli index is initialized.
pub fn ensure_index_initialized(instance_dir: String, index_name: String) -> Result<()> {
    ensure_instance_initialized(instance_dir.clone())?;
    let instances = INSTANCES.read().unwrap();
    let instance = instances.get(&instance_dir).unwrap();
    let indexes = instance.indexes.read().unwrap();

    if !indexes.contains_key(&index_name) {
        let mut indexes = instance.indexes.write().unwrap();
        let path = Path::new(&instance_dir).join(&index_name);
        let options = EnvOpenOptions::new();
        let index = Index::new(options, &path).unwrap();
        indexes.insert(index_name.clone(), Mutex::new(index));
    }

    Ok(())
}

macro_rules! get_instances {
    () => {
        INSTANCES.read().unwrap()
    };
}

macro_rules! get_indexes {
    ($instances:ident, $instance_dir:ident) => {
        $instances
            .get(&$instance_dir)
            .unwrap()
            .indexes
            .read()
            .unwrap()
    };
}

macro_rules! get_index {
    ($instance:ident, $index_name:ident) => {
        $instance.get(&$index_name).unwrap().lock().unwrap()
    };
}

/// Adds the given list of documents to the specified milli index.
/// Replaces documents that already exist in the index based on document ids.
pub fn add_documents(
    instance_dir: String,
    index_name: String,
    json_documents: Vec<String>,
) -> Result<()> {
    ensure_index_initialized(instance_dir.clone(), index_name.clone())?;
    let instances = get_instances!();
    let indexes = get_indexes!(instances, instance_dir);
    let index = get_index!(indexes, index_name);

    // Create a batch builder to convert json_documents into milli's format
    let mut builder = DocumentsBatchBuilder::new(Vec::new());
    for doc in json_documents.iter() {
        let doc: serde_json::Value = serde_json::from_str(&doc)?;
        let doc = doc
            .as_object()
            .ok_or(anyhow::Error::msg(
                "A json document was not Map<String, dynamic>",
            ))?
            .clone();
        builder.append_json_object(&doc)?;
    }

    // Flush the contents of the builder and retreive the buffer to make a batch reader
    let buff = builder.into_inner()?;
    let reader = DocumentsBatchReader::from_reader(Cursor::new(buff))?;

    // Create the configs needed for the batch document addition
    let indexer_config = IndexerConfig::default();
    let indexing_config = IndexDocumentsConfig {
        update_method: IndexDocumentsMethod::ReplaceDocuments,
        ..Default::default()
    };

    // Make an index write transaction with a batch step to index the new documents
    let mut wtxn = index.write_txn()?;
    IndexDocuments::new(
        &mut wtxn,
        &index,
        &indexer_config,
        indexing_config,
        |_| (),
        || false,
    )?
    .add_documents(reader)
    .map(|t| t.0)?
    .execute()?;
    wtxn.commit()?;

    Ok(())
}

// TODO other methods on index
