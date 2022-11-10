import 'dart:ffi';
import 'dart:io';

import 'package:mimir/mimir.dart';

DynamicLibrary get _dylib {
  const base = 'embedded_milli';

  if (Platform.isIOS || Platform.isMacOS) {
    return DynamicLibrary.executable();
  } else if (Platform.isWindows) {
    return DynamicLibrary.open('$base.dll');
  } else {
    return DynamicLibrary.open('lib$base.so');
  }
}

/// Creates an [EmbeddedMilli] ffi wrapper for dart:io platforms
EmbeddedMilli createFlutterWrapper() => Mimir.createWrapper(_dylib);
