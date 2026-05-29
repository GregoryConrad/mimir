import 'dart:convert';
import 'dart:io';

import 'package:mimir/mimir.dart';
import 'package:test/test.dart';

Directory useTmpDir() {
  final dir = Directory.systemTemp.createTempSync();
  addTearDown(() => dir.deleteSync(recursive: true));
  return dir;
}

Future<MimirInstance> useInstance() {
  final dir = useTmpDir();
  return Mimir.getInstance(path: dir.path);
}

Future<MimirIndex> useTestIndex() async =>
    (await useInstance()).getIndex('test');

List<Map<String, dynamic>> useExercises() {
  final exercisesStr = File('test/assets/exercises.json').readAsStringSync();
  final exerciseLibrary = json.decode(exercisesStr) as Map<String, dynamic>;
  return (exerciseLibrary['exercises'] as List)
      .cast<Map<String, dynamic>>()
      .map((e) => e..['id'] = e['name'].hashCode)
      .toList();
}
