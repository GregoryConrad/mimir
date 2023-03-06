import 'package:mimir/src/bridge_generated.dart';
import 'package:mimir/src/impl/instance_impl.dart';
import 'package:mimir/src/instance.dart';

// ignore: directives_ordering
import 'package:mimir/src/impl/ffi/stub.dart'
    if (dart.library.io) 'package:mimir/src/impl/ffi/io.dart'
    if (dart.library.html) 'package:mimir/src/impl/ffi/web.dart';

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

  // Internal ffi wrapper that is instantianted lazily.
  // Should only have one instance per process.
  EmbeddedMilli? _milli;

  // Instances map. Should only have one instance per app for streams to work.
  final _instances = <String, MimirInstance>{};

  /// Creates a MimirInstance from the given [path] and [library]
  ///
  /// The [path] has to point to a directory; a directory will be
  /// created for you at the given path if one does not already exist.
  ///
  /// [library] is a WasmModule on web & a DynamicLibrary on dart:io platforms.
  /// [library] is used to create the internal ffi object
  /// that is used to call the Rust APIs.
  MimirInstance getInstance({
    required String path,
    required ExternalLibrary library,
  }) {
    _milli ??= createWrapperImpl(library);
    return _instances.putIfAbsent(
      path,
      () => MimirInstanceImpl(path, _milli!),
    );
  }

  /// Creates an "or" [Filter] of the given sub-filters.
  Filter or(List<Filter> filters) => Filter.or(filters);

  /// Creates an "and" [Filter] of the given sub-filters.
  Filter and(List<Filter> filters) => Filter.and(filters);

  /// Creates a "not" [Filter] of the given sub-filter.
  Filter not(Filter filter) => Filter.not(filter);

  /// Creates a [Filter] in a declarative manner.
  /// Simply wraps around the underlying [Filter] API to make it easier to use.
  ///
  /// Example:
  /// ```dart
  /// // Instead of:
  /// Filter.or([
  ///   Filter.and([
  ///     Filter.equal(field: 'fruit', value: 'apple'),
  ///     Filter.between(field: 'year', from: '2000', to: '2009'),
  ///   ]),
  ///   Filter.inValues(field: 'colors', values: ['red', 'green']),
  /// ])
  /// // Which is somewhat hard to read, you can do:
  /// Mimir.or([
  ///   Mimir.and([
  ///     Mimir.where('fruit', isEqualTo: 'apple'),
  ///     Mimir.where('year', isBetween: '2000', and: '2009'),
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

    // "IN" operator
    List<String>? containsAtLeastOneOf,

    // "BETWEEN" operator
    String? isBetween,
    String? and,
  }) {
    final givenOperators = [
      MapEntry(
        isEqualTo != null,
        () => Filter.equal(field: field, value: isEqualTo!),
      ),
      MapEntry(
        isNotEqualTo != null,
        () => Filter.notEqual(field: field, value: isNotEqualTo!),
      ),
      MapEntry(
        isGreaterThanOrEqualTo != null,
        () => Filter.greaterThanOrEqual(
          field: field,
          value: isGreaterThanOrEqualTo!,
        ),
      ),
      MapEntry(
        isLessThanOrEqualTo != null,
        () => Filter.lessThanOrEqual(field: field, value: isLessThanOrEqualTo!),
      ),
      MapEntry(
        isGreaterThan != null,
        () => Filter.greaterThan(field: field, value: isGreaterThan!),
      ),
      MapEntry(
        isLessThan != null,
        () => Filter.lessThan(field: field, value: isLessThan!),
      ),
      MapEntry(exists != null, () {
        final existsFilter = Filter.exists(field: field);
        return exists! ? existsFilter : Filter.not(existsFilter);
      }),
      MapEntry(
        containsAtLeastOneOf != null,
        () => Filter.inValues(field: field, values: containsAtLeastOneOf!),
      ),
      MapEntry(
        isBetween != null && and != null,
        () => Filter.between(field: field, from: isBetween!, to: and!),
      ),
    ].where((e) => e.key);
    if (givenOperators.length != 1) {
      throw UnsupportedError(
        'Only one operator can be given for each where call. '
        'If you need to use multiple conditions, use Mimir.or or Mimir.and',
      );
    }
    return givenOperators.single.value();
  }
}
