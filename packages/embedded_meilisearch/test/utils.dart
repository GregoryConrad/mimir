import 'dart:ffi';
import 'dart:io';

import 'package:embedded_meilisearch/embedded_meilisearch.dart';
import 'package:test/test.dart';

EmbeddedMilli useMilli() {
  const libName = 'embedded_milli';
  final libPrefix = {
    Platform.isWindows: '',
    Platform.isMacOS: 'lib',
    Platform.isLinux: 'lib',
  }[true]!;
  final libSuffix = {
    Platform.isWindows: 'dll',
    Platform.isMacOS: 'dylib',
    Platform.isLinux: 'so',
  }[true]!;
  final dylibPath = 'native/target/debug/$libPrefix$libName.$libSuffix';
  return Meili.createWrapper(DynamicLibrary.open(dylibPath));
}

Directory useTmpDir() {
  final dir = Directory.systemTemp.createTempSync();
  addTearDown(() => dir.deleteSync(recursive: true));
  return dir;
}

MeiliInstance useInstance() {
  final dir = useTmpDir();
  final milli = useMilli();
  return Meili.getInstance(path: dir.path, milli: milli);
}

MeiliIndex useTestIndex() => useInstance().getIndex('test');
