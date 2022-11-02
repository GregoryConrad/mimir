import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as pp;

/// Represents an instance (essentially a group of indices)
/// of milli (the engine of meilisearch)
///
/// You will often only need one instance, but you can
/// make more if you so choose
class MeiliInstance {
  const MeiliInstance._(this.name, this.path);

  /// Creates the default MeiliInstance instance
  static Future<MeiliInstance> get defaultInstance => getInstance('default');

  /// Creates a MeiliInstance with the given name and (optional) path
  static Future<MeiliInstance> getInstance(String name, [String? path]) async {
    // Create the directory for this instance
    if (path == null) {
      try {
        final appSupportDir = await pp.getApplicationSupportDirectory();
        path = p.join(appSupportDir.path, 'embedded_meili', name);
        await Directory(path).create();
      } on pp.MissingPlatformDirectoryException {
        throw UnsupportedError(
          'Looks like this platform does not have an application support '
          'directory. Please call MeiliInstance.getInstance(\'$name\', some_dir) manually',
        );
      }
    }

    // TODO do initialization of the rust thread for this instance path and name

    return MeiliInstance._(name, path);
  }

  final String name;
  final String path;
  // TODO settings needed?
  // TODO milli version/dumps

  /// Returns the index with the given name (id)
  ///
  /// The name of the index must be filesystem-path safe
  /// When in doubt, just stick with a-z, A-Z, 0-9, -, and _ for the name
  MeiliIndex getIndex(String name) => _MeiliIndex(this, name);
}

typedef Document = Map<String, dynamic>;

/// Represents an index in milli, the engine of meilisearch
///
/// An index consists of documents, which is what search is based off of
abstract class MeiliIndex {
  const MeiliIndex._(this.instance, this.name);

  /// The corresponding MeiliInstance for this index
  final MeiliInstance instance;

  /// The name (id) of this index
  final String name;

  Future<List<Document>> search(
    String? query, {
    int? limit,
    // TODO clean API for doing filters/facets
    // TODO sort?
  });

  /// Gets the given document from the index
  Future<Document> getDocument(String id);

  /// Gets all documents from the index
  Future<List<Document>> getDocuments();

  /// Replaces all documents in the index with the given documents
  Future<void> setDocuments(List<Document> documents);

  /// Adds the given document to the index
  Future<void> addDocument(Document document) => addDocuments([document]);

  /// Adds the given documents to the index
  Future<void> addDocuments(List<Document> documents);

  /// Deletes the given document from the index
  Future<void> deleteDocument(String id) => deleteDocuments([id]);

  /// Deletes the given documents from the index
  Future<void> deleteDocuments(List<String> ids);

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
  MeiliIndexSettings copyWith() => const MeiliIndexSettings();
}

class _MeiliIndex extends MeiliIndex {
  const _MeiliIndex(MeiliInstance instance, String name)
      : super._(instance, name);

  @override
  Future<void> addDocuments(List<Document> documents) {
    // TODO: implement addDocuments
    throw UnimplementedError();
  }

  @override
  Future<void> deleteDocuments(List<String> ids) {
    // TODO: implement deleteDocuments
    throw UnimplementedError();
  }

  @override
  Future<void> setDocuments(List<Document> documents) {
    // TODO: implement setDocuments
    throw UnimplementedError();
  }

  @override
  Future<Document> getDocument(String id) {
    // TODO: implement getDocument
    throw UnimplementedError();
  }

  @override
  Future<List<Document>> getDocuments() {
    // TODO: implement getDocuments
    throw UnimplementedError();
  }

  @override
  Future<MeiliIndexSettings> getSettings() {
    // TODO: implement getSettings
    throw UnimplementedError();
  }

  @override
  Future<void> setSettings(MeiliIndexSettings settings) {
    // TODO: implement setSettings
    throw UnimplementedError();
  }

  @override
  Future<List<Document>> search(
    String? query, {
    int? limit,
  }) {
    // TODO: implement search
    throw UnimplementedError();
  }
}
