import 'package:embedded_meilisearch/bridge_generated.dart';
import 'package:embedded_meilisearch/src/interface.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';

/// Adds ffi wrapper functionality
extension WebFfiMeiliInterface on MeiliInterface {
  /// Creates an [EmbeddedMilli] ffi wrapper
  EmbeddedMilli createWrapper(WasmModule module) =>
      EmbeddedMilliImpl.wasm(module);
}
