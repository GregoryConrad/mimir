import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:mimir/mimir.dart';
import 'package:test/test.dart';

import 'utils.dart';

const allDocs = [
  // Test data taken from the example at:
  // https://github.com/meilisearch/milli/blob/main/README.md
  {
    'id': 2,
    'title': 'Prideand Prejudice',
    'author': 'Jane Austin',
    'genre': 'romance',
    'price': '3.5',
  },
  {
    'id': 456,
    'title': 'Le Petit Prince',
    'author': 'Antoine de Saint-Exupéry',
    'genre': 'adventure',
    'price': '10.0',
  },
  {
    'id': 1,
    'title': 'Wonderland',
    'author': 'Lewis Carroll',
    'genre': 'fantasy',
    'price': '25.99',
  },
  {
    'id': 4,
    'title': 'Harry Potter ing fantasylood Prince',
    'author': 'J. K. Rowling',
    'genre': 'fantasy',
  },
];

void main() {
  test('Basic add/search functionality', () async {
    final index = await useTestIndex();
    await index.addDocuments(allDocs);
    final foundDocs = await index.search(query: 'horry');
    expect(
      foundDocs,
      [allDocs[3]],
      reason: 'Search for horry should only return harry',
    );
  });

  test('Get and set all settings', () async {
    final index = await useTestIndex();
    const originalSettings = MimirIndexSettings(
      filterableFields: ['quantity'],
      sortableFields: ['price'],
      searchableFields: ['title'],
      stopWords: ['the', 'of'],
      rankingRules: ['proximity', 'typo', 'words'],
      synonyms: [
        Synonyms(word: 'a', synonyms: ['b']),
        Synonyms(word: 'b', synonyms: ['a']),
        Synonyms(word: 'x', synonyms: ['a']),
        Synonyms(word: 'c', synonyms: ['d', 'e', 'f']),
        Synonyms(word: 'y', synonyms: ['d', 'e', 'f']),
      ],
      typosEnabled: true,
      disallowTyposOnWords: ['importantword1', 'foobar'],
      disallowTyposOnFields: ['importantField'],
      minWordSizeForOneTypo: 3,
      minWordSizeForTwoTypos: 4,
    );
    final newSettings = originalSettings.copyWith(
      filterableFields: [],
      sortableFields: [],
      searchableFields: null,
      stopWords: [],
      synonyms: [],
      rankingRules: [
        'words',
        'typo',
        'proximity',
        'attribute',
        'sort',
        'exactness',
      ],
      typosEnabled: false,
      disallowTyposOnWords: [],
      disallowTyposOnFields: [],
      minWordSizeForOneTypo: 4,
      minWordSizeForTwoTypos: 5,
    );

    await index.setSettings(originalSettings);
    final actualSettings = await index.getSettings();
    expect(
      ComparableMimirIndexSettings.from(actualSettings),
      ComparableMimirIndexSettings.from(originalSettings),
    );

    await index.setSettings(newSettings);
    final actualNewSettings = await index.getSettings();
    expect(
      ComparableMimirIndexSettings.from(actualNewSettings),
      ComparableMimirIndexSettings.from(newSettings),
    );
  });

  test('Use multiple instances', () async {
    for (final _ in Iterable<int>.generate(100)) {
      await useTestIndex();
    }
  });

  test('Add and get documents', () async {
    final index = await useTestIndex();
    await index.addDocuments(allDocs);

    expect(await index.getAllDocuments(), allDocs);
    expect(await index.getDocument('1'), allDocs[2]);
    expect(await index.getDocument('456'), allDocs[1]);
    expect(await index.getDocument('1234'), null);
  });

  test('Add, get, set, and delete documents', () async {
    final index = await useTestIndex();
    await index.deleteAllDocuments(); // make sure it doesn't throw
    await index.addDocuments(allDocs);

    await index.deleteDocument('1234'); // make sure it doesn't throw
    expect(await index.getDocument('1'), allDocs[2]);
    expect(await index.getDocument('456'), allDocs[1]);
    expect(await index.getDocument('2'), allDocs[0]);
    expect(await index.getDocument('4'), allDocs[3]);

    await index.deleteDocuments(['1', '456']);
    expect(await index.getDocument('1'), null);
    expect(await index.getDocument('456'), null);
    expect(await index.getDocument('2'), allDocs[0]);
    expect(await index.getDocument('4'), allDocs[3]);

    await index.setDocuments([allDocs[2], allDocs[1]]);
    expect(await index.getDocument('1'), allDocs[2]);
    expect(await index.getDocument('456'), allDocs[1]);
    expect(await index.getDocument('2'), null);
    expect(await index.getDocument('4'), null);

    await index.deleteAllDocuments();
    expect(await index.getDocument('1'), null);
    expect(await index.getDocument('456'), null);
    expect(await index.getDocument('2'), null);
    expect(await index.getDocument('4'), null);
    expect(await index.getAllDocuments(), <MimirDocument>[]);
  });

  test('Multiprocessing functionality when adding documents', () async {
    const concurrentDocs = 100;
    const batchDocs = 10000;
    final index = await useTestIndex();

    // Add docs concurrently
    await Future.wait(
      Iterable<int>.generate(concurrentDocs)
          .map((i) => {'id': i})
          .map(index.addDocument),
    );

    // Add docs in batch
    await index.addDocuments(
      Iterable<int>.generate(batchDocs)
          .map((i) => {'id': i + concurrentDocs})
          .toList(),
    );

    final allDocs = await index.getAllDocuments();
    expect(allDocs.length, concurrentDocs + batchDocs);
  });

  test('Documents stream', () async {
    final index = await useTestIndex();
    final actualDocumentsStream = index.documents.asBroadcastStream();

    await expectLater(actualDocumentsStream, emits(equals([])));
    await index.addDocuments(allDocs);
    await expectLater(actualDocumentsStream, emits(equals(allDocs)));
    await index.deleteAllDocuments();
    await expectLater(actualDocumentsStream, emits(equals([])));
    await index.addDocument(allDocs[0]);
    await expectLater(actualDocumentsStream, emits(equals([allDocs[0]])));
  });

  test('Search stream', () async {
    final index = await useTestIndex();
    final actualDocumentsStream =
        index.searchStream(query: 'horry botter').asBroadcastStream();

    await expectLater(actualDocumentsStream, emits(equals([])));
    await index.addDocuments(allDocs);
    await expectLater(actualDocumentsStream, emits(equals([allDocs[3]])));
    await index.deleteAllDocuments();
    await expectLater(actualDocumentsStream, emits(equals([])));
  });

  test('Search with no parameters should return all documents', () async {
    final index = await useTestIndex();
    const numDocs = 1000;
    await index.addDocuments(
      Iterable.generate(numDocs, (i) => {'id': i}).toList(),
    );
    final searchResults = await index.search();
    expect(searchResults.length, numDocs);
  });

  test('Adding invalid documents throws errors', () async {
    final index = await useTestIndex();
    const missingIdDoc = {'name': 'test'};
    const invalidIdDoc = {'id': 'abc123='};
    expect(
      () => index.addDocument(missingIdDoc),
      throwsA(const TypeMatcher<FfiException>()),
    );
    expect(
      () => index.addDocument(invalidIdDoc),
      throwsA(const TypeMatcher<FfiException>()),
    );
  });

  test('Setting invalid documents throws errors', () async {
    final index = await useTestIndex();
    const missingIdDoc = {'name': 'test'};
    const invalidIdDoc = {'id': 'abc123='};
    expect(
      () => index.setDocuments([missingIdDoc]),
      throwsA(const TypeMatcher<FfiException>()),
    );
    expect(
      () => index.setDocuments([invalidIdDoc]),
      throwsA(const TypeMatcher<FfiException>()),
    );
  });

  test('Setting/adding an invalid batch adds no documents', () async {
    final index = await useTestIndex();
    const invalidBatch = [
      {'id': '1234'},
      {'id': 'abc123='},
    ];
    try {
      await index.setDocuments(invalidBatch);
    } catch (_) {}
    try {
      await index.addDocuments(invalidBatch);
    } catch (_) {}
    expect((await index.getAllDocuments()).length, 0);
  });

  test('Queries with 0 & 1 and/or sub-filter(s) work', () async {
    final index = await useTestIndex();
    await index.addDocuments(allDocs);

    // 0 sub-filters
    expect(await index.search(filter: Mimir.and([])), <MimirDocument>[]);
    expect(await index.search(filter: Mimir.or([])), <MimirDocument>[]);

    // 1 sub-filter
    final idFilter = Mimir.where('id', isEqualTo: '4');
    final expectedDocs = [allDocs.last];
    expect(await index.search(filter: Mimir.and([idFilter])), expectedDocs);
    expect(await index.search(filter: Mimir.or([idFilter])), expectedDocs);
  });

  test('Adding a document with multiple possible PKs errors out', () async {
    final index = await useTestIndex();
    final doc = {
      'id': 1234,
      'anotherId': 4321,
    };
    expect(index.addDocument(doc), throwsA(isA<FfiException>()));
  });

  test('openIndex should use the supplied PK', () async {
    final instance = await useInstance();
    final index = await instance.openIndex('docs', primaryKey: 'id');
    final doc = {
      'id': 1234,
      '_id': 4321,
    };
    await index.addDocument(doc);
    expect(await index.getDocument('1234'), doc);
  });

  test('Setting a primary key should use that primary key', () async {
    final index = await useTestIndex();
    await index.updateSettings(primaryKey: 'someKey');
    final doc = {
      'someKey': 0,
      'id': 1234,
      'anotherId': 4321,
    };
    await index.addDocument(doc);
    expect(await index.getDocument('0'), doc);
  });

  test('Changing a PK after one is already set will error out', () async {
    final index = await useTestIndex();
    await index.updateSettings(primaryKey: 'id');
    final doc = {
      'id': 1234,
      'anotherId': 4321,
    };
    await index.addDocument(doc);

    await index.updateSettings(primaryKey: 'id'); // should be a no-op
    expect(
      index.updateSettings(primaryKey: 'anotherId'),
      throwsA(isA<FfiException>()),
    );
  });

  test('Adding a document without the PK will error out', () async {
    final index = await useTestIndex();
    await index.updateSettings(primaryKey: 'id');
    final doc = {
      '_id': 4321,
    };

    expect(
      index.addDocument(doc),
      throwsA(isA<FfiException>()),
    );
  });

  test('Full text search with CJK works as expected', () async {
    final index = await useTestIndex();
    const docs = [
      {'id': 0, 'text': '你好妈妈'},
      {'id': 1, 'text': '这个饺子好吃'},
    ];
    await index.addDocuments(docs);

    // Test to make sure specific nouns return the right documents
    expect(
      await index.search(query: '妈妈'),
      [docs[0]],
    );
    expect(
      await index.search(query: '饺子'),
      [docs[1]],
    );

    // hao should not return nihao...
    expect(
      await index.search(query: '好'),
      [docs[1]],
    );
    // ...but nihao directly should no longer return haochi
    expect(
      await index.search(query: '你好'),
      [docs[0]],
    );
  });

  test('Searching can be done with pagination', () async {
    final index = await useTestIndex();
    const docs = [
      {'id': 'a'},
      {'id': 'aa'},
    ];
    await index.addDocuments(docs);

    // Test to make sure specific offsets return the right documents
    expect(
      await index.search(query: 'a', offset: 0, resultsLimit: 1),
      [docs[0]],
    );
    expect(
      await index.search(query: 'a', offset: 1, resultsLimit: 1),
      [docs[1]],
    );
  });

  test('numberOfDocuments returns the correct number of documents', () async {
    final index = await useTestIndex();
    expect(await index.numberOfDocuments, 0);
    await index.addDocument({'id': 0});
    expect(await index.numberOfDocuments, 1);
    await index.addDocument({'id': 1});
    expect(await index.numberOfDocuments, 2);
    await index.deleteAllDocuments();
    expect(await index.numberOfDocuments, 0);
  });

  test('isNull filter returns only documents where field is null', () async {
    final docs = [
      {'id': 1, 'field': null},
      {'id': 2, 'field': 1}
    ];
    final index = await useTestIndex();
    await index.addDocuments(docs);
    expect(
      await index.search(filter: Mimir.where('field', isNull: true)),
      [docs[0]],
    );
    expect(
      await index.search(filter: Mimir.where('field', isNull: false)),
      [docs[1]],
    );
  });

  test('isEmpty filter returns only documents where field is empty', () async {
    final docs = [
      {'id': 1, 'field': <int>[]},
      {
        'id': 2,
        'field': [1234],
      }
    ];
    final index = await useTestIndex();
    await index.addDocuments(docs);
    expect(
      await index.search(filter: Mimir.where('field', isEmpty: true)),
      [docs[0]],
    );
    expect(
      await index.search(filter: Mimir.where('field', isEmpty: false)),
      [docs[1]],
    );
  });
}
