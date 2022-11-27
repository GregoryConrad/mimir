import 'package:mimir/src/bridge_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';

typedef ExternalLibrary = WasmModule;

EmbeddedMilli createWrapperImpl(ExternalLibrary module) =>
    EmbeddedMilliImpl.wasm(module);
