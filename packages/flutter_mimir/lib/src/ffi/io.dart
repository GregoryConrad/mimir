import 'dart:ffi';
import 'dart:io';

import 'package:meta/meta.dart';

@internal
// ignore: public_member_api_docs
DynamicLibrary createLibraryImpl() {
  const base = 'embedded_milli';

  if (Platform.isIOS || Platform.isMacOS) {
    return DynamicLibrary.executable();
  } else if (Platform.isWindows) {
    return DynamicLibrary.open('$base.dll');
  } else {
    return DynamicLibrary.open('lib$base.so');
  }
}
