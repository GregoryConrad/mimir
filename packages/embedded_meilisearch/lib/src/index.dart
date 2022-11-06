/// Represents a document in a milli index
typedef MeiliDocument = Map<String, dynamic>;

/// Represents an index in milli (the engine of Meilisearch)
///
/// An index consists of documents, which is what searching is based off of
mixin MeiliIndex {
  /// The path-friendly name (id) of this index
  String get name;

  /// Perform a search against the documents of this index
  Future<List<MeiliDocument>> search(
    String? query, {
    int? limit,
    // TODO clean API for doing filters/facets
    // TODO sort?
  });

  /// Gets the given document from the index
  Future<MeiliDocument> getDocument(String id);

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
  /// If [ids] is null, deletes all documents in the index
  Future<void> deleteDocuments(List<String>? ids);

  /// Gets the settings of this index
  Future<MeiliIndexSettings> getSettings();

  /// Sets the settings of this index
  Future<void> setSettings(MeiliIndexSettings settings);
}

/// Represents the settings of a MeiliIndex
class MeiliIndexSettings {
  /// Creates the settings for a MeiliIndex
  const MeiliIndexSettings();

  /// Copies this settings object into a new settings object
  /// with the given changes
  /// TODO no nullable fields! That will mess up copyWith
  MeiliIndexSettings copyWith() => const MeiliIndexSettings();
}
