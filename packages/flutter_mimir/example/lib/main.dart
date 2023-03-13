import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mimir/flutter_mimir.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get a copy of the index.
  final instance = await Mimir.defaultInstance;
  final index = instance.getIndex('movies');

  // Add all the documents async.
  // We are purposefully not awaiting here so we can show the loading state
  // in the UI.
  rootBundle
      .loadString('assets/tmdb_movies.json')
      .then((l) => json.decode(l) as List)
      .then((l) => l.cast<Map<String, dynamic>>())
      .then(index.addDocuments);

  // Finally, run our application.
  runApp(ProviderScope(
    overrides: [indexProvider.overrideWith((_) => index)],
    child: MaterialApp(
      title: 'Mimir Demo',
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const Body(),
    ),
  ));
}

// The providers needed for this example.
final indexProvider = Provider<MimirIndex>((_) => throw UnimplementedError());
final queryProvider = StateProvider((_) => '');
final searchProvider = StreamProvider((ref) {
  final index = ref.watch(indexProvider);
  final query = ref.watch(queryProvider);

  // When query is null/empty, all docs will be returned.
  return index.searchStream(query: query);
});

class Body extends HookConsumerWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final searchResults = ref.watch(searchProvider);

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
              onChanged: (q) => ref.read(queryProvider.notifier).state = q,
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
                    ref.read(queryProvider.notifier).state = '';
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      body: searchResults.when(
        data: (searchResults) => ListView.builder(
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          itemCount: searchResults.length,
          itemBuilder: (_, index) => MovieCard(movie: searchResults[index]),
        ),
        error: (e, s) => Center(child: Text('Error: $e')),
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
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
