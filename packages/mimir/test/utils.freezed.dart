// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'utils.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ComparableMimirIndexSettings {
  Set<String>? get searchableFields;
  Set<String> get filterableFields;
  Set<String> get sortableFields;
  List<String> get rankingRules;
  Set<String> get stopWords;
  Set<Synonyms> get synonyms;
  bool get typosEnabled;
  int get minWordSizeForOneTypo;
  int get minWordSizeForTwoTypos;
  Set<String> get disallowTyposOnWords;
  Set<String> get disallowTyposOnFields;

  /// Create a copy of ComparableMimirIndexSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComparableMimirIndexSettingsCopyWith<ComparableMimirIndexSettings>
      get copyWith => _$ComparableMimirIndexSettingsCopyWithImpl<
              ComparableMimirIndexSettings>(
          this as ComparableMimirIndexSettings, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComparableMimirIndexSettings &&
            const DeepCollectionEquality()
                .equals(other.searchableFields, searchableFields) &&
            const DeepCollectionEquality()
                .equals(other.filterableFields, filterableFields) &&
            const DeepCollectionEquality()
                .equals(other.sortableFields, sortableFields) &&
            const DeepCollectionEquality()
                .equals(other.rankingRules, rankingRules) &&
            const DeepCollectionEquality().equals(other.stopWords, stopWords) &&
            const DeepCollectionEquality().equals(other.synonyms, synonyms) &&
            (identical(other.typosEnabled, typosEnabled) ||
                other.typosEnabled == typosEnabled) &&
            (identical(other.minWordSizeForOneTypo, minWordSizeForOneTypo) ||
                other.minWordSizeForOneTypo == minWordSizeForOneTypo) &&
            (identical(other.minWordSizeForTwoTypos, minWordSizeForTwoTypos) ||
                other.minWordSizeForTwoTypos == minWordSizeForTwoTypos) &&
            const DeepCollectionEquality()
                .equals(other.disallowTyposOnWords, disallowTyposOnWords) &&
            const DeepCollectionEquality()
                .equals(other.disallowTyposOnFields, disallowTyposOnFields));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(searchableFields),
      const DeepCollectionEquality().hash(filterableFields),
      const DeepCollectionEquality().hash(sortableFields),
      const DeepCollectionEquality().hash(rankingRules),
      const DeepCollectionEquality().hash(stopWords),
      const DeepCollectionEquality().hash(synonyms),
      typosEnabled,
      minWordSizeForOneTypo,
      minWordSizeForTwoTypos,
      const DeepCollectionEquality().hash(disallowTyposOnWords),
      const DeepCollectionEquality().hash(disallowTyposOnFields));

  @override
  String toString() {
    return 'ComparableMimirIndexSettings(searchableFields: $searchableFields, filterableFields: $filterableFields, sortableFields: $sortableFields, rankingRules: $rankingRules, stopWords: $stopWords, synonyms: $synonyms, typosEnabled: $typosEnabled, minWordSizeForOneTypo: $minWordSizeForOneTypo, minWordSizeForTwoTypos: $minWordSizeForTwoTypos, disallowTyposOnWords: $disallowTyposOnWords, disallowTyposOnFields: $disallowTyposOnFields)';
  }
}

/// @nodoc
abstract mixin class $ComparableMimirIndexSettingsCopyWith<$Res> {
  factory $ComparableMimirIndexSettingsCopyWith(
          ComparableMimirIndexSettings value,
          $Res Function(ComparableMimirIndexSettings) _then) =
      _$ComparableMimirIndexSettingsCopyWithImpl;
  @useResult
  $Res call(
      {Set<String>? searchableFields,
      Set<String> filterableFields,
      Set<String> sortableFields,
      List<String> rankingRules,
      Set<String> stopWords,
      Set<Synonyms> synonyms,
      bool typosEnabled,
      int minWordSizeForOneTypo,
      int minWordSizeForTwoTypos,
      Set<String> disallowTyposOnWords,
      Set<String> disallowTyposOnFields});
}

/// @nodoc
class _$ComparableMimirIndexSettingsCopyWithImpl<$Res>
    implements $ComparableMimirIndexSettingsCopyWith<$Res> {
  _$ComparableMimirIndexSettingsCopyWithImpl(this._self, this._then);

  final ComparableMimirIndexSettings _self;
  final $Res Function(ComparableMimirIndexSettings) _then;

  /// Create a copy of ComparableMimirIndexSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchableFields = freezed,
    Object? filterableFields = null,
    Object? sortableFields = null,
    Object? rankingRules = null,
    Object? stopWords = null,
    Object? synonyms = null,
    Object? typosEnabled = null,
    Object? minWordSizeForOneTypo = null,
    Object? minWordSizeForTwoTypos = null,
    Object? disallowTyposOnWords = null,
    Object? disallowTyposOnFields = null,
  }) {
    return _then(_self.copyWith(
      searchableFields: freezed == searchableFields
          ? _self.searchableFields
          : searchableFields // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
      filterableFields: null == filterableFields
          ? _self.filterableFields
          : filterableFields // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      sortableFields: null == sortableFields
          ? _self.sortableFields
          : sortableFields // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      rankingRules: null == rankingRules
          ? _self.rankingRules
          : rankingRules // ignore: cast_nullable_to_non_nullable
              as List<String>,
      stopWords: null == stopWords
          ? _self.stopWords
          : stopWords // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      synonyms: null == synonyms
          ? _self.synonyms
          : synonyms // ignore: cast_nullable_to_non_nullable
              as Set<Synonyms>,
      typosEnabled: null == typosEnabled
          ? _self.typosEnabled
          : typosEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      minWordSizeForOneTypo: null == minWordSizeForOneTypo
          ? _self.minWordSizeForOneTypo
          : minWordSizeForOneTypo // ignore: cast_nullable_to_non_nullable
              as int,
      minWordSizeForTwoTypos: null == minWordSizeForTwoTypos
          ? _self.minWordSizeForTwoTypos
          : minWordSizeForTwoTypos // ignore: cast_nullable_to_non_nullable
              as int,
      disallowTyposOnWords: null == disallowTyposOnWords
          ? _self.disallowTyposOnWords
          : disallowTyposOnWords // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      disallowTyposOnFields: null == disallowTyposOnFields
          ? _self.disallowTyposOnFields
          : disallowTyposOnFields // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ));
  }
}

/// @nodoc

class _ComparableMimirIndexSettings implements ComparableMimirIndexSettings {
  const _ComparableMimirIndexSettings(
      {required final Set<String>? searchableFields,
      required final Set<String> filterableFields,
      required final Set<String> sortableFields,
      required final List<String> rankingRules,
      required final Set<String> stopWords,
      required final Set<Synonyms> synonyms,
      required this.typosEnabled,
      required this.minWordSizeForOneTypo,
      required this.minWordSizeForTwoTypos,
      required final Set<String> disallowTyposOnWords,
      required final Set<String> disallowTyposOnFields})
      : _searchableFields = searchableFields,
        _filterableFields = filterableFields,
        _sortableFields = sortableFields,
        _rankingRules = rankingRules,
        _stopWords = stopWords,
        _synonyms = synonyms,
        _disallowTyposOnWords = disallowTyposOnWords,
        _disallowTyposOnFields = disallowTyposOnFields;

  final Set<String>? _searchableFields;
  @override
  Set<String>? get searchableFields {
    final value = _searchableFields;
    if (value == null) return null;
    if (_searchableFields is EqualUnmodifiableSetView) return _searchableFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(value);
  }

  final Set<String> _filterableFields;
  @override
  Set<String> get filterableFields {
    if (_filterableFields is EqualUnmodifiableSetView) return _filterableFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_filterableFields);
  }

  final Set<String> _sortableFields;
  @override
  Set<String> get sortableFields {
    if (_sortableFields is EqualUnmodifiableSetView) return _sortableFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_sortableFields);
  }

  final List<String> _rankingRules;
  @override
  List<String> get rankingRules {
    if (_rankingRules is EqualUnmodifiableListView) return _rankingRules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rankingRules);
  }

  final Set<String> _stopWords;
  @override
  Set<String> get stopWords {
    if (_stopWords is EqualUnmodifiableSetView) return _stopWords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_stopWords);
  }

  final Set<Synonyms> _synonyms;
  @override
  Set<Synonyms> get synonyms {
    if (_synonyms is EqualUnmodifiableSetView) return _synonyms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_synonyms);
  }

  @override
  final bool typosEnabled;
  @override
  final int minWordSizeForOneTypo;
  @override
  final int minWordSizeForTwoTypos;
  final Set<String> _disallowTyposOnWords;
  @override
  Set<String> get disallowTyposOnWords {
    if (_disallowTyposOnWords is EqualUnmodifiableSetView)
      return _disallowTyposOnWords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_disallowTyposOnWords);
  }

  final Set<String> _disallowTyposOnFields;
  @override
  Set<String> get disallowTyposOnFields {
    if (_disallowTyposOnFields is EqualUnmodifiableSetView)
      return _disallowTyposOnFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_disallowTyposOnFields);
  }

  /// Create a copy of ComparableMimirIndexSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComparableMimirIndexSettingsCopyWith<_ComparableMimirIndexSettings>
      get copyWith => __$ComparableMimirIndexSettingsCopyWithImpl<
          _ComparableMimirIndexSettings>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComparableMimirIndexSettings &&
            const DeepCollectionEquality()
                .equals(other._searchableFields, _searchableFields) &&
            const DeepCollectionEquality()
                .equals(other._filterableFields, _filterableFields) &&
            const DeepCollectionEquality()
                .equals(other._sortableFields, _sortableFields) &&
            const DeepCollectionEquality()
                .equals(other._rankingRules, _rankingRules) &&
            const DeepCollectionEquality()
                .equals(other._stopWords, _stopWords) &&
            const DeepCollectionEquality().equals(other._synonyms, _synonyms) &&
            (identical(other.typosEnabled, typosEnabled) ||
                other.typosEnabled == typosEnabled) &&
            (identical(other.minWordSizeForOneTypo, minWordSizeForOneTypo) ||
                other.minWordSizeForOneTypo == minWordSizeForOneTypo) &&
            (identical(other.minWordSizeForTwoTypos, minWordSizeForTwoTypos) ||
                other.minWordSizeForTwoTypos == minWordSizeForTwoTypos) &&
            const DeepCollectionEquality()
                .equals(other._disallowTyposOnWords, _disallowTyposOnWords) &&
            const DeepCollectionEquality()
                .equals(other._disallowTyposOnFields, _disallowTyposOnFields));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_searchableFields),
      const DeepCollectionEquality().hash(_filterableFields),
      const DeepCollectionEquality().hash(_sortableFields),
      const DeepCollectionEquality().hash(_rankingRules),
      const DeepCollectionEquality().hash(_stopWords),
      const DeepCollectionEquality().hash(_synonyms),
      typosEnabled,
      minWordSizeForOneTypo,
      minWordSizeForTwoTypos,
      const DeepCollectionEquality().hash(_disallowTyposOnWords),
      const DeepCollectionEquality().hash(_disallowTyposOnFields));

  @override
  String toString() {
    return 'ComparableMimirIndexSettings(searchableFields: $searchableFields, filterableFields: $filterableFields, sortableFields: $sortableFields, rankingRules: $rankingRules, stopWords: $stopWords, synonyms: $synonyms, typosEnabled: $typosEnabled, minWordSizeForOneTypo: $minWordSizeForOneTypo, minWordSizeForTwoTypos: $minWordSizeForTwoTypos, disallowTyposOnWords: $disallowTyposOnWords, disallowTyposOnFields: $disallowTyposOnFields)';
  }
}

/// @nodoc
abstract mixin class _$ComparableMimirIndexSettingsCopyWith<$Res>
    implements $ComparableMimirIndexSettingsCopyWith<$Res> {
  factory _$ComparableMimirIndexSettingsCopyWith(
          _ComparableMimirIndexSettings value,
          $Res Function(_ComparableMimirIndexSettings) _then) =
      __$ComparableMimirIndexSettingsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Set<String>? searchableFields,
      Set<String> filterableFields,
      Set<String> sortableFields,
      List<String> rankingRules,
      Set<String> stopWords,
      Set<Synonyms> synonyms,
      bool typosEnabled,
      int minWordSizeForOneTypo,
      int minWordSizeForTwoTypos,
      Set<String> disallowTyposOnWords,
      Set<String> disallowTyposOnFields});
}

/// @nodoc
class __$ComparableMimirIndexSettingsCopyWithImpl<$Res>
    implements _$ComparableMimirIndexSettingsCopyWith<$Res> {
  __$ComparableMimirIndexSettingsCopyWithImpl(this._self, this._then);

  final _ComparableMimirIndexSettings _self;
  final $Res Function(_ComparableMimirIndexSettings) _then;

  /// Create a copy of ComparableMimirIndexSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? searchableFields = freezed,
    Object? filterableFields = null,
    Object? sortableFields = null,
    Object? rankingRules = null,
    Object? stopWords = null,
    Object? synonyms = null,
    Object? typosEnabled = null,
    Object? minWordSizeForOneTypo = null,
    Object? minWordSizeForTwoTypos = null,
    Object? disallowTyposOnWords = null,
    Object? disallowTyposOnFields = null,
  }) {
    return _then(_ComparableMimirIndexSettings(
      searchableFields: freezed == searchableFields
          ? _self._searchableFields
          : searchableFields // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
      filterableFields: null == filterableFields
          ? _self._filterableFields
          : filterableFields // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      sortableFields: null == sortableFields
          ? _self._sortableFields
          : sortableFields // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      rankingRules: null == rankingRules
          ? _self._rankingRules
          : rankingRules // ignore: cast_nullable_to_non_nullable
              as List<String>,
      stopWords: null == stopWords
          ? _self._stopWords
          : stopWords // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      synonyms: null == synonyms
          ? _self._synonyms
          : synonyms // ignore: cast_nullable_to_non_nullable
              as Set<Synonyms>,
      typosEnabled: null == typosEnabled
          ? _self.typosEnabled
          : typosEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      minWordSizeForOneTypo: null == minWordSizeForOneTypo
          ? _self.minWordSizeForOneTypo
          : minWordSizeForOneTypo // ignore: cast_nullable_to_non_nullable
              as int,
      minWordSizeForTwoTypos: null == minWordSizeForTwoTypos
          ? _self.minWordSizeForTwoTypos
          : minWordSizeForTwoTypos // ignore: cast_nullable_to_non_nullable
              as int,
      disallowTyposOnWords: null == disallowTyposOnWords
          ? _self._disallowTyposOnWords
          : disallowTyposOnWords // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      disallowTyposOnFields: null == disallowTyposOnFields
          ? _self._disallowTyposOnFields
          : disallowTyposOnFields // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ));
  }
}

// dart format on
