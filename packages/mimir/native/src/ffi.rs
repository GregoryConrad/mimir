use std::any::Any;

use anyhow::{Context, Result};
use prost::Message;

use crate::{
    embedded_milli,
    proto::{
        instance_ffi_request::{
            self,
            index_request::{self, search_documents::TermsMatchingStrategy},
        },
        instance_ffi_response, InstanceFfiRequest, InstanceFfiResponse,
    },
};

/// Buffer going back to Dart
/// NOTE: must be freed with [embedded_milli_free_buffer] on the Dart side!
#[repr(C)]
pub struct RustBuffer {
    pub ptr: *mut u8,
    pub len: usize,
    pub capacity: usize,
}

impl From<Vec<u8>> for RustBuffer {
    fn from(mut value: Vec<u8>) -> Self {
        let buf = RustBuffer {
            ptr: value.as_mut_ptr(),
            len: value.len(),
            capacity: value.capacity(),
        };

        // NOTE: prevent Rust from freeing the buffer
        std::mem::forget(value);

        buf
    }
}

impl From<RustBuffer> for Vec<u8> {
    fn from(value: RustBuffer) -> Self {
        // SAFETY: RustBuffer is just a Vec wrapper for use across FFI
        unsafe { Vec::from_raw_parts(value.ptr, value.len, value.capacity) }
    }
}

/// # Safety
/// Caller must ensure provided ptr and len point to a valid memory buffer.
#[no_mangle]
pub unsafe extern "C" fn embedded_milli_process_instance_request(
    ptr: *const u8,
    len: usize,
) -> RustBuffer {
    // SAFETY: Dart side ensures buffer is a valid block of memory
    let buffer = unsafe { std::slice::from_raw_parts(ptr, len) };

    let response = std::panic::catch_unwind(|| match process_instance_request(buffer) {
        Ok(response) => InstanceFfiResponse {
            kind: response,
            error: None,
        },
        Err(err) => InstanceFfiResponse {
            kind: None,
            error: Some(err.to_string()),
        },
    })
    .unwrap_or_else(|panic| InstanceFfiResponse {
        error: Some(format!("A panic occurred: {}", panic_to_string(panic))),
        kind: None,
    });

    response.encode_to_vec().into()
}

#[no_mangle]
pub extern "C" fn embedded_milli_free_buffer(buffer: RustBuffer) {
    drop(Vec::from(buffer))
}

fn process_instance_request(buffer: &[u8]) -> Result<Option<instance_ffi_response::Kind>> {
    let request =
        InstanceFfiRequest::decode(buffer).context("Failed to decode InstanceFfiRequest")?;
    let instance_dir = request.instance_dir.as_str();
    let request_payload = request
        .kind
        .context("InstanceFfiRequest missing required payload")?;

    match request_payload {
        instance_ffi_request::Kind::EnsureInstanceInitialized(
            instance_ffi_request::EnsureInitialized { tmp_dir },
        ) => {
            embedded_milli::ensure_instance_initialized(instance_dir, tmp_dir)?;
            Ok(None)
        }
        instance_ffi_request::Kind::IndexRequest(instance_ffi_request::IndexRequest {
            index_name,
            kind,
        }) => process_index_request(
            instance_dir,
            index_name.as_str(),
            kind.context("IndexRequest missing required payload")?,
        ),
    }
}

fn process_index_request(
    instance_dir: &str,
    index_name: &str,
    request_payload: index_request::Kind,
) -> Result<Option<instance_ffi_response::Kind>> {
    match request_payload {
        index_request::Kind::EnsureIndexInitialized(index_request::EnsureInitialized {}) => {
            embedded_milli::ensure_index_initialized(instance_dir, index_name)?;
            Ok(None)
        }
        index_request::Kind::AddDocuments(index_request::AddDocuments { documents }) => {
            let documents = documents
                .iter()
                .map(String::as_str)
                .map(string_to_document)
                .collect::<Result<_>>()?;
            embedded_milli::add_documents(instance_dir, index_name, documents)?;
            Ok(None)
        }
        index_request::Kind::DeleteDocuments(index_request::DeleteDocuments { document_ids }) => {
            embedded_milli::delete_documents(instance_dir, index_name, document_ids)?;
            Ok(None)
        }
        index_request::Kind::DeleteAllDocuments(index_request::DeleteAllDocuments {}) => {
            embedded_milli::delete_all_documents(instance_dir, index_name)?;
            Ok(None)
        }
        index_request::Kind::SetDocuments(index_request::SetDocuments { documents }) => {
            let documents = documents
                .iter()
                .map(String::as_str)
                .map(string_to_document)
                .collect::<Result<_>>()?;
            embedded_milli::set_documents(instance_dir, index_name, documents)?;
            Ok(None)
        }
        index_request::Kind::GetDocument(index_request::GetDocument { document_id }) => {
            let document = embedded_milli::get_document(instance_dir, index_name, document_id)?
                .as_ref()
                .map(document_to_string)
                .transpose()?;
            Ok(Some(instance_ffi_response::Kind::Document(
                instance_ffi_response::OptionalDocument { document },
            )))
        }
        index_request::Kind::GetAllDocuments(index_request::GetAllDocuments {}) => {
            let documents = embedded_milli::get_all_documents(instance_dir, index_name)?
                .iter()
                .map(document_to_string)
                .collect::<Result<_>>()?;
            Ok(Some(instance_ffi_response::Kind::Documents(
                instance_ffi_response::Documents { documents },
            )))
        }
        index_request::Kind::SearchDocuments(index_request::SearchDocuments {
            query,
            limit,
            offset,
            filter,
            terms_matching_strategy,
            sort_criteria,
        }) => {
            let documents = embedded_milli::search_documents(
                instance_dir,
                index_name,
                query,
                limit,
                offset,
                sort_criteria
                    .map(|criteria| {
                        criteria
                            .sort_criteria
                            .into_iter()
                            .map(|sort_by| sort_by.kind)
                            .collect::<Option<_>>()
                            .context("SortBy missing required payload")
                    })
                    .transpose()?,
                filter,
                terms_matching_strategy
                    .map(TermsMatchingStrategy::try_from)
                    .transpose()
                    .context("TermsMatchingStrategy was sent with incorrect value")?,
            )?
            .iter()
            .map(document_to_string)
            .collect::<Result<_>>()?;
            Ok(Some(instance_ffi_response::Kind::Documents(
                instance_ffi_response::Documents { documents },
            )))
        }
        index_request::Kind::NumberOfDocuments(index_request::NumberOfDocuments {}) => {
            let num_documents = embedded_milli::number_of_documents(instance_dir, index_name)?;
            Ok(Some(instance_ffi_response::Kind::NumberOfDocuments(
                num_documents,
            )))
        }
        index_request::Kind::GetSettings(index_request::GetSettings {}) => {
            let settings = embedded_milli::get_settings(instance_dir, index_name)?;
            Ok(Some(instance_ffi_response::Kind::IndexSettings(settings)))
        }
        index_request::Kind::SetSettings(index_request::SetSettings { settings }) => {
            embedded_milli::set_settings(
                instance_dir,
                index_name,
                settings.context("SetSettings was sent with missing settings")?,
            )?;
            Ok(None)
        }
    }
}

fn panic_to_string(err: Box<dyn Any + Send>) -> String {
    if let Some(s) = err.downcast_ref::<&'static str>() {
        s.to_string()
    } else if let Some(s) = err.downcast_ref::<String>() {
        s.clone()
    } else {
        "Unknown panic payload".to_owned()
    }
}

fn string_to_document(s: &str) -> Result<embedded_milli::Document> {
    serde_json::from_str(s).map_err(anyhow::Error::from)
}

fn document_to_string(doc: &embedded_milli::Document) -> Result<String> {
    serde_json::to_string(doc).map_err(anyhow::Error::from)
}
