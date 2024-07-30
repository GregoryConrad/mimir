import 'package:mimir/mimir.dart';

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
abstract class MimirInstance {
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
