import 'dart:io';

import 'package:mimir_example/mimir_example.dart';
import 'package:test/test.dart';

void main() {
  test('Example runs without error', () async {
    final tmpDir = useTmpDir();
    await run(tmpDir.path);
  });
}

Directory useTmpDir() {
  final dir = Directory.systemTemp.createTempSync();
  addTearDown(() => dir.deleteSync(recursive: true));
  return dir;
}
