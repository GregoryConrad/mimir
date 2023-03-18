import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mimir/flutter_mimir.dart';
import 'package:flutter_unstate/flutter_unstate.dart';
import 'package:unstate/unstate.dart';

void main() async {
  runApp(UnstateBootstrapper(
    warmUpCapsules: [indexWarmUpCapsule],
    child: MaterialApp(
      title: 'Mimir Demo',
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const Body(),
    ),
  ));
}

// The capsules needed for this example.
final indexAsyncCapsule = Capsule.defaultManager(_indexAsync);
final indexWarmUpCapsule = Capsule.defaultManager(_indexWarmUp);
final indexCapsule = Capsule.defaultManager(_index);

// TODO following two should be a factory
final queryCapsule = Capsule.defaultManager((_) => '');
final searchProvider = Capsule.defaultManager((manager) {
  final index = manager.watchCapsule(indexCapsule);
  final query = manager.watchCapsule(queryCapsule);

  // When query is null/empty, all docs will be returned.
  return index.searchStream(query: query);
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
  rootBundle
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

class Body extends CapsuleConsumer {
  const Body({super.key}) : super(managerFactory: WidgetManager.new);

  @override
  Widget build(BuildContext context, WidgetManager manager) {
    final searchResultsStream = manager.watchCapsule(searchProvider);
    final use = manager.use;

    final searchResults = use.watchStream(searchResultsStream);
    final textController = use.textEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mimir Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => showInfoDialog(context),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: TextField(
              controller: textController,
              onChanged: (q) => manager.managerReader(queryCapsule).state = q,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    textController.text = '';
                    manager.managerReader(queryCapsule).state = '';
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      body: switch (searchResults) {
        AsyncData(data: final movies) => MoviesList(movies: movies),
        AsyncLoading(previousData: None()) =>
          const CircularProgressIndicator.adaptive(),
        AsyncLoading(previousData: Some(value: final movies)) =>
          MoviesList(movies: movies),
        AsyncError(:final error, :final stackTrace, :final previousData) =>
          Column(children: [
          Text('Error: $error\nStack Trace: $stackTrace'),
          if (previousData case Some(value: final oldMovies))
            Expanded(child: MoviesList(movies: oldMovies)),
        ]),
      },
    );
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
