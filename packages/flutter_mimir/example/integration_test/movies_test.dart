import 'package:flutter/material.dart';
import 'package:flutter_mimir_example/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_unstate/flutter_unstate.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Searching returns expected titles', (tester) async {
    Future<void> search(String text) async {
      await tester.enterText(find.byType(TextField), text);
      await tester.pump(const Duration(seconds: 1));
    }

    await tester.pumpWidget(UnstateBootstrapper(
      warmUpCapsules: [indexWarmUpCapsule],
      loading: const CircularProgressIndicator(),
      errorBuilder: (errors) => Column(
        children: errors.map((e) => Text('$e')).toList(),
      ),
      child: const MaterialApp(home: Body()),
    ));

    // Wait for inital document add to finish
    await tester.pumpAndSettle();

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
