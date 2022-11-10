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
    final index = useTestIndex();
    await index.addDocuments(allDocs);
    final foundDocs = await index.search(query: 'horry');
    expect(
      foundDocs,
      [allDocs[3]],
      reason: 'Search for horry should only return harry',
    );
  });

  test('Get and set all settings', () async {
    final index = useTestIndex();
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

  test('Use multiple instances', () {
    for (final _ in Iterable<int>.generate(100)) {
      useTestIndex();
    }
  });

  test('Add and get documents', () async {
    final index = useTestIndex();
    await index.addDocuments(allDocs);

    expect(await index.getAllDocuments(), allDocs);
    expect(await index.getDocument('1'), allDocs[2]);
    expect(await index.getDocument('456'), allDocs[1]);
    expect(await index.getDocument('1234'), null);
  });

  test('Add, get, set, and delete documents', () async {
    final index = useTestIndex();
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
    const concurrentDocs = 100, batchDocs = 10000;
    final index = useTestIndex();

    // Add docs concurrently
    await Future.wait(Iterable<int>.generate(concurrentDocs)
        .map((i) => {'id': i})
        .map(index.addDocument));

    // Add docs in batch
    await index.addDocuments(Iterable<int>.generate(batchDocs)
        .map((i) => {'id': i + concurrentDocs})
        .toList());

    final allDocs = await index.getAllDocuments();
    expect(allDocs.length, concurrentDocs + batchDocs);
  });
}
