import 'dart:ffi';
import 'dart:io';

import 'package:embedded_meilisearch/embedded_meilisearch.dart';

const _libName = 'embedded_milli';
final _libPrefix = {
  Platform.isWindows: '',
  Platform.isMacOS: 'lib',
  Platform.isLinux: 'lib',
}[true]!;
final _libSuffix = {
  Platform.isWindows: 'dll',
  Platform.isMacOS: 'dylib',
  Platform.isLinux: 'so',
}[true]!;
final _dylibPath = 'native/target/debug/$_libPrefix$_libName.$_libSuffix';
final milli = Meili.createWrapper(DynamicLibrary.open(_dylibPath));

Directory createTmpDir() => Directory.systemTemp.createTempSync();
