#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
typedef struct _Dart_Handle* Dart_Handle;

typedef struct DartCObject DartCObject;

typedef int64_t DartPort;

typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);

typedef struct wire_uint_8_list {
  uint8_t *ptr;
  int32_t len;
} wire_uint_8_list;

typedef struct wire_StringList {
  struct wire_uint_8_list **ptr;
  int32_t len;
} wire_StringList;

typedef struct wire_SortBy_Asc {
  struct wire_uint_8_list *field0;
} wire_SortBy_Asc;

typedef struct wire_SortBy_Desc {
  struct wire_uint_8_list *field0;
} wire_SortBy_Desc;

typedef union SortByKind {
  struct wire_SortBy_Asc *Asc;
  struct wire_SortBy_Desc *Desc;
} SortByKind;

typedef struct wire_SortBy {
  int32_t tag;
  union SortByKind *kind;
} wire_SortBy;

typedef struct wire_list_sort_by {
  struct wire_SortBy *ptr;
  int32_t len;
} wire_list_sort_by;

typedef struct wire_list_filter {
  struct wire_Filter *ptr;
  int32_t len;
} wire_list_filter;

typedef struct wire_Filter_Or {
  struct wire_list_filter *field0;
} wire_Filter_Or;

typedef struct wire_Filter_And {
  struct wire_list_filter *field0;
} wire_Filter_And;

typedef struct wire_Filter_Not {
  struct wire_Filter *field0;
} wire_Filter_Not;

typedef struct wire_Filter_Exists {
  struct wire_uint_8_list *field;
} wire_Filter_Exists;

typedef struct wire_Filter_InValues {
  struct wire_uint_8_list *field;
  struct wire_StringList *values;
} wire_Filter_InValues;

typedef struct wire_Filter_GreaterThan {
  struct wire_uint_8_list *field;
  struct wire_uint_8_list *value;
} wire_Filter_GreaterThan;

typedef struct wire_Filter_GreaterThanOrEqual {
  struct wire_uint_8_list *field;
  struct wire_uint_8_list *value;
} wire_Filter_GreaterThanOrEqual;

typedef struct wire_Filter_Equal {
  struct wire_uint_8_list *field;
  struct wire_uint_8_list *value;
} wire_Filter_Equal;

typedef struct wire_Filter_NotEqual {
  struct wire_uint_8_list *field;
  struct wire_uint_8_list *value;
} wire_Filter_NotEqual;

typedef struct wire_Filter_LessThan {
  struct wire_uint_8_list *field;
  struct wire_uint_8_list *value;
} wire_Filter_LessThan;

typedef struct wire_Filter_LessThanOrEqual {
  struct wire_uint_8_list *field;
  struct wire_uint_8_list *value;
} wire_Filter_LessThanOrEqual;

typedef struct wire_Filter_Between {
  struct wire_uint_8_list *field;
  struct wire_uint_8_list *from;
  struct wire_uint_8_list *to;
} wire_Filter_Between;

typedef struct wire_Filter_IsNull {
  struct wire_uint_8_list *field;
} wire_Filter_IsNull;

typedef struct wire_Filter_IsEmpty {
  struct wire_uint_8_list *field;
} wire_Filter_IsEmpty;

typedef union FilterKind {
  struct wire_Filter_Or *Or;
  struct wire_Filter_And *And;
  struct wire_Filter_Not *Not;
  struct wire_Filter_Exists *Exists;
  struct wire_Filter_InValues *InValues;
  struct wire_Filter_GreaterThan *GreaterThan;
  struct wire_Filter_GreaterThanOrEqual *GreaterThanOrEqual;
  struct wire_Filter_Equal *Equal;
  struct wire_Filter_NotEqual *NotEqual;
  struct wire_Filter_LessThan *LessThan;
  struct wire_Filter_LessThanOrEqual *LessThanOrEqual;
  struct wire_Filter_Between *Between;
  struct wire_Filter_IsNull *IsNull;
  struct wire_Filter_IsEmpty *IsEmpty;
} FilterKind;

typedef struct wire_Filter {
  int32_t tag;
  union FilterKind *kind;
} wire_Filter;

typedef struct wire_Synonyms {
  struct wire_uint_8_list *word;
  struct wire_StringList *synonyms;
} wire_Synonyms;

typedef struct wire_list_synonyms {
  struct wire_Synonyms *ptr;
  int32_t len;
} wire_list_synonyms;

typedef struct wire_MimirIndexSettings {
  struct wire_uint_8_list *primary_key;
  struct wire_StringList *searchable_fields;
  struct wire_StringList *filterable_fields;
  struct wire_StringList *sortable_fields;
  struct wire_StringList *ranking_rules;
  struct wire_StringList *stop_words;
  struct wire_list_synonyms *synonyms;
  bool typos_enabled;
  uint8_t min_word_size_for_one_typo;
  uint8_t min_word_size_for_two_typos;
  struct wire_StringList *disallow_typos_on_words;
  struct wire_StringList *disallow_typos_on_fields;
} wire_MimirIndexSettings;

typedef struct DartCObject *WireSyncReturn;

void store_dart_post_cobject(DartPostCObjectFnType ptr);

Dart_Handle get_dart_object(uintptr_t ptr);

void drop_dart_object(uintptr_t ptr);

uintptr_t new_dart_opaque(Dart_Handle handle);

intptr_t init_frb_dart_api_dl(void *obj);

void wire_ensure_instance_initialized(int64_t port_,
                                      struct wire_uint_8_list *instance_dir,
                                      struct wire_uint_8_list *tmp_dir);

void wire_ensure_index_initialized(int64_t port_,
                                   struct wire_uint_8_list *instance_dir,
                                   struct wire_uint_8_list *index_name);

void wire_add_documents(int64_t port_,
                        struct wire_uint_8_list *instance_dir,
                        struct wire_uint_8_list *index_name,
                        struct wire_StringList *documents);

void wire_delete_documents(int64_t port_,
                           struct wire_uint_8_list *instance_dir,
                           struct wire_uint_8_list *index_name,
                           struct wire_StringList *document_ids);

void wire_delete_all_documents(int64_t port_,
                               struct wire_uint_8_list *instance_dir,
                               struct wire_uint_8_list *index_name);

void wire_set_documents(int64_t port_,
                        struct wire_uint_8_list *instance_dir,
                        struct wire_uint_8_list *index_name,
                        struct wire_StringList *documents);

void wire_get_document(int64_t port_,
                       struct wire_uint_8_list *instance_dir,
                       struct wire_uint_8_list *index_name,
                       struct wire_uint_8_list *document_id);

void wire_get_all_documents(int64_t port_,
                            struct wire_uint_8_list *instance_dir,
                            struct wire_uint_8_list *index_name);

void wire_search_documents(int64_t port_,
                           struct wire_uint_8_list *instance_dir,
                           struct wire_uint_8_list *index_name,
                           struct wire_uint_8_list *query,
                           uint32_t *limit,
                           uint32_t *offset,
                           struct wire_list_sort_by *sort_criteria,
                           struct wire_Filter *filter,
                           int32_t *matching_strategy);

void wire_number_of_documents(int64_t port_,
                              struct wire_uint_8_list *instance_dir,
                              struct wire_uint_8_list *index_name);

void wire_get_settings(int64_t port_,
                       struct wire_uint_8_list *instance_dir,
                       struct wire_uint_8_list *index_name);

void wire_set_settings(int64_t port_,
                       struct wire_uint_8_list *instance_dir,
                       struct wire_uint_8_list *index_name,
                       struct wire_MimirIndexSettings *settings);

struct wire_StringList *new_StringList_0(int32_t len);

struct wire_Filter *new_box_autoadd_filter_0(void);

struct wire_MimirIndexSettings *new_box_autoadd_mimir_index_settings_0(void);

int32_t *new_box_autoadd_terms_matching_strategy_0(int32_t value);

uint32_t *new_box_autoadd_u32_0(uint32_t value);

struct wire_Filter *new_box_filter_0(void);

struct wire_list_filter *new_list_filter_0(int32_t len);

struct wire_list_sort_by *new_list_sort_by_0(int32_t len);

struct wire_list_synonyms *new_list_synonyms_0(int32_t len);

struct wire_uint_8_list *new_uint_8_list_0(int32_t len);

union FilterKind *inflate_Filter_Or(void);

union FilterKind *inflate_Filter_And(void);

union FilterKind *inflate_Filter_Not(void);

union FilterKind *inflate_Filter_Exists(void);

union FilterKind *inflate_Filter_InValues(void);

union FilterKind *inflate_Filter_GreaterThan(void);

union FilterKind *inflate_Filter_GreaterThanOrEqual(void);

union FilterKind *inflate_Filter_Equal(void);

union FilterKind *inflate_Filter_NotEqual(void);

union FilterKind *inflate_Filter_LessThan(void);

union FilterKind *inflate_Filter_LessThanOrEqual(void);

union FilterKind *inflate_Filter_Between(void);

union FilterKind *inflate_Filter_IsNull(void);

union FilterKind *inflate_Filter_IsEmpty(void);

union SortByKind *inflate_SortBy_Asc(void);

union SortByKind *inflate_SortBy_Desc(void);

void free_WireSyncReturn(WireSyncReturn ptr);

static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) wire_ensure_instance_initialized);
    dummy_var ^= ((int64_t) (void*) wire_ensure_index_initialized);
    dummy_var ^= ((int64_t) (void*) wire_add_documents);
    dummy_var ^= ((int64_t) (void*) wire_delete_documents);
    dummy_var ^= ((int64_t) (void*) wire_delete_all_documents);
    dummy_var ^= ((int64_t) (void*) wire_set_documents);
    dummy_var ^= ((int64_t) (void*) wire_get_document);
    dummy_var ^= ((int64_t) (void*) wire_get_all_documents);
    dummy_var ^= ((int64_t) (void*) wire_search_documents);
    dummy_var ^= ((int64_t) (void*) wire_number_of_documents);
    dummy_var ^= ((int64_t) (void*) wire_get_settings);
    dummy_var ^= ((int64_t) (void*) wire_set_settings);
    dummy_var ^= ((int64_t) (void*) new_StringList_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_filter_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_mimir_index_settings_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_terms_matching_strategy_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_u32_0);
    dummy_var ^= ((int64_t) (void*) new_box_filter_0);
    dummy_var ^= ((int64_t) (void*) new_list_filter_0);
    dummy_var ^= ((int64_t) (void*) new_list_sort_by_0);
    dummy_var ^= ((int64_t) (void*) new_list_synonyms_0);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list_0);
    dummy_var ^= ((int64_t) (void*) inflate_Filter_Or);
    dummy_var ^= ((int64_t) (void*) inflate_Filter_And);
    dummy_var ^= ((int64_t) (void*) inflate_Filter_Not);
    dummy_var ^= ((int64_t) (void*) inflate_Filter_Exists);
    dummy_var ^= ((int64_t) (void*) inflate_Filter_InValues);
    dummy_var ^= ((int64_t) (void*) inflate_Filter_GreaterThan);
    dummy_var ^= ((int64_t) (void*) inflate_Filter_GreaterThanOrEqual);
    dummy_var ^= ((int64_t) (void*) inflate_Filter_Equal);
    dummy_var ^= ((int64_t) (void*) inflate_Filter_NotEqual);
    dummy_var ^= ((int64_t) (void*) inflate_Filter_LessThan);
    dummy_var ^= ((int64_t) (void*) inflate_Filter_LessThanOrEqual);
    dummy_var ^= ((int64_t) (void*) inflate_Filter_Between);
    dummy_var ^= ((int64_t) (void*) inflate_Filter_IsNull);
    dummy_var ^= ((int64_t) (void*) inflate_Filter_IsEmpty);
    dummy_var ^= ((int64_t) (void*) inflate_SortBy_Asc);
    dummy_var ^= ((int64_t) (void*) inflate_SortBy_Desc);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturn);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    dummy_var ^= ((int64_t) (void*) get_dart_object);
    dummy_var ^= ((int64_t) (void*) drop_dart_object);
    dummy_var ^= ((int64_t) (void*) new_dart_opaque);
    return dummy_var;
}
