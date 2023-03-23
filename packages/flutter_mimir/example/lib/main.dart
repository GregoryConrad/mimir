import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mimir/flutter_mimir.dart';
import 'package:flutter_unstate/flutter_unstate.dart';
import 'package:unstate/unstate.dart';

void main() => runApp(const DemoApp());

// The capsules needed for this example.
final indexAsyncCapsule = Capsule.defaultManager(_indexAsync);
final indexWarmUpCapsule = Capsule.defaultManager(_indexWarmUp);
final indexCapsule = Capsule.defaultManager(_index);
final queryCapsule = Capsule.defaultManager((_) => '');
final searchResultsCapsule = Capsule.defaultManager((manager) {
  final index = manager.watchCapsule(indexCapsule);
  final query = manager.watchCapsule(queryCapsule);

  // When query is null/empty, all docs will be returned.
  final stream = manager.use.memo(
    () => index.searchStream(query: query),
    [index, query],
  );
  return manager.use.watchStream(stream);
});

MimirIndex _index(CapsuleManager<MimirIndex> manager) {
  return manager
      .watchCapsule(indexWarmUpCapsule)
      .data
      .unwrapOrElse(() => throw 'indexCapsule was not warmed up!');
}

Future<MimirIndex> _indexAsync(
  CapsuleManager<Future<MimirIndex>> manager,
) async {
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

AsyncValue<MimirIndex> _indexWarmUp(
  CapsuleManager<AsyncValue<MimirIndex>> manager,
) {
  final future = manager.watchCapsule(indexAsyncCapsule);
  return manager.use.watchFuture(future);
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UnstateBootstrapper(
      child: MaterialApp(
        title: 'Mimir Demo',
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        home: const GlobalWarmUps(child: Body()),
      ),
    );
  }
}

final class GlobalWarmUps extends CapsuleConsumer {
  const GlobalWarmUps({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetManager manager) {
    return [
      manager.watchCapsule(indexWarmUpCapsule),
    ].asWarmUpWidget(
      child: child,
      loading: const Center(child: CircularProgressIndicator.adaptive()),
      errorBuilder: (errors) => Column(children: [
        for (final AsyncError(:error, :stackTrace) in errors)
          Text('$error\n$stackTrace'),
      ]),
    );
  }
}

class Body extends StatelessWidget {
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

final class SearchBar extends CapsuleConsumer {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetManager manager) {
    final searchResults = manager.watchCapsule(searchResultsCapsule);
    final isLoading = searchResults is AsyncLoading;
    final searchTextManager = manager.managerReader(queryCapsule);
    final use = manager.use;
    final textController = use.textEditingController();

    return TextField(
      controller: textController,
      onChanged: (q) => searchTextManager.state = q,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        prefixIcon: const Icon(Icons.search),
        suffixIcon: Row(mainAxisSize: MainAxisSize.min, children: [
          if (isLoading) const CircularProgressIndicator.adaptive(),
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () {
              textController.text = '';
              searchTextManager.state = '';
            },
          ),
        ]),
      ),
    );
  }
}

final class SearchResults extends CapsuleConsumer {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context, WidgetManager manager) {
    final searchResults = manager.watchCapsule(searchResultsCapsule);

    return switch (searchResults) {
      AsyncData(data: final movies) => MoviesList(movies: movies),
      AsyncLoading(previousData: None()) =>
        const Center(child: CircularProgressIndicator.adaptive()),
      AsyncLoading(previousData: Some(value: final movies)) =>
        MoviesList(movies: movies),
      AsyncError(:final error, :final stackTrace, :final previousData) =>
        Column(children: [
        Text('Error: $error\nStack Trace: $stackTrace'),
        if (previousData case Some(value: final oldMovies))
          Expanded(child: MoviesList(movies: oldMovies)),
      ]),
    };
  }
}

class MoviesList extends StatelessWidget {
  const MoviesList({super.key, required this.movies});

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

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie});

  final Map<String, dynamic> movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 100),
        child: Row(children: [
          AspectRatio(
            aspectRatio: 188.0 / 282.0,
            child: Image.network(
              'https://www.themoviedb.org/t/p/w188_and_h282_bestv2${movie['poster_path']}',
              fit: BoxFit.fill,
              errorBuilder: (_, __, ___) => Center(
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
                movie['title'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                movie['overview'],
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text((movie['release_date'] as String).split('-')[0]),
          const SizedBox(width: 12),
        ]),
      ),
    );
  }
}

void showInfoDialog(BuildContext context) {
  showDialog(
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
