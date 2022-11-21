<p align="center">
<a href="https://github.com/GregoryConrad/mimir/actions"><img src="https://github.com/GregoryConrad/mimir/actions/workflows/build.yml/badge.svg" alt="Build Status"></a>
<a href="https://github.com/GregoryConrad/mimir"><img src="https://img.shields.io/github/stars/GregoryConrad/mimir.svg?style=flat&logo=github&colorB=deeppink&label=stars" alt="Github Stars"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="MIT License"></a>
</p>

<p align="center">
<img src="https://github.com/GregoryConrad/mimir/blob/main/assets/prototype-logo.png?raw=true" width="50%" alt="Mimir Banner" />
</p>

A batteries-included database for Dart & Flutter based on [Meilisearch](https://www.meilisearch.com).

---

## Features
- 🔎 Typo tolerant full-text search *with no extra configuration needed*
- 🔥 Blazingly fast search and reads (written in Rust)
- 🤝 Flutter friendly with a super easy-to-use API (see demo below!)
- 🔱 Powerful, declarative, and reactive queries
- 🔌 Cross-platform support ([web hopefully coming soon!](https://github.com/GregoryConrad/mimir/issues/10))

## Getting Started
- With Flutter, run `flutter pub add flutter_mimir`
- For Dart-only, run `dart pub add mimir`

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
![Demo Video](https://media3.giphy.com/media/5CXp6KYJIyuhLApWNK/giphy.gif)

## Reference Documentation
A collection of commonly used APIs ready for copy-paste into your application.

#### Getting & Creating an Index
```dart
// With Flutter (flutter_mimir)
final instance = await Mimir.defaultInstance;

// Dart-only (just mimir)
final instance = Mimir.getInstance(
    path: instanceDirectory,
    // Following line will change based on your platform
    library: DynamicLibrary.open('libembedded_milli.so'),
); 

// Get an index (creates one lazily if not already created)
final moviesIndex = instance.getIndex('movies');
```

#### Configuring an Index
```dart
final currSettings = await index.getSettings();
await index.setSettings(currSettings.copyWith(
    // Fields in the document that are included in full-text search.
    // Use null, the default, to search all fields
    searchableFields: <String>[],
    // Fields in the document that can be queried/filtered by.
    // You probably don't need to change this; it is automatically
    // updated for you.
    filterableFields: <String>[],
    // Fields in the document that can be sorted by in searches/queries.
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
        Synonym(
            word: 'automobile',
            synonyms: ['vehicle'],
        ),
        Synonym(
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

```

#### Searching/Querying
```dart

```