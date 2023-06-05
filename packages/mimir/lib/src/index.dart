import 'package:mimir/src/bridge_generated.dart';

/// Represents a document in a mimir (and also milli) index
typedef MimirDocument = Map<String, dynamic>;

/// Represents an index in mimir (and also milli, the engine of Meilisearch)
///
/// An index consists of documents, which is what searching is based off of
abstract class MimirIndex {
  /// The path-friendly name (id) of this index
  String get name;

  /// Perform a search against the documents of this index.
  ///
  /// Searches based on the provided [query], if not null.
  /// Filters the results based on the [filter], if not null.
  /// Sorts the results based on relevance, or the [sortBy] if not null.
  /// Returns at most [resultsLimit] documents
  /// (if not null; otherwise all matches).
  /// Supply an [offset] in order to implement pagination or infinite scroll.
  /// Uses the provided [matchingStrategy]
  /// (if not null) to get to [resultsLimit] documents (if not already there).
  Future<List<MimirDocument>> search({
    String? query,
    Filter? filter,
    List<SortBy>? sortBy,
    int? resultsLimit,
    int? offset,
    TermsMatchingStrategy? matchingStrategy,
  });

  /// This is the same as [search], but instead returns a [Stream] that can be
  /// used to listen to the changes in a search from document modifications.
  Stream<List<MimirDocument>> searchStream({
    String? query,
    Filter? filter,
    List<SortBy>? sortBy,
    int? resultsLimit,
    int? offset,
    TermsMatchingStrategy? matchingStrategy,
  });

  /// Returns the number of documents in this index.
  /// Useful for pagination or infinite scroll.
  Future<int> get numberOfDocuments;

  /// Gets the given document from the index, if it exists
  Future<MimirDocument?> getDocument(String id);

  /// Gets all documents from the index
  Future<List<MimirDocument>> getAllDocuments();

  /// A stream of all documents from this index
  Stream<List<MimirDocument>> get documents;

  /// Adds the given document to the index
  Future<void> addDocument(MimirDocument document) => addDocuments([document]);

  /// Adds the given documents to the index
  Future<void> addDocuments(List<MimirDocument> documents);

  /// Deletes the given document from the index
  Future<void> deleteDocument(String id) => deleteDocuments([id]);

  /// Deletes the documents with the given [ids] from the index
  Future<void> deleteDocuments(List<String> ids);

  /// Deletes all documents in the index
  Future<void> deleteAllDocuments();

  /// Replaces all documents in the index with the given documents
  Future<void> setDocuments(List<MimirDocument> documents);

  /// Gets the settings of this index
  Future<MimirIndexSettings> getSettings();

  /// Sets the settings of this index
  Future<void> setSettings(MimirIndexSettings settings);

  /// Updates the settings of this index
  Future<void> updateSettings({
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

  /// Close any resources in use by the index.
  /// Any streams in use will be closed as a result of calling this method.
  /// You probably *should not* call this unless you know what you are doing.
  Future<void> close();
}
