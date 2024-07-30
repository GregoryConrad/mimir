#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
// EXTRA BEGIN
typedef struct DartCObject *WireSyncRust2DartDco;
typedef struct WireSyncRust2DartSse {
  uint8_t *ptr;
  int32_t len;
} WireSyncRust2DartSse;

typedef int64_t DartPort;
typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);
void store_dart_post_cobject(DartPostCObjectFnType ptr);
// EXTRA END
typedef struct _Dart_Handle* Dart_Handle;

typedef struct wire_cst_list_prim_u_8_strict {
  uint8_t *ptr;
  int32_t len;
} wire_cst_list_prim_u_8_strict;

typedef struct wire_cst_list_String {
  struct wire_cst_list_prim_u_8_strict **ptr;
  int32_t len;
} wire_cst_list_String;

typedef struct wire_cst_SortBy_Asc {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_SortBy_Asc;

typedef struct wire_cst_SortBy_Desc {
  struct wire_cst_list_prim_u_8_strict *field0;
} wire_cst_SortBy_Desc;

typedef union SortByKind {
  struct wire_cst_SortBy_Asc Asc;
  struct wire_cst_SortBy_Desc Desc;
} SortByKind;

typedef struct wire_cst_sort_by {
  int32_t tag;
  union SortByKind kind;
} wire_cst_sort_by;

typedef struct wire_cst_list_sort_by {
  struct wire_cst_sort_by *ptr;
  int32_t len;
} wire_cst_list_sort_by;

typedef struct wire_cst_list_filter {
  struct wire_cst_filter *ptr;
  int32_t len;
} wire_cst_list_filter;

typedef struct wire_cst_Filter_Or {
  struct wire_cst_list_filter *field0;
} wire_cst_Filter_Or;

typedef struct wire_cst_Filter_And {
  struct wire_cst_list_filter *field0;
} wire_cst_Filter_And;

typedef struct wire_cst_Filter_Not {
  struct wire_cst_filter *field0;
} wire_cst_Filter_Not;

typedef struct wire_cst_Filter_Exists {
  struct wire_cst_list_prim_u_8_strict *field;
} wire_cst_Filter_Exists;

typedef struct wire_cst_Filter_InValues {
  struct wire_cst_list_prim_u_8_strict *field;
  struct wire_cst_list_String *values;
} wire_cst_Filter_InValues;

typedef struct wire_cst_Filter_GreaterThan {
  struct wire_cst_list_prim_u_8_strict *field;
  struct wire_cst_list_prim_u_8_strict *value;
} wire_cst_Filter_GreaterThan;

typedef struct wire_cst_Filter_GreaterThanOrEqual {
  struct wire_cst_list_prim_u_8_strict *field;
  struct wire_cst_list_prim_u_8_strict *value;
} wire_cst_Filter_GreaterThanOrEqual;

typedef struct wire_cst_Filter_Equal {
  struct wire_cst_list_prim_u_8_strict *field;
  struct wire_cst_list_prim_u_8_strict *value;
} wire_cst_Filter_Equal;

typedef struct wire_cst_Filter_NotEqual {
  struct wire_cst_list_prim_u_8_strict *field;
  struct wire_cst_list_prim_u_8_strict *value;
} wire_cst_Filter_NotEqual;

typedef struct wire_cst_Filter_LessThan {
  struct wire_cst_list_prim_u_8_strict *field;
  struct wire_cst_list_prim_u_8_strict *value;
} wire_cst_Filter_LessThan;

typedef struct wire_cst_Filter_LessThanOrEqual {
  struct wire_cst_list_prim_u_8_strict *field;
  struct wire_cst_list_prim_u_8_strict *value;
} wire_cst_Filter_LessThanOrEqual;

typedef struct wire_cst_Filter_Between {
  struct wire_cst_list_prim_u_8_strict *field;
  struct wire_cst_list_prim_u_8_strict *from;
  struct wire_cst_list_prim_u_8_strict *to;
} wire_cst_Filter_Between;

typedef struct wire_cst_Filter_IsNull {
  struct wire_cst_list_prim_u_8_strict *field;
} wire_cst_Filter_IsNull;

typedef struct wire_cst_Filter_IsEmpty {
  struct wire_cst_list_prim_u_8_strict *field;
} wire_cst_Filter_IsEmpty;

typedef union FilterKind {
  struct wire_cst_Filter_Or Or;
  struct wire_cst_Filter_And And;
  struct wire_cst_Filter_Not Not;
  struct wire_cst_Filter_Exists Exists;
  struct wire_cst_Filter_InValues InValues;
  struct wire_cst_Filter_GreaterThan GreaterThan;
  struct wire_cst_Filter_GreaterThanOrEqual GreaterThanOrEqual;
  struct wire_cst_Filter_Equal Equal;
  struct wire_cst_Filter_NotEqual NotEqual;
  struct wire_cst_Filter_LessThan LessThan;
  struct wire_cst_Filter_LessThanOrEqual LessThanOrEqual;
  struct wire_cst_Filter_Between Between;
  struct wire_cst_Filter_IsNull IsNull;
  struct wire_cst_Filter_IsEmpty IsEmpty;
} FilterKind;

typedef struct wire_cst_filter {
  int32_t tag;
  union FilterKind kind;
} wire_cst_filter;

typedef struct wire_cst_synonyms {
  struct wire_cst_list_prim_u_8_strict *word;
  struct wire_cst_list_String *synonyms;
} wire_cst_synonyms;

typedef struct wire_cst_list_synonyms {
  struct wire_cst_synonyms *ptr;
  int32_t len;
} wire_cst_list_synonyms;

typedef struct wire_cst_mimir_index_settings {
  struct wire_cst_list_prim_u_8_strict *primary_key;
  struct wire_cst_list_String *searchable_fields;
  struct wire_cst_list_String *filterable_fields;
  struct wire_cst_list_String *sortable_fields;
  struct wire_cst_list_String *ranking_rules;
  struct wire_cst_list_String *stop_words;
  struct wire_cst_list_synonyms *synonyms;
  bool typos_enabled;
  uint8_t min_word_size_for_one_typo;
  uint8_t min_word_size_for_two_typos;
  struct wire_cst_list_String *disallow_typos_on_words;
  struct wire_cst_list_String *disallow_typos_on_fields;
} wire_cst_mimir_index_settings;

void frbgen_mimir_wire__crate__api__add_documents(int64_t port_,
                                                  struct wire_cst_list_prim_u_8_strict *instance_dir,
                                                  struct wire_cst_list_prim_u_8_strict *index_name,
                                                  struct wire_cst_list_String *documents);

void frbgen_mimir_wire__crate__api__delete_all_documents(int64_t port_,
                                                         struct wire_cst_list_prim_u_8_strict *instance_dir,
                                                         struct wire_cst_list_prim_u_8_strict *index_name);

void frbgen_mimir_wire__crate__api__delete_documents(int64_t port_,
                                                     struct wire_cst_list_prim_u_8_strict *instance_dir,
                                                     struct wire_cst_list_prim_u_8_strict *index_name,
                                                     struct wire_cst_list_String *document_ids);

void frbgen_mimir_wire__crate__api__ensure_index_initialized(int64_t port_,
                                                             struct wire_cst_list_prim_u_8_strict *instance_dir,
                                                             struct wire_cst_list_prim_u_8_strict *index_name);

void frbgen_mimir_wire__crate__api__ensure_instance_initialized(int64_t port_,
                                                                struct wire_cst_list_prim_u_8_strict *instance_dir,
                                                                struct wire_cst_list_prim_u_8_strict *tmp_dir);

void frbgen_mimir_wire__crate__api__get_all_documents(int64_t port_,
                                                      struct wire_cst_list_prim_u_8_strict *instance_dir,
                                                      struct wire_cst_list_prim_u_8_strict *index_name);

void frbgen_mimir_wire__crate__api__get_document(int64_t port_,
                                                 struct wire_cst_list_prim_u_8_strict *instance_dir,
                                                 struct wire_cst_list_prim_u_8_strict *index_name,
                                                 struct wire_cst_list_prim_u_8_strict *document_id);

void frbgen_mimir_wire__crate__api__get_settings(int64_t port_,
                                                 struct wire_cst_list_prim_u_8_strict *instance_dir,
                                                 struct wire_cst_list_prim_u_8_strict *index_name);

void frbgen_mimir_wire__crate__api__number_of_documents(int64_t port_,
                                                        struct wire_cst_list_prim_u_8_strict *instance_dir,
                                                        struct wire_cst_list_prim_u_8_strict *index_name);

void frbgen_mimir_wire__crate__api__search_documents(int64_t port_,
                                                     struct wire_cst_list_prim_u_8_strict *instance_dir,
                                                     struct wire_cst_list_prim_u_8_strict *index_name,
                                                     struct wire_cst_list_prim_u_8_strict *query,
                                                     uint32_t *limit,
                                                     uint32_t *offset,
                                                     struct wire_cst_list_sort_by *sort_criteria,
                                                     struct wire_cst_filter *filter,
                                                     int32_t *matching_strategy);

void frbgen_mimir_wire__crate__api__set_documents(int64_t port_,
                                                  struct wire_cst_list_prim_u_8_strict *instance_dir,
                                                  struct wire_cst_list_prim_u_8_strict *index_name,
                                                  struct wire_cst_list_String *documents);

void frbgen_mimir_wire__crate__api__set_settings(int64_t port_,
                                                 struct wire_cst_list_prim_u_8_strict *instance_dir,
                                                 struct wire_cst_list_prim_u_8_strict *index_name,
                                                 struct wire_cst_mimir_index_settings *settings);

struct wire_cst_filter *frbgen_mimir_cst_new_box_autoadd_filter(void);

struct wire_cst_mimir_index_settings *frbgen_mimir_cst_new_box_autoadd_mimir_index_settings(void);

int32_t *frbgen_mimir_cst_new_box_autoadd_terms_matching_strategy(int32_t value);

uint32_t *frbgen_mimir_cst_new_box_autoadd_u_32(uint32_t value);

struct wire_cst_filter *frbgen_mimir_cst_new_box_filter(void);

struct wire_cst_list_String *frbgen_mimir_cst_new_list_String(int32_t len);

struct wire_cst_list_filter *frbgen_mimir_cst_new_list_filter(int32_t len);

struct wire_cst_list_prim_u_8_strict *frbgen_mimir_cst_new_list_prim_u_8_strict(int32_t len);

struct wire_cst_list_sort_by *frbgen_mimir_cst_new_list_sort_by(int32_t len);

struct wire_cst_list_synonyms *frbgen_mimir_cst_new_list_synonyms(int32_t len);
static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) frbgen_mimir_cst_new_box_autoadd_filter);
    dummy_var ^= ((int64_t) (void*) frbgen_mimir_cst_new_box_autoadd_mimir_index_settings);
    dummy_var ^= ((int64_t) (void*) frbgen_mimir_cst_new_box_autoadd_terms_matching_strategy);
    dummy_var ^= ((int64_t) (void*) frbgen_mimir_cst_new_box_autoadd_u_32);
    dummy_var ^= ((int64_t) (void*) frbgen_mimir_cst_new_box_filter);
    dummy_var ^= ((int64_t) (void*) frbgen_mimir_cst_new_list_String);
    dummy_var ^= ((int64_t) (void*) frbgen_mimir_cst_new_list_filter);
    dummy_var ^= ((int64_t) (void*) frbgen_mimir_cst_new_list_prim_u_8_strict);
    dummy_var ^= ((int64_t) (void*) frbgen_mimir_cst_new_list_sort_by);
    dummy_var ^= ((int64_t) (void*) frbgen_mimir_cst_new_list_synonyms);
    dummy_var ^= ((int64_t) (void*) frbgen_mimir_wire__crate__api__add_documents);
    dummy_var ^= ((int64_t) (void*) frbgen_mimir_wire__crate__api__delete_all_documents);
    dummy_var ^= ((int64_t) (void*) frbgen_mimir_wire__crate__api__delete_documents);
    dummy_var ^= ((int64_t) (void*) frbgen_mimir_wire__crate__api__ensure_index_initialized);
    dummy_var ^= ((int64_t) (void*) frbgen_mimir_wire__crate__api__ensure_instance_initialized);
    dummy_var ^= ((int64_t) (void*) frbgen_mimir_wire__crate__api__get_all_documents);
    dummy_var ^= ((int64_t) (void*) frbgen_mimir_wire__crate__api__get_document);
    dummy_var ^= ((int64_t) (void*) frbgen_mimir_wire__crate__api__get_settings);
    dummy_var ^= ((int64_t) (void*) frbgen_mimir_wire__crate__api__number_of_documents);
    dummy_var ^= ((int64_t) (void*) frbgen_mimir_wire__crate__api__search_documents);
    dummy_var ^= ((int64_t) (void*) frbgen_mimir_wire__crate__api__set_documents);
    dummy_var ^= ((int64_t) (void*) frbgen_mimir_wire__crate__api__set_settings);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    return dummy_var;
}
