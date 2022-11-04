use std::{collections::HashMap, sync::Mutex};

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
pub fn init_instance(instance_dir: String) {
    let mut instances = INSTANCES.lock().unwrap();

    if instances.contains_key(&instance_dir) {
        return;
    }

    let new_instance = Instance {
        indexes: Mutex::new(HashMap::new()),
    };

    instances.insert(instance_dir.clone(), new_instance);
}

// TODO init index
// TODO methods on index
