import 'package:mimir/mimir.dart';

WasmModule get _module {
  // Web is currently not supported. If we support web in the future, see:
  // https://github.com/fzyzcjy/flutter_rust_bridge/blob/master/frb_example/with_flutter/lib/ffi.web.dart

  throw UnsupportedError(
    'Web support is not provided by mimir (yet). See here:\n'
    'https://github.com/GregoryConrad/mimir/issues/10',
  );
}

/// Creates an [EmbeddedMilli] ffi wrapper for the web
EmbeddedMilli createFlutterWrapper() => Mimir.createWrapper(_module);
