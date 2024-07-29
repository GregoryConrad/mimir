import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:mimir/mimir.dart';

final uri = Uri.parse(
  'https://raw.githubusercontent.com/prust/wikipedia-movie-data/master/movies.json',
);

Future<void> main() async {
  final tmpDir = getTmpDir();
  try {
    await run(tmpDir.path, getLibrary());
  } finally {
    tmpDir.deleteSync(recursive: true);
  }
}

Future<void> run(String path, DynamicLibrary lib) async {
  // First, we get our instance of Mimir from:
  // - path, the path to the instance directory (that holds all of our data)
  // - lib, an instance of DynamicLibrary
  //   - lib is an object that enables us to communicate with the db in Rust
  // If you are going to use Flutter, don't pay too much attention to lib;
  // lib will be created for you automatically under the hood.
  // However, in pure Dart, you need to explicity state how to get it.
  final instance = await Mimir.getInstance(path: path, library: lib);

  // Let's create an 'index' of movies that we can search through.
  // An index can be thought of as a grouping of documents of the same type.
  // Instances and indices are created for you on-demand (lazily)
  // if they do not already exist. This is what allows Mimir to not need
  // async/await when trying ot get an instance or an index!
  final index = instance.getIndex('movies');

  // Mimir simply "works out of the box" and covers many use-cases for free.
  // However, we want to configure some additional settings for this example.
  //
  // As this is a new index, these settings will just be the default settings.
  // We also could have just created a new settings object like:
  // `new MimirIndexSettings(...)`.
  await index.updateSettings(
    // By default, mimir allows you to search by any fields in the documents
    // you add to an index. While this is convenient, it can often use more
    // memory than is really required on a device. To improve effeciency,
    // let's specify that we only need to search by the title here.
    // To revert this behavior and search by all fields, set this to null.
    searchableFields: ['title'],
  );

  // Let's add all of the movies from a JSON file online
  // It's best to change any settings before adding documents to an index
  // for performance reasons, which is why we do it above.
  final response = await http.get(uri);
  final jsonList = json.decode(response.body) as List;
  final docs = jsonList.cast<Map<String, dynamic>>().map((d) {
    // Add in the required id field by copying & modifying the title + year
    final disallowedInId = RegExp(r'[^a-zA-Z0-9-_]');
    String newId = d['title'] + d['year'].toString();
    newId = newId.replaceAll(disallowedInId, '');
    return d..['id'] = newId;
  }).toList();
  await index.addDocuments(docs);

  // Now, let's perform a search on the documents!
  final harryPotterMovies = await index.search(
    query: 'horry botter',
    // Normally, the results are in order of their "relevance;"
    // We can override this behavior with sortBy!
    sortBy: [
      // Let's sort the results by year in descending order here (new to old):
      SortBy.desc('year'),
      // If any two movies had the same year, we could sort by title next:
      SortBy.asc('title'),
    ],
  );

  // Check to see if the found movies include all the Harry Potter movies
  final foundHarryPotterTitles =
      harryPotterMovies.map((movie) => movie['title'] as String).toSet();
  final expectedHarryPotterTitles = docs
      .map((movie) => movie['title'] as String)
      .where((title) => title.contains('Harry Potter'));
  assert(
    foundHarryPotterTitles.containsAll(expectedHarryPotterTitles),
    'Search for "horry botter" should return all Harry Potter movies',
  );

  // Let's do another search to show some more features:
  final bruceWillis2015To2017Movies = await index.search(
    // Sort by the movie year, old to new
    sortBy: [SortBy.asc('year')],
    // Filter the movies by two different conditions.
    // Because we use "and" below, both of the sub-filters have to be true
    // for a document to be included in the results. We could've also used "or"
    filter: Mimir.and([
      // The movie cast must include Bruce Willis
      Mimir.where('cast', containsAtLeastOneOf: ['Bruce Willis']),
      // The movie must have been released between 2015 & 2017
      Mimir.where('year', isBetween: ('2015', '2017')),
    ]),
  );

  // Check to see if the found movies include all 2015-2017 Bruce Willis movies
  final expectedWillisTitles = docs
      .where((movie) => movie['cast'].contains('Bruce Willis'))
      .where((movie) => movie['year'] >= 2015 && movie['year'] <= 2017)
      .map((movie) => movie['title']);
  final foundWillisTitles =
      bruceWillis2015To2017Movies.map((movie) => movie['title'] as String);
  assert(
    IterableEquality().equals(foundWillisTitles, expectedWillisTitles),
    'Query for 2015-2017 Bruce Willis movies should return the expected results',
  );
}

DynamicLibrary getLibrary() {
  // If you are running this example locally, you will need to run
  // `cargo build -r` to generate the needed dylib.
  const libName = 'embedded_milli';
  final libPrefix = {
    Platform.isWindows: '',
    Platform.isMacOS: 'lib',
    Platform.isLinux: 'lib',
  }[true]!;
  final libSuffix = {
    Platform.isWindows: 'dll',
    Platform.isMacOS: 'dylib',
    Platform.isLinux: 'so',
  }[true]!;
  final dylibPath = '../../../target/release/$libPrefix$libName.$libSuffix';
  return DynamicLibrary.open(dylibPath);
}

Directory getTmpDir() => Directory.systemTemp.createTempSync();
