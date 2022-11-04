import 'package:embedded_meilisearch/src/impl/instance_impl.dart';
import 'package:embedded_meilisearch/src/index.dart';

class MeiliIndexImpl with MeiliIndex {
  static Future<MeiliIndexImpl> from(
    MeiliInstanceImpl instance,
    String name,
  ) async {
    // TODO init the index in rust
    return MeiliIndexImpl._(instance, name);
  }

  const MeiliIndexImpl._(this.instance, this.name);

  final MeiliInstanceImpl instance;

  @override
  final String name;

  @override
  Future<void> addDocuments(List<MeiliDocument> documents) {
    // TODO: implement addDocuments
    throw UnimplementedError();
  }

  @override
  Future<void> deleteDocuments(List<String> ids) {
    // TODO: implement deleteDocuments
    throw UnimplementedError();
  }

  @override
  Future<void> setDocuments(List<MeiliDocument> documents) {
    // TODO: implement setDocuments
    throw UnimplementedError();
  }

  @override
  Future<MeiliDocument> getDocument(String id) {
    // TODO: implement getDocument
    throw UnimplementedError();
  }

  @override
  Future<List<MeiliDocument>> getDocuments() {
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
  Future<List<MeiliDocument>> search(
    String? query, {
    int? limit,
  }) {
    // TODO: implement search
    throw UnimplementedError();
  }
}
