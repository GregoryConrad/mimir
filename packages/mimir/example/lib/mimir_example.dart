import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mimir/mimir.dart';

/// [Uri] of the movies json file
final Uri moviesUri = Uri.parse(
  'https://raw.githubusercontent.com/prust/wikipedia-movie-data/master/movies.json',
);

/// Runs the example code at the given [path].
Future<void> run(String path) async {
  // First, we get an instance of Mimir that stores data at the supplied path.
  final instance = await Mimir.getInstance(path: path);

  // Let's create an 'index' of movies that we can search through.
  // An index can be thought of as a grouping of documents of the same type.
  // Instances and indices are created for you on-demand (lazily)
  // if they do not already exist. This is what allows Mimir to not need
  // async/await when trying to get an instance or an index.
  final index = instance.getIndex('movies');

  // Mimir simply "works out of the box" and covers many use-cases for free.
  // However, we want to configure some additional settings for this example.
  //
  // As this is a new index, these settings will just be the default settings.
  await index.updateSettings(
    // By default, mimir allows you to search by any fields in the documents
    // you add to an index. While this is convenient, it can often use more
    // memory than is really required on a device. To improve effeciency,
    // let's specify that we only need to search by the title here.
    // To revert this behavior and search by all fields, set this to null.
    searchableFields: ['title'],
  );

  // Let's add all of the movies from a JSON file online.
  // It's best to change any settings before adding documents to an index
  // for performance reasons, which is why we do it above.
  // (You can also use `openIndex` instead of `getIndex`.)
  final response = await http.get(moviesUri);
  final jsonList = json.decode(response.body) as List;
  final docs = jsonList.cast<Map<String, dynamic>>().map((d) {
    // Add in the required id field by copying & modifying the title + year
    final disallowedInId = RegExp('[^a-zA-Z0-9-_]');
    return d
      ..['id'] = '${d['title']}${d['year']}'.replaceAll(disallowedInId, '');
  }).toList();
  await index.addDocuments(docs);

  // Now, let's perform a search on the documents!
  final harryPotterMovies = await index.search(
    query: 'horry botter',
    // Normally, the results are in order of their "relevance;"
    // we can override this behavior with sortBy!
    sortBy: const [
      // Let's sort the results by year in descending order here (new to old):
      SortBy.desc('year'),
      // If any two movies had the same year, we could sort by title next:
      SortBy.asc('title'),
    ],
  );

  // Check to see if the found movies include all the Harry Potter movies
  final foundHarryPotterTitles = harryPotterMovies
      .map((movie) => movie['title'] as String)
      .toSet();
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
    sortBy: const [SortBy.asc('year')],
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
      .where((movie) => (movie['cast'] as List).contains('Bruce Willis'))
      .where((movie) => movie['year'] as int >= 2015)
      .where((movie) => movie['year'] as int <= 2017)
      .map((movie) => movie['title'] as String)
      .toList();
  final foundWillisTitles = bruceWillis2015To2017Movies
      .map((movie) => movie['title'] as String)
      .toList();
  assert(
    foundWillisTitles.toString() == expectedWillisTitles.toString(),
    'Query for 2015-2017 Bruce Willis movies should return expected results',
  );
}
