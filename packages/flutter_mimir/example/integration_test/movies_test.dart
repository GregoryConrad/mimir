import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mimir_example/main.dart';
import 'package:flutter_mimir/flutter_mimir.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> pause() => Future.delayed(const Duration(milliseconds: 500));

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Searching returns expected titles', (tester) async {
    Future<void> search(String text) async {
      await tester.enterText(find.byType(TextField), text);
      await tester.pump();
      await pause();
      await tester.pump();
    }

    final instance = await Mimir.defaultInstance;
    final index = instance.getIndex('movies');

    await rootBundle
        .loadString('assets/tmdb_movies.json')
        .then((l) => json.decode(l) as List)
        .then((l) => l.cast<Map<String, dynamic>>())
        .then((l) => index.addDocuments(l));

    await tester.pumpWidget(ProviderScope(
      overrides: [indexProvider.overrideWith((_) => index)],
      child: const MaterialApp(home: Body()),
    ));

    // When no search text, Godzilla vs. Kong is the first entry
    await search('');
    expect(find.text('Godzilla vs. Kong'), findsOneWidget);
    expect(find.text('Jurassic Park'), findsNothing);
    expect(find.text('Forrest Gump'), findsNothing);

    // Look for Jurassic Park
    await search('jurissic');
    expect(find.text('Godzilla vs. Kong'), findsNothing);
    expect(find.text('Jurassic Park'), findsOneWidget);
    expect(find.text('Forrest Gump'), findsNothing);

    // Look for Forrest Gump
    await search('forest gum');
    expect(find.text('Godzilla vs. Kong'), findsNothing);
    expect(find.text('Jurassic Park'), findsNothing);
    expect(find.text('Forrest Gump'), findsOneWidget);
  });
}
