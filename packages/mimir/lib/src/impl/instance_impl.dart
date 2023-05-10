import 'package:meta/meta.dart';
import 'package:mimir/mimir.dart';
import 'package:mimir/src/bridge_generated.dart';
import 'package:mimir/src/impl/index_impl.dart';

// ignore_for_file: public_member_api_docs

@internal
class MimirInstanceImpl extends MimirInstance {
  MimirInstanceImpl(this.path, this.milli);

  final EmbeddedMilli milli;

  @override
  final String path;

  final _indices = <String, MimirIndexImpl>{};

  @override
  MimirIndexImpl getIndex(String name) =>
      _indices.putIfAbsent(name, () => MimirIndexImpl(this, name));

  static const _defaultOptionalValue = Object();

  @override
  Future<MimirIndex> openIndex(
    String name, {
    Object? primaryKey = _defaultOptionalValue,
    Object? searchableFields = _defaultOptionalValue,
    Object filterableFields = _defaultOptionalValue,
    Object sortableFields = _defaultOptionalValue,
    Object rankingRules = _defaultOptionalValue,
    Object stopWords = _defaultOptionalValue,
    Object synonyms = _defaultOptionalValue,
    Object typosEnabled = _defaultOptionalValue,
    Object minWordSizeForOneTypo = _defaultOptionalValue,
    Object minWordSizeForTwoTypos = _defaultOptionalValue,
    Object disallowTyposOnWords = _defaultOptionalValue,
    Object disallowTyposOnFields = _defaultOptionalValue,
  }) async {
    final index = getIndex(name);
    final currSettings = await index.getSettings();
    await index.setSettings(
      MimirIndexSettings(
        primaryKey: primaryKey == _defaultOptionalValue
            ? currSettings.primaryKey
            : primaryKey as String?,
        searchableFields: searchableFields == _defaultOptionalValue
            ? currSettings.searchableFields
            : searchableFields as List<String>?,
        filterableFields: filterableFields == _defaultOptionalValue
            ? currSettings.filterableFields
            : filterableFields as List<String>,
        sortableFields: sortableFields == _defaultOptionalValue
            ? currSettings.sortableFields
            : sortableFields as List<String>,
        rankingRules: rankingRules == _defaultOptionalValue
            ? currSettings.rankingRules
            : rankingRules as List<String>,
        stopWords: stopWords == _defaultOptionalValue
            ? currSettings.stopWords
            : stopWords as List<String>,
        synonyms: synonyms == _defaultOptionalValue
            ? currSettings.synonyms
            : synonyms as List<Synonyms>,
        typosEnabled: typosEnabled == _defaultOptionalValue
            ? currSettings.typosEnabled
            : typosEnabled as bool,
        minWordSizeForOneTypo: minWordSizeForOneTypo == _defaultOptionalValue
            ? currSettings.minWordSizeForOneTypo
            : minWordSizeForOneTypo as int,
        minWordSizeForTwoTypos: minWordSizeForTwoTypos == _defaultOptionalValue
            ? currSettings.minWordSizeForTwoTypos
            : minWordSizeForTwoTypos as int,
        disallowTyposOnWords: disallowTyposOnWords == _defaultOptionalValue
            ? currSettings.disallowTyposOnWords
            : disallowTyposOnWords as List<String>,
        disallowTyposOnFields: disallowTyposOnFields == _defaultOptionalValue
            ? currSettings.disallowTyposOnFields
            : disallowTyposOnFields as List<String>,
      ),
    );
    return index;
  }
}
