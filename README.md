<p align="center">
<a href="https://github.com/GregoryConrad/mimir/actions"><img src="https://github.com/GregoryConrad/mimir/actions/workflows/build.yml/badge.svg" alt="Build Status"></a>
<a href="https://github.com/GregoryConrad/mimir"><img src="https://img.shields.io/github/stars/GregoryConrad/mimir.svg?style=flat&logo=github&colorB=deeppink&label=stars" alt="Github Stars"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="MIT License"></a>
</p>

<p align="center">
<img src="https://github.com/GregoryConrad/mimir/blob/main/assets/banner.jpg?raw=true" width="100%" alt="Mimir Banner" />
</p>

A batteries-included NoSQL database for Dart & Flutter based on an embedded
[Meilisearch](https://www.meilisearch.com) instance.

---

## Features
- 🔎 Typo tolerant and relevant full-text search *with no extra configuration needed*
- 🔥 Blazingly fast search and reads (written in Rust)
- 🤝 Flutter friendly with a super easy-to-use API (see demo below!)
- 🔱 Powerful, declarative, and reactive queries
- 🔌 Cross-platform support ([web hopefully coming soon!](https://github.com/GregoryConrad/mimir/issues/10))
- 🉑️ Diverse language support, [including CJK, Hebrew, and more!](https://www.meilisearch.com/docs/learn/what_is_meilisearch/language)

## Getting Started
- With Flutter, run `flutter pub add mimir flutter_mimir`
- For Dart-only, run `dart pub add mimir`

Also read the [caveats below](#important-caveats).

## Demo
With Flutter, you can get started with as little as:
```dart
// Get an "index" to store our movies
final instance = await Mimir.defaultInstance;
final index = instance.getIndex('movies');

// Add movies to our index
await index.addDocuments(myMovies);

// Perform a search!
final results = await index.search(query: 'jarrassic par'); // returns Jurassic Park!
```
![Demo Video](https://github.com/GregoryConrad/mimir/blob/main/assets/demo.gif?raw=true)

## Reference Documentation
A collection of commonly used APIs ready for copy-paste into your application.

*Note: unless otherwise stated, all asynchronous methods exposed in Mimir are fallible
and synchronous methods are infallible.
The methods are fail-fast, so you should be aware of any issues early on during development.*

#### Getting & Creating an Index
```dart
// With Flutter (flutter_mimir)
final instance = await Mimir.defaultInstance;

// Dart-only (just mimir)
final instance = await Mimir.getInstance(
  path: instanceDirectory,
  // Following line will change based on your platform
  library: DynamicLibrary.open('libembedded_milli.so'),
); 

// Get an index (creates one lazily if not already created)
final index = instance.getIndex('movies');

// Or, specify some default settings and open the index eagerly
// If you have some settings you want to specify in advance, use openIndex!
final index = await instance.openIndex('movies', primaryKey: 'CustomIdField');
```

#### Configuring an Index
```dart
await index.updateSettings(...); // see setSettings below for arguments
final currSettings = await index.getSettings();
await index.setSettings(currSettings.copyWith(
  // The primary key (PK) is the "ID field" of documents added to mimir.
  // When null, it is automatically inferred for you, but sometimes you may
  // need to specify it manually. See the Important Caveats section for more.
  primaryKey: null,
  // Fields in documents that are included in full-text search.
  // Use null, the default, to search all fields
  searchableFields: <String>[],
  // Fields in documents that can be queried/filtered by.
  // You probably don't need to change this; it is automatically
  // updated for you.
  filterableFields: <String>[],
  // Fields in documents that can be sorted by in searches/queries.
  // You probably don't need to change this; it is automatically
  // updated for you.
  sortableFields: <String>[],
  // The ranking rules of this index, see:
  // https://docs.meilisearch.com/reference/api/settings.html#ranking-rules
  rankingRules: <String>[],
  // The stop words of this index, see:
  // https://docs.meilisearch.com/reference/api/settings.html#stop-words
  stopWords: <String>[],
  // A list of synonyms to link words with the same meaning together.
  // Note: in most cases, you probably want to add synonyms both ways, like below:
  synonyms: <Synonyms>[
    Synonyms(
      word: 'automobile',
      synonyms: ['vehicle'],
    ),
    Synonyms(
      word: 'vehicle',
      synonyms: ['automobile'],
    ),
  ],
  // Whether to enable typo tolerance in searches.
  typosEnabled: true,
  // The minimum size of a word that can have 1 typo.
  // See minWordSizeForTypos.oneTypo here:
  // https://docs.meilisearch.com/reference/api/settings.html#typo-tolerance-object
  minWordSizeForOneTypo: 5,
  // The minimum size of a word that can have 2 typos.
  // See minWordSizeForTypos.twoTypos here:
  // https://docs.meilisearch.com/reference/api/settings.html#typo-tolerance-object
  minWordSizeForTwoTypos: 9,
  // Words that disallow typos. See disableOnWords here:
  // https://docs.meilisearch.com/reference/api/settings.html#typo-tolerance-object
  disallowTyposOnWords: <String>[],
  // Fields that disallow typos. See disableOnAttributes here:
  // https://docs.meilisearch.com/reference/api/settings.html#typo-tolerance-object
  disallowTyposOnFields: <String>[],
));
```

#### Manipulating Documents
```dart
// Adding documents (replaces any documents with the same id)
await index.addDocument(document);
await index.addDocuments(documents);

// Replacing all documents
await index.setDocuments(documents);

// Deleting documents
await index.deleteDocument(id);
await index.deleteDocuments(ids);
await index.deleteAllDocuments();

// Getting documents (not querying--see next section!)
final docOrNull = await index.getDocument(someId);
final allDocs = await index.getAllDocuments();
final allDocsStream = index.documents;
```

#### Searching/Querying
```dart
// Getting a stream of results (very useful in Flutter!)
// Same arguments as index.search; see below
final documentsStream = index.searchStream(...);

// Performing a search/query (using movies here)!
final movies = index.search(
  // The string to use for full-text search. Can be user-supplied.
  // To do a regular database query without full-text search, leave this null.
  query: 'some wordz with typoes to saerch for',
  // The filter used to filter results in a full-text search or query.
  // See the next section; this is a very handy feature in mimir.
  // Set to null to not filter out any documents.
  filter: Mimir.where('director', isEqualTo: 'Alfred Hitchcock'),
  // The fields to sort by (in ascending or descending order).
  // Can be left as null to sort by relevance (to the query text)!
  sortBy: [
    // Sort by year, newest to oldest
    SortBy.desc('year'),
    // In case 2+ documents share the same year, sort by increasing profit next
    SortBy.asc('profit'),
  ],
  // If you want to limit the number of results you get, use the resultsLimit.
  // Defaults to null, which means return all matches.
  resultsLimit: null,
  // Defaults to null, see https://docs.meilisearch.com/reference/api/search.html#matching-strategy
  matchingStrategy: null,
);
```

#### Filtering Search/Query Results
There is a "raw" filtering API in mimir provided by `Filter`,
but it is recommended to use the following API that creates `Filter`s for you instead.

Here are the methods you need to be aware of:
- `Mimir.or(subFilters)` creates an "or" filter (like `||`) of the sub-filters
- `Mimir.and(subFilters)` creates an "and" filter (like `&&`) of the sub-filters
- `Mimir.not(subFilter)` creates a "not" filter (like `!someCondition`) of the sub-filter
- `Mimir.where(condition)` creates a single filter from a given condition.
- The above can be composed together to create powerful, declarative queries!

Heres an example that shows these methods in practice.

Say our Dart boolean logic is (formatted to show intent):
```dart
(
    (
        (movie['fruit'] == 'apple')
        &&
        (movie['year'] >= 2000 && movie['year'] <= 2009)
    )
    ||
    movie['colors'].any((color) => {'red', 'green'}.contains(color))
)
```

Then our "raw" filter API logic would be:
```dart
final filter = Filter.or([
  Filter.and([
    Filter.equal(field: 'fruit', value: 'apple'),
    Filter.between(field: 'year', from: '2000', to: '2009'),
  ]),
  Filter.inValues(field: 'colors', values: ['red', 'green']),
])
```
Which is somewhat hard to read.

Here's what the recommended approach would look like:
```dart
final filter = Mimir.or([
  Mimir.and([
    Mimir.where('fruit', isEqualTo: 'apple'),
    Mimir.where('year', isBetween: ('2000', '2009')),
  ]),
  Mimir.where('colors', containsAtLeastOneOf: ['red', 'green']),
])
```
I think most would agree that this is the easiest of the three to understand,
as it almost reads as pure English, even for complex conditions.

## Important Caveats
Please read these caveats _before_ adding mimir to your project.

- Every document in mimir needs to have a "primary key"
  - The PK is automatically inferred via a field ending in `id` (or simply just `id`)
  - If you have multiple fields ending in `id`, use `instance.openIndex('indexName', primaryKey: 'theActualId')`
  - The contents of the PK field can be a number, or a string matching the regex `^[a-zA-Z0-9-_]*$`
    - In English: PKs can be alphanumeric and contain `-` and `_`
- macOS App Sandbox is *not supported* at the moment, meaning you will not be able to submit apps to the *Mac* App Store
  - You will still be able to distribute macOS applications on your own
  - See more details [here](https://github.com/GregoryConrad/mimir/issues/101)
- Resource usage
  - While modern devices run mimir just fine, several thousand detailed documents can easily consume several MB of disk space and RAM
  - This is due to Milli, a heavy-weight core component of Meilisearch, which gives mimir a lot of its power
  - If you do not need all the features provided by mimir, also consider a more lightweight alternative!
    - [Hive](https://pub.dev/packages/hive) for simple key-value storage
    - [Isar](https://pub.dev/packages/isar) for more sophisticated use-cases
      - Note: while Isar does have full-text search, it is *neither typo-tolerant nor relevant*!
    - If you need easy, typo-tolerant, relevant full-text search, you will want mimir!
      - I am unaware of any other databases that currently provide typo-tolerant full-text search in Flutter, which is why I made mimir in the first place!
