import 'package:embedded_meilisearch/embedded_meilisearch.dart';

/// Adds Flutter ffi wrapper functionality for the web
extension WebFfiFlutterMeiliInterface on MeiliInterface {
  WasmModule get _module {
    // Web is currently not supported. If we support web in the future, see:
    // https://github.com/fzyzcjy/flutter_rust_bridge/blob/master/frb_example/with_flutter/lib/ffi.web.dart

    throw UnsupportedError(
      'Web support is not provided by embedded_meilisearch (yet). See here:\n'
      'https://github.com/GregoryConrad/embedded_meilisearch/issues/10',
    );
  }

  /// Creates an [EmbeddedMilli] ffi wrapper for the web
  EmbeddedMilli createFlutterWrapper() => createWrapper(_module);
}
