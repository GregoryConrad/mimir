use std::{collections::HashMap, fs::create_dir_all, sync::Mutex};

use anyhow::Result;
use lazy_static::lazy_static;

lazy_static! {
    /// The mapping of paths to instances
    static ref INSTANCES: Mutex<HashMap<String, Instance>> = Mutex::new(HashMap::new());
}

struct Index {}

struct Instance {
    indexes: Mutex<HashMap<String, Mutex<Index>>>,
}

/// Initializes an instance of milli (represented by just a directory)
pub fn init_instance(instance_dir: String) -> Result<()> {
    let mut instances = INSTANCES.lock().unwrap();

    // Check to see whether the instance was already initialized
    if instances.contains_key(&instance_dir) {
        return Ok(());
    }

    // If not already initialized, initialize the instance
    create_dir_all(&instance_dir)?;
    let new_instance = Instance {
        indexes: Mutex::new(HashMap::new()),
    };
    instances.insert(instance_dir.clone(), new_instance);

    Ok(())
}

// TODO init index
// TODO methods on index
