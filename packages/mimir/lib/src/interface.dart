import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mimir/src/dispatch.dart';
import 'package:mimir/src/exception.dart';
import 'package:mimir/src/native/proto/instance/request.pb.dart';
import 'package:mimir/src/wrapper_types.dart';

part 'index.dart';
part 'instance.dart';

/// A default value to use for optional function parameters
const _defaultOptionalValue = Object();

/// Throws the error contained in [response], if there is one.
void _handleResponseError(InstanceFfiResponse response) {
  if (response.hasError()) throw MimirException(response.error);
}

/// The exposed API to interact with mimir
// Instead of just having a Mimir namespace, we have to do this instead,
// because we cannot add static extension methods to a class.
// This approach was taken from Hive, where initFlutter()
// in the hive_flutter package is an extension method.
// To the user this will look like a class/namespace so it is okay.
// ignore: non_constant_identifier_names
final Mimir = MimirInterface._();

/// The interface of the API to interact with mimir
class MimirInterface {
  // This class should only ever be instantiated *once*, so private constructor
  MimirInterface._();

  // Instances map. Should only have one instance per app for streams to work.
  final _instances = <String, MimirInstance>{};

  /// Creates a MimirInstance from the given [path].
  ///
  /// The [path] has to point to a directory; a directory will be
  /// created for you at the given path if one does not already exist.
  Future<MimirInstance> getInstance({required String path}) async {
    await processInstanceRequest(
      InstanceFfiRequest(
        instanceDir: path,
        ensureInstanceInitialized: InstanceFfiRequest_EnsureInitialized(
          // NOTE: Needed by https://github.com/GregoryConrad/mimir/issues/170
          tmpDir: Platform.isAndroid ? Directory.systemTemp.path : null,
        ),
      ),
      _handleResponseError,
    );
    return _instances.putIfAbsent(path, () => _MimirInstanceImpl(path));
  }

  /// Creates an "or" [Filter] of the given sub-filters.
  Filter or(List<Filter> filters) =>
      Filter(or: Filter_Filters(filters: filters));

  /// Creates an "and" [Filter] of the given sub-filters.
  Filter and(List<Filter> filters) =>
      Filter(and: Filter_Filters(filters: filters));

  /// Creates a "not" [Filter] of the given sub-filter.
  Filter not(Filter filter) => Filter(not: filter);

  /// Creates a [Filter] in a declarative manner.
  /// Simply wraps around the underlying [Filter] API.
  ///
  /// Example:
  /// ```dart
  /// Mimir.or([
  ///   Mimir.and([
  ///     Mimir.where('fruit', isEqualTo: 'apple'),
  ///     Mimir.where('year', isBetween: ('2000', '2009')),
  ///   ]),
  ///   Mimir.where('colors', containsAtLeastOneOf: ['red', 'green']),
  /// ])
  /// ```
  Filter where(
    String field, {
    // Standard operators
    String? isEqualTo,
    String? isNotEqualTo,
    String? isGreaterThanOrEqualTo,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isLessThan,
    bool? exists,
    bool? isNull,
    bool? isEmpty,

    // "IN" operator
    List<String>? containsAtLeastOneOf,

    // "BETWEEN" operator
    (String, String)? isBetween,
  }) {
    final givenOperators = [
      (
        isEqualTo != null,
        () => Filter(
          equal: Filter_Comparison(field_1: field, value: isEqualTo),
        ),
      ),
      (
        isNotEqualTo != null,
        () => Filter(
          notEqual: Filter_Comparison(field_1: field, value: isNotEqualTo),
        ),
      ),
      (
        isGreaterThanOrEqualTo != null,
        () => Filter(
          greaterThanOrEqual: Filter_Comparison(
            field_1: field,
            value: isGreaterThanOrEqualTo,
          ),
        ),
      ),
      (
        isLessThanOrEqualTo != null,
        () => Filter(
          lessThanOrEqual: Filter_Comparison(
            field_1: field,
            value: isLessThanOrEqualTo,
          ),
        ),
      ),
      (
        isGreaterThan != null,
        () => Filter(
          greaterThan: Filter_Comparison(field_1: field, value: isGreaterThan),
        ),
      ),
      (
        isLessThan != null,
        () => Filter(
          lessThan: Filter_Comparison(field_1: field, value: isLessThan),
        ),
      ),
      (
        exists != null,
        () {
          final existsFilter = Filter(exists: Filter_Field(field_1: field));
          return exists! ? existsFilter : not(existsFilter);
        },
      ),
      (
        isNull != null,
        () {
          final isNullFilter = Filter(isNull: Filter_Field(field_1: field));
          return isNull! ? isNullFilter : not(isNullFilter);
        },
      ),
      (
        isEmpty != null,
        () {
          final isEmptyFilter = Filter(isEmpty: Filter_Field(field_1: field));
          return isEmpty! ? isEmptyFilter : not(isEmptyFilter);
        },
      ),
      (
        containsAtLeastOneOf != null,
        () => Filter(
          inValues: Filter_InValues(
            field_1: field,
            values: containsAtLeastOneOf,
          ),
        ),
      ),
      (
        isBetween != null,
        () => Filter(
          between: Filter_Between(
            field_1: field,
            from: isBetween!.$1,
            to: isBetween.$2,
          ),
        ),
      ),
    ].where((operator) => operator.$1);
    if (givenOperators.length != 1) {
      throw UnsupportedError(
        'Exactly one operator must be specified for each where call. '
        'If you need to use multiple conditions, use Mimir.or or Mimir.and.',
      );
    }
    return givenOperators.single.$2();
  }
}
