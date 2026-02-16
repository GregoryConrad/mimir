mod embedded_milli;
mod proto {
    #![allow(clippy::all)]
    include!("./proto/instance/instance.rs");
}

pub mod ffi;
