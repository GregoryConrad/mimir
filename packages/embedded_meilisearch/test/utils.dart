import 'dart:ffi';
import 'dart:io';

import 'package:embedded_meilisearch/embedded_meilisearch.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test/test.dart';

part 'utils.freezed.dart';

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

@freezed
class ComparableMeiliIndexSettings with _$ComparableMeiliIndexSettings {
  const factory ComparableMeiliIndexSettings({
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
  }) = _ComparableMeiliIndexSettings;

  factory ComparableMeiliIndexSettings.from(MeiliIndexSettings settings) {
    return ComparableMeiliIndexSettings(
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
