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
  /// Returns at most [limit] documents (if not null; otherwise all matches).
  /// Uses the provided [matchingStrategy] (if not null) to get to [limit]
  /// documents (if not already there).
  /// Sorts the results based on relevance, or the [sortCriteria] if not null.
  Future<List<MeiliDocument>> search(
    String? query, {
    int? limit,
    TermsMatchingStrategy? matchingStrategy,
    List<SortAscDesc>? sortCriteria,
  });

  /// Gets the given document from the index, if it exists
  Future<MeiliDocument?> getDocument(String id);

  /// Gets all documents from the index
  Future<List<MeiliDocument>> getDocuments();

  /// Replaces all documents in the index with the given documents
  Future<void> setDocuments(List<MeiliDocument> documents);

  /// Adds the given document to the index
  Future<void> addDocument(MeiliDocument document) => addDocuments([document]);

  /// Adds the given documents to the index
  Future<void> addDocuments(List<MeiliDocument> documents);

  /// Deletes the given document from the index
  Future<void> deleteDocument(String id) => deleteDocuments([id]);

  /// Deletes the documents with the given [ids] from the index
  Future<void> deleteDocuments(List<String> ids);

  /// Gets the settings of this index
  Future<MeiliIndexSettings> getSettings();

  /// Sets the settings of this index
  Future<void> setSettings(MeiliIndexSettings settings);
}

/// Represents the settings of a MeiliIndex
/// TODO move to just the Rust file and delete here
class MeiliIndexSettings {
  /// Creates the settings for a MeiliIndex
  const MeiliIndexSettings();

  /// Copies this settings object into a new settings object
  /// with the given changes
  /// TODO no nullable fields! That will mess up copyWith
  MeiliIndexSettings copyWith() => const MeiliIndexSettings();
}
