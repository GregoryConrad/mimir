// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Filter {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Filter);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Filter()';
  }
}

/// @nodoc
class $FilterCopyWith<$Res> {
  $FilterCopyWith(Filter _, $Res Function(Filter) __);
}

/// @nodoc

class Filter_Or extends Filter {
  const Filter_Or(final List<Filter> field0)
      : _field0 = field0,
        super._();

  final List<Filter> _field0;
  List<Filter> get field0 {
    if (_field0 is EqualUnmodifiableListView) return _field0;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_field0);
  }

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Filter_OrCopyWith<Filter_Or> get copyWith =>
      _$Filter_OrCopyWithImpl<Filter_Or>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Filter_Or &&
            const DeepCollectionEquality().equals(other._field0, _field0));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_field0));

  @override
  String toString() {
    return 'Filter.or(field0: $field0)';
  }
}

/// @nodoc
abstract mixin class $Filter_OrCopyWith<$Res> implements $FilterCopyWith<$Res> {
  factory $Filter_OrCopyWith(Filter_Or value, $Res Function(Filter_Or) _then) =
      _$Filter_OrCopyWithImpl;
  @useResult
  $Res call({List<Filter> field0});
}

/// @nodoc
class _$Filter_OrCopyWithImpl<$Res> implements $Filter_OrCopyWith<$Res> {
  _$Filter_OrCopyWithImpl(this._self, this._then);

  final Filter_Or _self;
  final $Res Function(Filter_Or) _then;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? field0 = null,
  }) {
    return _then(Filter_Or(
      null == field0
          ? _self._field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as List<Filter>,
    ));
  }
}

/// @nodoc

class Filter_And extends Filter {
  const Filter_And(final List<Filter> field0)
      : _field0 = field0,
        super._();

  final List<Filter> _field0;
  List<Filter> get field0 {
    if (_field0 is EqualUnmodifiableListView) return _field0;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_field0);
  }

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Filter_AndCopyWith<Filter_And> get copyWith =>
      _$Filter_AndCopyWithImpl<Filter_And>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Filter_And &&
            const DeepCollectionEquality().equals(other._field0, _field0));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_field0));

  @override
  String toString() {
    return 'Filter.and(field0: $field0)';
  }
}

/// @nodoc
abstract mixin class $Filter_AndCopyWith<$Res>
    implements $FilterCopyWith<$Res> {
  factory $Filter_AndCopyWith(
          Filter_And value, $Res Function(Filter_And) _then) =
      _$Filter_AndCopyWithImpl;
  @useResult
  $Res call({List<Filter> field0});
}

/// @nodoc
class _$Filter_AndCopyWithImpl<$Res> implements $Filter_AndCopyWith<$Res> {
  _$Filter_AndCopyWithImpl(this._self, this._then);

  final Filter_And _self;
  final $Res Function(Filter_And) _then;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? field0 = null,
  }) {
    return _then(Filter_And(
      null == field0
          ? _self._field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as List<Filter>,
    ));
  }
}

/// @nodoc

class Filter_Not extends Filter {
  const Filter_Not(this.field0) : super._();

  final Filter field0;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Filter_NotCopyWith<Filter_Not> get copyWith =>
      _$Filter_NotCopyWithImpl<Filter_Not>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Filter_Not &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @override
  String toString() {
    return 'Filter.not(field0: $field0)';
  }
}

/// @nodoc
abstract mixin class $Filter_NotCopyWith<$Res>
    implements $FilterCopyWith<$Res> {
  factory $Filter_NotCopyWith(
          Filter_Not value, $Res Function(Filter_Not) _then) =
      _$Filter_NotCopyWithImpl;
  @useResult
  $Res call({Filter field0});

  $FilterCopyWith<$Res> get field0;
}

/// @nodoc
class _$Filter_NotCopyWithImpl<$Res> implements $Filter_NotCopyWith<$Res> {
  _$Filter_NotCopyWithImpl(this._self, this._then);

  final Filter_Not _self;
  final $Res Function(Filter_Not) _then;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? field0 = null,
  }) {
    return _then(Filter_Not(
      null == field0
          ? _self.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as Filter,
    ));
  }

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FilterCopyWith<$Res> get field0 {
    return $FilterCopyWith<$Res>(_self.field0, (value) {
      return _then(_self.copyWith(field0: value));
    });
  }
}

/// @nodoc

class Filter_Exists extends Filter {
  const Filter_Exists({required this.field}) : super._();

  final String field;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Filter_ExistsCopyWith<Filter_Exists> get copyWith =>
      _$Filter_ExistsCopyWithImpl<Filter_Exists>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Filter_Exists &&
            (identical(other.field, field) || other.field == field));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field);

  @override
  String toString() {
    return 'Filter.exists(field: $field)';
  }
}

/// @nodoc
abstract mixin class $Filter_ExistsCopyWith<$Res>
    implements $FilterCopyWith<$Res> {
  factory $Filter_ExistsCopyWith(
          Filter_Exists value, $Res Function(Filter_Exists) _then) =
      _$Filter_ExistsCopyWithImpl;
  @useResult
  $Res call({String field});
}

/// @nodoc
class _$Filter_ExistsCopyWithImpl<$Res>
    implements $Filter_ExistsCopyWith<$Res> {
  _$Filter_ExistsCopyWithImpl(this._self, this._then);

  final Filter_Exists _self;
  final $Res Function(Filter_Exists) _then;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? field = null,
  }) {
    return _then(Filter_Exists(
      field: null == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class Filter_InValues extends Filter {
  const Filter_InValues(
      {required this.field, required final List<String> values})
      : _values = values,
        super._();

  final String field;
  final List<String> _values;
  List<String> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Filter_InValuesCopyWith<Filter_InValues> get copyWith =>
      _$Filter_InValuesCopyWithImpl<Filter_InValues>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Filter_InValues &&
            (identical(other.field, field) || other.field == field) &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, field, const DeepCollectionEquality().hash(_values));

  @override
  String toString() {
    return 'Filter.inValues(field: $field, values: $values)';
  }
}

/// @nodoc
abstract mixin class $Filter_InValuesCopyWith<$Res>
    implements $FilterCopyWith<$Res> {
  factory $Filter_InValuesCopyWith(
          Filter_InValues value, $Res Function(Filter_InValues) _then) =
      _$Filter_InValuesCopyWithImpl;
  @useResult
  $Res call({String field, List<String> values});
}

/// @nodoc
class _$Filter_InValuesCopyWithImpl<$Res>
    implements $Filter_InValuesCopyWith<$Res> {
  _$Filter_InValuesCopyWithImpl(this._self, this._then);

  final Filter_InValues _self;
  final $Res Function(Filter_InValues) _then;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? field = null,
    Object? values = null,
  }) {
    return _then(Filter_InValues(
      field: null == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      values: null == values
          ? _self._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class Filter_GreaterThan extends Filter {
  const Filter_GreaterThan({required this.field, required this.value})
      : super._();

  final String field;
  final String value;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Filter_GreaterThanCopyWith<Filter_GreaterThan> get copyWith =>
      _$Filter_GreaterThanCopyWithImpl<Filter_GreaterThan>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Filter_GreaterThan &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field, value);

  @override
  String toString() {
    return 'Filter.greaterThan(field: $field, value: $value)';
  }
}

/// @nodoc
abstract mixin class $Filter_GreaterThanCopyWith<$Res>
    implements $FilterCopyWith<$Res> {
  factory $Filter_GreaterThanCopyWith(
          Filter_GreaterThan value, $Res Function(Filter_GreaterThan) _then) =
      _$Filter_GreaterThanCopyWithImpl;
  @useResult
  $Res call({String field, String value});
}

/// @nodoc
class _$Filter_GreaterThanCopyWithImpl<$Res>
    implements $Filter_GreaterThanCopyWith<$Res> {
  _$Filter_GreaterThanCopyWithImpl(this._self, this._then);

  final Filter_GreaterThan _self;
  final $Res Function(Filter_GreaterThan) _then;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? field = null,
    Object? value = null,
  }) {
    return _then(Filter_GreaterThan(
      field: null == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class Filter_GreaterThanOrEqual extends Filter {
  const Filter_GreaterThanOrEqual({required this.field, required this.value})
      : super._();

  final String field;
  final String value;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Filter_GreaterThanOrEqualCopyWith<Filter_GreaterThanOrEqual> get copyWith =>
      _$Filter_GreaterThanOrEqualCopyWithImpl<Filter_GreaterThanOrEqual>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Filter_GreaterThanOrEqual &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field, value);

  @override
  String toString() {
    return 'Filter.greaterThanOrEqual(field: $field, value: $value)';
  }
}

/// @nodoc
abstract mixin class $Filter_GreaterThanOrEqualCopyWith<$Res>
    implements $FilterCopyWith<$Res> {
  factory $Filter_GreaterThanOrEqualCopyWith(Filter_GreaterThanOrEqual value,
          $Res Function(Filter_GreaterThanOrEqual) _then) =
      _$Filter_GreaterThanOrEqualCopyWithImpl;
  @useResult
  $Res call({String field, String value});
}

/// @nodoc
class _$Filter_GreaterThanOrEqualCopyWithImpl<$Res>
    implements $Filter_GreaterThanOrEqualCopyWith<$Res> {
  _$Filter_GreaterThanOrEqualCopyWithImpl(this._self, this._then);

  final Filter_GreaterThanOrEqual _self;
  final $Res Function(Filter_GreaterThanOrEqual) _then;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? field = null,
    Object? value = null,
  }) {
    return _then(Filter_GreaterThanOrEqual(
      field: null == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class Filter_Equal extends Filter {
  const Filter_Equal({required this.field, required this.value}) : super._();

  final String field;
  final String value;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Filter_EqualCopyWith<Filter_Equal> get copyWith =>
      _$Filter_EqualCopyWithImpl<Filter_Equal>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Filter_Equal &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field, value);

  @override
  String toString() {
    return 'Filter.equal(field: $field, value: $value)';
  }
}

/// @nodoc
abstract mixin class $Filter_EqualCopyWith<$Res>
    implements $FilterCopyWith<$Res> {
  factory $Filter_EqualCopyWith(
          Filter_Equal value, $Res Function(Filter_Equal) _then) =
      _$Filter_EqualCopyWithImpl;
  @useResult
  $Res call({String field, String value});
}

/// @nodoc
class _$Filter_EqualCopyWithImpl<$Res> implements $Filter_EqualCopyWith<$Res> {
  _$Filter_EqualCopyWithImpl(this._self, this._then);

  final Filter_Equal _self;
  final $Res Function(Filter_Equal) _then;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? field = null,
    Object? value = null,
  }) {
    return _then(Filter_Equal(
      field: null == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class Filter_NotEqual extends Filter {
  const Filter_NotEqual({required this.field, required this.value}) : super._();

  final String field;
  final String value;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Filter_NotEqualCopyWith<Filter_NotEqual> get copyWith =>
      _$Filter_NotEqualCopyWithImpl<Filter_NotEqual>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Filter_NotEqual &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field, value);

  @override
  String toString() {
    return 'Filter.notEqual(field: $field, value: $value)';
  }
}

/// @nodoc
abstract mixin class $Filter_NotEqualCopyWith<$Res>
    implements $FilterCopyWith<$Res> {
  factory $Filter_NotEqualCopyWith(
          Filter_NotEqual value, $Res Function(Filter_NotEqual) _then) =
      _$Filter_NotEqualCopyWithImpl;
  @useResult
  $Res call({String field, String value});
}

/// @nodoc
class _$Filter_NotEqualCopyWithImpl<$Res>
    implements $Filter_NotEqualCopyWith<$Res> {
  _$Filter_NotEqualCopyWithImpl(this._self, this._then);

  final Filter_NotEqual _self;
  final $Res Function(Filter_NotEqual) _then;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? field = null,
    Object? value = null,
  }) {
    return _then(Filter_NotEqual(
      field: null == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class Filter_LessThan extends Filter {
  const Filter_LessThan({required this.field, required this.value}) : super._();

  final String field;
  final String value;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Filter_LessThanCopyWith<Filter_LessThan> get copyWith =>
      _$Filter_LessThanCopyWithImpl<Filter_LessThan>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Filter_LessThan &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field, value);

  @override
  String toString() {
    return 'Filter.lessThan(field: $field, value: $value)';
  }
}

/// @nodoc
abstract mixin class $Filter_LessThanCopyWith<$Res>
    implements $FilterCopyWith<$Res> {
  factory $Filter_LessThanCopyWith(
          Filter_LessThan value, $Res Function(Filter_LessThan) _then) =
      _$Filter_LessThanCopyWithImpl;
  @useResult
  $Res call({String field, String value});
}

/// @nodoc
class _$Filter_LessThanCopyWithImpl<$Res>
    implements $Filter_LessThanCopyWith<$Res> {
  _$Filter_LessThanCopyWithImpl(this._self, this._then);

  final Filter_LessThan _self;
  final $Res Function(Filter_LessThan) _then;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? field = null,
    Object? value = null,
  }) {
    return _then(Filter_LessThan(
      field: null == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class Filter_LessThanOrEqual extends Filter {
  const Filter_LessThanOrEqual({required this.field, required this.value})
      : super._();

  final String field;
  final String value;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Filter_LessThanOrEqualCopyWith<Filter_LessThanOrEqual> get copyWith =>
      _$Filter_LessThanOrEqualCopyWithImpl<Filter_LessThanOrEqual>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Filter_LessThanOrEqual &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field, value);

  @override
  String toString() {
    return 'Filter.lessThanOrEqual(field: $field, value: $value)';
  }
}

/// @nodoc
abstract mixin class $Filter_LessThanOrEqualCopyWith<$Res>
    implements $FilterCopyWith<$Res> {
  factory $Filter_LessThanOrEqualCopyWith(Filter_LessThanOrEqual value,
          $Res Function(Filter_LessThanOrEqual) _then) =
      _$Filter_LessThanOrEqualCopyWithImpl;
  @useResult
  $Res call({String field, String value});
}

/// @nodoc
class _$Filter_LessThanOrEqualCopyWithImpl<$Res>
    implements $Filter_LessThanOrEqualCopyWith<$Res> {
  _$Filter_LessThanOrEqualCopyWithImpl(this._self, this._then);

  final Filter_LessThanOrEqual _self;
  final $Res Function(Filter_LessThanOrEqual) _then;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? field = null,
    Object? value = null,
  }) {
    return _then(Filter_LessThanOrEqual(
      field: null == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class Filter_Between extends Filter {
  const Filter_Between(
      {required this.field, required this.from, required this.to})
      : super._();

  final String field;
  final String from;
  final String to;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Filter_BetweenCopyWith<Filter_Between> get copyWith =>
      _$Filter_BetweenCopyWithImpl<Filter_Between>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Filter_Between &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field, from, to);

  @override
  String toString() {
    return 'Filter.between(field: $field, from: $from, to: $to)';
  }
}

/// @nodoc
abstract mixin class $Filter_BetweenCopyWith<$Res>
    implements $FilterCopyWith<$Res> {
  factory $Filter_BetweenCopyWith(
          Filter_Between value, $Res Function(Filter_Between) _then) =
      _$Filter_BetweenCopyWithImpl;
  @useResult
  $Res call({String field, String from, String to});
}

/// @nodoc
class _$Filter_BetweenCopyWithImpl<$Res>
    implements $Filter_BetweenCopyWith<$Res> {
  _$Filter_BetweenCopyWithImpl(this._self, this._then);

  final Filter_Between _self;
  final $Res Function(Filter_Between) _then;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? field = null,
    Object? from = null,
    Object? to = null,
  }) {
    return _then(Filter_Between(
      field: null == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      from: null == from
          ? _self.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _self.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class Filter_IsNull extends Filter {
  const Filter_IsNull({required this.field}) : super._();

  final String field;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Filter_IsNullCopyWith<Filter_IsNull> get copyWith =>
      _$Filter_IsNullCopyWithImpl<Filter_IsNull>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Filter_IsNull &&
            (identical(other.field, field) || other.field == field));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field);

  @override
  String toString() {
    return 'Filter.isNull(field: $field)';
  }
}

/// @nodoc
abstract mixin class $Filter_IsNullCopyWith<$Res>
    implements $FilterCopyWith<$Res> {
  factory $Filter_IsNullCopyWith(
          Filter_IsNull value, $Res Function(Filter_IsNull) _then) =
      _$Filter_IsNullCopyWithImpl;
  @useResult
  $Res call({String field});
}

/// @nodoc
class _$Filter_IsNullCopyWithImpl<$Res>
    implements $Filter_IsNullCopyWith<$Res> {
  _$Filter_IsNullCopyWithImpl(this._self, this._then);

  final Filter_IsNull _self;
  final $Res Function(Filter_IsNull) _then;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? field = null,
  }) {
    return _then(Filter_IsNull(
      field: null == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class Filter_IsEmpty extends Filter {
  const Filter_IsEmpty({required this.field}) : super._();

  final String field;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $Filter_IsEmptyCopyWith<Filter_IsEmpty> get copyWith =>
      _$Filter_IsEmptyCopyWithImpl<Filter_IsEmpty>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Filter_IsEmpty &&
            (identical(other.field, field) || other.field == field));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field);

  @override
  String toString() {
    return 'Filter.isEmpty(field: $field)';
  }
}

/// @nodoc
abstract mixin class $Filter_IsEmptyCopyWith<$Res>
    implements $FilterCopyWith<$Res> {
  factory $Filter_IsEmptyCopyWith(
          Filter_IsEmpty value, $Res Function(Filter_IsEmpty) _then) =
      _$Filter_IsEmptyCopyWithImpl;
  @useResult
  $Res call({String field});
}

/// @nodoc
class _$Filter_IsEmptyCopyWithImpl<$Res>
    implements $Filter_IsEmptyCopyWith<$Res> {
  _$Filter_IsEmptyCopyWithImpl(this._self, this._then);

  final Filter_IsEmpty _self;
  final $Res Function(Filter_IsEmpty) _then;

  /// Create a copy of Filter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? field = null,
  }) {
    return _then(Filter_IsEmpty(
      field: null == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$MimirIndexSettings {
  String? get primaryKey;
  List<String>? get searchableFields;
  List<String> get filterableFields;
  List<String> get sortableFields;
  List<String> get rankingRules;
  List<String> get stopWords;
  List<Synonyms> get synonyms;
  bool get typosEnabled;
  int get minWordSizeForOneTypo;
  int get minWordSizeForTwoTypos;
  List<String> get disallowTyposOnWords;
  List<String> get disallowTyposOnFields;

  /// Create a copy of MimirIndexSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MimirIndexSettingsCopyWith<MimirIndexSettings> get copyWith =>
      _$MimirIndexSettingsCopyWithImpl<MimirIndexSettings>(
          this as MimirIndexSettings, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MimirIndexSettings &&
            (identical(other.primaryKey, primaryKey) ||
                other.primaryKey == primaryKey) &&
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
      primaryKey,
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
    return 'MimirIndexSettings(primaryKey: $primaryKey, searchableFields: $searchableFields, filterableFields: $filterableFields, sortableFields: $sortableFields, rankingRules: $rankingRules, stopWords: $stopWords, synonyms: $synonyms, typosEnabled: $typosEnabled, minWordSizeForOneTypo: $minWordSizeForOneTypo, minWordSizeForTwoTypos: $minWordSizeForTwoTypos, disallowTyposOnWords: $disallowTyposOnWords, disallowTyposOnFields: $disallowTyposOnFields)';
  }
}

/// @nodoc
abstract mixin class $MimirIndexSettingsCopyWith<$Res> {
  factory $MimirIndexSettingsCopyWith(
          MimirIndexSettings value, $Res Function(MimirIndexSettings) _then) =
      _$MimirIndexSettingsCopyWithImpl;
  @useResult
  $Res call(
      {String? primaryKey,
      List<String>? searchableFields,
      List<String> filterableFields,
      List<String> sortableFields,
      List<String> rankingRules,
      List<String> stopWords,
      List<Synonyms> synonyms,
      bool typosEnabled,
      int minWordSizeForOneTypo,
      int minWordSizeForTwoTypos,
      List<String> disallowTyposOnWords,
      List<String> disallowTyposOnFields});
}

/// @nodoc
class _$MimirIndexSettingsCopyWithImpl<$Res>
    implements $MimirIndexSettingsCopyWith<$Res> {
  _$MimirIndexSettingsCopyWithImpl(this._self, this._then);

  final MimirIndexSettings _self;
  final $Res Function(MimirIndexSettings) _then;

  /// Create a copy of MimirIndexSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primaryKey = freezed,
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
      primaryKey: freezed == primaryKey
          ? _self.primaryKey
          : primaryKey // ignore: cast_nullable_to_non_nullable
              as String?,
      searchableFields: freezed == searchableFields
          ? _self.searchableFields
          : searchableFields // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      filterableFields: null == filterableFields
          ? _self.filterableFields
          : filterableFields // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sortableFields: null == sortableFields
          ? _self.sortableFields
          : sortableFields // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rankingRules: null == rankingRules
          ? _self.rankingRules
          : rankingRules // ignore: cast_nullable_to_non_nullable
              as List<String>,
      stopWords: null == stopWords
          ? _self.stopWords
          : stopWords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      synonyms: null == synonyms
          ? _self.synonyms
          : synonyms // ignore: cast_nullable_to_non_nullable
              as List<Synonyms>,
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
              as List<String>,
      disallowTyposOnFields: null == disallowTyposOnFields
          ? _self.disallowTyposOnFields
          : disallowTyposOnFields // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _MimirIndexSettings implements MimirIndexSettings {
  const _MimirIndexSettings(
      {this.primaryKey,
      final List<String>? searchableFields,
      required final List<String> filterableFields,
      required final List<String> sortableFields,
      required final List<String> rankingRules,
      required final List<String> stopWords,
      required final List<Synonyms> synonyms,
      required this.typosEnabled,
      required this.minWordSizeForOneTypo,
      required this.minWordSizeForTwoTypos,
      required final List<String> disallowTyposOnWords,
      required final List<String> disallowTyposOnFields})
      : _searchableFields = searchableFields,
        _filterableFields = filterableFields,
        _sortableFields = sortableFields,
        _rankingRules = rankingRules,
        _stopWords = stopWords,
        _synonyms = synonyms,
        _disallowTyposOnWords = disallowTyposOnWords,
        _disallowTyposOnFields = disallowTyposOnFields;

  @override
  final String? primaryKey;
  final List<String>? _searchableFields;
  @override
  List<String>? get searchableFields {
    final value = _searchableFields;
    if (value == null) return null;
    if (_searchableFields is EqualUnmodifiableListView)
      return _searchableFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String> _filterableFields;
  @override
  List<String> get filterableFields {
    if (_filterableFields is EqualUnmodifiableListView)
      return _filterableFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filterableFields);
  }

  final List<String> _sortableFields;
  @override
  List<String> get sortableFields {
    if (_sortableFields is EqualUnmodifiableListView) return _sortableFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sortableFields);
  }

  final List<String> _rankingRules;
  @override
  List<String> get rankingRules {
    if (_rankingRules is EqualUnmodifiableListView) return _rankingRules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rankingRules);
  }

  final List<String> _stopWords;
  @override
  List<String> get stopWords {
    if (_stopWords is EqualUnmodifiableListView) return _stopWords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stopWords);
  }

  final List<Synonyms> _synonyms;
  @override
  List<Synonyms> get synonyms {
    if (_synonyms is EqualUnmodifiableListView) return _synonyms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_synonyms);
  }

  @override
  final bool typosEnabled;
  @override
  final int minWordSizeForOneTypo;
  @override
  final int minWordSizeForTwoTypos;
  final List<String> _disallowTyposOnWords;
  @override
  List<String> get disallowTyposOnWords {
    if (_disallowTyposOnWords is EqualUnmodifiableListView)
      return _disallowTyposOnWords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_disallowTyposOnWords);
  }

  final List<String> _disallowTyposOnFields;
  @override
  List<String> get disallowTyposOnFields {
    if (_disallowTyposOnFields is EqualUnmodifiableListView)
      return _disallowTyposOnFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_disallowTyposOnFields);
  }

  /// Create a copy of MimirIndexSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MimirIndexSettingsCopyWith<_MimirIndexSettings> get copyWith =>
      __$MimirIndexSettingsCopyWithImpl<_MimirIndexSettings>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MimirIndexSettings &&
            (identical(other.primaryKey, primaryKey) ||
                other.primaryKey == primaryKey) &&
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
      primaryKey,
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
    return 'MimirIndexSettings(primaryKey: $primaryKey, searchableFields: $searchableFields, filterableFields: $filterableFields, sortableFields: $sortableFields, rankingRules: $rankingRules, stopWords: $stopWords, synonyms: $synonyms, typosEnabled: $typosEnabled, minWordSizeForOneTypo: $minWordSizeForOneTypo, minWordSizeForTwoTypos: $minWordSizeForTwoTypos, disallowTyposOnWords: $disallowTyposOnWords, disallowTyposOnFields: $disallowTyposOnFields)';
  }
}

/// @nodoc
abstract mixin class _$MimirIndexSettingsCopyWith<$Res>
    implements $MimirIndexSettingsCopyWith<$Res> {
  factory _$MimirIndexSettingsCopyWith(
          _MimirIndexSettings value, $Res Function(_MimirIndexSettings) _then) =
      __$MimirIndexSettingsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? primaryKey,
      List<String>? searchableFields,
      List<String> filterableFields,
      List<String> sortableFields,
      List<String> rankingRules,
      List<String> stopWords,
      List<Synonyms> synonyms,
      bool typosEnabled,
      int minWordSizeForOneTypo,
      int minWordSizeForTwoTypos,
      List<String> disallowTyposOnWords,
      List<String> disallowTyposOnFields});
}

/// @nodoc
class __$MimirIndexSettingsCopyWithImpl<$Res>
    implements _$MimirIndexSettingsCopyWith<$Res> {
  __$MimirIndexSettingsCopyWithImpl(this._self, this._then);

  final _MimirIndexSettings _self;
  final $Res Function(_MimirIndexSettings) _then;

  /// Create a copy of MimirIndexSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? primaryKey = freezed,
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
    return _then(_MimirIndexSettings(
      primaryKey: freezed == primaryKey
          ? _self.primaryKey
          : primaryKey // ignore: cast_nullable_to_non_nullable
              as String?,
      searchableFields: freezed == searchableFields
          ? _self._searchableFields
          : searchableFields // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      filterableFields: null == filterableFields
          ? _self._filterableFields
          : filterableFields // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sortableFields: null == sortableFields
          ? _self._sortableFields
          : sortableFields // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rankingRules: null == rankingRules
          ? _self._rankingRules
          : rankingRules // ignore: cast_nullable_to_non_nullable
              as List<String>,
      stopWords: null == stopWords
          ? _self._stopWords
          : stopWords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      synonyms: null == synonyms
          ? _self._synonyms
          : synonyms // ignore: cast_nullable_to_non_nullable
              as List<Synonyms>,
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
              as List<String>,
      disallowTyposOnFields: null == disallowTyposOnFields
          ? _self._disallowTyposOnFields
          : disallowTyposOnFields // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
mixin _$SortBy {
  String get field0;

  /// Create a copy of SortBy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SortByCopyWith<SortBy> get copyWith =>
      _$SortByCopyWithImpl<SortBy>(this as SortBy, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SortBy &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @override
  String toString() {
    return 'SortBy(field0: $field0)';
  }
}

/// @nodoc
abstract mixin class $SortByCopyWith<$Res> {
  factory $SortByCopyWith(SortBy value, $Res Function(SortBy) _then) =
      _$SortByCopyWithImpl;
  @useResult
  $Res call({String field0});
}

/// @nodoc
class _$SortByCopyWithImpl<$Res> implements $SortByCopyWith<$Res> {
  _$SortByCopyWithImpl(this._self, this._then);

  final SortBy _self;
  final $Res Function(SortBy) _then;

  /// Create a copy of SortBy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_self.copyWith(
      field0: null == field0
          ? _self.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class SortBy_Asc extends SortBy {
  const SortBy_Asc(this.field0) : super._();

  @override
  final String field0;

  /// Create a copy of SortBy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SortBy_AscCopyWith<SortBy_Asc> get copyWith =>
      _$SortBy_AscCopyWithImpl<SortBy_Asc>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SortBy_Asc &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @override
  String toString() {
    return 'SortBy.asc(field0: $field0)';
  }
}

/// @nodoc
abstract mixin class $SortBy_AscCopyWith<$Res>
    implements $SortByCopyWith<$Res> {
  factory $SortBy_AscCopyWith(
          SortBy_Asc value, $Res Function(SortBy_Asc) _then) =
      _$SortBy_AscCopyWithImpl;
  @override
  @useResult
  $Res call({String field0});
}

/// @nodoc
class _$SortBy_AscCopyWithImpl<$Res> implements $SortBy_AscCopyWith<$Res> {
  _$SortBy_AscCopyWithImpl(this._self, this._then);

  final SortBy_Asc _self;
  final $Res Function(SortBy_Asc) _then;

  /// Create a copy of SortBy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? field0 = null,
  }) {
    return _then(SortBy_Asc(
      null == field0
          ? _self.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class SortBy_Desc extends SortBy {
  const SortBy_Desc(this.field0) : super._();

  @override
  final String field0;

  /// Create a copy of SortBy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SortBy_DescCopyWith<SortBy_Desc> get copyWith =>
      _$SortBy_DescCopyWithImpl<SortBy_Desc>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SortBy_Desc &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @override
  String toString() {
    return 'SortBy.desc(field0: $field0)';
  }
}

/// @nodoc
abstract mixin class $SortBy_DescCopyWith<$Res>
    implements $SortByCopyWith<$Res> {
  factory $SortBy_DescCopyWith(
          SortBy_Desc value, $Res Function(SortBy_Desc) _then) =
      _$SortBy_DescCopyWithImpl;
  @override
  @useResult
  $Res call({String field0});
}

/// @nodoc
class _$SortBy_DescCopyWithImpl<$Res> implements $SortBy_DescCopyWith<$Res> {
  _$SortBy_DescCopyWithImpl(this._self, this._then);

  final SortBy_Desc _self;
  final $Res Function(SortBy_Desc) _then;

  /// Create a copy of SortBy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? field0 = null,
  }) {
    return _then(SortBy_Desc(
      null == field0
          ? _self.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$Synonyms {
  String get word;
  List<String> get synonyms;

  /// Create a copy of Synonyms
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SynonymsCopyWith<Synonyms> get copyWith =>
      _$SynonymsCopyWithImpl<Synonyms>(this as Synonyms, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Synonyms &&
            (identical(other.word, word) || other.word == word) &&
            const DeepCollectionEquality().equals(other.synonyms, synonyms));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, word, const DeepCollectionEquality().hash(synonyms));

  @override
  String toString() {
    return 'Synonyms(word: $word, synonyms: $synonyms)';
  }
}

/// @nodoc
abstract mixin class $SynonymsCopyWith<$Res> {
  factory $SynonymsCopyWith(Synonyms value, $Res Function(Synonyms) _then) =
      _$SynonymsCopyWithImpl;
  @useResult
  $Res call({String word, List<String> synonyms});
}

/// @nodoc
class _$SynonymsCopyWithImpl<$Res> implements $SynonymsCopyWith<$Res> {
  _$SynonymsCopyWithImpl(this._self, this._then);

  final Synonyms _self;
  final $Res Function(Synonyms) _then;

  /// Create a copy of Synonyms
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? word = null,
    Object? synonyms = null,
  }) {
    return _then(_self.copyWith(
      word: null == word
          ? _self.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      synonyms: null == synonyms
          ? _self.synonyms
          : synonyms // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _Synonyms implements Synonyms {
  const _Synonyms({required this.word, required final List<String> synonyms})
      : _synonyms = synonyms;

  @override
  final String word;
  final List<String> _synonyms;
  @override
  List<String> get synonyms {
    if (_synonyms is EqualUnmodifiableListView) return _synonyms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_synonyms);
  }

  /// Create a copy of Synonyms
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SynonymsCopyWith<_Synonyms> get copyWith =>
      __$SynonymsCopyWithImpl<_Synonyms>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Synonyms &&
            (identical(other.word, word) || other.word == word) &&
            const DeepCollectionEquality().equals(other._synonyms, _synonyms));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, word, const DeepCollectionEquality().hash(_synonyms));

  @override
  String toString() {
    return 'Synonyms(word: $word, synonyms: $synonyms)';
  }
}

/// @nodoc
abstract mixin class _$SynonymsCopyWith<$Res>
    implements $SynonymsCopyWith<$Res> {
  factory _$SynonymsCopyWith(_Synonyms value, $Res Function(_Synonyms) _then) =
      __$SynonymsCopyWithImpl;
  @override
  @useResult
  $Res call({String word, List<String> synonyms});
}

/// @nodoc
class __$SynonymsCopyWithImpl<$Res> implements _$SynonymsCopyWith<$Res> {
  __$SynonymsCopyWithImpl(this._self, this._then);

  final _Synonyms _self;
  final $Res Function(_Synonyms) _then;

  /// Create a copy of Synonyms
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? word = null,
    Object? synonyms = null,
  }) {
    return _then(_Synonyms(
      word: null == word
          ? _self.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      synonyms: null == synonyms
          ? _self._synonyms
          : synonyms // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
