import 'dart:convert';
import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mimir/mimir.dart';
import 'package:test/test.dart';

part 'utils.freezed.dart';

Directory useTmpDir() {
  final dir = Directory.systemTemp.createTempSync();
  addTearDown(() => dir.deleteSync(recursive: true));
  return dir;
}

Future<MimirInstance> useInstance() {
  final dir = useTmpDir();
  const ioDirectory = '../../target/release/';
  return Mimir.getInstance(path: dir.path, ioDirectory: ioDirectory);
}

Future<MimirIndex> useTestIndex() async =>
    (await useInstance()).getIndex('test');

List<Map<String, dynamic>> useExercises() {
  final exercisesStr = File('test/assets/exercises.json').readAsStringSync();
  final exerciseLibrary = json.decode(exercisesStr) as Map<String, dynamic>;
  return (exerciseLibrary['exercises'] as List)
      .cast<Map<String, dynamic>>()
      // ignore: avoid_dynamic_calls
      .map((e) => e..['id'] = e['name'].hashCode)
      .toList();
}

@freezed
sealed class ComparableMimirIndexSettings with _$ComparableMimirIndexSettings {
  const factory ComparableMimirIndexSettings({
    required Set<String>? searchableFields,
    required Set<String> filterableFields,
    required Set<String> sortableFields,
    required List<String> rankingRules,
    required Set<String> stopWords,
    required Set<Synonyms> synonyms,
    required bool typosEnabled,
    required int minWordSizeForOneTypo,
    required int minWordSizeForTwoTypos,
    required Set<String> disallowTyposOnWords,
    required Set<String> disallowTyposOnFields,
  }) = _ComparableMimirIndexSettings;

  factory ComparableMimirIndexSettings.from(MimirIndexSettings settings) {
    return ComparableMimirIndexSettings(
      searchableFields: settings.searchableFields?.toSet(),
      filterableFields: settings.filterableFields.toSet(),
      sortableFields: settings.sortableFields.toSet(),
      rankingRules: settings.rankingRules,
      stopWords: settings.stopWords.toSet(),
      synonyms: settings.synonyms.toSet(),
      typosEnabled: settings.typosEnabled,
      minWordSizeForOneTypo: settings.minWordSizeForOneTypo,
      minWordSizeForTwoTypos: settings.minWordSizeForTwoTypos,
      disallowTyposOnWords: settings.disallowTyposOnWords.toSet(),
      disallowTyposOnFields: settings.disallowTyposOnFields.toSet(),
    );
  }
}
