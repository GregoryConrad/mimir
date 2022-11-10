import 'dart:convert';

import 'package:embedded_meilisearch/bridge_generated.dart';
import 'package:embedded_meilisearch/src/impl/instance_impl.dart';
import 'package:embedded_meilisearch/src/index.dart';

class MimirIndexImpl with MimirIndex {
  const MimirIndexImpl(this.instance, this.name);

  final MimirInstanceImpl instance;

  @override
  final String name;

  String get instanceDir => instance.path;
  EmbeddedMilli get milli => instance.milli;

  @override
  Future<void> addDocuments(List<MimirDocument> documents) {
    return milli.addDocuments(
      instanceDir: instanceDir,
      indexName: name,
      jsonDocuments: documents.map((d) => json.encode(d)).toList(),
    );
  }

  @override
  Future<void> deleteDocuments(List<String> ids) {
    return milli.deleteDocuments(
      instanceDir: instanceDir,
      indexName: name,
      documentIds: ids,
    );
  }

  @override
  Future<void> deleteAllDocuments() {
    return milli.deleteAllDocuments(
      instanceDir: instanceDir,
      indexName: name,
    );
  }

  @override
  Future<void> setDocuments(List<MimirDocument> documents) async {
    await deleteAllDocuments();
    return addDocuments(documents);
  }

  @override
  Future<MimirDocument?> getDocument(String id) {
    return milli
        .getDocument(instanceDir: instanceDir, indexName: name, documentId: id)
        .then((s) => s == null ? null : json.decode(s));
  }

  @override
  Future<List<MimirDocument>> getAllDocuments() async {
    final jsonDocs = await milli.getAllDocuments(
      instanceDir: instanceDir,
      indexName: name,
    );
    return jsonDocs.map((s) => json.decode(s)).cast<MimirDocument>().toList();
  }

  @override
  Future<MimirIndexSettings> getSettings() {
    return milli.getSettings(
      instanceDir: instanceDir,
      indexName: name,
    );
  }

  @override
  Future<void> setSettings(MimirIndexSettings settings) {
    return milli.setSettings(
      instanceDir: instanceDir,
      indexName: name,
      settings: settings,
    );
  }

  @override
  Future<List<MimirDocument>> search({
    String? query,
    int? resultsLimit,
    TermsMatchingStrategy? matchingStrategy,
    List<SortBy>? sortBy,
  }) async {
    final jsonDocs = await milli.searchDocuments(
      instanceDir: instanceDir,
      indexName: name,
      query: query,
      limit: resultsLimit,
      // TODO remove the ?? Last below once following resolved
      //  https://github.com/fzyzcjy/flutter_rust_bridge/issues/828
      matchingStrategy: matchingStrategy ?? TermsMatchingStrategy.Last,
      sortCriteria: sortBy,
      // TODO filter using a Rust enum. See for more:
      //  https://docs.meilisearch.com/reference/api/search.html#filter
    );
    return jsonDocs.map((s) => json.decode(s)).cast<MimirDocument>().toList();
  }
}
