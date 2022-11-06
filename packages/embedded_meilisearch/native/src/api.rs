use std::{
    collections::HashMap,
    fs::create_dir_all,
    path::Path,
    sync::{Mutex, RwLock},
};

use anyhow::Result;
use lazy_static::lazy_static;
use milli::{heed::EnvOpenOptions, Index};

lazy_static! {
    /// The mapping of instance paths (directories) to instances
    static ref INSTANCES: RwLock<HashMap<String, Instance>> = RwLock::new(HashMap::new());
}

struct Instance {
    indexes: RwLock<HashMap<String, Mutex<Index>>>,
}

/// Ensures an instance of milli (represented by just a directory) is initialized
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

/// Ensures a milli index is initialized
pub fn ensure_index_initialized(instance_dir: String, index_name: String) -> Result<()> {
    ensure_instance_initialized(instance_dir.clone())?;
    let instances = INSTANCES.read().unwrap();
    let instance = instances.get(&instance_dir).unwrap();
    let mut indexes = instance.indexes.write().unwrap();

    let path = Path::new(&instance_dir).join(&index_name);
    let options = EnvOpenOptions::new();
    let index = Index::new(options, &path).unwrap();
    indexes.insert(index_name.clone(), Mutex::new(index));

    Ok(())
}

// TODO init index
// TODO methods on index
