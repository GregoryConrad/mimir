// This is a generated file - do not edit.
//
// Generated from instance/request.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'request.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'request.pbenum.dart';

/// Represents the searchable fields
class MimirIndexSettings_SearchableFields extends $pb.GeneratedMessage {
  factory MimirIndexSettings_SearchableFields({
    $core.Iterable<$core.String>? searchableFields,
  }) {
    final result = create();
    if (searchableFields != null)
      result.searchableFields.addAll(searchableFields);
    return result;
  }

  MimirIndexSettings_SearchableFields._();

  factory MimirIndexSettings_SearchableFields.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MimirIndexSettings_SearchableFields.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MimirIndexSettings.SearchableFields',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'searchableFields')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MimirIndexSettings_SearchableFields clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MimirIndexSettings_SearchableFields copyWith(
          void Function(MimirIndexSettings_SearchableFields) updates) =>
      super.copyWith((message) =>
              updates(message as MimirIndexSettings_SearchableFields))
          as MimirIndexSettings_SearchableFields;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MimirIndexSettings_SearchableFields create() =>
      MimirIndexSettings_SearchableFields._();
  @$core.override
  MimirIndexSettings_SearchableFields createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MimirIndexSettings_SearchableFields getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          MimirIndexSettings_SearchableFields>(create);
  static MimirIndexSettings_SearchableFields? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get searchableFields => $_getList(0);
}

/// Represents the synonyms of a given word
class MimirIndexSettings_Synonyms extends $pb.GeneratedMessage {
  factory MimirIndexSettings_Synonyms({
    $core.String? word,
    $core.Iterable<$core.String>? synonyms,
  }) {
    final result = create();
    if (word != null) result.word = word;
    if (synonyms != null) result.synonyms.addAll(synonyms);
    return result;
  }

  MimirIndexSettings_Synonyms._();

  factory MimirIndexSettings_Synonyms.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MimirIndexSettings_Synonyms.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MimirIndexSettings.Synonyms',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'word')
    ..pPS(2, _omitFieldNames ? '' : 'synonyms')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MimirIndexSettings_Synonyms clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MimirIndexSettings_Synonyms copyWith(
          void Function(MimirIndexSettings_Synonyms) updates) =>
      super.copyWith(
              (message) => updates(message as MimirIndexSettings_Synonyms))
          as MimirIndexSettings_Synonyms;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MimirIndexSettings_Synonyms create() =>
      MimirIndexSettings_Synonyms._();
  @$core.override
  MimirIndexSettings_Synonyms createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MimirIndexSettings_Synonyms getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MimirIndexSettings_Synonyms>(create);
  static MimirIndexSettings_Synonyms? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get word => $_getSZ(0);
  @$pb.TagNumber(1)
  set word($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWord() => $_has(0);
  @$pb.TagNumber(1)
  void clearWord() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get synonyms => $_getList(1);
}

/// The settings of a mimir index
class MimirIndexSettings extends $pb.GeneratedMessage {
  factory MimirIndexSettings({
    $core.String? primaryKey,
    MimirIndexSettings_SearchableFields? searchableFields,
    $core.Iterable<$core.String>? filterableFields,
    $core.Iterable<$core.String>? sortableFields,
    $core.Iterable<$core.String>? rankingRules,
    $core.Iterable<$core.String>? stopWords,
    $core.Iterable<MimirIndexSettings_Synonyms>? synonyms,
    $core.bool? typosEnabled,
    $core.int? minWordSizeForOneTypo,
    $core.int? minWordSizeForTwoTypos,
    $core.Iterable<$core.String>? disallowTyposOnWords,
    $core.Iterable<$core.String>? disallowTyposOnFields,
  }) {
    final result = create();
    if (primaryKey != null) result.primaryKey = primaryKey;
    if (searchableFields != null) result.searchableFields = searchableFields;
    if (filterableFields != null)
      result.filterableFields.addAll(filterableFields);
    if (sortableFields != null) result.sortableFields.addAll(sortableFields);
    if (rankingRules != null) result.rankingRules.addAll(rankingRules);
    if (stopWords != null) result.stopWords.addAll(stopWords);
    if (synonyms != null) result.synonyms.addAll(synonyms);
    if (typosEnabled != null) result.typosEnabled = typosEnabled;
    if (minWordSizeForOneTypo != null)
      result.minWordSizeForOneTypo = minWordSizeForOneTypo;
    if (minWordSizeForTwoTypos != null)
      result.minWordSizeForTwoTypos = minWordSizeForTwoTypos;
    if (disallowTyposOnWords != null)
      result.disallowTyposOnWords.addAll(disallowTyposOnWords);
    if (disallowTyposOnFields != null)
      result.disallowTyposOnFields.addAll(disallowTyposOnFields);
    return result;
  }

  MimirIndexSettings._();

  factory MimirIndexSettings.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MimirIndexSettings.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MimirIndexSettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'primaryKey')
    ..aOM<MimirIndexSettings_SearchableFields>(
        2, _omitFieldNames ? '' : 'searchableFields',
        subBuilder: MimirIndexSettings_SearchableFields.create)
    ..pPS(3, _omitFieldNames ? '' : 'filterableFields')
    ..pPS(4, _omitFieldNames ? '' : 'sortableFields')
    ..pPS(5, _omitFieldNames ? '' : 'rankingRules')
    ..pPS(6, _omitFieldNames ? '' : 'stopWords')
    ..pPM<MimirIndexSettings_Synonyms>(7, _omitFieldNames ? '' : 'synonyms',
        subBuilder: MimirIndexSettings_Synonyms.create)
    ..aOB(8, _omitFieldNames ? '' : 'typosEnabled')
    ..aI(9, _omitFieldNames ? '' : 'minWordSizeForOneTypo',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(10, _omitFieldNames ? '' : 'minWordSizeForTwoTypos',
        fieldType: $pb.PbFieldType.OU3)
    ..pPS(11, _omitFieldNames ? '' : 'disallowTyposOnWords')
    ..pPS(12, _omitFieldNames ? '' : 'disallowTyposOnFields')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MimirIndexSettings clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MimirIndexSettings copyWith(void Function(MimirIndexSettings) updates) =>
      super.copyWith((message) => updates(message as MimirIndexSettings))
          as MimirIndexSettings;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MimirIndexSettings create() => MimirIndexSettings._();
  @$core.override
  MimirIndexSettings createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MimirIndexSettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MimirIndexSettings>(create);
  static MimirIndexSettings? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get primaryKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set primaryKey($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPrimaryKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearPrimaryKey() => $_clearField(1);

  @$pb.TagNumber(2)
  MimirIndexSettings_SearchableFields get searchableFields => $_getN(1);
  @$pb.TagNumber(2)
  set searchableFields(MimirIndexSettings_SearchableFields value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSearchableFields() => $_has(1);
  @$pb.TagNumber(2)
  void clearSearchableFields() => $_clearField(2);
  @$pb.TagNumber(2)
  MimirIndexSettings_SearchableFields ensureSearchableFields() => $_ensure(1);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get filterableFields => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get sortableFields => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get rankingRules => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get stopWords => $_getList(5);

  @$pb.TagNumber(7)
  $pb.PbList<MimirIndexSettings_Synonyms> get synonyms => $_getList(6);

  @$pb.TagNumber(8)
  $core.bool get typosEnabled => $_getBF(7);
  @$pb.TagNumber(8)
  set typosEnabled($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTyposEnabled() => $_has(7);
  @$pb.TagNumber(8)
  void clearTyposEnabled() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get minWordSizeForOneTypo => $_getIZ(8);
  @$pb.TagNumber(9)
  set minWordSizeForOneTypo($core.int value) => $_setUnsignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasMinWordSizeForOneTypo() => $_has(8);
  @$pb.TagNumber(9)
  void clearMinWordSizeForOneTypo() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get minWordSizeForTwoTypos => $_getIZ(9);
  @$pb.TagNumber(10)
  set minWordSizeForTwoTypos($core.int value) => $_setUnsignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasMinWordSizeForTwoTypos() => $_has(9);
  @$pb.TagNumber(10)
  void clearMinWordSizeForTwoTypos() => $_clearField(10);

  @$pb.TagNumber(11)
  $pb.PbList<$core.String> get disallowTyposOnWords => $_getList(10);

  @$pb.TagNumber(12)
  $pb.PbList<$core.String> get disallowTyposOnFields => $_getList(11);
}

/// For Or/And, when we need repeated sub-filters
class Filter_Filters extends $pb.GeneratedMessage {
  factory Filter_Filters({
    $core.Iterable<Filter>? filters,
  }) {
    final result = create();
    if (filters != null) result.filters.addAll(filters);
    return result;
  }

  Filter_Filters._();

  factory Filter_Filters.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Filter_Filters.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Filter.Filters',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..pPM<Filter>(1, _omitFieldNames ? '' : 'filters',
        subBuilder: Filter.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Filter_Filters clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Filter_Filters copyWith(void Function(Filter_Filters) updates) =>
      super.copyWith((message) => updates(message as Filter_Filters))
          as Filter_Filters;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Filter_Filters create() => Filter_Filters._();
  @$core.override
  Filter_Filters createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Filter_Filters getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Filter_Filters>(create);
  static Filter_Filters? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Filter> get filters => $_getList(0);
}

/// For field-only cases (IsNull, IsEmpty, Exists)
class Filter_Field extends $pb.GeneratedMessage {
  factory Filter_Field({
    $core.String? field_1,
  }) {
    final result = create();
    if (field_1 != null) result.field_1 = field_1;
    return result;
  }

  Filter_Field._();

  factory Filter_Field.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Filter_Field.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Filter.Field',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'field')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Filter_Field clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Filter_Field copyWith(void Function(Filter_Field) updates) =>
      super.copyWith((message) => updates(message as Filter_Field))
          as Filter_Field;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Filter_Field create() => Filter_Field._();
  @$core.override
  Filter_Field createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Filter_Field getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Filter_Field>(create);
  static Filter_Field? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get field_1 => $_getSZ(0);
  @$pb.TagNumber(1)
  set field_1($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasField_1() => $_has(0);
  @$pb.TagNumber(1)
  void clearField_1() => $_clearField(1);
}

/// For IN operator
class Filter_InValues extends $pb.GeneratedMessage {
  factory Filter_InValues({
    $core.String? field_1,
    $core.Iterable<$core.String>? values,
  }) {
    final result = create();
    if (field_1 != null) result.field_1 = field_1;
    if (values != null) result.values.addAll(values);
    return result;
  }

  Filter_InValues._();

  factory Filter_InValues.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Filter_InValues.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Filter.InValues',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'field')
    ..pPS(2, _omitFieldNames ? '' : 'values')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Filter_InValues clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Filter_InValues copyWith(void Function(Filter_InValues) updates) =>
      super.copyWith((message) => updates(message as Filter_InValues))
          as Filter_InValues;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Filter_InValues create() => Filter_InValues._();
  @$core.override
  Filter_InValues createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Filter_InValues getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Filter_InValues>(create);
  static Filter_InValues? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get field_1 => $_getSZ(0);
  @$pb.TagNumber(1)
  set field_1($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasField_1() => $_has(0);
  @$pb.TagNumber(1)
  void clearField_1() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get values => $_getList(1);
}

/// For comparisons like >, >=, ==, etc.
class Filter_Comparison extends $pb.GeneratedMessage {
  factory Filter_Comparison({
    $core.String? field_1,
    $core.String? value,
  }) {
    final result = create();
    if (field_1 != null) result.field_1 = field_1;
    if (value != null) result.value = value;
    return result;
  }

  Filter_Comparison._();

  factory Filter_Comparison.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Filter_Comparison.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Filter.Comparison',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'field')
    ..aOS(2, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Filter_Comparison clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Filter_Comparison copyWith(void Function(Filter_Comparison) updates) =>
      super.copyWith((message) => updates(message as Filter_Comparison))
          as Filter_Comparison;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Filter_Comparison create() => Filter_Comparison._();
  @$core.override
  Filter_Comparison createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Filter_Comparison getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Filter_Comparison>(create);
  static Filter_Comparison? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get field_1 => $_getSZ(0);
  @$pb.TagNumber(1)
  set field_1($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasField_1() => $_has(0);
  @$pb.TagNumber(1)
  void clearField_1() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);
}

/// For BETWEEN operator
class Filter_Between extends $pb.GeneratedMessage {
  factory Filter_Between({
    $core.String? field_1,
    $core.String? from,
    $core.String? to,
  }) {
    final result = create();
    if (field_1 != null) result.field_1 = field_1;
    if (from != null) result.from = from;
    if (to != null) result.to = to;
    return result;
  }

  Filter_Between._();

  factory Filter_Between.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Filter_Between.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Filter.Between',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'field')
    ..aOS(2, _omitFieldNames ? '' : 'from')
    ..aOS(3, _omitFieldNames ? '' : 'to')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Filter_Between clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Filter_Between copyWith(void Function(Filter_Between) updates) =>
      super.copyWith((message) => updates(message as Filter_Between))
          as Filter_Between;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Filter_Between create() => Filter_Between._();
  @$core.override
  Filter_Between createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Filter_Between getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Filter_Between>(create);
  static Filter_Between? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get field_1 => $_getSZ(0);
  @$pb.TagNumber(1)
  set field_1($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasField_1() => $_has(0);
  @$pb.TagNumber(1)
  void clearField_1() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get from => $_getSZ(1);
  @$pb.TagNumber(2)
  set from($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFrom() => $_has(1);
  @$pb.TagNumber(2)
  void clearFrom() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get to => $_getSZ(2);
  @$pb.TagNumber(3)
  set to($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTo() => $_has(2);
  @$pb.TagNumber(3)
  void clearTo() => $_clearField(3);
}

enum Filter_Kind {
  or,
  and,
  not,
  exists,
  inValues,
  greaterThan,
  greaterThanOrEqual,
  equal,
  notEqual,
  lessThan,
  lessThanOrEqual,
  between,
  isNull,
  isEmpty,
  notSet
}

/// The filters to be used in a search/query
class Filter extends $pb.GeneratedMessage {
  factory Filter({
    Filter_Filters? or,
    Filter_Filters? and,
    Filter? not,
    Filter_Field? exists,
    Filter_InValues? inValues,
    Filter_Comparison? greaterThan,
    Filter_Comparison? greaterThanOrEqual,
    Filter_Comparison? equal,
    Filter_Comparison? notEqual,
    Filter_Comparison? lessThan,
    Filter_Comparison? lessThanOrEqual,
    Filter_Between? between,
    Filter_Field? isNull,
    Filter_Field? isEmpty,
  }) {
    final result = create();
    if (or != null) result.or = or;
    if (and != null) result.and = and;
    if (not != null) result.not = not;
    if (exists != null) result.exists = exists;
    if (inValues != null) result.inValues = inValues;
    if (greaterThan != null) result.greaterThan = greaterThan;
    if (greaterThanOrEqual != null)
      result.greaterThanOrEqual = greaterThanOrEqual;
    if (equal != null) result.equal = equal;
    if (notEqual != null) result.notEqual = notEqual;
    if (lessThan != null) result.lessThan = lessThan;
    if (lessThanOrEqual != null) result.lessThanOrEqual = lessThanOrEqual;
    if (between != null) result.between = between;
    if (isNull != null) result.isNull = isNull;
    if (isEmpty != null) result.isEmpty = isEmpty;
    return result;
  }

  Filter._();

  factory Filter.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Filter.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Filter_Kind> _Filter_KindByTag = {
    1: Filter_Kind.or,
    2: Filter_Kind.and,
    3: Filter_Kind.not,
    10: Filter_Kind.exists,
    11: Filter_Kind.inValues,
    12: Filter_Kind.greaterThan,
    13: Filter_Kind.greaterThanOrEqual,
    14: Filter_Kind.equal,
    15: Filter_Kind.notEqual,
    16: Filter_Kind.lessThan,
    17: Filter_Kind.lessThanOrEqual,
    18: Filter_Kind.between,
    19: Filter_Kind.isNull,
    20: Filter_Kind.isEmpty,
    0: Filter_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Filter',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20])
    ..aOM<Filter_Filters>(1, _omitFieldNames ? '' : 'or',
        subBuilder: Filter_Filters.create)
    ..aOM<Filter_Filters>(2, _omitFieldNames ? '' : 'and',
        subBuilder: Filter_Filters.create)
    ..aOM<Filter>(3, _omitFieldNames ? '' : 'not', subBuilder: Filter.create)
    ..aOM<Filter_Field>(10, _omitFieldNames ? '' : 'exists',
        subBuilder: Filter_Field.create)
    ..aOM<Filter_InValues>(11, _omitFieldNames ? '' : 'inValues',
        subBuilder: Filter_InValues.create)
    ..aOM<Filter_Comparison>(12, _omitFieldNames ? '' : 'greaterThan',
        subBuilder: Filter_Comparison.create)
    ..aOM<Filter_Comparison>(13, _omitFieldNames ? '' : 'greaterThanOrEqual',
        subBuilder: Filter_Comparison.create)
    ..aOM<Filter_Comparison>(14, _omitFieldNames ? '' : 'equal',
        subBuilder: Filter_Comparison.create)
    ..aOM<Filter_Comparison>(15, _omitFieldNames ? '' : 'notEqual',
        subBuilder: Filter_Comparison.create)
    ..aOM<Filter_Comparison>(16, _omitFieldNames ? '' : 'lessThan',
        subBuilder: Filter_Comparison.create)
    ..aOM<Filter_Comparison>(17, _omitFieldNames ? '' : 'lessThanOrEqual',
        subBuilder: Filter_Comparison.create)
    ..aOM<Filter_Between>(18, _omitFieldNames ? '' : 'between',
        subBuilder: Filter_Between.create)
    ..aOM<Filter_Field>(19, _omitFieldNames ? '' : 'isNull',
        subBuilder: Filter_Field.create)
    ..aOM<Filter_Field>(20, _omitFieldNames ? '' : 'isEmpty',
        subBuilder: Filter_Field.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Filter clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Filter copyWith(void Function(Filter) updates) =>
      super.copyWith((message) => updates(message as Filter)) as Filter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Filter create() => Filter._();
  @$core.override
  Filter createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Filter getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Filter>(create);
  static Filter? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(10)
  @$pb.TagNumber(11)
  @$pb.TagNumber(12)
  @$pb.TagNumber(13)
  @$pb.TagNumber(14)
  @$pb.TagNumber(15)
  @$pb.TagNumber(16)
  @$pb.TagNumber(17)
  @$pb.TagNumber(18)
  @$pb.TagNumber(19)
  @$pb.TagNumber(20)
  Filter_Kind whichKind() => _Filter_KindByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(10)
  @$pb.TagNumber(11)
  @$pb.TagNumber(12)
  @$pb.TagNumber(13)
  @$pb.TagNumber(14)
  @$pb.TagNumber(15)
  @$pb.TagNumber(16)
  @$pb.TagNumber(17)
  @$pb.TagNumber(18)
  @$pb.TagNumber(19)
  @$pb.TagNumber(20)
  void clearKind() => $_clearField($_whichOneof(0));

  /// Creates an "or" [Filter] of the given sub-filters.
  @$pb.TagNumber(1)
  Filter_Filters get or => $_getN(0);
  @$pb.TagNumber(1)
  set or(Filter_Filters value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasOr() => $_has(0);
  @$pb.TagNumber(1)
  void clearOr() => $_clearField(1);
  @$pb.TagNumber(1)
  Filter_Filters ensureOr() => $_ensure(0);

  /// Creates an "and" [Filter] of the given sub-filters.
  @$pb.TagNumber(2)
  Filter_Filters get and => $_getN(1);
  @$pb.TagNumber(2)
  set and(Filter_Filters value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAnd() => $_has(1);
  @$pb.TagNumber(2)
  void clearAnd() => $_clearField(2);
  @$pb.TagNumber(2)
  Filter_Filters ensureAnd() => $_ensure(1);

  /// Creates a "not" [Filter] of the given sub-filter.
  @$pb.TagNumber(3)
  Filter get not => $_getN(2);
  @$pb.TagNumber(3)
  set not(Filter value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasNot() => $_has(2);
  @$pb.TagNumber(3)
  void clearNot() => $_clearField(3);
  @$pb.TagNumber(3)
  Filter ensureNot() => $_ensure(2);

  /// Creates a [Filter] that specifies the given field exists.
  @$pb.TagNumber(10)
  Filter_Field get exists => $_getN(3);
  @$pb.TagNumber(10)
  set exists(Filter_Field value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasExists() => $_has(3);
  @$pb.TagNumber(10)
  void clearExists() => $_clearField(10);
  @$pb.TagNumber(10)
  Filter_Field ensureExists() => $_ensure(3);

  /// Creates a [Filter] for the "IN" operator.
  @$pb.TagNumber(11)
  Filter_InValues get inValues => $_getN(4);
  @$pb.TagNumber(11)
  set inValues(Filter_InValues value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasInValues() => $_has(4);
  @$pb.TagNumber(11)
  void clearInValues() => $_clearField(11);
  @$pb.TagNumber(11)
  Filter_InValues ensureInValues() => $_ensure(4);

  /// Creates a [Filter] for the ">" operator.
  @$pb.TagNumber(12)
  Filter_Comparison get greaterThan => $_getN(5);
  @$pb.TagNumber(12)
  set greaterThan(Filter_Comparison value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasGreaterThan() => $_has(5);
  @$pb.TagNumber(12)
  void clearGreaterThan() => $_clearField(12);
  @$pb.TagNumber(12)
  Filter_Comparison ensureGreaterThan() => $_ensure(5);

  /// Creates a [Filter] for the ">=" operator.
  @$pb.TagNumber(13)
  Filter_Comparison get greaterThanOrEqual => $_getN(6);
  @$pb.TagNumber(13)
  set greaterThanOrEqual(Filter_Comparison value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasGreaterThanOrEqual() => $_has(6);
  @$pb.TagNumber(13)
  void clearGreaterThanOrEqual() => $_clearField(13);
  @$pb.TagNumber(13)
  Filter_Comparison ensureGreaterThanOrEqual() => $_ensure(6);

  /// Creates a [Filter] for the "==" operator.
  @$pb.TagNumber(14)
  Filter_Comparison get equal => $_getN(7);
  @$pb.TagNumber(14)
  set equal(Filter_Comparison value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasEqual() => $_has(7);
  @$pb.TagNumber(14)
  void clearEqual() => $_clearField(14);
  @$pb.TagNumber(14)
  Filter_Comparison ensureEqual() => $_ensure(7);

  /// Creates a [Filter] for the "!=" operator.
  @$pb.TagNumber(15)
  Filter_Comparison get notEqual => $_getN(8);
  @$pb.TagNumber(15)
  set notEqual(Filter_Comparison value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasNotEqual() => $_has(8);
  @$pb.TagNumber(15)
  void clearNotEqual() => $_clearField(15);
  @$pb.TagNumber(15)
  Filter_Comparison ensureNotEqual() => $_ensure(8);

  /// Creates a [Filter] for the "<" operator.
  @$pb.TagNumber(16)
  Filter_Comparison get lessThan => $_getN(9);
  @$pb.TagNumber(16)
  set lessThan(Filter_Comparison value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasLessThan() => $_has(9);
  @$pb.TagNumber(16)
  void clearLessThan() => $_clearField(16);
  @$pb.TagNumber(16)
  Filter_Comparison ensureLessThan() => $_ensure(9);

  /// Creates a [Filter] for the "<=" operator.
  @$pb.TagNumber(17)
  Filter_Comparison get lessThanOrEqual => $_getN(10);
  @$pb.TagNumber(17)
  set lessThanOrEqual(Filter_Comparison value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasLessThanOrEqual() => $_has(10);
  @$pb.TagNumber(17)
  void clearLessThanOrEqual() => $_clearField(17);
  @$pb.TagNumber(17)
  Filter_Comparison ensureLessThanOrEqual() => $_ensure(10);

  /// Creates a [Filter] for the "BETWEEN" operator.
  @$pb.TagNumber(18)
  Filter_Between get between => $_getN(11);
  @$pb.TagNumber(18)
  set between(Filter_Between value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasBetween() => $_has(11);
  @$pb.TagNumber(18)
  void clearBetween() => $_clearField(18);
  @$pb.TagNumber(18)
  Filter_Between ensureBetween() => $_ensure(11);

  /// Creates a [Filter] for the "IS NULL" operator.
  @$pb.TagNumber(19)
  Filter_Field get isNull => $_getN(12);
  @$pb.TagNumber(19)
  set isNull(Filter_Field value) => $_setField(19, value);
  @$pb.TagNumber(19)
  $core.bool hasIsNull() => $_has(12);
  @$pb.TagNumber(19)
  void clearIsNull() => $_clearField(19);
  @$pb.TagNumber(19)
  Filter_Field ensureIsNull() => $_ensure(12);

  /// Creates a [Filter] for the "IS EMPTY" operator.
  @$pb.TagNumber(20)
  Filter_Field get isEmpty => $_getN(13);
  @$pb.TagNumber(20)
  set isEmpty(Filter_Field value) => $_setField(20, value);
  @$pb.TagNumber(20)
  $core.bool hasIsEmpty() => $_has(13);
  @$pb.TagNumber(20)
  void clearIsEmpty() => $_clearField(20);
  @$pb.TagNumber(20)
  Filter_Field ensureIsEmpty() => $_ensure(13);
}

/// Ensures an instance of milli (represented by just a directory) is initialized
///
/// `tmp_dir`, if specified, is the directory used to store all temporary files
/// (see https://github.com/GregoryConrad/mimir/issues/170)
class InstanceFfiRequest_EnsureInitialized extends $pb.GeneratedMessage {
  factory InstanceFfiRequest_EnsureInitialized({
    $core.String? tmpDir,
  }) {
    final result = create();
    if (tmpDir != null) result.tmpDir = tmpDir;
    return result;
  }

  InstanceFfiRequest_EnsureInitialized._();

  factory InstanceFfiRequest_EnsureInitialized.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InstanceFfiRequest_EnsureInitialized.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InstanceFfiRequest.EnsureInitialized',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'tmpDir')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_EnsureInitialized clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_EnsureInitialized copyWith(
          void Function(InstanceFfiRequest_EnsureInitialized) updates) =>
      super.copyWith((message) =>
              updates(message as InstanceFfiRequest_EnsureInitialized))
          as InstanceFfiRequest_EnsureInitialized;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_EnsureInitialized create() =>
      InstanceFfiRequest_EnsureInitialized._();
  @$core.override
  InstanceFfiRequest_EnsureInitialized createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_EnsureInitialized getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          InstanceFfiRequest_EnsureInitialized>(create);
  static InstanceFfiRequest_EnsureInitialized? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get tmpDir => $_getSZ(0);
  @$pb.TagNumber(1)
  set tmpDir($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTmpDir() => $_has(0);
  @$pb.TagNumber(1)
  void clearTmpDir() => $_clearField(1);
}

/// Ensures a milli index is initialized
class InstanceFfiRequest_IndexRequest_EnsureInitialized
    extends $pb.GeneratedMessage {
  factory InstanceFfiRequest_IndexRequest_EnsureInitialized() => create();

  InstanceFfiRequest_IndexRequest_EnsureInitialized._();

  factory InstanceFfiRequest_IndexRequest_EnsureInitialized.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InstanceFfiRequest_IndexRequest_EnsureInitialized.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'InstanceFfiRequest.IndexRequest.EnsureInitialized',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_EnsureInitialized clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_EnsureInitialized copyWith(
          void Function(InstanceFfiRequest_IndexRequest_EnsureInitialized)
              updates) =>
      super.copyWith((message) => updates(
              message as InstanceFfiRequest_IndexRequest_EnsureInitialized))
          as InstanceFfiRequest_IndexRequest_EnsureInitialized;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_EnsureInitialized create() =>
      InstanceFfiRequest_IndexRequest_EnsureInitialized._();
  @$core.override
  InstanceFfiRequest_IndexRequest_EnsureInitialized createEmptyInstance() =>
      create();
  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_EnsureInitialized getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          InstanceFfiRequest_IndexRequest_EnsureInitialized>(create);
  static InstanceFfiRequest_IndexRequest_EnsureInitialized? _defaultInstance;
}

/// Adds the given list of documents to the specified milli index
///
/// Replaces documents that already exist in the index based on document ids
class InstanceFfiRequest_IndexRequest_AddDocuments
    extends $pb.GeneratedMessage {
  factory InstanceFfiRequest_IndexRequest_AddDocuments({
    $core.Iterable<$core.String>? documents,
  }) {
    final result = create();
    if (documents != null) result.documents.addAll(documents);
    return result;
  }

  InstanceFfiRequest_IndexRequest_AddDocuments._();

  factory InstanceFfiRequest_IndexRequest_AddDocuments.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InstanceFfiRequest_IndexRequest_AddDocuments.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InstanceFfiRequest.IndexRequest.AddDocuments',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'documents')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_AddDocuments clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_AddDocuments copyWith(
          void Function(InstanceFfiRequest_IndexRequest_AddDocuments)
              updates) =>
      super.copyWith((message) =>
              updates(message as InstanceFfiRequest_IndexRequest_AddDocuments))
          as InstanceFfiRequest_IndexRequest_AddDocuments;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_AddDocuments create() =>
      InstanceFfiRequest_IndexRequest_AddDocuments._();
  @$core.override
  InstanceFfiRequest_IndexRequest_AddDocuments createEmptyInstance() =>
      create();
  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_AddDocuments getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          InstanceFfiRequest_IndexRequest_AddDocuments>(create);
  static InstanceFfiRequest_IndexRequest_AddDocuments? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get documents => $_getList(0);
}

/// Deletes the documents with the given ids from the milli index
class InstanceFfiRequest_IndexRequest_DeleteDocuments
    extends $pb.GeneratedMessage {
  factory InstanceFfiRequest_IndexRequest_DeleteDocuments({
    $core.Iterable<$core.String>? documentIds,
  }) {
    final result = create();
    if (documentIds != null) result.documentIds.addAll(documentIds);
    return result;
  }

  InstanceFfiRequest_IndexRequest_DeleteDocuments._();

  factory InstanceFfiRequest_IndexRequest_DeleteDocuments.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InstanceFfiRequest_IndexRequest_DeleteDocuments.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'InstanceFfiRequest.IndexRequest.DeleteDocuments',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'documentIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_DeleteDocuments clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_DeleteDocuments copyWith(
          void Function(InstanceFfiRequest_IndexRequest_DeleteDocuments)
              updates) =>
      super.copyWith((message) => updates(
              message as InstanceFfiRequest_IndexRequest_DeleteDocuments))
          as InstanceFfiRequest_IndexRequest_DeleteDocuments;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_DeleteDocuments create() =>
      InstanceFfiRequest_IndexRequest_DeleteDocuments._();
  @$core.override
  InstanceFfiRequest_IndexRequest_DeleteDocuments createEmptyInstance() =>
      create();
  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_DeleteDocuments getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          InstanceFfiRequest_IndexRequest_DeleteDocuments>(create);
  static InstanceFfiRequest_IndexRequest_DeleteDocuments? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get documentIds => $_getList(0);
}

/// Deletes all the documents from the milli index
class InstanceFfiRequest_IndexRequest_DeleteAllDocuments
    extends $pb.GeneratedMessage {
  factory InstanceFfiRequest_IndexRequest_DeleteAllDocuments() => create();

  InstanceFfiRequest_IndexRequest_DeleteAllDocuments._();

  factory InstanceFfiRequest_IndexRequest_DeleteAllDocuments.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InstanceFfiRequest_IndexRequest_DeleteAllDocuments.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'InstanceFfiRequest.IndexRequest.DeleteAllDocuments',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_DeleteAllDocuments clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_DeleteAllDocuments copyWith(
          void Function(InstanceFfiRequest_IndexRequest_DeleteAllDocuments)
              updates) =>
      super.copyWith((message) => updates(
              message as InstanceFfiRequest_IndexRequest_DeleteAllDocuments))
          as InstanceFfiRequest_IndexRequest_DeleteAllDocuments;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_DeleteAllDocuments create() =>
      InstanceFfiRequest_IndexRequest_DeleteAllDocuments._();
  @$core.override
  InstanceFfiRequest_IndexRequest_DeleteAllDocuments createEmptyInstance() =>
      create();
  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_DeleteAllDocuments getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          InstanceFfiRequest_IndexRequest_DeleteAllDocuments>(create);
  static InstanceFfiRequest_IndexRequest_DeleteAllDocuments? _defaultInstance;
}

/// Replaces all documents with the given documents
class InstanceFfiRequest_IndexRequest_SetDocuments
    extends $pb.GeneratedMessage {
  factory InstanceFfiRequest_IndexRequest_SetDocuments({
    $core.Iterable<$core.String>? documents,
  }) {
    final result = create();
    if (documents != null) result.documents.addAll(documents);
    return result;
  }

  InstanceFfiRequest_IndexRequest_SetDocuments._();

  factory InstanceFfiRequest_IndexRequest_SetDocuments.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InstanceFfiRequest_IndexRequest_SetDocuments.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InstanceFfiRequest.IndexRequest.SetDocuments',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'documents')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_SetDocuments clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_SetDocuments copyWith(
          void Function(InstanceFfiRequest_IndexRequest_SetDocuments)
              updates) =>
      super.copyWith((message) =>
              updates(message as InstanceFfiRequest_IndexRequest_SetDocuments))
          as InstanceFfiRequest_IndexRequest_SetDocuments;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_SetDocuments create() =>
      InstanceFfiRequest_IndexRequest_SetDocuments._();
  @$core.override
  InstanceFfiRequest_IndexRequest_SetDocuments createEmptyInstance() =>
      create();
  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_SetDocuments getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          InstanceFfiRequest_IndexRequest_SetDocuments>(create);
  static InstanceFfiRequest_IndexRequest_SetDocuments? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get documents => $_getList(0);
}

/// Returns the document with the specified id from the index, if one exists
class InstanceFfiRequest_IndexRequest_GetDocument extends $pb.GeneratedMessage {
  factory InstanceFfiRequest_IndexRequest_GetDocument({
    $core.String? documentId,
  }) {
    final result = create();
    if (documentId != null) result.documentId = documentId;
    return result;
  }

  InstanceFfiRequest_IndexRequest_GetDocument._();

  factory InstanceFfiRequest_IndexRequest_GetDocument.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InstanceFfiRequest_IndexRequest_GetDocument.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InstanceFfiRequest.IndexRequest.GetDocument',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'documentId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_GetDocument clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_GetDocument copyWith(
          void Function(InstanceFfiRequest_IndexRequest_GetDocument) updates) =>
      super.copyWith((message) =>
              updates(message as InstanceFfiRequest_IndexRequest_GetDocument))
          as InstanceFfiRequest_IndexRequest_GetDocument;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_GetDocument create() =>
      InstanceFfiRequest_IndexRequest_GetDocument._();
  @$core.override
  InstanceFfiRequest_IndexRequest_GetDocument createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_GetDocument getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          InstanceFfiRequest_IndexRequest_GetDocument>(create);
  static InstanceFfiRequest_IndexRequest_GetDocument? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get documentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set documentId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDocumentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocumentId() => $_clearField(1);
}

/// Returns all documents stored in the index
class InstanceFfiRequest_IndexRequest_GetAllDocuments
    extends $pb.GeneratedMessage {
  factory InstanceFfiRequest_IndexRequest_GetAllDocuments() => create();

  InstanceFfiRequest_IndexRequest_GetAllDocuments._();

  factory InstanceFfiRequest_IndexRequest_GetAllDocuments.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InstanceFfiRequest_IndexRequest_GetAllDocuments.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'InstanceFfiRequest.IndexRequest.GetAllDocuments',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_GetAllDocuments clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_GetAllDocuments copyWith(
          void Function(InstanceFfiRequest_IndexRequest_GetAllDocuments)
              updates) =>
      super.copyWith((message) => updates(
              message as InstanceFfiRequest_IndexRequest_GetAllDocuments))
          as InstanceFfiRequest_IndexRequest_GetAllDocuments;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_GetAllDocuments create() =>
      InstanceFfiRequest_IndexRequest_GetAllDocuments._();
  @$core.override
  InstanceFfiRequest_IndexRequest_GetAllDocuments createEmptyInstance() =>
      create();
  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_GetAllDocuments getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          InstanceFfiRequest_IndexRequest_GetAllDocuments>(create);
  static InstanceFfiRequest_IndexRequest_GetAllDocuments? _defaultInstance;
}

class InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria
    extends $pb.GeneratedMessage {
  factory InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria({
    $core.Iterable<InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy>?
        sortCriteria,
  }) {
    final result = create();
    if (sortCriteria != null) result.sortCriteria.addAll(sortCriteria);
    return result;
  }

  InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria._();

  factory InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'InstanceFfiRequest.IndexRequest.SearchDocuments.SortCriteria',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..pPM<InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy>(
        1, _omitFieldNames ? '' : 'sortCriteria',
        subBuilder:
            InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria clone() =>
      deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria copyWith(
          void Function(
                  InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria)
              updates) =>
      super.copyWith((message) => updates(message
              as InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria))
          as InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria
      create() =>
          InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria._();
  @$core.override
  InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria
      createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria
      getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria>(create);
  static InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria?
      _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy>
      get sortCriteria => $_getList(0);
}

enum InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy_Kind {
  asc,
  desc,
  notSet
}

/// Whether to sort by a field in ascending or descending order.
/// See https://docs.meilisearch.com/reference/api/search.html#sort
class InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy
    extends $pb.GeneratedMessage {
  factory InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy({
    $core.String? asc,
    $core.String? desc,
  }) {
    final result = create();
    if (asc != null) result.asc = asc;
    if (desc != null) result.desc = desc;
    return result;
  }

  InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy._();

  factory InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int,
          InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy_Kind>
      _InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy_KindByTag = {
    1: InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy_Kind.asc,
    2: InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy_Kind.desc,
    0: InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'InstanceFfiRequest.IndexRequest.SearchDocuments.SortBy',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOS(1, _omitFieldNames ? '' : 'asc')
    ..aOS(2, _omitFieldNames ? '' : 'desc')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy copyWith(
          void Function(InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy)
              updates) =>
      super.copyWith((message) => updates(message
              as InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy))
          as InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy create() =>
      InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy._();
  @$core.override
  InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy
      createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy>(create);
  static InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy?
      _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy_Kind whichKind() =>
      _InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy_KindByTag[
          $_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  void clearKind() => $_clearField($_whichOneof(0));

  /// Sort by the given field in ascending order
  @$pb.TagNumber(1)
  $core.String get asc => $_getSZ(0);
  @$pb.TagNumber(1)
  set asc($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAsc() => $_has(0);
  @$pb.TagNumber(1)
  void clearAsc() => $_clearField(1);

  /// Sort by the given field in descending order
  @$pb.TagNumber(2)
  $core.String get desc => $_getSZ(1);
  @$pb.TagNumber(2)
  set desc($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDesc() => $_has(1);
  @$pb.TagNumber(2)
  void clearDesc() => $_clearField(2);
}

/// Performs a search against the index and returns the documents found
class InstanceFfiRequest_IndexRequest_SearchDocuments
    extends $pb.GeneratedMessage {
  factory InstanceFfiRequest_IndexRequest_SearchDocuments({
    $core.String? query,
    $core.int? limit,
    $core.int? offset,
    Filter? filter,
    InstanceFfiRequest_IndexRequest_SearchDocuments_TermsMatchingStrategy?
        termsMatchingStrategy,
    InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria? sortCriteria,
  }) {
    final result = create();
    if (query != null) result.query = query;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    if (filter != null) result.filter = filter;
    if (termsMatchingStrategy != null)
      result.termsMatchingStrategy = termsMatchingStrategy;
    if (sortCriteria != null) result.sortCriteria = sortCriteria;
    return result;
  }

  InstanceFfiRequest_IndexRequest_SearchDocuments._();

  factory InstanceFfiRequest_IndexRequest_SearchDocuments.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InstanceFfiRequest_IndexRequest_SearchDocuments.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'InstanceFfiRequest.IndexRequest.SearchDocuments',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..aI(2, _omitFieldNames ? '' : 'limit', fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'offset', fieldType: $pb.PbFieldType.OU3)
    ..aOM<Filter>(4, _omitFieldNames ? '' : 'filter', subBuilder: Filter.create)
    ..aE<InstanceFfiRequest_IndexRequest_SearchDocuments_TermsMatchingStrategy>(
        5, _omitFieldNames ? '' : 'termsMatchingStrategy',
        enumValues:
            InstanceFfiRequest_IndexRequest_SearchDocuments_TermsMatchingStrategy
                .values)
    ..aOM<InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria>(
        6, _omitFieldNames ? '' : 'sortCriteria',
        subBuilder:
            InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_SearchDocuments clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_SearchDocuments copyWith(
          void Function(InstanceFfiRequest_IndexRequest_SearchDocuments)
              updates) =>
      super.copyWith((message) => updates(
              message as InstanceFfiRequest_IndexRequest_SearchDocuments))
          as InstanceFfiRequest_IndexRequest_SearchDocuments;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_SearchDocuments create() =>
      InstanceFfiRequest_IndexRequest_SearchDocuments._();
  @$core.override
  InstanceFfiRequest_IndexRequest_SearchDocuments createEmptyInstance() =>
      create();
  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_SearchDocuments getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          InstanceFfiRequest_IndexRequest_SearchDocuments>(create);
  static InstanceFfiRequest_IndexRequest_SearchDocuments? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(2);
  @$pb.TagNumber(3)
  set offset($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffset() => $_clearField(3);

  @$pb.TagNumber(4)
  Filter get filter => $_getN(3);
  @$pb.TagNumber(4)
  set filter(Filter value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearFilter() => $_clearField(4);
  @$pb.TagNumber(4)
  Filter ensureFilter() => $_ensure(3);

  @$pb.TagNumber(5)
  InstanceFfiRequest_IndexRequest_SearchDocuments_TermsMatchingStrategy
      get termsMatchingStrategy => $_getN(4);
  @$pb.TagNumber(5)
  set termsMatchingStrategy(
          InstanceFfiRequest_IndexRequest_SearchDocuments_TermsMatchingStrategy
              value) =>
      $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasTermsMatchingStrategy() => $_has(4);
  @$pb.TagNumber(5)
  void clearTermsMatchingStrategy() => $_clearField(5);

  @$pb.TagNumber(6)
  InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria
      get sortCriteria => $_getN(5);
  @$pb.TagNumber(6)
  set sortCriteria(
          InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria value) =>
      $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasSortCriteria() => $_has(5);
  @$pb.TagNumber(6)
  void clearSortCriteria() => $_clearField(6);
  @$pb.TagNumber(6)
  InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria
      ensureSortCriteria() => $_ensure(5);
}

/// Returns the number of documents stored in the index
class InstanceFfiRequest_IndexRequest_NumberOfDocuments
    extends $pb.GeneratedMessage {
  factory InstanceFfiRequest_IndexRequest_NumberOfDocuments() => create();

  InstanceFfiRequest_IndexRequest_NumberOfDocuments._();

  factory InstanceFfiRequest_IndexRequest_NumberOfDocuments.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InstanceFfiRequest_IndexRequest_NumberOfDocuments.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'InstanceFfiRequest.IndexRequest.NumberOfDocuments',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_NumberOfDocuments clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_NumberOfDocuments copyWith(
          void Function(InstanceFfiRequest_IndexRequest_NumberOfDocuments)
              updates) =>
      super.copyWith((message) => updates(
              message as InstanceFfiRequest_IndexRequest_NumberOfDocuments))
          as InstanceFfiRequest_IndexRequest_NumberOfDocuments;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_NumberOfDocuments create() =>
      InstanceFfiRequest_IndexRequest_NumberOfDocuments._();
  @$core.override
  InstanceFfiRequest_IndexRequest_NumberOfDocuments createEmptyInstance() =>
      create();
  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_NumberOfDocuments getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          InstanceFfiRequest_IndexRequest_NumberOfDocuments>(create);
  static InstanceFfiRequest_IndexRequest_NumberOfDocuments? _defaultInstance;
}

/// Gets the settings of the specified index
class InstanceFfiRequest_IndexRequest_GetSettings extends $pb.GeneratedMessage {
  factory InstanceFfiRequest_IndexRequest_GetSettings() => create();

  InstanceFfiRequest_IndexRequest_GetSettings._();

  factory InstanceFfiRequest_IndexRequest_GetSettings.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InstanceFfiRequest_IndexRequest_GetSettings.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InstanceFfiRequest.IndexRequest.GetSettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_GetSettings clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_GetSettings copyWith(
          void Function(InstanceFfiRequest_IndexRequest_GetSettings) updates) =>
      super.copyWith((message) =>
              updates(message as InstanceFfiRequest_IndexRequest_GetSettings))
          as InstanceFfiRequest_IndexRequest_GetSettings;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_GetSettings create() =>
      InstanceFfiRequest_IndexRequest_GetSettings._();
  @$core.override
  InstanceFfiRequest_IndexRequest_GetSettings createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_GetSettings getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          InstanceFfiRequest_IndexRequest_GetSettings>(create);
  static InstanceFfiRequest_IndexRequest_GetSettings? _defaultInstance;
}

/// Sets the settings of the specified index
class InstanceFfiRequest_IndexRequest_SetSettings extends $pb.GeneratedMessage {
  factory InstanceFfiRequest_IndexRequest_SetSettings({
    MimirIndexSettings? settings,
  }) {
    final result = create();
    if (settings != null) result.settings = settings;
    return result;
  }

  InstanceFfiRequest_IndexRequest_SetSettings._();

  factory InstanceFfiRequest_IndexRequest_SetSettings.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InstanceFfiRequest_IndexRequest_SetSettings.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InstanceFfiRequest.IndexRequest.SetSettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..aOM<MimirIndexSettings>(1, _omitFieldNames ? '' : 'settings',
        subBuilder: MimirIndexSettings.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_SetSettings clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest_SetSettings copyWith(
          void Function(InstanceFfiRequest_IndexRequest_SetSettings) updates) =>
      super.copyWith((message) =>
              updates(message as InstanceFfiRequest_IndexRequest_SetSettings))
          as InstanceFfiRequest_IndexRequest_SetSettings;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_SetSettings create() =>
      InstanceFfiRequest_IndexRequest_SetSettings._();
  @$core.override
  InstanceFfiRequest_IndexRequest_SetSettings createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest_SetSettings getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          InstanceFfiRequest_IndexRequest_SetSettings>(create);
  static InstanceFfiRequest_IndexRequest_SetSettings? _defaultInstance;

  @$pb.TagNumber(1)
  MimirIndexSettings get settings => $_getN(0);
  @$pb.TagNumber(1)
  set settings(MimirIndexSettings value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSettings() => $_has(0);
  @$pb.TagNumber(1)
  void clearSettings() => $_clearField(1);
  @$pb.TagNumber(1)
  MimirIndexSettings ensureSettings() => $_ensure(0);
}

enum InstanceFfiRequest_IndexRequest_Kind {
  ensureIndexInitialized,
  addDocuments,
  deleteDocuments,
  deleteAllDocuments,
  setDocuments,
  getDocument,
  getAllDocuments,
  searchDocuments,
  numberOfDocuments,
  getSettings,
  setSettings,
  notSet
}

/// A request that operates on an index.
class InstanceFfiRequest_IndexRequest extends $pb.GeneratedMessage {
  factory InstanceFfiRequest_IndexRequest({
    $core.String? indexName,
    InstanceFfiRequest_IndexRequest_EnsureInitialized? ensureIndexInitialized,
    InstanceFfiRequest_IndexRequest_AddDocuments? addDocuments,
    InstanceFfiRequest_IndexRequest_DeleteDocuments? deleteDocuments,
    InstanceFfiRequest_IndexRequest_DeleteAllDocuments? deleteAllDocuments,
    InstanceFfiRequest_IndexRequest_SetDocuments? setDocuments,
    InstanceFfiRequest_IndexRequest_GetDocument? getDocument,
    InstanceFfiRequest_IndexRequest_GetAllDocuments? getAllDocuments,
    InstanceFfiRequest_IndexRequest_SearchDocuments? searchDocuments,
    InstanceFfiRequest_IndexRequest_NumberOfDocuments? numberOfDocuments,
    InstanceFfiRequest_IndexRequest_GetSettings? getSettings,
    InstanceFfiRequest_IndexRequest_SetSettings? setSettings,
  }) {
    final result = create();
    if (indexName != null) result.indexName = indexName;
    if (ensureIndexInitialized != null)
      result.ensureIndexInitialized = ensureIndexInitialized;
    if (addDocuments != null) result.addDocuments = addDocuments;
    if (deleteDocuments != null) result.deleteDocuments = deleteDocuments;
    if (deleteAllDocuments != null)
      result.deleteAllDocuments = deleteAllDocuments;
    if (setDocuments != null) result.setDocuments = setDocuments;
    if (getDocument != null) result.getDocument = getDocument;
    if (getAllDocuments != null) result.getAllDocuments = getAllDocuments;
    if (searchDocuments != null) result.searchDocuments = searchDocuments;
    if (numberOfDocuments != null) result.numberOfDocuments = numberOfDocuments;
    if (getSettings != null) result.getSettings = getSettings;
    if (setSettings != null) result.setSettings = setSettings;
    return result;
  }

  InstanceFfiRequest_IndexRequest._();

  factory InstanceFfiRequest_IndexRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InstanceFfiRequest_IndexRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, InstanceFfiRequest_IndexRequest_Kind>
      _InstanceFfiRequest_IndexRequest_KindByTag = {
    2: InstanceFfiRequest_IndexRequest_Kind.ensureIndexInitialized,
    3: InstanceFfiRequest_IndexRequest_Kind.addDocuments,
    4: InstanceFfiRequest_IndexRequest_Kind.deleteDocuments,
    5: InstanceFfiRequest_IndexRequest_Kind.deleteAllDocuments,
    6: InstanceFfiRequest_IndexRequest_Kind.setDocuments,
    7: InstanceFfiRequest_IndexRequest_Kind.getDocument,
    8: InstanceFfiRequest_IndexRequest_Kind.getAllDocuments,
    9: InstanceFfiRequest_IndexRequest_Kind.searchDocuments,
    10: InstanceFfiRequest_IndexRequest_Kind.numberOfDocuments,
    11: InstanceFfiRequest_IndexRequest_Kind.getSettings,
    12: InstanceFfiRequest_IndexRequest_Kind.setSettings,
    0: InstanceFfiRequest_IndexRequest_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InstanceFfiRequest.IndexRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..oo(0, [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
    ..aOS(1, _omitFieldNames ? '' : 'indexName')
    ..aOM<InstanceFfiRequest_IndexRequest_EnsureInitialized>(
        2, _omitFieldNames ? '' : 'ensureIndexInitialized',
        subBuilder: InstanceFfiRequest_IndexRequest_EnsureInitialized.create)
    ..aOM<InstanceFfiRequest_IndexRequest_AddDocuments>(
        3, _omitFieldNames ? '' : 'addDocuments',
        subBuilder: InstanceFfiRequest_IndexRequest_AddDocuments.create)
    ..aOM<InstanceFfiRequest_IndexRequest_DeleteDocuments>(
        4, _omitFieldNames ? '' : 'deleteDocuments',
        subBuilder: InstanceFfiRequest_IndexRequest_DeleteDocuments.create)
    ..aOM<InstanceFfiRequest_IndexRequest_DeleteAllDocuments>(
        5, _omitFieldNames ? '' : 'deleteAllDocuments',
        subBuilder: InstanceFfiRequest_IndexRequest_DeleteAllDocuments.create)
    ..aOM<InstanceFfiRequest_IndexRequest_SetDocuments>(
        6, _omitFieldNames ? '' : 'setDocuments',
        subBuilder: InstanceFfiRequest_IndexRequest_SetDocuments.create)
    ..aOM<InstanceFfiRequest_IndexRequest_GetDocument>(
        7, _omitFieldNames ? '' : 'getDocument',
        subBuilder: InstanceFfiRequest_IndexRequest_GetDocument.create)
    ..aOM<InstanceFfiRequest_IndexRequest_GetAllDocuments>(
        8, _omitFieldNames ? '' : 'getAllDocuments',
        subBuilder: InstanceFfiRequest_IndexRequest_GetAllDocuments.create)
    ..aOM<InstanceFfiRequest_IndexRequest_SearchDocuments>(
        9, _omitFieldNames ? '' : 'searchDocuments',
        subBuilder: InstanceFfiRequest_IndexRequest_SearchDocuments.create)
    ..aOM<InstanceFfiRequest_IndexRequest_NumberOfDocuments>(
        10, _omitFieldNames ? '' : 'numberOfDocuments',
        subBuilder: InstanceFfiRequest_IndexRequest_NumberOfDocuments.create)
    ..aOM<InstanceFfiRequest_IndexRequest_GetSettings>(
        11, _omitFieldNames ? '' : 'getSettings',
        subBuilder: InstanceFfiRequest_IndexRequest_GetSettings.create)
    ..aOM<InstanceFfiRequest_IndexRequest_SetSettings>(
        12, _omitFieldNames ? '' : 'setSettings',
        subBuilder: InstanceFfiRequest_IndexRequest_SetSettings.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest_IndexRequest copyWith(
          void Function(InstanceFfiRequest_IndexRequest) updates) =>
      super.copyWith(
              (message) => updates(message as InstanceFfiRequest_IndexRequest))
          as InstanceFfiRequest_IndexRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest create() =>
      InstanceFfiRequest_IndexRequest._();
  @$core.override
  InstanceFfiRequest_IndexRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest_IndexRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InstanceFfiRequest_IndexRequest>(
          create);
  static InstanceFfiRequest_IndexRequest? _defaultInstance;

  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  @$pb.TagNumber(8)
  @$pb.TagNumber(9)
  @$pb.TagNumber(10)
  @$pb.TagNumber(11)
  @$pb.TagNumber(12)
  InstanceFfiRequest_IndexRequest_Kind whichKind() =>
      _InstanceFfiRequest_IndexRequest_KindByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  @$pb.TagNumber(8)
  @$pb.TagNumber(9)
  @$pb.TagNumber(10)
  @$pb.TagNumber(11)
  @$pb.TagNumber(12)
  void clearKind() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get indexName => $_getSZ(0);
  @$pb.TagNumber(1)
  set indexName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIndexName() => $_has(0);
  @$pb.TagNumber(1)
  void clearIndexName() => $_clearField(1);

  @$pb.TagNumber(2)
  InstanceFfiRequest_IndexRequest_EnsureInitialized
      get ensureIndexInitialized => $_getN(1);
  @$pb.TagNumber(2)
  set ensureIndexInitialized(
          InstanceFfiRequest_IndexRequest_EnsureInitialized value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEnsureIndexInitialized() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnsureIndexInitialized() => $_clearField(2);
  @$pb.TagNumber(2)
  InstanceFfiRequest_IndexRequest_EnsureInitialized
      ensureEnsureIndexInitialized() => $_ensure(1);

  @$pb.TagNumber(3)
  InstanceFfiRequest_IndexRequest_AddDocuments get addDocuments => $_getN(2);
  @$pb.TagNumber(3)
  set addDocuments(InstanceFfiRequest_IndexRequest_AddDocuments value) =>
      $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasAddDocuments() => $_has(2);
  @$pb.TagNumber(3)
  void clearAddDocuments() => $_clearField(3);
  @$pb.TagNumber(3)
  InstanceFfiRequest_IndexRequest_AddDocuments ensureAddDocuments() =>
      $_ensure(2);

  @$pb.TagNumber(4)
  InstanceFfiRequest_IndexRequest_DeleteDocuments get deleteDocuments =>
      $_getN(3);
  @$pb.TagNumber(4)
  set deleteDocuments(InstanceFfiRequest_IndexRequest_DeleteDocuments value) =>
      $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasDeleteDocuments() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeleteDocuments() => $_clearField(4);
  @$pb.TagNumber(4)
  InstanceFfiRequest_IndexRequest_DeleteDocuments ensureDeleteDocuments() =>
      $_ensure(3);

  @$pb.TagNumber(5)
  InstanceFfiRequest_IndexRequest_DeleteAllDocuments get deleteAllDocuments =>
      $_getN(4);
  @$pb.TagNumber(5)
  set deleteAllDocuments(
          InstanceFfiRequest_IndexRequest_DeleteAllDocuments value) =>
      $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasDeleteAllDocuments() => $_has(4);
  @$pb.TagNumber(5)
  void clearDeleteAllDocuments() => $_clearField(5);
  @$pb.TagNumber(5)
  InstanceFfiRequest_IndexRequest_DeleteAllDocuments
      ensureDeleteAllDocuments() => $_ensure(4);

  @$pb.TagNumber(6)
  InstanceFfiRequest_IndexRequest_SetDocuments get setDocuments => $_getN(5);
  @$pb.TagNumber(6)
  set setDocuments(InstanceFfiRequest_IndexRequest_SetDocuments value) =>
      $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasSetDocuments() => $_has(5);
  @$pb.TagNumber(6)
  void clearSetDocuments() => $_clearField(6);
  @$pb.TagNumber(6)
  InstanceFfiRequest_IndexRequest_SetDocuments ensureSetDocuments() =>
      $_ensure(5);

  @$pb.TagNumber(7)
  InstanceFfiRequest_IndexRequest_GetDocument get getDocument => $_getN(6);
  @$pb.TagNumber(7)
  set getDocument(InstanceFfiRequest_IndexRequest_GetDocument value) =>
      $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasGetDocument() => $_has(6);
  @$pb.TagNumber(7)
  void clearGetDocument() => $_clearField(7);
  @$pb.TagNumber(7)
  InstanceFfiRequest_IndexRequest_GetDocument ensureGetDocument() =>
      $_ensure(6);

  @$pb.TagNumber(8)
  InstanceFfiRequest_IndexRequest_GetAllDocuments get getAllDocuments =>
      $_getN(7);
  @$pb.TagNumber(8)
  set getAllDocuments(InstanceFfiRequest_IndexRequest_GetAllDocuments value) =>
      $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasGetAllDocuments() => $_has(7);
  @$pb.TagNumber(8)
  void clearGetAllDocuments() => $_clearField(8);
  @$pb.TagNumber(8)
  InstanceFfiRequest_IndexRequest_GetAllDocuments ensureGetAllDocuments() =>
      $_ensure(7);

  @$pb.TagNumber(9)
  InstanceFfiRequest_IndexRequest_SearchDocuments get searchDocuments =>
      $_getN(8);
  @$pb.TagNumber(9)
  set searchDocuments(InstanceFfiRequest_IndexRequest_SearchDocuments value) =>
      $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasSearchDocuments() => $_has(8);
  @$pb.TagNumber(9)
  void clearSearchDocuments() => $_clearField(9);
  @$pb.TagNumber(9)
  InstanceFfiRequest_IndexRequest_SearchDocuments ensureSearchDocuments() =>
      $_ensure(8);

  @$pb.TagNumber(10)
  InstanceFfiRequest_IndexRequest_NumberOfDocuments get numberOfDocuments =>
      $_getN(9);
  @$pb.TagNumber(10)
  set numberOfDocuments(
          InstanceFfiRequest_IndexRequest_NumberOfDocuments value) =>
      $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasNumberOfDocuments() => $_has(9);
  @$pb.TagNumber(10)
  void clearNumberOfDocuments() => $_clearField(10);
  @$pb.TagNumber(10)
  InstanceFfiRequest_IndexRequest_NumberOfDocuments ensureNumberOfDocuments() =>
      $_ensure(9);

  @$pb.TagNumber(11)
  InstanceFfiRequest_IndexRequest_GetSettings get getSettings => $_getN(10);
  @$pb.TagNumber(11)
  set getSettings(InstanceFfiRequest_IndexRequest_GetSettings value) =>
      $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasGetSettings() => $_has(10);
  @$pb.TagNumber(11)
  void clearGetSettings() => $_clearField(11);
  @$pb.TagNumber(11)
  InstanceFfiRequest_IndexRequest_GetSettings ensureGetSettings() =>
      $_ensure(10);

  @$pb.TagNumber(12)
  InstanceFfiRequest_IndexRequest_SetSettings get setSettings => $_getN(11);
  @$pb.TagNumber(12)
  set setSettings(InstanceFfiRequest_IndexRequest_SetSettings value) =>
      $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasSetSettings() => $_has(11);
  @$pb.TagNumber(12)
  void clearSetSettings() => $_clearField(12);
  @$pb.TagNumber(12)
  InstanceFfiRequest_IndexRequest_SetSettings ensureSetSettings() =>
      $_ensure(11);
}

enum InstanceFfiRequest_Kind { ensureInstanceInitialized, indexRequest, notSet }

/// A request that operates on an instance.
class InstanceFfiRequest extends $pb.GeneratedMessage {
  factory InstanceFfiRequest({
    $core.String? instanceDir,
    InstanceFfiRequest_EnsureInitialized? ensureInstanceInitialized,
    InstanceFfiRequest_IndexRequest? indexRequest,
  }) {
    final result = create();
    if (instanceDir != null) result.instanceDir = instanceDir;
    if (ensureInstanceInitialized != null)
      result.ensureInstanceInitialized = ensureInstanceInitialized;
    if (indexRequest != null) result.indexRequest = indexRequest;
    return result;
  }

  InstanceFfiRequest._();

  factory InstanceFfiRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InstanceFfiRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, InstanceFfiRequest_Kind>
      _InstanceFfiRequest_KindByTag = {
    2: InstanceFfiRequest_Kind.ensureInstanceInitialized,
    3: InstanceFfiRequest_Kind.indexRequest,
    0: InstanceFfiRequest_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InstanceFfiRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..oo(0, [2, 3])
    ..aOS(1, _omitFieldNames ? '' : 'instanceDir')
    ..aOM<InstanceFfiRequest_EnsureInitialized>(
        2, _omitFieldNames ? '' : 'ensureInstanceInitialized',
        subBuilder: InstanceFfiRequest_EnsureInitialized.create)
    ..aOM<InstanceFfiRequest_IndexRequest>(
        3, _omitFieldNames ? '' : 'indexRequest',
        subBuilder: InstanceFfiRequest_IndexRequest.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiRequest copyWith(void Function(InstanceFfiRequest) updates) =>
      super.copyWith((message) => updates(message as InstanceFfiRequest))
          as InstanceFfiRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest create() => InstanceFfiRequest._();
  @$core.override
  InstanceFfiRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InstanceFfiRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InstanceFfiRequest>(create);
  static InstanceFfiRequest? _defaultInstance;

  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  InstanceFfiRequest_Kind whichKind() =>
      _InstanceFfiRequest_KindByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  void clearKind() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get instanceDir => $_getSZ(0);
  @$pb.TagNumber(1)
  set instanceDir($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInstanceDir() => $_has(0);
  @$pb.TagNumber(1)
  void clearInstanceDir() => $_clearField(1);

  @$pb.TagNumber(2)
  InstanceFfiRequest_EnsureInitialized get ensureInstanceInitialized =>
      $_getN(1);
  @$pb.TagNumber(2)
  set ensureInstanceInitialized(InstanceFfiRequest_EnsureInitialized value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEnsureInstanceInitialized() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnsureInstanceInitialized() => $_clearField(2);
  @$pb.TagNumber(2)
  InstanceFfiRequest_EnsureInitialized ensureEnsureInstanceInitialized() =>
      $_ensure(1);

  @$pb.TagNumber(3)
  InstanceFfiRequest_IndexRequest get indexRequest => $_getN(2);
  @$pb.TagNumber(3)
  set indexRequest(InstanceFfiRequest_IndexRequest value) =>
      $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasIndexRequest() => $_has(2);
  @$pb.TagNumber(3)
  void clearIndexRequest() => $_clearField(3);
  @$pb.TagNumber(3)
  InstanceFfiRequest_IndexRequest ensureIndexRequest() => $_ensure(2);
}

class InstanceFfiResponse_OptionalDocument extends $pb.GeneratedMessage {
  factory InstanceFfiResponse_OptionalDocument({
    $core.String? document,
  }) {
    final result = create();
    if (document != null) result.document = document;
    return result;
  }

  InstanceFfiResponse_OptionalDocument._();

  factory InstanceFfiResponse_OptionalDocument.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InstanceFfiResponse_OptionalDocument.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InstanceFfiResponse.OptionalDocument',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'document')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiResponse_OptionalDocument clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiResponse_OptionalDocument copyWith(
          void Function(InstanceFfiResponse_OptionalDocument) updates) =>
      super.copyWith((message) =>
              updates(message as InstanceFfiResponse_OptionalDocument))
          as InstanceFfiResponse_OptionalDocument;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstanceFfiResponse_OptionalDocument create() =>
      InstanceFfiResponse_OptionalDocument._();
  @$core.override
  InstanceFfiResponse_OptionalDocument createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InstanceFfiResponse_OptionalDocument getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          InstanceFfiResponse_OptionalDocument>(create);
  static InstanceFfiResponse_OptionalDocument? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get document => $_getSZ(0);
  @$pb.TagNumber(1)
  set document($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDocument() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocument() => $_clearField(1);
}

class InstanceFfiResponse_Documents extends $pb.GeneratedMessage {
  factory InstanceFfiResponse_Documents({
    $core.Iterable<$core.String>? documents,
  }) {
    final result = create();
    if (documents != null) result.documents.addAll(documents);
    return result;
  }

  InstanceFfiResponse_Documents._();

  factory InstanceFfiResponse_Documents.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InstanceFfiResponse_Documents.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InstanceFfiResponse.Documents',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'documents')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiResponse_Documents clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiResponse_Documents copyWith(
          void Function(InstanceFfiResponse_Documents) updates) =>
      super.copyWith(
              (message) => updates(message as InstanceFfiResponse_Documents))
          as InstanceFfiResponse_Documents;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstanceFfiResponse_Documents create() =>
      InstanceFfiResponse_Documents._();
  @$core.override
  InstanceFfiResponse_Documents createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InstanceFfiResponse_Documents getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InstanceFfiResponse_Documents>(create);
  static InstanceFfiResponse_Documents? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get documents => $_getList(0);
}

enum InstanceFfiResponse_Kind {
  document,
  documents,
  numberOfDocuments,
  indexSettings,
  notSet
}

class InstanceFfiResponse extends $pb.GeneratedMessage {
  factory InstanceFfiResponse({
    $core.String? error,
    InstanceFfiResponse_OptionalDocument? document,
    InstanceFfiResponse_Documents? documents,
    $fixnum.Int64? numberOfDocuments,
    MimirIndexSettings? indexSettings,
  }) {
    final result = create();
    if (error != null) result.error = error;
    if (document != null) result.document = document;
    if (documents != null) result.documents = documents;
    if (numberOfDocuments != null) result.numberOfDocuments = numberOfDocuments;
    if (indexSettings != null) result.indexSettings = indexSettings;
    return result;
  }

  InstanceFfiResponse._();

  factory InstanceFfiResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InstanceFfiResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, InstanceFfiResponse_Kind>
      _InstanceFfiResponse_KindByTag = {
    2: InstanceFfiResponse_Kind.document,
    3: InstanceFfiResponse_Kind.documents,
    4: InstanceFfiResponse_Kind.numberOfDocuments,
    5: InstanceFfiResponse_Kind.indexSettings,
    0: InstanceFfiResponse_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InstanceFfiResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'instance'),
      createEmptyInstance: create)
    ..oo(0, [2, 3, 4, 5])
    ..aOS(1, _omitFieldNames ? '' : 'error')
    ..aOM<InstanceFfiResponse_OptionalDocument>(
        2, _omitFieldNames ? '' : 'document',
        subBuilder: InstanceFfiResponse_OptionalDocument.create)
    ..aOM<InstanceFfiResponse_Documents>(3, _omitFieldNames ? '' : 'documents',
        subBuilder: InstanceFfiResponse_Documents.create)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'numberOfDocuments', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<MimirIndexSettings>(5, _omitFieldNames ? '' : 'indexSettings',
        subBuilder: MimirIndexSettings.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InstanceFfiResponse copyWith(void Function(InstanceFfiResponse) updates) =>
      super.copyWith((message) => updates(message as InstanceFfiResponse))
          as InstanceFfiResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstanceFfiResponse create() => InstanceFfiResponse._();
  @$core.override
  InstanceFfiResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InstanceFfiResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InstanceFfiResponse>(create);
  static InstanceFfiResponse? _defaultInstance;

  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  InstanceFfiResponse_Kind whichKind() =>
      _InstanceFfiResponse_KindByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  void clearKind() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get error => $_getSZ(0);
  @$pb.TagNumber(1)
  set error($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasError() => $_has(0);
  @$pb.TagNumber(1)
  void clearError() => $_clearField(1);

  @$pb.TagNumber(2)
  InstanceFfiResponse_OptionalDocument get document => $_getN(1);
  @$pb.TagNumber(2)
  set document(InstanceFfiResponse_OptionalDocument value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDocument() => $_has(1);
  @$pb.TagNumber(2)
  void clearDocument() => $_clearField(2);
  @$pb.TagNumber(2)
  InstanceFfiResponse_OptionalDocument ensureDocument() => $_ensure(1);

  @$pb.TagNumber(3)
  InstanceFfiResponse_Documents get documents => $_getN(2);
  @$pb.TagNumber(3)
  set documents(InstanceFfiResponse_Documents value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDocuments() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocuments() => $_clearField(3);
  @$pb.TagNumber(3)
  InstanceFfiResponse_Documents ensureDocuments() => $_ensure(2);

  @$pb.TagNumber(4)
  $fixnum.Int64 get numberOfDocuments => $_getI64(3);
  @$pb.TagNumber(4)
  set numberOfDocuments($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNumberOfDocuments() => $_has(3);
  @$pb.TagNumber(4)
  void clearNumberOfDocuments() => $_clearField(4);

  @$pb.TagNumber(5)
  MimirIndexSettings get indexSettings => $_getN(4);
  @$pb.TagNumber(5)
  set indexSettings(MimirIndexSettings value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasIndexSettings() => $_has(4);
  @$pb.TagNumber(5)
  void clearIndexSettings() => $_clearField(5);
  @$pb.TagNumber(5)
  MimirIndexSettings ensureIndexSettings() => $_ensure(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
