import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:mimir/mimir.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test/test.dart';

part 'utils.freezed.dart';

DynamicLibrary useLibrary() {
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
  return DynamicLibrary.open(dylibPath);
}

Directory useTmpDir() {
  final dir = Directory.systemTemp.createTempSync();
  addTearDown(() => dir.deleteSync(recursive: true));
  return dir;
}

MimirInstance useInstance() {
  final dir = useTmpDir();
  final lib = useLibrary();
  return Mimir.getInstance(path: dir.path, library: lib);
}

MimirIndex useTestIndex() => useInstance().getIndex('test');

// Force the current context of running code to go to end of the event queue
// so that an async stream's next change can be processed correctly.
// This is kinda janky but works fine because of Dart's design w/ event loop.
Future<void> useForceStreamUpdate() => Future.delayed(Duration.zero);

List<Map<String, dynamic>> useExercises() {
  final exercisesStr = File('test/assets/exercises.json').readAsStringSync();
  final exerciseLibrary = json.decode(exercisesStr) as Map<String, dynamic>;
  return (exerciseLibrary['exercises'] as List)
      .cast<Map<String, dynamic>>()
      // TODO get rid of ..remove('video') below. See here:
      //  https://github.com/meilisearch/milli/issues/695
      .map((e) => e
        ..['id'] = e['name'].hashCode
        ..remove('video'))
      .toList();
}

@freezed
class ComparableMimirIndexSettings with _$ComparableMimirIndexSettings {
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
