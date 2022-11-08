import 'package:embedded_meilisearch/bridge_generated.dart';

/// Represents a document in a milli index
typedef MeiliDocument = Map<String, dynamic>;

/// Represents an index in milli (the engine of Meilisearch)
///
/// An index consists of documents, which is what searching is based off of
mixin MeiliIndex {
  /// The path-friendly name (id) of this index
  String get name;

  /// Perform a search against the documents of this index.
  ///
  /// Searches based on the provided [query], if not null.
  /// Returns at most [resultsLimit] documents (if not null; otherwise all matches).
  /// Uses the provided [matchingStrategy] (if not null) to get to [resultsLimit]
  /// documents (if not already there).
  /// Sorts the results based on relevance, or the [sortBy] if not null.
  Future<List<MeiliDocument>> search(
    String? query, {
    int? resultsLimit,
    TermsMatchingStrategy? matchingStrategy,
    List<SortBy>? sortBy,
  });

  /// Gets the given document from the index, if it exists
  Future<MeiliDocument?> getDocument(String id);

  /// Gets all documents from the index
  Future<List<MeiliDocument>> getAllDocuments();

  /// Adds the given document to the index
  Future<void> addDocument(MeiliDocument document) => addDocuments([document]);

  /// Adds the given documents to the index
  Future<void> addDocuments(List<MeiliDocument> documents);

  /// Deletes the given document from the index
  Future<void> deleteDocument(String id) => deleteDocuments([id]);

  /// Deletes the documents with the given [ids] from the index
  Future<void> deleteDocuments(List<String> ids);

  /// Deletes all documents in the index
  Future<void> deleteAllDocuments();

  /// Replaces all documents in the index with the given documents
  Future<void> setDocuments(List<MeiliDocument> documents);

  /// Gets the settings of this index
  Future<MeiliIndexSettings> getSettings();

  /// Sets the settings of this index
  Future<void> setSettings(MeiliIndexSettings settings);
}
