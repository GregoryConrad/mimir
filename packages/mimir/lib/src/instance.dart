part of 'interface.dart';

/// Represents an instance (essentially a group of indices) of mimir.
///
/// You will often only need one instance, but you can
/// make more if you so choose.
///
/// mimir is based on Milli (the engine of Meilisearch).
/// While we could embed all of Meilisearch in Flutter, it would hardly
/// make sense; you can just use ffi to access the engine, Milli, directly.
/// With this approach, its easier on constrained resources (no http server)
/// and more simple (no management of the server needed).
abstract interface class MimirInstance {
  /// The file-system path for the directory of this instance
  String get path;

  /// Gets the index with the given name (also acts as its id).
  /// One will be created for you if an index with the same name
  /// does not yet exist.
  ///
  /// The name of the index must be filesystem-path safe.
  /// When in doubt, just stick with a-z, A-Z, 0-9, -, and _ for the name.
  ///
  /// If you know any settings of the index in advance (such as a primary key),
  /// it is preferred to use [openIndex] instead.
  MimirIndex getIndex(String name);

  /// Eagerly opens an index with the supplied [name] and settings.
  /// If you know the primary key (or any of the other settings) in advance,
  /// it is recommended to use [openIndex] over [getIndex].
  /// See also [getIndex] for restrictions on what [name] can be.
  ///
  /// While [getIndex] opens indexes lazily (on the first method call),
  /// [openIndex] both opens and initializes an index before returning.
  Future<MimirIndex> openIndex(
    String name, {
    String? primaryKey,
    List<String>? searchableFields,
    List<String> filterableFields,
    List<String> sortableFields,
    List<String> rankingRules,
    List<String> stopWords,
    List<Synonyms> synonyms,
    bool typosEnabled,
    int minWordSizeForOneTypo,
    int minWordSizeForTwoTypos,
    List<String> disallowTyposOnWords,
    List<String> disallowTyposOnFields,
  });
}

final class _MimirInstanceImpl implements MimirInstance {
  _MimirInstanceImpl(this.path);

  @override
  final String path;

  final _indices = <String, _MimirIndexImpl>{};

  @override
  _MimirIndexImpl getIndex(String name) =>
      _indices.putIfAbsent(name, () => _MimirIndexImpl(this, name));

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
    await index.updateSettings(
      primaryKey: primaryKey is String? ? primaryKey : _defaultOptionalValue,
      searchableFields: searchableFields is List<String>?
          ? searchableFields
          : _defaultOptionalValue,
      filterableFields: filterableFields is List<String>
          ? filterableFields
          : _defaultOptionalValue,
      sortableFields: sortableFields is List<String>
          ? sortableFields
          : _defaultOptionalValue,
      rankingRules: rankingRules is List<String>
          ? rankingRules
          : _defaultOptionalValue,
      stopWords: stopWords is List<String> ? stopWords : _defaultOptionalValue,
      synonyms: synonyms is List<Synonyms> ? synonyms : _defaultOptionalValue,
      typosEnabled: typosEnabled is bool ? typosEnabled : _defaultOptionalValue,
      minWordSizeForOneTypo: minWordSizeForOneTypo is int
          ? minWordSizeForOneTypo
          : _defaultOptionalValue,
      minWordSizeForTwoTypos: minWordSizeForTwoTypos is int
          ? minWordSizeForTwoTypos
          : _defaultOptionalValue,
      disallowTyposOnWords: disallowTyposOnWords is List<String>
          ? disallowTyposOnWords
          : _defaultOptionalValue,
      disallowTyposOnFields: disallowTyposOnFields is List<String>
          ? disallowTyposOnFields
          : _defaultOptionalValue,
    );
    return index;
  }
}
