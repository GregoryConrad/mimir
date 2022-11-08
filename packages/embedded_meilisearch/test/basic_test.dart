import 'package:embedded_meilisearch/embedded_meilisearch.dart';
import 'package:test/test.dart';

import 'utils.dart';

const allDocs = [
  {
    "id": 2,
    "title": "Prideand Prejudice",
    "author": "Jane Austin",
    "genre": "romance",
    "price": "3.5",
  },
  {
    "id": 456,
    "title": "Le Petit Prince",
    "author": "Antoine de Saint-Exupéry",
    "genre": "adventure",
    "price": "10.0",
  },
  {
    "id": 1,
    "title": "Wonderland",
    "author": "Lewis Carroll",
    "genre": "fantasy",
    "price": "25.99",
  },
  {
    "id": 4,
    "title": "Harry Potter ing fantasy\0lood Prince",
    "author": "J. K. Rowling",
    "genre": "fantasy\0",
  },
];

void main() {
  test('Basic add/search functionality', () async {
    // Test data taken from the example at:
    // https://github.com/meilisearch/milli/blob/main/README.md
    final index = useTestIndex();
    await index.addDocuments(allDocs);
    final foundDocs = await index.search('horry');
    expect(
      foundDocs,
      [allDocs[3]],
      reason: 'Search for horry should only return harry',
    );
  });

  test('Get and set settings', () async {
    final index = useTestIndex();
    final settings = MeiliIndexSettings.raw(
      filterableFields: ['quantity'],
      sortableFields: ['price'],
      searchableFields: ['title'],
      stopWords: ['the'],
      rankingRules: ['proximity', 'typo', 'words'],
      synonyms: [
        Synonyms(word: 'a', synonyms: ['b']),
        Synonyms(word: 'b', synonyms: ['a']),
        Synonyms(word: 'c', synonyms: ['d', 'e']),
      ],
      typoTolerance: TypoTolerance(
        enabled: true,
        disableOnFields: ['importantField'],
        disableOnWords: ['importantWord'],
        minWordSizeForOneTypo: 3,
        minWordSizeForTwoTypos: 4,
      ),
    );
    // TODO convert Synonyms & TypoTolerance to freezed to fix this fail
    await index.setSettings(settings);
    expect(await index.getSettings(), settings);
  });
}
