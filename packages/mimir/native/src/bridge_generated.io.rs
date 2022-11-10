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

#[no_mangle]
pub extern "C" fn wire_get_settings(
    port_: i64,
    instance_dir: *mut wire_uint_8_list,
    index_name: *mut wire_uint_8_list,
) {
    wire_get_settings_impl(port_, instance_dir, index_name)
}

#[no_mangle]
pub extern "C" fn wire_set_settings(
    port_: i64,
    instance_dir: *mut wire_uint_8_list,
    index_name: *mut wire_uint_8_list,
    settings: *mut wire_MimirIndexSettings,
) {
    wire_set_settings_impl(port_, instance_dir, index_name, settings)
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
pub extern "C" fn new_box_autoadd_mimir_index_settings_0() -> *mut wire_MimirIndexSettings {
    support::new_leak_box_ptr(wire_MimirIndexSettings::new_with_null_ptr())
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
pub extern "C" fn new_list_synonyms_0(len: i32) -> *mut wire_list_synonyms {
    let wrap = wire_list_synonyms {
        ptr: support::new_leak_vec_ptr(<wire_Synonyms>::new_with_null_ptr(), len),
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

impl Wire2Api<MimirIndexSettings> for *mut wire_MimirIndexSettings {
    fn wire2api(self) -> MimirIndexSettings {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<MimirIndexSettings>::wire2api(*wrap).into()
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
impl Wire2Api<Vec<Synonyms>> for *mut wire_list_synonyms {
    fn wire2api(self) -> Vec<Synonyms> {
        let vec = unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(Wire2Api::wire2api).collect()
    }
}
impl Wire2Api<MimirIndexSettings> for wire_MimirIndexSettings {
    fn wire2api(self) -> MimirIndexSettings {
        MimirIndexSettings {
            searchable_fields: self.searchable_fields.wire2api(),
            filterable_fields: self.filterable_fields.wire2api(),
            sortable_fields: self.sortable_fields.wire2api(),
            ranking_rules: self.ranking_rules.wire2api(),
            stop_words: self.stop_words.wire2api(),
            synonyms: self.synonyms.wire2api(),
            typos_enabled: self.typos_enabled.wire2api(),
            min_word_size_for_one_typo: self.min_word_size_for_one_typo.wire2api(),
            min_word_size_for_two_typos: self.min_word_size_for_two_typos.wire2api(),
            disallow_typos_on_words: self.disallow_typos_on_words.wire2api(),
            disallow_typos_on_fields: self.disallow_typos_on_fields.wire2api(),
        }
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
impl Wire2Api<Synonyms> for wire_Synonyms {
    fn wire2api(self) -> Synonyms {
        Synonyms {
            word: self.word.wire2api(),
            synonyms: self.synonyms.wire2api(),
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
pub struct wire_list_synonyms {
    ptr: *mut wire_Synonyms,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_MimirIndexSettings {
    searchable_fields: *mut wire_StringList,
    filterable_fields: *mut wire_StringList,
    sortable_fields: *mut wire_StringList,
    ranking_rules: *mut wire_StringList,
    stop_words: *mut wire_StringList,
    synonyms: *mut wire_list_synonyms,
    typos_enabled: bool,
    min_word_size_for_one_typo: u8,
    min_word_size_for_two_typos: u8,
    disallow_typos_on_words: *mut wire_StringList,
    disallow_typos_on_fields: *mut wire_StringList,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_Synonyms {
    word: *mut wire_uint_8_list,
    synonyms: *mut wire_StringList,
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

impl NewWithNullPtr for wire_MimirIndexSettings {
    fn new_with_null_ptr() -> Self {
        Self {
            searchable_fields: core::ptr::null_mut(),
            filterable_fields: core::ptr::null_mut(),
            sortable_fields: core::ptr::null_mut(),
            ranking_rules: core::ptr::null_mut(),
            stop_words: core::ptr::null_mut(),
            synonyms: core::ptr::null_mut(),
            typos_enabled: Default::default(),
            min_word_size_for_one_typo: Default::default(),
            min_word_size_for_two_typos: Default::default(),
            disallow_typos_on_words: core::ptr::null_mut(),
            disallow_typos_on_fields: core::ptr::null_mut(),
        }
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

impl NewWithNullPtr for wire_Synonyms {
    fn new_with_null_ptr() -> Self {
        Self {
            word: core::ptr::null_mut(),
            synonyms: core::ptr::null_mut(),
        }
    }
}

// Section: sync execution mode utility

#[no_mangle]
pub extern "C" fn free_WireSyncReturnStruct(val: support::WireSyncReturnStruct) {
    unsafe {
        let _ = support::vec_from_leak_ptr(val.ptr, val.len);
    }
}
