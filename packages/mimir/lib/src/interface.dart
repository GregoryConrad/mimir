import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:mimir/src/api.dart';
import 'package:mimir/src/frb_generated.dart';
import 'package:mimir/src/impl/instance_impl.dart';
import 'package:mimir/src/instance.dart';

// ignore: directives_ordering
import 'package:mimir/src/impl/ffi/stub.dart'
    if (dart.library.io) 'package:mimir/src/impl/ffi/io.dart';

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
  ///
  /// In io (native), [ioDirectory] is the directory path used to locate
  /// the compiled rust library file.
  ///
  /// In Web, [webPrefix] is the prefix path for the wasm.
  Future<MimirInstance> getInstance({
    required String path,
    String? ioDirectory,
    String? webPrefix,
  }) async {
    if (!RustLib.instance.initialized) {
      final libraryLoaderConfig = ExternalLibraryLoaderConfig(
        stem: 'embedded_milli',
        ioDirectory: ioDirectory,
        webPrefix: webPrefix,
      );
      final lib = await loadExternalLibrary(libraryLoaderConfig);
      await RustLib.init(externalLibrary: lib);
    }

    await ensureInstanceInitialized(instanceDir: path, tmpDir: tmpDir());
    return _instances.putIfAbsent(path, () => MimirInstanceImpl(path));
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
        () => Filter.equal(field: field, value: isEqualTo!),
      ),
      (
        isNotEqualTo != null,
        () => Filter.notEqual(field: field, value: isNotEqualTo!),
      ),
      (
        isGreaterThanOrEqualTo != null,
        () => Filter.greaterThanOrEqual(
              field: field,
              value: isGreaterThanOrEqualTo!,
            ),
      ),
      (
        isLessThanOrEqualTo != null,
        () => Filter.lessThanOrEqual(field: field, value: isLessThanOrEqualTo!),
      ),
      (
        isGreaterThan != null,
        () => Filter.greaterThan(field: field, value: isGreaterThan!),
      ),
      (
        isLessThan != null,
        () => Filter.lessThan(field: field, value: isLessThan!),
      ),
      (
        exists != null,
        () {
          final existsFilter = Filter.exists(field: field);
          return exists! ? existsFilter : Filter.not(existsFilter);
        }
      ),
      (
        isNull != null,
        () {
          final isNullFilter = Filter.isNull(field: field);
          return isNull! ? isNullFilter : Filter.not(isNullFilter);
        }
      ),
      (
        isEmpty != null,
        () {
          final isEmptyFilter = Filter.isEmpty(field: field);
          return isEmpty! ? isEmptyFilter : Filter.not(isEmptyFilter);
        }
      ),
      (
        containsAtLeastOneOf != null,
        () => Filter.inValues(field: field, values: containsAtLeastOneOf!),
      ),
      (
        isBetween != null,
        () => Filter.between(
              field: field,
              from: isBetween!.$1,
              to: isBetween.$2,
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
