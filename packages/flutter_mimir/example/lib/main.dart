import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mimir/flutter_mimir.dart';
import 'package:flutter_rearch/flutter_rearch.dart';
import 'package:mimir/mimir.dart';
import 'package:rearch/rearch.dart';

void main() => runApp(const DemoApp());

/// Represents the [MimirIndex] that contains the movie dataset.
Future<MimirIndex> indexAsyncCapsule(CapsuleHandle use) async {
  final instance = await Mimir.defaultInstance;
  final index = instance.getIndex('movies');

  // Add all the documents asynchronously.
  await rootBundle
      .loadString('assets/tmdb_movies.json')
      .then((l) => json.decode(l) as List)
      .then((l) => l.cast<Map<String, dynamic>>())
      .then(index.setDocuments);

  return index;
}

/// Allows for the [indexAsyncCapsule] to more easily be warmed up
/// for use in [indexCapsule].
AsyncValue<MimirIndex> indexWarmUpCapsule(CapsuleHandle use) {
  final future = use(indexAsyncCapsule);
  return use.future(future);
}

/// Acts as a proxy to the warmed-up [indexAsyncCapsule].
MimirIndex indexCapsule(CapsuleHandle use) {
  return use(indexWarmUpCapsule).data.unwrapOrElse(
    () => throw StateError('indexAsyncCapsule was not warmed up!'),
  );
}

/// Represents the current query to search for ('' for no current query).
(String, void Function(String)) queryCapsule(CapsuleHandle use) =>
    use.state('');

/// Represents the search results using the query in the [queryCapsule].
AsyncValue<List<Map<String, dynamic>>> searchResultsCapsule(CapsuleHandle use) {
  final index = use(indexCapsule);
  final query = use(queryCapsule);

  // When query is null/empty, all docs will be returned.
  final stream = use.memo(
    () => index.searchStream(query: query.$1),
    [index, query.$1],
  );
  return use.stream(stream);
}

/// {@template DemoApp}
/// [Widget] serving as the root of this demo application.
/// {@endtemplate}
class DemoApp extends StatelessWidget {
  /// {@macro DemoApp}
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RearchBootstrapper(
      child: MaterialApp(
        title: 'Mimir Demo',
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        home: const GlobalWarmUps(child: Body()),
      ),
    );
  }
}

/// {@template GlobalWarmUps}
/// Warms up all of the global warm up capsules so that the rest of the app
/// doesn't have to individually handle failure states.
/// {@endtemplate}
final class GlobalWarmUps extends RearchConsumer {
  /// {@macro GlobalWarmUps}
  const GlobalWarmUps({required this.child, super.key});

  /// The [Widget] to show when all warm up capsules are [AsyncData]s.
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetHandle use) {
    return [
      use(indexWarmUpCapsule),
    ].toWarmUpWidget(
      child: child,
      loading: const Center(child: CircularProgressIndicator.adaptive()),
      errorBuilder: (errors) => Column(
        children: [
          for (final AsyncError(:error, :stackTrace) in errors)
            Text('$error\n$stackTrace'),
        ],
      ),
    );
  }
}

/// {@template Body}
/// Displays the body of the application, including the [SearchBar]
/// and [SearchResults], nested inside a [Scaffold].
/// {@endtemplate}
class Body extends StatelessWidget {
  /// {@macro Body}
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mimir Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => showInfoDialog(context),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: Padding(
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: SearchBar(),
          ),
        ),
      ),
      body: const SearchResults(),
    );
  }
}

/// {@template SearchBar}
/// Displays the search bar at the top of the application
/// and mutates the [queryCapsule].
/// {@endtemplate}
class SearchBar extends RearchConsumer {
  /// {@macro SearchBar}
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetHandle use) {
    final isLoading = use(searchResultsCapsule) is AsyncLoading;
    final (_, setQuery) = use(queryCapsule);
    final textController = use.textEditingController();

    return TextField(
      controller: textController,
      onChanged: setQuery,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        prefixIcon: const Icon(Icons.search),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading) const CircularProgressIndicator.adaptive(),
            IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                textController.text = '';
                setQuery('');
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// {@template SearchResults}
/// Displays the search results from the [searchResultsCapsule].
/// {@endtemplate}
class SearchResults extends RearchConsumer {
  /// {@macro SearchResults}
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context, WidgetHandle use) {
    return switch (use(searchResultsCapsule)) {
      AsyncData(data: final movies) => MoviesList(movies: movies),
      AsyncLoading(previousData: None()) => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      AsyncLoading(previousData: Some(value: final movies)) => MoviesList(
        movies: movies,
      ),
      AsyncError(:final error, :final stackTrace, :final previousData) =>
        Column(
          children: [
            Text('Error: $error\nStack Trace: $stackTrace'),
            if (previousData case Some(value: final oldMovies))
              Expanded(child: MoviesList(movies: oldMovies)),
          ],
        ),
    };
  }
}

/// {@template MoviesList}
/// Displays a [List] of movies.
/// {@endtemplate}
class MoviesList extends StatelessWidget {
  /// {@macro MoviesList}
  const MoviesList({required this.movies, super.key});

  /// The [List] of movies as a [MimirDocument]s (`Map<String, dynamic>`s).
  final List<MimirDocument> movies;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      itemCount: movies.length,
      itemBuilder: (_, index) => MovieCard(movie: movies[index]),
    );
  }
}

/// {@template MovieCard}
/// Displays movie information as a [Card].
/// {@endtemplate}
class MovieCard extends StatelessWidget {
  /// {@macro MovieCard}
  const MovieCard({required this.movie, super.key});

  /// The movie data being displayed in this [MovieCard].
  final Map<String, dynamic> movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 100),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 188.0 / 282.0,
              child: Image.network(
                'https://www.themoviedb.org/t/p/w188_and_h282_bestv2'
                '${movie['poster_path']}',
                fit: BoxFit.fill,
                errorBuilder: (_, _, _) => Center(
                  child: Icon(
                    Icons.cancel,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                loadingBuilder: (_, child, progress) {
                  if (progress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  movie['title'] as String,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  movie['overview'] as String,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text((movie['release_date'] as String).split('-')[0]),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}

/// Displays the movie data info dialog
Future<void> showInfoDialog(BuildContext context) async {
  await showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('info'),
      content: const Text('Movie data provided by themoviedb.org.'),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Close'),
        ),
      ],
    ),
  );
}
