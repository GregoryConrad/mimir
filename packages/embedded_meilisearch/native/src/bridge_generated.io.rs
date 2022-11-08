use super::*;
// Section: wire functions

#[no_mangle]
pub extern "C" fn wire_ensure_instance_initialized(
    port_: i64,
    instance_dir: *mut wire_uint_8_list,
) {
    wire_ensure_instance_initialized_impl(port_, instance_dir)
}

#[no_mangle]
pub extern "C" fn wire_ensure_index_initialized(
    port_: i64,
    instance_dir: *mut wire_uint_8_list,
    index_name: *mut wire_uint_8_list,
) {
    wire_ensure_index_initialized_impl(port_, instance_dir, index_name)
}

#[no_mangle]
pub extern "C" fn wire_add_documents(
    port_: i64,
    instance_dir: *mut wire_uint_8_list,
    index_name: *mut wire_uint_8_list,
    json_documents: *mut wire_StringList,
) {
    wire_add_documents_impl(port_, instance_dir, index_name, json_documents)
}

#[no_mangle]
pub extern "C" fn wire_delete_documents(
    port_: i64,
    instance_dir: *mut wire_uint_8_list,
    index_name: *mut wire_uint_8_list,
    document_ids: *mut wire_StringList,
) {
    wire_delete_documents_impl(port_, instance_dir, index_name, document_ids)
}

#[no_mangle]
pub extern "C" fn wire_delete_all_documents(
    port_: i64,
    instance_dir: *mut wire_uint_8_list,
    index_name: *mut wire_uint_8_list,
) {
    wire_delete_all_documents_impl(port_, instance_dir, index_name)
}

#[no_mangle]
pub extern "C" fn wire_get_document(
    port_: i64,
    instance_dir: *mut wire_uint_8_list,
    index_name: *mut wire_uint_8_list,
    document_id: *mut wire_uint_8_list,
) {
    wire_get_document_impl(port_, instance_dir, index_name, document_id)
}

#[no_mangle]
pub extern "C" fn wire_get_all_documents(
    port_: i64,
    instance_dir: *mut wire_uint_8_list,
    index_name: *mut wire_uint_8_list,
) {
    wire_get_all_documents_impl(port_, instance_dir, index_name)
}

#[no_mangle]
pub extern "C" fn wire_search_documents(
    port_: i64,
    instance_dir: *mut wire_uint_8_list,
    index_name: *mut wire_uint_8_list,
    query: *mut wire_uint_8_list,
    limit: *mut u32,
    matching_strategy: i32,
    sort_criteria: *mut wire_list_sort_by,
) {
    wire_search_documents_impl(
        port_,
        instance_dir,
        index_name,
        query,
        limit,
        matching_strategy,
        sort_criteria,
    )
}

// Section: allocate functions

#[no_mangle]
pub extern "C" fn new_StringList_0(len: i32) -> *mut wire_StringList {
    let wrap = wire_StringList {
        ptr: support::new_leak_vec_ptr(<*mut wire_uint_8_list>::new_with_null_ptr(), len),
        len,
    };
    support::new_leak_box_ptr(wrap)
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_u32_0(value: u32) -> *mut u32 {
    support::new_leak_box_ptr(value)
}

#[no_mangle]
pub extern "C" fn new_list_sort_by_0(len: i32) -> *mut wire_list_sort_by {
    let wrap = wire_list_sort_by {
        ptr: support::new_leak_vec_ptr(<wire_SortBy>::new_with_null_ptr(), len),
        len,
    };
    support::new_leak_box_ptr(wrap)
}

#[no_mangle]
pub extern "C" fn new_uint_8_list_0(len: i32) -> *mut wire_uint_8_list {
    let ans = wire_uint_8_list {
        ptr: support::new_leak_vec_ptr(Default::default(), len),
        len,
    };
    support::new_leak_box_ptr(ans)
}

// Section: impl Wire2Api

impl Wire2Api<String> for *mut wire_uint_8_list {
    fn wire2api(self) -> String {
        let vec: Vec<u8> = self.wire2api();
        String::from_utf8_lossy(&vec).into_owned()
    }
}
impl Wire2Api<Vec<String>> for *mut wire_StringList {
    fn wire2api(self) -> Vec<String> {
        let vec = unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(Wire2Api::wire2api).collect()
    }
}

impl Wire2Api<Vec<SortBy>> for *mut wire_list_sort_by {
    fn wire2api(self) -> Vec<SortBy> {
        let vec = unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(Wire2Api::wire2api).collect()
    }
}

impl Wire2Api<SortBy> for wire_SortBy {
    fn wire2api(self) -> SortBy {
        match self.tag {
            0 => unsafe {
                let ans = support::box_from_leak_ptr(self.kind);
                let ans = support::box_from_leak_ptr(ans.Asc);
                SortBy::Asc(ans.field0.wire2api())
            },
            1 => unsafe {
                let ans = support::box_from_leak_ptr(self.kind);
                let ans = support::box_from_leak_ptr(ans.Desc);
                SortBy::Desc(ans.field0.wire2api())
            },
            _ => unreachable!(),
        }
    }
}

impl Wire2Api<Vec<u8>> for *mut wire_uint_8_list {
    fn wire2api(self) -> Vec<u8> {
        unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        }
    }
}
// Section: wire structs

#[repr(C)]
#[derive(Clone)]
pub struct wire_StringList {
    ptr: *mut *mut wire_uint_8_list,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_list_sort_by {
    ptr: *mut wire_SortBy,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_uint_8_list {
    ptr: *mut u8,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_SortBy {
    tag: i32,
    kind: *mut SortByKind,
}

#[repr(C)]
pub union SortByKind {
    Asc: *mut wire_SortBy_Asc,
    Desc: *mut wire_SortBy_Desc,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_SortBy_Asc {
    field0: *mut wire_uint_8_list,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_SortBy_Desc {
    field0: *mut wire_uint_8_list,
}

// Section: impl NewWithNullPtr

pub trait NewWithNullPtr {
    fn new_with_null_ptr() -> Self;
}

impl<T> NewWithNullPtr for *mut T {
    fn new_with_null_ptr() -> Self {
        std::ptr::null_mut()
    }
}

impl NewWithNullPtr for wire_SortBy {
    fn new_with_null_ptr() -> Self {
        Self {
            tag: -1,
            kind: core::ptr::null_mut(),
        }
    }
}

#[no_mangle]
pub extern "C" fn inflate_SortBy_Asc() -> *mut SortByKind {
    support::new_leak_box_ptr(SortByKind {
        Asc: support::new_leak_box_ptr(wire_SortBy_Asc {
            field0: core::ptr::null_mut(),
        }),
    })
}

#[no_mangle]
pub extern "C" fn inflate_SortBy_Desc() -> *mut SortByKind {
    support::new_leak_box_ptr(SortByKind {
        Desc: support::new_leak_box_ptr(wire_SortBy_Desc {
            field0: core::ptr::null_mut(),
        }),
    })
}

// Section: sync execution mode utility

#[no_mangle]
pub extern "C" fn free_WireSyncReturnStruct(val: support::WireSyncReturnStruct) {
    unsafe {
        let _ = support::vec_from_leak_ptr(val.ptr, val.len);
    }
}
