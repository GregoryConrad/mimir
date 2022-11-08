// Dart API related
export 'src/interface.dart';
export 'src/instance.dart';
export 'src/index.dart';
export 'src/interface_ffi.dart'
    if (dart.library.io) 'src/impl/interface_ffi.io.dart'
    if (dart.library.html) 'src/impl/interface_ffi.web.dart';

// Rust FFI related
export 'bridge_generated.dart'
    show
        EmbeddedMilli,
        SortAscDesc,
        TermsMatchingStrategy,
        MeiliIndexSettings,
        Synonyms,
        TypoTolerance;
export 'package:flutter_rust_bridge/flutter_rust_bridge.dart' show WasmModule;
