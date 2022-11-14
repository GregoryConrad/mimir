import 'dart:async';
import 'dart:convert';

import 'package:mimir/bridge_generated.dart';
import 'package:mimir/src/impl/instance_impl.dart';
import 'package:mimir/src/index.dart';

class MimirIndexImpl with MimirIndex {
  MimirIndexImpl(this.instance, this.name);

  final MimirInstanceImpl instance;

  @override
  final String name;

  final _changes = StreamController<void>.broadcast();

  String get instanceDir => instance.path;
  EmbeddedMilli get milli => instance.milli;

  @override
  Future<void> addDocuments(List<MimirDocument> documents) async {
    await milli.addDocuments(
      instanceDir: instanceDir,
      indexName: name,
      jsonDocuments: documents.map((d) => json.encode(d)).toList(),
    );
    _changes.add(null);
  }

  @override
  Future<void> deleteDocuments(List<String> ids) async {
    await milli.deleteDocuments(
      instanceDir: instanceDir,
      indexName: name,
      documentIds: ids,
    );
    _changes.add(null);
  }

  @override
  Future<void> deleteAllDocuments({broadcastChange = true}) async {
    await milli.deleteAllDocuments(
      instanceDir: instanceDir,
      indexName: name,
    );
    if (broadcastChange) _changes.add(null);
  }

  @override
  Future<void> setDocuments(List<MimirDocument> documents) async {
    // TODO this should be implemented in Rust as one write txn
    //  to get rid of the broadcastChange workaround
    await deleteAllDocuments(broadcastChange: false);
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
  Future<void> setSettings(MimirIndexSettings settings) async {
    await milli.setSettings(
      instanceDir: instanceDir,
      indexName: name,
      settings: settings,
    );
    _changes.add(null);
  }

  @override
  Future<List<MimirDocument>> search({
    String? query,
    int? resultsLimit,
    TermsMatchingStrategy? matchingStrategy,
    List<SortBy>? sortBy,
    Filter? filter,
  }) async {
    final jsonDocs = await milli.searchDocuments(
      instanceDir: instanceDir,
      indexName: name,
      query: query,
      limit: resultsLimit,
      sortCriteria: sortBy,
      // TODO remove the ?? below once following resolved
      //  https://github.com/fzyzcjy/flutter_rust_bridge/issues/828
      matchingStrategy: matchingStrategy ?? TermsMatchingStrategy.Last,
      filter: filter ?? const Filter.or([]),
    );
    return jsonDocs.map((s) => json.decode(s)).cast<MimirDocument>().toList();
  }

  @override
  Future<void> close() => _changes.close();

  Stream<T> _autoRefresh<T>(FutureOr<T> Function() fn) async* {
    yield await fn();
    await for (final _ in _changes.stream) {
      yield await fn();
    }
  }

  @override
  Stream<List<MimirDocument>> get documents => _autoRefresh(getAllDocuments);

  @override
  Stream<List<MimirDocument>> searchStream({
    String? query,
    Filter? filter,
    List<SortBy>? sortBy,
    int? resultsLimit,
    TermsMatchingStrategy? matchingStrategy,
  }) {
    return _autoRefresh(
      () => search(
        query: query,
        filter: filter,
        sortBy: sortBy,
        resultsLimit: resultsLimit,
        matchingStrategy: matchingStrategy,
      ),
    );
  }
}
