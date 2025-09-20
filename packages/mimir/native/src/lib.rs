mod embedded_milli;
mod proto {
    #![allow(clippy::all)]
    include!("./proto/instance.rs");
}

pub mod ffi;
