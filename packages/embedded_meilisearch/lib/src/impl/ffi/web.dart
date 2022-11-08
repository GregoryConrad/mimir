import 'package:embedded_meilisearch/bridge_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';

EmbeddedMilli createWrapperImpl(WasmModule module) =>
    EmbeddedMilliImpl.wasm(module);
