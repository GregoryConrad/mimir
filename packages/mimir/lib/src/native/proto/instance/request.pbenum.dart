// This is a generated file - do not edit.
//
// Generated from instance/request.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// See https://docs.meilisearch.com/reference/api/search.html#matching-strategy
class InstanceFfiRequest_IndexRequest_SearchDocuments_TermsMatchingStrategy
    extends $pb.ProtobufEnum {
  /// Remove last word first
  /// buf:lint:ignore ENUM_ZERO_VALUE_SUFFIX
  static const InstanceFfiRequest_IndexRequest_SearchDocuments_TermsMatchingStrategy
      TERMS_MATCHING_STRATEGY_LAST =
      InstanceFfiRequest_IndexRequest_SearchDocuments_TermsMatchingStrategy._(
          0, _omitEnumNames ? '' : 'TERMS_MATCHING_STRATEGY_LAST');

  /// All words are mandatory
  static const InstanceFfiRequest_IndexRequest_SearchDocuments_TermsMatchingStrategy
      TERMS_MATCHING_STRATEGY_ALL =
      InstanceFfiRequest_IndexRequest_SearchDocuments_TermsMatchingStrategy._(
          1, _omitEnumNames ? '' : 'TERMS_MATCHING_STRATEGY_ALL');

  static const $core.List<
          InstanceFfiRequest_IndexRequest_SearchDocuments_TermsMatchingStrategy>
      values =
      <InstanceFfiRequest_IndexRequest_SearchDocuments_TermsMatchingStrategy>[
    TERMS_MATCHING_STRATEGY_LAST,
    TERMS_MATCHING_STRATEGY_ALL,
  ];

  static final $core.List<
          InstanceFfiRequest_IndexRequest_SearchDocuments_TermsMatchingStrategy?>
      _byValue = $pb.ProtobufEnum.$_initByValueList(values, 1);
  static InstanceFfiRequest_IndexRequest_SearchDocuments_TermsMatchingStrategy?
      valueOf($core.int value) =>
          value < 0 || value >= _byValue.length ? null : _byValue[value];

  const InstanceFfiRequest_IndexRequest_SearchDocuments_TermsMatchingStrategy._(
      super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
