import 'dart:async';
import 'dart:convert';

import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:meta/meta.dart';
import 'package:mimir/mimir.dart';
import 'package:mimir/src/api.dart' as api;
import 'package:mimir/src/impl/instance_impl.dart';

// ignore_for_file: public_member_api_docs

@internal
class MimirIndexImpl extends MimirIndex {
  MimirIndexImpl(this.instance, this.name);

  final MimirInstanceImpl instance;

  @override
  final String name;

  final _changes = StreamController<void>.broadcast();

  String get instanceDir => instance.path;

  @override
  Future<void> addDocuments(List<MimirDocument> documents) async {
    await api.addDocuments(
      instanceDir: instanceDir,
      indexName: name,
      documents: documents.map((d) => json.encode(d)).toList(),
    );
    _changes.add(null);
  }

  @override
  Future<void> deleteDocuments(List<String> ids) async {
    await api.deleteDocuments(
      instanceDir: instanceDir,
      indexName: name,
      documentIds: ids,
    );
    _changes.add(null);
  }

  @override
  Future<void> deleteAllDocuments() async {
    await api.deleteAllDocuments(
      instanceDir: instanceDir,
      indexName: name,
    );
    _changes.add(null);
  }

  @override
  Future<void> setDocuments(List<MimirDocument> documents) async {
    await api.setDocuments(
      instanceDir: instanceDir,
      indexName: name,
      documents: documents.map((d) => json.encode(d)).toList(),
    );
    _changes.add(null);
  }

  @override
  Future<MimirDocument?> getDocument(String id) {
    return api
        .getDocument(instanceDir: instanceDir, indexName: name, documentId: id)
        .then((s) => s == null ? null : json.decode(s) as Map<String, dynamic>);
  }

  @override
  Future<List<MimirDocument>> getAllDocuments() async {
    final jsonDocs = await api.getAllDocuments(
      instanceDir: instanceDir,
      indexName: name,
    );
    return jsonDocs.map((s) => json.decode(s)).cast<MimirDocument>().toList();
  }

  @override
  Future<MimirIndexSettings> getSettings() {
    return api.getSettings(instanceDir: instanceDir, indexName: name);
  }

  @override
  Future<void> setSettings(MimirIndexSettings settings) async {
    await api.setSettings(
      instanceDir: instanceDir,
      indexName: name,
      settings: settings,
    );
    _changes.add(null);
  }

  static const _defaultOptionalValue = Object();

  @override
  Future<void> updateSettings({
    Object? primaryKey = _defaultOptionalValue,
    Object? searchableFields = _defaultOptionalValue,
    Object filterableFields = _defaultOptionalValue,
    Object sortableFields = _defaultOptionalValue,
    Object rankingRules = _defaultOptionalValue,
    Object stopWords = _defaultOptionalValue,
    Object synonyms = _defaultOptionalValue,
    Object typosEnabled = _defaultOptionalValue,
    Object minWordSizeForOneTypo = _defaultOptionalValue,
    Object minWordSizeForTwoTypos = _defaultOptionalValue,
    Object disallowTyposOnWords = _defaultOptionalValue,
    Object disallowTyposOnFields = _defaultOptionalValue,
  }) async {
    final currSettings = await getSettings();
    return setSettings(
      MimirIndexSettings(
        primaryKey: primaryKey == _defaultOptionalValue
            ? currSettings.primaryKey
            : primaryKey as String?,
        searchableFields: searchableFields == _defaultOptionalValue
            ? currSettings.searchableFields
            : searchableFields as List<String>?,
        filterableFields: filterableFields == _defaultOptionalValue
            ? currSettings.filterableFields
            : filterableFields as List<String>,
        sortableFields: sortableFields == _defaultOptionalValue
            ? currSettings.sortableFields
            : sortableFields as List<String>,
        rankingRules: rankingRules == _defaultOptionalValue
            ? currSettings.rankingRules
            : rankingRules as List<String>,
        stopWords: stopWords == _defaultOptionalValue
            ? currSettings.stopWords
            : stopWords as List<String>,
        synonyms: synonyms == _defaultOptionalValue
            ? currSettings.synonyms
            : synonyms as List<Synonyms>,
        typosEnabled: typosEnabled == _defaultOptionalValue
            ? currSettings.typosEnabled
            : typosEnabled as bool,
        minWordSizeForOneTypo: minWordSizeForOneTypo == _defaultOptionalValue
            ? currSettings.minWordSizeForOneTypo
            : minWordSizeForOneTypo as int,
        minWordSizeForTwoTypos: minWordSizeForTwoTypos == _defaultOptionalValue
            ? currSettings.minWordSizeForTwoTypos
            : minWordSizeForTwoTypos as int,
        disallowTyposOnWords: disallowTyposOnWords == _defaultOptionalValue
            ? currSettings.disallowTyposOnWords
            : disallowTyposOnWords as List<String>,
        disallowTyposOnFields: disallowTyposOnFields == _defaultOptionalValue
            ? currSettings.disallowTyposOnFields
            : disallowTyposOnFields as List<String>,
      ),
    );
  }

  @override
  Future<BigInt> get numberOfDocuments =>
      api.numberOfDocuments(instanceDir: instanceDir, indexName: name);

  @override
  Future<List<MimirDocument>> search({
    String? query,
    int? resultsLimit,
    int? offset,
    TermsMatchingStrategy? matchingStrategy,
    List<SortBy>? sortBy,
    Filter? filter,
  }) async {
    try {
      final jsonDocs = await api.searchDocuments(
        instanceDir: instanceDir,
        indexName: name,
        query: query,
        limit: resultsLimit,
        offset: offset,
        sortCriteria: sortBy,
        matchingStrategy: matchingStrategy,
        filter: filter,
      );
      return jsonDocs.map((s) => json.decode(s)).cast<MimirDocument>().toList();
    } on AnyhowException catch (e) {
      // Check to see if this error was caused by any filters or sortBys
      // not being indexed for search
      final filtersNotAdded =
          filter != null && e.message.contains('not filterable');
      final sortBysNotAdded =
          sortBy != null && e.message.contains('not sortable');

      if (filtersNotAdded || sortBysNotAdded) {
        final currSettings = await getSettings();

        // Update the current settings to include the filters/sortBys
        final filterableFields = currSettings.filterableFields.toSet()
          ..addAll(filter?.getFields() ?? []);
        final sortableFields = currSettings.sortableFields.toSet()
          ..addAll(sortBy?.map((s) => s.field0) ?? []);
        await setSettings(
          currSettings.copyWith(
            filterableFields: filterableFields.toList(),
            sortableFields: sortableFields.toList(),
          ),
        );

        // Finally, retry the search with the new settings configuration
        return search(
          query: query,
          resultsLimit: resultsLimit,
          offset: offset,
          matchingStrategy: matchingStrategy,
          sortBy: sortBy,
          filter: filter,
        );
      } else {
        // Not an error caused by missing filterable/sortable fields; rethrow it
        rethrow;
      }
    }
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
    int? offset,
    TermsMatchingStrategy? matchingStrategy,
  }) {
    return _autoRefresh(
      () => search(
        query: query,
        filter: filter,
        sortBy: sortBy,
        resultsLimit: resultsLimit,
        offset: offset,
        matchingStrategy: matchingStrategy,
      ),
    );
  }
}

extension on Filter {
  Iterable<String> _getFields(Filter filter) {
    return switch (filter) {
      api.Filter_Or(:final field0) => field0.expand(_getFields),
      api.Filter_And(:final field0) => field0.expand(_getFields),
      api.Filter_Not(:final field0) => _getFields(field0),
      api.Filter_Exists(:final field) => [field],
      api.Filter_InValues(:final field) => [field],
      api.Filter_GreaterThan(:final field) => [field],
      api.Filter_GreaterThanOrEqual(:final field) => [field],
      api.Filter_Equal(:final field) => [field],
      api.Filter_NotEqual(:final field) => [field],
      api.Filter_LessThan(:final field) => [field],
      api.Filter_LessThanOrEqual(:final field) => [field],
      api.Filter_Between(:final field) => [field],
      api.Filter_IsNull(:final field) => [field],
      api.Filter_IsEmpty(:final field) => [field],
    };
  }

  Iterable<String> getFields() => _getFields(this);
}
