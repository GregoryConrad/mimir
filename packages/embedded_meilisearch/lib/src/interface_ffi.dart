import 'package:embedded_meilisearch/bridge_generated.dart';
import 'package:embedded_meilisearch/src/interface.dart';

/// Represents the external library for embedded_milli.
///
/// Will be a DynamicLibrary for dart:io or WasmModule for dart:html
typedef ExternalLibrary = Object;

/// Adds ffi wrapper functionality
extension StubFfiMeiliInterface on MeiliInterface {
  /// Creates an [EmbeddedMilli] ffi wrapper from the supplied [lib].
  ///
  /// [lib] is either a DynamicLibrary on dart:io platforms
  /// or a WasmModule on web.
  EmbeddedMilli createWrapper(ExternalLibrary lib) =>
      throw UnimplementedError();
}
