// This is a generated file - do not edit.
//
// Generated from instance/request.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use mimirIndexSettingsDescriptor instead')
const MimirIndexSettings$json = {
  '1': 'MimirIndexSettings',
  '2': [
    {
      '1': 'primary_key',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'primaryKey',
      '17': true
    },
    {
      '1': 'searchable_fields',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.instance.MimirIndexSettings.SearchableFields',
      '9': 1,
      '10': 'searchableFields',
      '17': true
    },
    {
      '1': 'filterable_fields',
      '3': 3,
      '4': 3,
      '5': 9,
      '10': 'filterableFields'
    },
    {'1': 'sortable_fields', '3': 4, '4': 3, '5': 9, '10': 'sortableFields'},
    {'1': 'ranking_rules', '3': 5, '4': 3, '5': 9, '10': 'rankingRules'},
    {'1': 'stop_words', '3': 6, '4': 3, '5': 9, '10': 'stopWords'},
    {
      '1': 'synonyms',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.instance.MimirIndexSettings.Synonyms',
      '10': 'synonyms'
    },
    {'1': 'typos_enabled', '3': 8, '4': 1, '5': 8, '10': 'typosEnabled'},
    {
      '1': 'min_word_size_for_one_typo',
      '3': 9,
      '4': 1,
      '5': 13,
      '10': 'minWordSizeForOneTypo'
    },
    {
      '1': 'min_word_size_for_two_typos',
      '3': 10,
      '4': 1,
      '5': 13,
      '10': 'minWordSizeForTwoTypos'
    },
    {
      '1': 'disallow_typos_on_words',
      '3': 11,
      '4': 3,
      '5': 9,
      '10': 'disallowTyposOnWords'
    },
    {
      '1': 'disallow_typos_on_fields',
      '3': 12,
      '4': 3,
      '5': 9,
      '10': 'disallowTyposOnFields'
    },
  ],
  '3': [
    MimirIndexSettings_SearchableFields$json,
    MimirIndexSettings_Synonyms$json
  ],
  '8': [
    {'1': '_primary_key'},
    {'1': '_searchable_fields'},
  ],
};

@$core.Deprecated('Use mimirIndexSettingsDescriptor instead')
const MimirIndexSettings_SearchableFields$json = {
  '1': 'SearchableFields',
  '2': [
    {
      '1': 'searchable_fields',
      '3': 1,
      '4': 3,
      '5': 9,
      '10': 'searchableFields'
    },
  ],
};

@$core.Deprecated('Use mimirIndexSettingsDescriptor instead')
const MimirIndexSettings_Synonyms$json = {
  '1': 'Synonyms',
  '2': [
    {'1': 'word', '3': 1, '4': 1, '5': 9, '10': 'word'},
    {'1': 'synonyms', '3': 2, '4': 3, '5': 9, '10': 'synonyms'},
  ],
};

/// Descriptor for `MimirIndexSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mimirIndexSettingsDescriptor = $convert.base64Decode(
    'ChJNaW1pckluZGV4U2V0dGluZ3MSJAoLcHJpbWFyeV9rZXkYASABKAlIAFIKcHJpbWFyeUtleY'
    'gBARJfChFzZWFyY2hhYmxlX2ZpZWxkcxgCIAEoCzItLmluc3RhbmNlLk1pbWlySW5kZXhTZXR0'
    'aW5ncy5TZWFyY2hhYmxlRmllbGRzSAFSEHNlYXJjaGFibGVGaWVsZHOIAQESKwoRZmlsdGVyYW'
    'JsZV9maWVsZHMYAyADKAlSEGZpbHRlcmFibGVGaWVsZHMSJwoPc29ydGFibGVfZmllbGRzGAQg'
    'AygJUg5zb3J0YWJsZUZpZWxkcxIjCg1yYW5raW5nX3J1bGVzGAUgAygJUgxyYW5raW5nUnVsZX'
    'MSHQoKc3RvcF93b3JkcxgGIAMoCVIJc3RvcFdvcmRzEkEKCHN5bm9ueW1zGAcgAygLMiUuaW5z'
    'dGFuY2UuTWltaXJJbmRleFNldHRpbmdzLlN5bm9ueW1zUghzeW5vbnltcxIjCg10eXBvc19lbm'
    'FibGVkGAggASgIUgx0eXBvc0VuYWJsZWQSOQoabWluX3dvcmRfc2l6ZV9mb3Jfb25lX3R5cG8Y'
    'CSABKA1SFW1pbldvcmRTaXplRm9yT25lVHlwbxI7ChttaW5fd29yZF9zaXplX2Zvcl90d29fdH'
    'lwb3MYCiABKA1SFm1pbldvcmRTaXplRm9yVHdvVHlwb3MSNQoXZGlzYWxsb3dfdHlwb3Nfb25f'
    'd29yZHMYCyADKAlSFGRpc2FsbG93VHlwb3NPbldvcmRzEjcKGGRpc2FsbG93X3R5cG9zX29uX2'
    'ZpZWxkcxgMIAMoCVIVZGlzYWxsb3dUeXBvc09uRmllbGRzGj8KEFNlYXJjaGFibGVGaWVsZHMS'
    'KwoRc2VhcmNoYWJsZV9maWVsZHMYASADKAlSEHNlYXJjaGFibGVGaWVsZHMaOgoIU3lub255bX'
    'MSEgoEd29yZBgBIAEoCVIEd29yZBIaCghzeW5vbnltcxgCIAMoCVIIc3lub255bXNCDgoMX3By'
    'aW1hcnlfa2V5QhQKEl9zZWFyY2hhYmxlX2ZpZWxkcw==');

@$core.Deprecated('Use filterDescriptor instead')
const Filter$json = {
  '1': 'Filter',
  '2': [
    {
      '1': 'or',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.instance.Filter.Filters',
      '9': 0,
      '10': 'or'
    },
    {
      '1': 'and',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.instance.Filter.Filters',
      '9': 0,
      '10': 'and'
    },
    {
      '1': 'not',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.instance.Filter',
      '9': 0,
      '10': 'not'
    },
    {
      '1': 'exists',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.instance.Filter.Field',
      '9': 0,
      '10': 'exists'
    },
    {
      '1': 'in_values',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.instance.Filter.InValues',
      '9': 0,
      '10': 'inValues'
    },
    {
      '1': 'greater_than',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.instance.Filter.Comparison',
      '9': 0,
      '10': 'greaterThan'
    },
    {
      '1': 'greater_than_or_equal',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.instance.Filter.Comparison',
      '9': 0,
      '10': 'greaterThanOrEqual'
    },
    {
      '1': 'equal',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.instance.Filter.Comparison',
      '9': 0,
      '10': 'equal'
    },
    {
      '1': 'not_equal',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.instance.Filter.Comparison',
      '9': 0,
      '10': 'notEqual'
    },
    {
      '1': 'less_than',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.instance.Filter.Comparison',
      '9': 0,
      '10': 'lessThan'
    },
    {
      '1': 'less_than_or_equal',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.instance.Filter.Comparison',
      '9': 0,
      '10': 'lessThanOrEqual'
    },
    {
      '1': 'between',
      '3': 18,
      '4': 1,
      '5': 11,
      '6': '.instance.Filter.Between',
      '9': 0,
      '10': 'between'
    },
    {
      '1': 'is_null',
      '3': 19,
      '4': 1,
      '5': 11,
      '6': '.instance.Filter.Field',
      '9': 0,
      '10': 'isNull'
    },
    {
      '1': 'is_empty',
      '3': 20,
      '4': 1,
      '5': 11,
      '6': '.instance.Filter.Field',
      '9': 0,
      '10': 'isEmpty'
    },
  ],
  '3': [
    Filter_Filters$json,
    Filter_Field$json,
    Filter_InValues$json,
    Filter_Comparison$json,
    Filter_Between$json
  ],
  '8': [
    {'1': 'kind'},
  ],
};

@$core.Deprecated('Use filterDescriptor instead')
const Filter_Filters$json = {
  '1': 'Filters',
  '2': [
    {
      '1': 'filters',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.instance.Filter',
      '10': 'filters'
    },
  ],
};

@$core.Deprecated('Use filterDescriptor instead')
const Filter_Field$json = {
  '1': 'Field',
  '2': [
    {'1': 'field', '3': 1, '4': 1, '5': 9, '10': 'field'},
  ],
};

@$core.Deprecated('Use filterDescriptor instead')
const Filter_InValues$json = {
  '1': 'InValues',
  '2': [
    {'1': 'field', '3': 1, '4': 1, '5': 9, '10': 'field'},
    {'1': 'values', '3': 2, '4': 3, '5': 9, '10': 'values'},
  ],
};

@$core.Deprecated('Use filterDescriptor instead')
const Filter_Comparison$json = {
  '1': 'Comparison',
  '2': [
    {'1': 'field', '3': 1, '4': 1, '5': 9, '10': 'field'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
};

@$core.Deprecated('Use filterDescriptor instead')
const Filter_Between$json = {
  '1': 'Between',
  '2': [
    {'1': 'field', '3': 1, '4': 1, '5': 9, '10': 'field'},
    {'1': 'from', '3': 2, '4': 1, '5': 9, '10': 'from'},
    {'1': 'to', '3': 3, '4': 1, '5': 9, '10': 'to'},
  ],
};

/// Descriptor for `Filter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List filterDescriptor = $convert.base64Decode(
    'CgZGaWx0ZXISKgoCb3IYASABKAsyGC5pbnN0YW5jZS5GaWx0ZXIuRmlsdGVyc0gAUgJvchIsCg'
    'NhbmQYAiABKAsyGC5pbnN0YW5jZS5GaWx0ZXIuRmlsdGVyc0gAUgNhbmQSJAoDbm90GAMgASgL'
    'MhAuaW5zdGFuY2UuRmlsdGVySABSA25vdBIwCgZleGlzdHMYCiABKAsyFi5pbnN0YW5jZS5GaW'
    'x0ZXIuRmllbGRIAFIGZXhpc3RzEjgKCWluX3ZhbHVlcxgLIAEoCzIZLmluc3RhbmNlLkZpbHRl'
    'ci5JblZhbHVlc0gAUghpblZhbHVlcxJACgxncmVhdGVyX3RoYW4YDCABKAsyGy5pbnN0YW5jZS'
    '5GaWx0ZXIuQ29tcGFyaXNvbkgAUgtncmVhdGVyVGhhbhJQChVncmVhdGVyX3RoYW5fb3JfZXF1'
    'YWwYDSABKAsyGy5pbnN0YW5jZS5GaWx0ZXIuQ29tcGFyaXNvbkgAUhJncmVhdGVyVGhhbk9yRX'
    'F1YWwSMwoFZXF1YWwYDiABKAsyGy5pbnN0YW5jZS5GaWx0ZXIuQ29tcGFyaXNvbkgAUgVlcXVh'
    'bBI6Cglub3RfZXF1YWwYDyABKAsyGy5pbnN0YW5jZS5GaWx0ZXIuQ29tcGFyaXNvbkgAUghub3'
    'RFcXVhbBI6CglsZXNzX3RoYW4YECABKAsyGy5pbnN0YW5jZS5GaWx0ZXIuQ29tcGFyaXNvbkgA'
    'UghsZXNzVGhhbhJKChJsZXNzX3RoYW5fb3JfZXF1YWwYESABKAsyGy5pbnN0YW5jZS5GaWx0ZX'
    'IuQ29tcGFyaXNvbkgAUg9sZXNzVGhhbk9yRXF1YWwSNAoHYmV0d2VlbhgSIAEoCzIYLmluc3Rh'
    'bmNlLkZpbHRlci5CZXR3ZWVuSABSB2JldHdlZW4SMQoHaXNfbnVsbBgTIAEoCzIWLmluc3Rhbm'
    'NlLkZpbHRlci5GaWVsZEgAUgZpc051bGwSMwoIaXNfZW1wdHkYFCABKAsyFi5pbnN0YW5jZS5G'
    'aWx0ZXIuRmllbGRIAFIHaXNFbXB0eRo1CgdGaWx0ZXJzEioKB2ZpbHRlcnMYASADKAsyEC5pbn'
    'N0YW5jZS5GaWx0ZXJSB2ZpbHRlcnMaHQoFRmllbGQSFAoFZmllbGQYASABKAlSBWZpZWxkGjgK'
    'CEluVmFsdWVzEhQKBWZpZWxkGAEgASgJUgVmaWVsZBIWCgZ2YWx1ZXMYAiADKAlSBnZhbHVlcx'
    'o4CgpDb21wYXJpc29uEhQKBWZpZWxkGAEgASgJUgVmaWVsZBIUCgV2YWx1ZRgCIAEoCVIFdmFs'
    'dWUaQwoHQmV0d2VlbhIUCgVmaWVsZBgBIAEoCVIFZmllbGQSEgoEZnJvbRgCIAEoCVIEZnJvbR'
    'IOCgJ0bxgDIAEoCVICdG9CBgoEa2luZA==');

@$core.Deprecated('Use instanceFfiRequestDescriptor instead')
const InstanceFfiRequest$json = {
  '1': 'InstanceFfiRequest',
  '2': [
    {'1': 'instance_dir', '3': 1, '4': 1, '5': 9, '10': 'instanceDir'},
    {
      '1': 'ensure_instance_initialized',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.instance.InstanceFfiRequest.EnsureInitialized',
      '9': 0,
      '10': 'ensureInstanceInitialized'
    },
    {
      '1': 'index_request',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.instance.InstanceFfiRequest.IndexRequest',
      '9': 0,
      '10': 'indexRequest'
    },
  ],
  '3': [
    InstanceFfiRequest_EnsureInitialized$json,
    InstanceFfiRequest_IndexRequest$json
  ],
  '8': [
    {'1': 'kind'},
  ],
};

@$core.Deprecated('Use instanceFfiRequestDescriptor instead')
const InstanceFfiRequest_EnsureInitialized$json = {
  '1': 'EnsureInitialized',
  '2': [
    {
      '1': 'tmp_dir',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'tmpDir',
      '17': true
    },
  ],
  '8': [
    {'1': '_tmp_dir'},
  ],
};

@$core.Deprecated('Use instanceFfiRequestDescriptor instead')
const InstanceFfiRequest_IndexRequest$json = {
  '1': 'IndexRequest',
  '2': [
    {'1': 'index_name', '3': 1, '4': 1, '5': 9, '10': 'indexName'},
    {
      '1': 'ensure_index_initialized',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.instance.InstanceFfiRequest.IndexRequest.EnsureInitialized',
      '9': 0,
      '10': 'ensureIndexInitialized'
    },
    {
      '1': 'add_documents',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.instance.InstanceFfiRequest.IndexRequest.AddDocuments',
      '9': 0,
      '10': 'addDocuments'
    },
    {
      '1': 'delete_documents',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.instance.InstanceFfiRequest.IndexRequest.DeleteDocuments',
      '9': 0,
      '10': 'deleteDocuments'
    },
    {
      '1': 'delete_all_documents',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.instance.InstanceFfiRequest.IndexRequest.DeleteAllDocuments',
      '9': 0,
      '10': 'deleteAllDocuments'
    },
    {
      '1': 'set_documents',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.instance.InstanceFfiRequest.IndexRequest.SetDocuments',
      '9': 0,
      '10': 'setDocuments'
    },
    {
      '1': 'get_document',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.instance.InstanceFfiRequest.IndexRequest.GetDocument',
      '9': 0,
      '10': 'getDocument'
    },
    {
      '1': 'get_all_documents',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.instance.InstanceFfiRequest.IndexRequest.GetAllDocuments',
      '9': 0,
      '10': 'getAllDocuments'
    },
    {
      '1': 'search_documents',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.instance.InstanceFfiRequest.IndexRequest.SearchDocuments',
      '9': 0,
      '10': 'searchDocuments'
    },
    {
      '1': 'number_of_documents',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.instance.InstanceFfiRequest.IndexRequest.NumberOfDocuments',
      '9': 0,
      '10': 'numberOfDocuments'
    },
    {
      '1': 'get_settings',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.instance.InstanceFfiRequest.IndexRequest.GetSettings',
      '9': 0,
      '10': 'getSettings'
    },
    {
      '1': 'set_settings',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.instance.InstanceFfiRequest.IndexRequest.SetSettings',
      '9': 0,
      '10': 'setSettings'
    },
  ],
  '3': [
    InstanceFfiRequest_IndexRequest_EnsureInitialized$json,
    InstanceFfiRequest_IndexRequest_AddDocuments$json,
    InstanceFfiRequest_IndexRequest_DeleteDocuments$json,
    InstanceFfiRequest_IndexRequest_DeleteAllDocuments$json,
    InstanceFfiRequest_IndexRequest_SetDocuments$json,
    InstanceFfiRequest_IndexRequest_GetDocument$json,
    InstanceFfiRequest_IndexRequest_GetAllDocuments$json,
    InstanceFfiRequest_IndexRequest_SearchDocuments$json,
    InstanceFfiRequest_IndexRequest_NumberOfDocuments$json,
    InstanceFfiRequest_IndexRequest_GetSettings$json,
    InstanceFfiRequest_IndexRequest_SetSettings$json
  ],
  '8': [
    {'1': 'kind'},
  ],
};

@$core.Deprecated('Use instanceFfiRequestDescriptor instead')
const InstanceFfiRequest_IndexRequest_EnsureInitialized$json = {
  '1': 'EnsureInitialized',
};

@$core.Deprecated('Use instanceFfiRequestDescriptor instead')
const InstanceFfiRequest_IndexRequest_AddDocuments$json = {
  '1': 'AddDocuments',
  '2': [
    {'1': 'documents', '3': 1, '4': 3, '5': 9, '10': 'documents'},
  ],
};

@$core.Deprecated('Use instanceFfiRequestDescriptor instead')
const InstanceFfiRequest_IndexRequest_DeleteDocuments$json = {
  '1': 'DeleteDocuments',
  '2': [
    {'1': 'document_ids', '3': 1, '4': 3, '5': 9, '10': 'documentIds'},
  ],
};

@$core.Deprecated('Use instanceFfiRequestDescriptor instead')
const InstanceFfiRequest_IndexRequest_DeleteAllDocuments$json = {
  '1': 'DeleteAllDocuments',
};

@$core.Deprecated('Use instanceFfiRequestDescriptor instead')
const InstanceFfiRequest_IndexRequest_SetDocuments$json = {
  '1': 'SetDocuments',
  '2': [
    {'1': 'documents', '3': 1, '4': 3, '5': 9, '10': 'documents'},
  ],
};

@$core.Deprecated('Use instanceFfiRequestDescriptor instead')
const InstanceFfiRequest_IndexRequest_GetDocument$json = {
  '1': 'GetDocument',
  '2': [
    {'1': 'document_id', '3': 1, '4': 1, '5': 9, '10': 'documentId'},
  ],
};

@$core.Deprecated('Use instanceFfiRequestDescriptor instead')
const InstanceFfiRequest_IndexRequest_GetAllDocuments$json = {
  '1': 'GetAllDocuments',
};

@$core.Deprecated('Use instanceFfiRequestDescriptor instead')
const InstanceFfiRequest_IndexRequest_SearchDocuments$json = {
  '1': 'SearchDocuments',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'query', '17': true},
    {'1': 'limit', '3': 2, '4': 1, '5': 13, '9': 1, '10': 'limit', '17': true},
    {
      '1': 'offset',
      '3': 3,
      '4': 1,
      '5': 13,
      '9': 2,
      '10': 'offset',
      '17': true
    },
    {
      '1': 'filter',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.instance.Filter',
      '9': 3,
      '10': 'filter',
      '17': true
    },
    {
      '1': 'terms_matching_strategy',
      '3': 5,
      '4': 1,
      '5': 14,
      '6':
          '.instance.InstanceFfiRequest.IndexRequest.SearchDocuments.TermsMatchingStrategy',
      '9': 4,
      '10': 'termsMatchingStrategy',
      '17': true
    },
    {
      '1': 'sort_criteria',
      '3': 6,
      '4': 1,
      '5': 11,
      '6':
          '.instance.InstanceFfiRequest.IndexRequest.SearchDocuments.SortCriteria',
      '9': 5,
      '10': 'sortCriteria',
      '17': true
    },
  ],
  '3': [
    InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria$json,
    InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy$json
  ],
  '4': [
    InstanceFfiRequest_IndexRequest_SearchDocuments_TermsMatchingStrategy$json
  ],
  '8': [
    {'1': '_query'},
    {'1': '_limit'},
    {'1': '_offset'},
    {'1': '_filter'},
    {'1': '_terms_matching_strategy'},
    {'1': '_sort_criteria'},
  ],
};

@$core.Deprecated('Use instanceFfiRequestDescriptor instead')
const InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria$json = {
  '1': 'SortCriteria',
  '2': [
    {
      '1': 'sort_criteria',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.instance.InstanceFfiRequest.IndexRequest.SearchDocuments.SortBy',
      '10': 'sortCriteria'
    },
  ],
};

@$core.Deprecated('Use instanceFfiRequestDescriptor instead')
const InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy$json = {
  '1': 'SortBy',
  '2': [
    {'1': 'asc', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'asc'},
    {'1': 'desc', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'desc'},
  ],
  '8': [
    {'1': 'kind'},
  ],
};

@$core.Deprecated('Use instanceFfiRequestDescriptor instead')
const InstanceFfiRequest_IndexRequest_SearchDocuments_TermsMatchingStrategy$json =
    {
  '1': 'TermsMatchingStrategy',
  '2': [
    {'1': 'TERMS_MATCHING_STRATEGY_LAST', '2': 0},
    {'1': 'TERMS_MATCHING_STRATEGY_ALL', '2': 1},
  ],
};

@$core.Deprecated('Use instanceFfiRequestDescriptor instead')
const InstanceFfiRequest_IndexRequest_NumberOfDocuments$json = {
  '1': 'NumberOfDocuments',
};

@$core.Deprecated('Use instanceFfiRequestDescriptor instead')
const InstanceFfiRequest_IndexRequest_GetSettings$json = {
  '1': 'GetSettings',
};

@$core.Deprecated('Use instanceFfiRequestDescriptor instead')
const InstanceFfiRequest_IndexRequest_SetSettings$json = {
  '1': 'SetSettings',
  '2': [
    {
      '1': 'settings',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.instance.MimirIndexSettings',
      '10': 'settings'
    },
  ],
};

/// Descriptor for `InstanceFfiRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List instanceFfiRequestDescriptor = $convert.base64Decode(
    'ChJJbnN0YW5jZUZmaVJlcXVlc3QSIQoMaW5zdGFuY2VfZGlyGAEgASgJUgtpbnN0YW5jZURpch'
    'JwChtlbnN1cmVfaW5zdGFuY2VfaW5pdGlhbGl6ZWQYAiABKAsyLi5pbnN0YW5jZS5JbnN0YW5j'
    'ZUZmaVJlcXVlc3QuRW5zdXJlSW5pdGlhbGl6ZWRIAFIZZW5zdXJlSW5zdGFuY2VJbml0aWFsaX'
    'plZBJQCg1pbmRleF9yZXF1ZXN0GAMgASgLMikuaW5zdGFuY2UuSW5zdGFuY2VGZmlSZXF1ZXN0'
    'LkluZGV4UmVxdWVzdEgAUgxpbmRleFJlcXVlc3QaPQoRRW5zdXJlSW5pdGlhbGl6ZWQSHAoHdG'
    '1wX2RpchgBIAEoCUgAUgZ0bXBEaXKIAQFCCgoIX3RtcF9kaXIahRIKDEluZGV4UmVxdWVzdBId'
    'CgppbmRleF9uYW1lGAEgASgJUglpbmRleE5hbWUSdwoYZW5zdXJlX2luZGV4X2luaXRpYWxpem'
    'VkGAIgASgLMjsuaW5zdGFuY2UuSW5zdGFuY2VGZmlSZXF1ZXN0LkluZGV4UmVxdWVzdC5FbnN1'
    'cmVJbml0aWFsaXplZEgAUhZlbnN1cmVJbmRleEluaXRpYWxpemVkEl0KDWFkZF9kb2N1bWVudH'
    'MYAyABKAsyNi5pbnN0YW5jZS5JbnN0YW5jZUZmaVJlcXVlc3QuSW5kZXhSZXF1ZXN0LkFkZERv'
    'Y3VtZW50c0gAUgxhZGREb2N1bWVudHMSZgoQZGVsZXRlX2RvY3VtZW50cxgEIAEoCzI5Lmluc3'
    'RhbmNlLkluc3RhbmNlRmZpUmVxdWVzdC5JbmRleFJlcXVlc3QuRGVsZXRlRG9jdW1lbnRzSABS'
    'D2RlbGV0ZURvY3VtZW50cxJwChRkZWxldGVfYWxsX2RvY3VtZW50cxgFIAEoCzI8Lmluc3Rhbm'
    'NlLkluc3RhbmNlRmZpUmVxdWVzdC5JbmRleFJlcXVlc3QuRGVsZXRlQWxsRG9jdW1lbnRzSABS'
    'EmRlbGV0ZUFsbERvY3VtZW50cxJdCg1zZXRfZG9jdW1lbnRzGAYgASgLMjYuaW5zdGFuY2UuSW'
    '5zdGFuY2VGZmlSZXF1ZXN0LkluZGV4UmVxdWVzdC5TZXREb2N1bWVudHNIAFIMc2V0RG9jdW1l'
    'bnRzEloKDGdldF9kb2N1bWVudBgHIAEoCzI1Lmluc3RhbmNlLkluc3RhbmNlRmZpUmVxdWVzdC'
    '5JbmRleFJlcXVlc3QuR2V0RG9jdW1lbnRIAFILZ2V0RG9jdW1lbnQSZwoRZ2V0X2FsbF9kb2N1'
    'bWVudHMYCCABKAsyOS5pbnN0YW5jZS5JbnN0YW5jZUZmaVJlcXVlc3QuSW5kZXhSZXF1ZXN0Lk'
    'dldEFsbERvY3VtZW50c0gAUg9nZXRBbGxEb2N1bWVudHMSZgoQc2VhcmNoX2RvY3VtZW50cxgJ'
    'IAEoCzI5Lmluc3RhbmNlLkluc3RhbmNlRmZpUmVxdWVzdC5JbmRleFJlcXVlc3QuU2VhcmNoRG'
    '9jdW1lbnRzSABSD3NlYXJjaERvY3VtZW50cxJtChNudW1iZXJfb2ZfZG9jdW1lbnRzGAogASgL'
    'MjsuaW5zdGFuY2UuSW5zdGFuY2VGZmlSZXF1ZXN0LkluZGV4UmVxdWVzdC5OdW1iZXJPZkRvY3'
    'VtZW50c0gAUhFudW1iZXJPZkRvY3VtZW50cxJaCgxnZXRfc2V0dGluZ3MYCyABKAsyNS5pbnN0'
    'YW5jZS5JbnN0YW5jZUZmaVJlcXVlc3QuSW5kZXhSZXF1ZXN0LkdldFNldHRpbmdzSABSC2dldF'
    'NldHRpbmdzEloKDHNldF9zZXR0aW5ncxgMIAEoCzI1Lmluc3RhbmNlLkluc3RhbmNlRmZpUmVx'
    'dWVzdC5JbmRleFJlcXVlc3QuU2V0U2V0dGluZ3NIAFILc2V0U2V0dGluZ3MaEwoRRW5zdXJlSW'
    '5pdGlhbGl6ZWQaLAoMQWRkRG9jdW1lbnRzEhwKCWRvY3VtZW50cxgBIAMoCVIJZG9jdW1lbnRz'
    'GjQKD0RlbGV0ZURvY3VtZW50cxIhCgxkb2N1bWVudF9pZHMYASADKAlSC2RvY3VtZW50SWRzGh'
    'QKEkRlbGV0ZUFsbERvY3VtZW50cxosCgxTZXREb2N1bWVudHMSHAoJZG9jdW1lbnRzGAEgAygJ'
    'Uglkb2N1bWVudHMaLgoLR2V0RG9jdW1lbnQSHwoLZG9jdW1lbnRfaWQYASABKAlSCmRvY3VtZW'
    '50SWQaEQoPR2V0QWxsRG9jdW1lbnRzGvsFCg9TZWFyY2hEb2N1bWVudHMSGQoFcXVlcnkYASAB'
    'KAlIAFIFcXVlcnmIAQESGQoFbGltaXQYAiABKA1IAVIFbGltaXSIAQESGwoGb2Zmc2V0GAMgAS'
    'gNSAJSBm9mZnNldIgBARItCgZmaWx0ZXIYBCABKAsyEC5pbnN0YW5jZS5GaWx0ZXJIA1IGZmls'
    'dGVyiAEBEowBChd0ZXJtc19tYXRjaGluZ19zdHJhdGVneRgFIAEoDjJPLmluc3RhbmNlLkluc3'
    'RhbmNlRmZpUmVxdWVzdC5JbmRleFJlcXVlc3QuU2VhcmNoRG9jdW1lbnRzLlRlcm1zTWF0Y2hp'
    'bmdTdHJhdGVneUgEUhV0ZXJtc01hdGNoaW5nU3RyYXRlZ3mIAQEScAoNc29ydF9jcml0ZXJpYR'
    'gGIAEoCzJGLmluc3RhbmNlLkluc3RhbmNlRmZpUmVxdWVzdC5JbmRleFJlcXVlc3QuU2VhcmNo'
    'RG9jdW1lbnRzLlNvcnRDcml0ZXJpYUgFUgxzb3J0Q3JpdGVyaWGIAQEadQoMU29ydENyaXRlcm'
    'lhEmUKDXNvcnRfY3JpdGVyaWEYASADKAsyQC5pbnN0YW5jZS5JbnN0YW5jZUZmaVJlcXVlc3Qu'
    'SW5kZXhSZXF1ZXN0LlNlYXJjaERvY3VtZW50cy5Tb3J0QnlSDHNvcnRDcml0ZXJpYRo6CgZTb3'
    'J0QnkSEgoDYXNjGAEgASgJSABSA2FzYxIUCgRkZXNjGAIgASgJSABSBGRlc2NCBgoEa2luZCJa'
    'ChVUZXJtc01hdGNoaW5nU3RyYXRlZ3kSIAocVEVSTVNfTUFUQ0hJTkdfU1RSQVRFR1lfTEFTVB'
    'AAEh8KG1RFUk1TX01BVENISU5HX1NUUkFURUdZX0FMTBABQggKBl9xdWVyeUIICgZfbGltaXRC'
    'CQoHX29mZnNldEIJCgdfZmlsdGVyQhoKGF90ZXJtc19tYXRjaGluZ19zdHJhdGVneUIQCg5fc2'
    '9ydF9jcml0ZXJpYRoTChFOdW1iZXJPZkRvY3VtZW50cxoNCgtHZXRTZXR0aW5ncxpHCgtTZXRT'
    'ZXR0aW5ncxI4CghzZXR0aW5ncxgBIAEoCzIcLmluc3RhbmNlLk1pbWlySW5kZXhTZXR0aW5nc1'
    'IIc2V0dGluZ3NCBgoEa2luZEIGCgRraW5k');

@$core.Deprecated('Use instanceFfiResponseDescriptor instead')
const InstanceFfiResponse$json = {
  '1': 'InstanceFfiResponse',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 9, '9': 1, '10': 'error', '17': true},
    {
      '1': 'document',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.instance.InstanceFfiResponse.OptionalDocument',
      '9': 0,
      '10': 'document'
    },
    {
      '1': 'documents',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.instance.InstanceFfiResponse.Documents',
      '9': 0,
      '10': 'documents'
    },
    {
      '1': 'number_of_documents',
      '3': 4,
      '4': 1,
      '5': 4,
      '9': 0,
      '10': 'numberOfDocuments'
    },
    {
      '1': 'index_settings',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.instance.MimirIndexSettings',
      '9': 0,
      '10': 'indexSettings'
    },
  ],
  '3': [
    InstanceFfiResponse_OptionalDocument$json,
    InstanceFfiResponse_Documents$json
  ],
  '8': [
    {'1': 'kind'},
    {'1': '_error'},
  ],
};

@$core.Deprecated('Use instanceFfiResponseDescriptor instead')
const InstanceFfiResponse_OptionalDocument$json = {
  '1': 'OptionalDocument',
  '2': [
    {
      '1': 'document',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'document',
      '17': true
    },
  ],
  '8': [
    {'1': '_document'},
  ],
};

@$core.Deprecated('Use instanceFfiResponseDescriptor instead')
const InstanceFfiResponse_Documents$json = {
  '1': 'Documents',
  '2': [
    {'1': 'documents', '3': 1, '4': 3, '5': 9, '10': 'documents'},
  ],
};

/// Descriptor for `InstanceFfiResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List instanceFfiResponseDescriptor = $convert.base64Decode(
    'ChNJbnN0YW5jZUZmaVJlc3BvbnNlEhkKBWVycm9yGAEgASgJSAFSBWVycm9yiAEBEkwKCGRvY3'
    'VtZW50GAIgASgLMi4uaW5zdGFuY2UuSW5zdGFuY2VGZmlSZXNwb25zZS5PcHRpb25hbERvY3Vt'
    'ZW50SABSCGRvY3VtZW50EkcKCWRvY3VtZW50cxgDIAEoCzInLmluc3RhbmNlLkluc3RhbmNlRm'
    'ZpUmVzcG9uc2UuRG9jdW1lbnRzSABSCWRvY3VtZW50cxIwChNudW1iZXJfb2ZfZG9jdW1lbnRz'
    'GAQgASgESABSEW51bWJlck9mRG9jdW1lbnRzEkUKDmluZGV4X3NldHRpbmdzGAUgASgLMhwuaW'
    '5zdGFuY2UuTWltaXJJbmRleFNldHRpbmdzSABSDWluZGV4U2V0dGluZ3MaQAoQT3B0aW9uYWxE'
    'b2N1bWVudBIfCghkb2N1bWVudBgBIAEoCUgAUghkb2N1bWVudIgBAUILCglfZG9jdW1lbnQaKQ'
    'oJRG9jdW1lbnRzEhwKCWRvY3VtZW50cxgBIAMoCVIJZG9jdW1lbnRzQgYKBGtpbmRCCAoGX2Vy'
    'cm9y');
