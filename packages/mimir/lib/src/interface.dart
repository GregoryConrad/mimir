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
// ignore: constant_identifier_names
const Mimir = MimirInterface._();

/// The interface of the API to interact with mimir
class MimirInterface {
  const MimirInterface._();

  static EmbeddedMilli? _wrapper;

  /// Creates a MimirInstance from the given [path] and [milli]
  ///
  /// The [path] has to point to a directory; a directory will be
  /// created for you at the given path if one does not already exist.
  ///
  /// [milli] is the ffi wrapper that is used internally to call the Rust APIs
  MimirInstance getInstance({
    required String path,
    required EmbeddedMilli milli,
  }) =>
      MimirInstanceImpl(path, milli);

  /// Creates an [EmbeddedMilli] ffi wrapper from the supplied [lib].
  ///
  /// [lib] is either a DynamicLibrary on dart:io platforms
  /// or a WasmModule on web.
  EmbeddedMilli createWrapper(ExternalLibrary lib) {
    _wrapper ??= createWrapperImpl(lib);
    return _wrapper!;
  }
}
