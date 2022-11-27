// Dart API related
export 'src/interface.dart';
export 'src/instance.dart';
export 'src/index.dart';

// Rust FFI related
export 'src/bridge_generated.dart'
    show SortBy, TermsMatchingStrategy, MimirIndexSettings, Synonyms, Filter;
export 'package:flutter_rust_bridge/flutter_rust_bridge.dart' show WasmModule;
