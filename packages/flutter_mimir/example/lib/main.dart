import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mimir/flutter_mimir.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get the index
  final instance = await Mimir.defaultInstance;
  final index = instance.getIndex('movies');

  // Add all the documents async (do NOT await)
  rootBundle
      .loadString('assets/tmdb_movies.json')
      .then((l) => json.decode(l) as List)
      .then((l) => l.cast<Map<String, dynamic>>())
      .then((l) => index.addDocuments(l));

  // Finally, run our application
  runApp(ProviderScope(
    overrides: [
      indexProvider.overrideWith((_) => index),
    ],
    child: MaterialApp(
      title: 'Mimir Demo',
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Mimir Demo'),
            actions: [
              IconButton(
                icon: const Icon(Icons.info),
                onPressed: () => showInfoDialog(context),
              ),
            ],
          ),
          body: const Body(),
        );
      }),
    ),
  ));
}

// The providers needed for this example
final indexProvider = Provider<MimirIndex>((_) => throw UnimplementedError());
final queryProvider = StateProvider((_) => '');
final searchProvider = StreamProvider((ref) {
  final index = ref.watch(indexProvider);
  final query = ref.watch(queryProvider);
  return query.isEmpty ? index.documents : index.searchStream(query: query);
});

class Body extends HookConsumerWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final searchResults = ref.watch(searchProvider);

    return Column(children: [
      TextField(
        controller: textController,
        onChanged: (q) => ref.read(queryProvider.notifier).state = q,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () {
              textController.text = '';
              ref.read(queryProvider.notifier).state = '';
            },
          ),
        ),
      ),
      Expanded(
        child: searchResults.when(
          data: (searchResults) => ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (_, index) => MovieCard(movie: searchResults[index]),
          ),
          error: (e, s) => Center(child: Text('Error: $e')),
          loading: CircularProgressIndicator.adaptive,
        ),
      ),
    ]);
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie});

  final Map<String, dynamic> movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          'https://www.themoviedb.org/t/p/w45${movie['poster_path']}',
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(movie['release_date'])],
        ),
        title: Text(movie['title']),
        subtitle: Text(
          movie['overview'],
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
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
