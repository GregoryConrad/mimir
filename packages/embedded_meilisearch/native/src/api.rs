use std::sync::Mutex;

use lazy_static::lazy_static;

lazy_static! {
    static ref API: Mutex<u64> = Mutex::new(1234);
}

// From https://github.com/fzyzcjy/flutter_rust_bridge/issues/252#issuecomment-1002322865
/*
lazy_static! {
    static ref API: Mutex<Option<Api>> = Mutex::new(None);
}
pub fn init_api(input_app_dir: String) -> Result<()> {
    *API.lock() = Some(Api::new(input_app_dir));
    Ok(())
}
pub fn pr_search(capacity: u32, query: String) -> Result<Vec<PrSearchResult>> {
    Ok((*API.lock()).as_ref().unwrap().pr_search(capacity, &query))
}
 */

/// Documentation on a simple adder function.
pub fn simple_adder_1(a: i32, b: i32) -> i32 {
    a + b
}
