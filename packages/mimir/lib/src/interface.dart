import 'package:mimir/bridge_generated.dart';
import 'package:mimir/src/impl/instance_impl.dart';
import 'package:mimir/src/instance.dart';
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
}
