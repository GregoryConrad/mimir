// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bridge_generated.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MeiliIndexSettings {
  List<String> get searchableAttributes => throw _privateConstructorUsedError;
  List<String> get filterableAttributes => throw _privateConstructorUsedError;
  List<String> get rankingRules => throw _privateConstructorUsedError;
  List<String> get stopWords => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<String> searchableAttributes,
            List<String> filterableAttributes,
            List<String> rankingRules,
            List<String> stopWords)
        raw,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<String> searchableAttributes,
            List<String> filterableAttributes,
            List<String> rankingRules,
            List<String> stopWords)?
        raw,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<String> searchableAttributes,
            List<String> filterableAttributes,
            List<String> rankingRules,
            List<String> stopWords)?
        raw,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MeiliIndexSettings_Raw value) raw,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MeiliIndexSettings_Raw value)? raw,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MeiliIndexSettings_Raw value)? raw,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MeiliIndexSettingsCopyWith<MeiliIndexSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeiliIndexSettingsCopyWith<$Res> {
  factory $MeiliIndexSettingsCopyWith(
          MeiliIndexSettings value, $Res Function(MeiliIndexSettings) then) =
      _$MeiliIndexSettingsCopyWithImpl<$Res, MeiliIndexSettings>;
  @useResult
  $Res call(
      {List<String> searchableAttributes,
      List<String> filterableAttributes,
      List<String> rankingRules,
      List<String> stopWords});
}

/// @nodoc
class _$MeiliIndexSettingsCopyWithImpl<$Res, $Val extends MeiliIndexSettings>
    implements $MeiliIndexSettingsCopyWith<$Res> {
  _$MeiliIndexSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchableAttributes = null,
    Object? filterableAttributes = null,
    Object? rankingRules = null,
    Object? stopWords = null,
  }) {
    return _then(_value.copyWith(
      searchableAttributes: null == searchableAttributes
          ? _value.searchableAttributes
          : searchableAttributes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      filterableAttributes: null == filterableAttributes
          ? _value.filterableAttributes
          : filterableAttributes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rankingRules: null == rankingRules
          ? _value.rankingRules
          : rankingRules // ignore: cast_nullable_to_non_nullable
              as List<String>,
      stopWords: null == stopWords
          ? _value.stopWords
          : stopWords // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MeiliIndexSettings_RawCopyWith<$Res>
    implements $MeiliIndexSettingsCopyWith<$Res> {
  factory _$$MeiliIndexSettings_RawCopyWith(_$MeiliIndexSettings_Raw value,
          $Res Function(_$MeiliIndexSettings_Raw) then) =
      __$$MeiliIndexSettings_RawCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> searchableAttributes,
      List<String> filterableAttributes,
      List<String> rankingRules,
      List<String> stopWords});
}

/// @nodoc
class __$$MeiliIndexSettings_RawCopyWithImpl<$Res>
    extends _$MeiliIndexSettingsCopyWithImpl<$Res, _$MeiliIndexSettings_Raw>
    implements _$$MeiliIndexSettings_RawCopyWith<$Res> {
  __$$MeiliIndexSettings_RawCopyWithImpl(_$MeiliIndexSettings_Raw _value,
      $Res Function(_$MeiliIndexSettings_Raw) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchableAttributes = null,
    Object? filterableAttributes = null,
    Object? rankingRules = null,
    Object? stopWords = null,
  }) {
    return _then(_$MeiliIndexSettings_Raw(
      searchableAttributes: null == searchableAttributes
          ? _value._searchableAttributes
          : searchableAttributes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      filterableAttributes: null == filterableAttributes
          ? _value._filterableAttributes
          : filterableAttributes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rankingRules: null == rankingRules
          ? _value._rankingRules
          : rankingRules // ignore: cast_nullable_to_non_nullable
              as List<String>,
      stopWords: null == stopWords
          ? _value._stopWords
          : stopWords // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$MeiliIndexSettings_Raw implements MeiliIndexSettings_Raw {
  const _$MeiliIndexSettings_Raw(
      {required final List<String> searchableAttributes,
      required final List<String> filterableAttributes,
      required final List<String> rankingRules,
      required final List<String> stopWords})
      : _searchableAttributes = searchableAttributes,
        _filterableAttributes = filterableAttributes,
        _rankingRules = rankingRules,
        _stopWords = stopWords;

  final List<String> _searchableAttributes;
  @override
  List<String> get searchableAttributes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchableAttributes);
  }

  final List<String> _filterableAttributes;
  @override
  List<String> get filterableAttributes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filterableAttributes);
  }

  final List<String> _rankingRules;
  @override
  List<String> get rankingRules {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rankingRules);
  }

  final List<String> _stopWords;
  @override
  List<String> get stopWords {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stopWords);
  }

  @override
  String toString() {
    return 'MeiliIndexSettings.raw(searchableAttributes: $searchableAttributes, filterableAttributes: $filterableAttributes, rankingRules: $rankingRules, stopWords: $stopWords)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeiliIndexSettings_Raw &&
            const DeepCollectionEquality()
                .equals(other._searchableAttributes, _searchableAttributes) &&
            const DeepCollectionEquality()
                .equals(other._filterableAttributes, _filterableAttributes) &&
            const DeepCollectionEquality()
                .equals(other._rankingRules, _rankingRules) &&
            const DeepCollectionEquality()
                .equals(other._stopWords, _stopWords));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_searchableAttributes),
      const DeepCollectionEquality().hash(_filterableAttributes),
      const DeepCollectionEquality().hash(_rankingRules),
      const DeepCollectionEquality().hash(_stopWords));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MeiliIndexSettings_RawCopyWith<_$MeiliIndexSettings_Raw> get copyWith =>
      __$$MeiliIndexSettings_RawCopyWithImpl<_$MeiliIndexSettings_Raw>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<String> searchableAttributes,
            List<String> filterableAttributes,
            List<String> rankingRules,
            List<String> stopWords)
        raw,
  }) {
    return raw(
        searchableAttributes, filterableAttributes, rankingRules, stopWords);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<String> searchableAttributes,
            List<String> filterableAttributes,
            List<String> rankingRules,
            List<String> stopWords)?
        raw,
  }) {
    return raw?.call(
        searchableAttributes, filterableAttributes, rankingRules, stopWords);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<String> searchableAttributes,
            List<String> filterableAttributes,
            List<String> rankingRules,
            List<String> stopWords)?
        raw,
    required TResult orElse(),
  }) {
    if (raw != null) {
      return raw(
          searchableAttributes, filterableAttributes, rankingRules, stopWords);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MeiliIndexSettings_Raw value) raw,
  }) {
    return raw(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MeiliIndexSettings_Raw value)? raw,
  }) {
    return raw?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MeiliIndexSettings_Raw value)? raw,
    required TResult orElse(),
  }) {
    if (raw != null) {
      return raw(this);
    }
    return orElse();
  }
}

abstract class MeiliIndexSettings_Raw implements MeiliIndexSettings {
  const factory MeiliIndexSettings_Raw(
      {required final List<String> searchableAttributes,
      required final List<String> filterableAttributes,
      required final List<String> rankingRules,
      required final List<String> stopWords}) = _$MeiliIndexSettings_Raw;

  @override
  List<String> get searchableAttributes;
  @override
  List<String> get filterableAttributes;
  @override
  List<String> get rankingRules;
  @override
  List<String> get stopWords;
  @override
  @JsonKey(ignore: true)
  _$$MeiliIndexSettings_RawCopyWith<_$MeiliIndexSettings_Raw> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SortAscDesc {
  String get field0 => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String field0) asc,
    required TResult Function(String field0) desc,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? asc,
    TResult? Function(String field0)? desc,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? asc,
    TResult Function(String field0)? desc,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SortAscDesc_Asc value) asc,
    required TResult Function(SortAscDesc_Desc value) desc,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SortAscDesc_Asc value)? asc,
    TResult? Function(SortAscDesc_Desc value)? desc,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SortAscDesc_Asc value)? asc,
    TResult Function(SortAscDesc_Desc value)? desc,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SortAscDescCopyWith<SortAscDesc> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SortAscDescCopyWith<$Res> {
  factory $SortAscDescCopyWith(
          SortAscDesc value, $Res Function(SortAscDesc) then) =
      _$SortAscDescCopyWithImpl<$Res, SortAscDesc>;
  @useResult
  $Res call({String field0});
}

/// @nodoc
class _$SortAscDescCopyWithImpl<$Res, $Val extends SortAscDesc>
    implements $SortAscDescCopyWith<$Res> {
  _$SortAscDescCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_value.copyWith(
      field0: null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SortAscDesc_AscCopyWith<$Res>
    implements $SortAscDescCopyWith<$Res> {
  factory _$$SortAscDesc_AscCopyWith(
          _$SortAscDesc_Asc value, $Res Function(_$SortAscDesc_Asc) then) =
      __$$SortAscDesc_AscCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String field0});
}

/// @nodoc
class __$$SortAscDesc_AscCopyWithImpl<$Res>
    extends _$SortAscDescCopyWithImpl<$Res, _$SortAscDesc_Asc>
    implements _$$SortAscDesc_AscCopyWith<$Res> {
  __$$SortAscDesc_AscCopyWithImpl(
      _$SortAscDesc_Asc _value, $Res Function(_$SortAscDesc_Asc) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$SortAscDesc_Asc(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SortAscDesc_Asc implements SortAscDesc_Asc {
  const _$SortAscDesc_Asc(this.field0);

  @override
  final String field0;

  @override
  String toString() {
    return 'SortAscDesc.asc(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SortAscDesc_Asc &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SortAscDesc_AscCopyWith<_$SortAscDesc_Asc> get copyWith =>
      __$$SortAscDesc_AscCopyWithImpl<_$SortAscDesc_Asc>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String field0) asc,
    required TResult Function(String field0) desc,
  }) {
    return asc(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? asc,
    TResult? Function(String field0)? desc,
  }) {
    return asc?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? asc,
    TResult Function(String field0)? desc,
    required TResult orElse(),
  }) {
    if (asc != null) {
      return asc(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SortAscDesc_Asc value) asc,
    required TResult Function(SortAscDesc_Desc value) desc,
  }) {
    return asc(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SortAscDesc_Asc value)? asc,
    TResult? Function(SortAscDesc_Desc value)? desc,
  }) {
    return asc?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SortAscDesc_Asc value)? asc,
    TResult Function(SortAscDesc_Desc value)? desc,
    required TResult orElse(),
  }) {
    if (asc != null) {
      return asc(this);
    }
    return orElse();
  }
}

abstract class SortAscDesc_Asc implements SortAscDesc {
  const factory SortAscDesc_Asc(final String field0) = _$SortAscDesc_Asc;

  @override
  String get field0;
  @override
  @JsonKey(ignore: true)
  _$$SortAscDesc_AscCopyWith<_$SortAscDesc_Asc> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SortAscDesc_DescCopyWith<$Res>
    implements $SortAscDescCopyWith<$Res> {
  factory _$$SortAscDesc_DescCopyWith(
          _$SortAscDesc_Desc value, $Res Function(_$SortAscDesc_Desc) then) =
      __$$SortAscDesc_DescCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String field0});
}

/// @nodoc
class __$$SortAscDesc_DescCopyWithImpl<$Res>
    extends _$SortAscDescCopyWithImpl<$Res, _$SortAscDesc_Desc>
    implements _$$SortAscDesc_DescCopyWith<$Res> {
  __$$SortAscDesc_DescCopyWithImpl(
      _$SortAscDesc_Desc _value, $Res Function(_$SortAscDesc_Desc) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$SortAscDesc_Desc(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SortAscDesc_Desc implements SortAscDesc_Desc {
  const _$SortAscDesc_Desc(this.field0);

  @override
  final String field0;

  @override
  String toString() {
    return 'SortAscDesc.desc(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SortAscDesc_Desc &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SortAscDesc_DescCopyWith<_$SortAscDesc_Desc> get copyWith =>
      __$$SortAscDesc_DescCopyWithImpl<_$SortAscDesc_Desc>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String field0) asc,
    required TResult Function(String field0) desc,
  }) {
    return desc(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String field0)? asc,
    TResult? Function(String field0)? desc,
  }) {
    return desc?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String field0)? asc,
    TResult Function(String field0)? desc,
    required TResult orElse(),
  }) {
    if (desc != null) {
      return desc(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SortAscDesc_Asc value) asc,
    required TResult Function(SortAscDesc_Desc value) desc,
  }) {
    return desc(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SortAscDesc_Asc value)? asc,
    TResult? Function(SortAscDesc_Desc value)? desc,
  }) {
    return desc?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SortAscDesc_Asc value)? asc,
    TResult Function(SortAscDesc_Desc value)? desc,
    required TResult orElse(),
  }) {
    if (desc != null) {
      return desc(this);
    }
    return orElse();
  }
}

abstract class SortAscDesc_Desc implements SortAscDesc {
  const factory SortAscDesc_Desc(final String field0) = _$SortAscDesc_Desc;

  @override
  String get field0;
  @override
  @JsonKey(ignore: true)
  _$$SortAscDesc_DescCopyWith<_$SortAscDesc_Desc> get copyWith =>
      throw _privateConstructorUsedError;
}
