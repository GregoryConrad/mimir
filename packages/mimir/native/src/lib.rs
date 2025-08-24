mod embedded_milli;
mod proto {
    include!(concat!(env!("OUT_DIR"), "/instance.rs"));
}

pub mod ffi;
