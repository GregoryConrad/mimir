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
mixin _$SortBy {
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
    required TResult Function(SortBy_Asc value) asc,
    required TResult Function(SortBy_Desc value) desc,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SortBy_Asc value)? asc,
    TResult? Function(SortBy_Desc value)? desc,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SortBy_Asc value)? asc,
    TResult Function(SortBy_Desc value)? desc,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SortByCopyWith<SortBy> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SortByCopyWith<$Res> {
  factory $SortByCopyWith(SortBy value, $Res Function(SortBy) then) =
      _$SortByCopyWithImpl<$Res, SortBy>;
  @useResult
  $Res call({String field0});
}

/// @nodoc
class _$SortByCopyWithImpl<$Res, $Val extends SortBy>
    implements $SortByCopyWith<$Res> {
  _$SortByCopyWithImpl(this._value, this._then);

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
abstract class _$$SortBy_AscCopyWith<$Res> implements $SortByCopyWith<$Res> {
  factory _$$SortBy_AscCopyWith(
          _$SortBy_Asc value, $Res Function(_$SortBy_Asc) then) =
      __$$SortBy_AscCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String field0});
}

/// @nodoc
class __$$SortBy_AscCopyWithImpl<$Res>
    extends _$SortByCopyWithImpl<$Res, _$SortBy_Asc>
    implements _$$SortBy_AscCopyWith<$Res> {
  __$$SortBy_AscCopyWithImpl(
      _$SortBy_Asc _value, $Res Function(_$SortBy_Asc) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$SortBy_Asc(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SortBy_Asc implements SortBy_Asc {
  const _$SortBy_Asc(this.field0);

  @override
  final String field0;

  @override
  String toString() {
    return 'SortBy.asc(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SortBy_Asc &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SortBy_AscCopyWith<_$SortBy_Asc> get copyWith =>
      __$$SortBy_AscCopyWithImpl<_$SortBy_Asc>(this, _$identity);

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
    required TResult Function(SortBy_Asc value) asc,
    required TResult Function(SortBy_Desc value) desc,
  }) {
    return asc(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SortBy_Asc value)? asc,
    TResult? Function(SortBy_Desc value)? desc,
  }) {
    return asc?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SortBy_Asc value)? asc,
    TResult Function(SortBy_Desc value)? desc,
    required TResult orElse(),
  }) {
    if (asc != null) {
      return asc(this);
    }
    return orElse();
  }
}

abstract class SortBy_Asc implements SortBy {
  const factory SortBy_Asc(final String field0) = _$SortBy_Asc;

  @override
  String get field0;
  @override
  @JsonKey(ignore: true)
  _$$SortBy_AscCopyWith<_$SortBy_Asc> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SortBy_DescCopyWith<$Res> implements $SortByCopyWith<$Res> {
  factory _$$SortBy_DescCopyWith(
          _$SortBy_Desc value, $Res Function(_$SortBy_Desc) then) =
      __$$SortBy_DescCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String field0});
}

/// @nodoc
class __$$SortBy_DescCopyWithImpl<$Res>
    extends _$SortByCopyWithImpl<$Res, _$SortBy_Desc>
    implements _$$SortBy_DescCopyWith<$Res> {
  __$$SortBy_DescCopyWithImpl(
      _$SortBy_Desc _value, $Res Function(_$SortBy_Desc) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$SortBy_Desc(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SortBy_Desc implements SortBy_Desc {
  const _$SortBy_Desc(this.field0);

  @override
  final String field0;

  @override
  String toString() {
    return 'SortBy.desc(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SortBy_Desc &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SortBy_DescCopyWith<_$SortBy_Desc> get copyWith =>
      __$$SortBy_DescCopyWithImpl<_$SortBy_Desc>(this, _$identity);

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
    required TResult Function(SortBy_Asc value) asc,
    required TResult Function(SortBy_Desc value) desc,
  }) {
    return desc(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SortBy_Asc value)? asc,
    TResult? Function(SortBy_Desc value)? desc,
  }) {
    return desc?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SortBy_Asc value)? asc,
    TResult Function(SortBy_Desc value)? desc,
    required TResult orElse(),
  }) {
    if (desc != null) {
      return desc(this);
    }
    return orElse();
  }
}

abstract class SortBy_Desc implements SortBy {
  const factory SortBy_Desc(final String field0) = _$SortBy_Desc;

  @override
  String get field0;
  @override
  @JsonKey(ignore: true)
  _$$SortBy_DescCopyWith<_$SortBy_Desc> get copyWith =>
      throw _privateConstructorUsedError;
}
