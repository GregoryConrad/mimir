part of 'interface.dart';

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
  Future<BigInt> get numberOfDocuments;

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

final class _MimirIndexImpl extends MimirIndex {
  _MimirIndexImpl(this.instance, this.name);

  final _MimirInstanceImpl instance;

  @override
  final String name;

  final changes = StreamController<void>.broadcast();

  InstanceFfiRequest createRequest(InstanceFfiRequest_IndexRequest request) {
    return InstanceFfiRequest(
      instanceDir: instance.path,
      indexRequest: request,
    );
  }

  @override
  Future<void> addDocuments(List<MimirDocument> documents) async {
    final serializedDocuments = documents.map((d) => json.encode(d)).toList();
    await processInstanceRequest(
      createRequest(
        InstanceFfiRequest_IndexRequest(
          indexName: name,
          addDocuments: InstanceFfiRequest_IndexRequest_AddDocuments(
            documents: serializedDocuments,
          ),
        ),
      ),
      _handleResponseError,
    );
    changes.add(null);
  }

  @override
  Future<void> deleteDocuments(List<String> ids) async {
    await processInstanceRequest(
      createRequest(
        InstanceFfiRequest_IndexRequest(
          indexName: name,
          deleteDocuments: InstanceFfiRequest_IndexRequest_DeleteDocuments(
            documentIds: ids,
          ),
        ),
      ),
      _handleResponseError,
    );
    changes.add(null);
  }

  @override
  Future<void> deleteAllDocuments() async {
    await processInstanceRequest(
      createRequest(
        InstanceFfiRequest_IndexRequest(
          indexName: name,
          deleteAllDocuments:
              InstanceFfiRequest_IndexRequest_DeleteAllDocuments(),
        ),
      ),
      _handleResponseError,
    );
    changes.add(null);
  }

  @override
  Future<void> setDocuments(List<MimirDocument> documents) async {
    final serializedDocuments = documents.map((d) => json.encode(d)).toList();
    await processInstanceRequest(
      createRequest(
        InstanceFfiRequest_IndexRequest(
          indexName: name,
          setDocuments: InstanceFfiRequest_IndexRequest_SetDocuments(
            documents: serializedDocuments,
          ),
        ),
      ),
      _handleResponseError,
    );
    changes.add(null);
  }

  @override
  Future<MimirDocument?> getDocument(String id) {
    return processInstanceRequest(
      createRequest(
        InstanceFfiRequest_IndexRequest(
          indexName: name,
          getDocument: InstanceFfiRequest_IndexRequest_GetDocument(
            documentId: id,
          ),
        ),
      ),
      (response) {
        _handleResponseError(response);
        return response.document.hasDocument()
            ? json.decode(response.document.document) as MimirDocument
            : null;
      },
    );
  }

  @override
  Future<List<MimirDocument>> getAllDocuments() {
    return processInstanceRequest(
      createRequest(
        InstanceFfiRequest_IndexRequest(
          indexName: name,
          getAllDocuments: InstanceFfiRequest_IndexRequest_GetAllDocuments(),
        ),
      ),
      (response) {
        _handleResponseError(response);
        return response.documents.documents
            .map((s) => json.decode(s))
            .cast<MimirDocument>()
            .toList();
      },
    );
  }

  Future<MimirIndexSettings> getSettings() {
    return processInstanceRequest(
      createRequest(
        InstanceFfiRequest_IndexRequest(
          indexName: name,
          getSettings: InstanceFfiRequest_IndexRequest_GetSettings(),
        ),
      ),
      (response) {
        _handleResponseError(response);
        return response.indexSettings;
      },
    );
  }

  Future<void> setSettings(MimirIndexSettings settings) async {
    await processInstanceRequest(
      createRequest(
        InstanceFfiRequest_IndexRequest(
          indexName: name,
          setSettings: InstanceFfiRequest_IndexRequest_SetSettings(
            settings: settings,
          ),
        ),
      ),
      _handleResponseError,
    );
    changes.add(null);
  }

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

    // NOTE: for now, these are an internal-only API.
    // They can be made public if folks have a need.
    bool overwriteFilterableFields = false,
    bool overwriteSortableFields = false,
  }) async {
    final currSettings = await getSettings();
    return setSettings(
      MimirIndexSettings(
        primaryKey: primaryKey is String?
            ? primaryKey
            : currSettings.hasPrimaryKey()
            ? currSettings.primaryKey
            : null,
        searchableFields: searchableFields is List<String>?
            ? MimirIndexSettings_SearchableFields(
                searchableFields: searchableFields,
              )
            : currSettings.hasSearchableFields()
            ? currSettings.searchableFields
            : null,
        filterableFields: {
          if (!overwriteFilterableFields) ...currSettings.filterableFields,
          if (filterableFields is List<String>) ...filterableFields,
        }.toList(),
        sortableFields: {
          if (!overwriteSortableFields) ...currSettings.sortableFields,
          if (sortableFields is List<String>) ...sortableFields,
        }.toList(),
        rankingRules: rankingRules is List<String>
            ? rankingRules
            : currSettings.rankingRules,
        stopWords: stopWords is List<String>
            ? stopWords
            : currSettings.stopWords,
        synonyms: synonyms is List<Synonyms>
            ? synonyms.map(
                (e) => MimirIndexSettings_Synonyms(
                  word: e.word,
                  synonyms: e.synonyms,
                ),
              )
            : currSettings.synonyms,
        typosEnabled: typosEnabled is bool
            ? typosEnabled
            : currSettings.typosEnabled,
        minWordSizeForOneTypo: minWordSizeForOneTypo is int
            ? minWordSizeForOneTypo
            : currSettings.minWordSizeForOneTypo,
        minWordSizeForTwoTypos: minWordSizeForTwoTypos is int
            ? minWordSizeForTwoTypos
            : currSettings.minWordSizeForTwoTypos,
        disallowTyposOnWords: disallowTyposOnWords is List<String>
            ? disallowTyposOnWords
            : currSettings.disallowTyposOnWords,
        disallowTyposOnFields: disallowTyposOnFields is List<String>
            ? disallowTyposOnFields
            : currSettings.disallowTyposOnFields,
      ),
    );
  }

  @override
  Future<BigInt> get numberOfDocuments {
    return processInstanceRequest(
      createRequest(
        InstanceFfiRequest_IndexRequest(
          indexName: name,
          numberOfDocuments:
              InstanceFfiRequest_IndexRequest_NumberOfDocuments(),
        ),
      ),
      (response) {
        _handleResponseError(response);
        return BigInt.parse(response.numberOfDocuments.toString());
      },
    );
  }

  @override
  Future<List<MimirDocument>> search({
    String? query,
    int? resultsLimit,
    int? offset,
    TermsMatchingStrategy? matchingStrategy,
    List<SortBy>? sortBy,
    Filter? filter,
  }) async {
    // NOTE: ensure all requested fields in filter + sortBy are indexed
    await updateSettings(
      filterableFields: filter?.getFields().toList() ?? [],
      sortableFields: sortBy?.getFields().toList() ?? [],
      // NOTE: this must remain false to prevent removing existing fields!
      // ignore: avoid_redundant_argument_values
      overwriteFilterableFields: false,
      // NOTE: this must remain false to prevent removing existing fields!
      // ignore: avoid_redundant_argument_values
      overwriteSortableFields: false,
    );

    return processInstanceRequest(
      createRequest(
        InstanceFfiRequest_IndexRequest(
          indexName: name,
          searchDocuments: InstanceFfiRequest_IndexRequest_SearchDocuments(
            query: query,
            limit: resultsLimit,
            offset: offset,
            filter: filter,
            termsMatchingStrategy: matchingStrategy?.toProto(),
            sortCriteria: sortBy?.toProto(),
          ),
        ),
      ),
      (response) {
        _handleResponseError(response);
        return response.documents.documents
            .map((s) => json.decode(s))
            .cast<MimirDocument>()
            .toList();
      },
    );
  }

  @override
  Future<void> close() => changes.close();

  Stream<T> _autoRefresh<T>(FutureOr<T> Function() fn) async* {
    yield await fn();
    await for (final _ in changes.stream) {
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
  Iterable<String> getFields() {
    return switch (whichKind()) {
      Filter_Kind.or => or.filters.expand((f) => f.getFields()),
      Filter_Kind.and => and.filters.expand((f) => f.getFields()),
      Filter_Kind.not => not.getFields(),
      Filter_Kind.exists => [exists.field_1],
      Filter_Kind.inValues => [inValues.field_1],
      Filter_Kind.greaterThan => [greaterThan.field_1],
      Filter_Kind.greaterThanOrEqual => [greaterThanOrEqual.field_1],
      Filter_Kind.equal => [equal.field_1],
      Filter_Kind.notEqual => [notEqual.field_1],
      Filter_Kind.lessThan => [lessThan.field_1],
      Filter_Kind.lessThanOrEqual => [lessThanOrEqual.field_1],
      Filter_Kind.between => [between.field_1],
      Filter_Kind.isNull => [isNull.field_1],
      Filter_Kind.isEmpty => [isEmpty.field_1],
      Filter_Kind.notSet => throw UnsupportedError(
        'Filter missing required variant',
      ),
    };
  }
}

extension on List<SortBy> {
  Iterable<String> getFields() {
    return map(
      (e) => switch (e) {
        SortByAsc(:final field) => field,
        SortByDesc(:final field) => field,
      },
    );
  }

  InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria toProto() {
    return InstanceFfiRequest_IndexRequest_SearchDocuments_SortCriteria(
      sortCriteria: map((e) {
        return switch (e) {
          SortByAsc(:final field) =>
            InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy(asc: field),
          SortByDesc(:final field) =>
            InstanceFfiRequest_IndexRequest_SearchDocuments_SortBy(desc: field),
        };
      }),
    );
  }
}

extension on TermsMatchingStrategy {
  InstanceFfiRequest_IndexRequest_SearchDocuments_TermsMatchingStrategy
  toProto() {
    return switch (this) {
      TermsMatchingStrategy.last =>
        InstanceFfiRequest_IndexRequest_SearchDocuments_TermsMatchingStrategy
            .TERMS_MATCHING_STRATEGY_LAST,
      TermsMatchingStrategy.all =>
        InstanceFfiRequest_IndexRequest_SearchDocuments_TermsMatchingStrategy
            .TERMS_MATCHING_STRATEGY_ALL,
    };
  }
}
