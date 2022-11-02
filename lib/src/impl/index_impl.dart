part of '../index.dart';

class _MeiliIndexImpl with MeiliIndex {
  const _MeiliIndexImpl._(this.instance, this.name);

  @override
  final MeiliInstance instance;

  @override
  final String name;

  static Future<_MeiliIndexImpl> from(
      MeiliInstance instance, String name) async {
    // TODO init the index in rust
    return _MeiliIndexImpl._(instance, name);
  }

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
