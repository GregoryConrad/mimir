import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mimir/mimir.dart';

final uri = Uri.parse(
  'https://raw.githubusercontent.com/prust/wikipedia-movie-data/master/movies.json',
);

void main() async {
  final tmpDir = getTmpDir();
  try {
    await run(tmpDir.path, getMilli());
  } finally {
    tmpDir.deleteSync(recursive: true);
  }
}

Future<void> run(String path, EmbeddedMilli milli) async {
  // First, we get our instance of Mimir from:
  // - path, the path to the instance directory (that holds all of our data)
  // - milli, an instance of EmbeddedMilli, the "ffi wrapper object"
  //   - milli is an object that enables us to communicate with the db in Rust
  // If you are going to use Flutter, don't pay too much attention to milli;
  // milli will be created for you automatically under the hood.
  // However, in pure Dart, you need to explicity state how to get it.
  final instance = Mimir.getInstance(path: path, milli: milli);

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
  final currSettings = await index.getSettings();
  await index.setSettings(currSettings.copyWith(
    // By default, we cannot filter by any fields (to save device memory).
    // We can change this to allow filtering by year & cast (in this example):
    filterableFields: ['year', 'cast'],
    // By default, we cannot sort by any fields (to save device memory).
    // Let's also specify that we want to sort based on a movie's year:
    sortableFields: ['year'],
    // By default, mimir allows you to search by any fields in the documents
    // you add to an index. While this is convenient, it can often use more
    // memory than is really required on a device. To improve effeciency,
    // let's specify that we only need to search by the title here.
    // To revert this behavior and search by all fields, set this to null.
    searchableFields: ['title'],
  ));

  // Let's add all of the movies from a JSON file online
  // It's best to change any settings before adding documents to an index
  // for performance reasons, which is why we do it above.
  final response = await http.get(uri);
  final jsonList = json.decode(response.body) as List;
  final docs = jsonList.cast<Map<String, dynamic>>();
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
      // To enable sorting by title, add it to the sortableFields above
      // SortBy.asc('title'),
    ],
  );
  print(harryPotterMovies);

  // Let's do another search to show some more features:
  final bruceWillis2015To2017Movies = await index.search(
    // Sort by the movie year, old to new
    sortBy: [SortBy.asc('year')],
    // Filter the movies by two different conditions.
    // Because we use "and" below, both of the sub-filters have to be true
    // for a document to be included in the results. We could've also used "or"
    filter: Filter.and([
      // The movie cast must include Bruce Willis
      Filter.inValues(field: 'cast', values: ['Bruce Willis']),
      // The movie must have been released between 2015 & 2017
      Filter.between(field: 'year', from: '2015', to: '2017'),
    ]),
  );
  print(bruceWillis2015To2017Movies);
}

EmbeddedMilli getMilli() {
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
  final dylibPath = '../native/target/debug/$libPrefix$libName.$libSuffix';
  return Mimir.createWrapper(DynamicLibrary.open(dylibPath));
}

Directory getTmpDir() => Directory.systemTemp.createTempSync();
