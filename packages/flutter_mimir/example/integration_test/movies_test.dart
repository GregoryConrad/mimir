import 'package:flutter/material.dart';
import 'package:flutter_mimir_example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Searching returns expected titles', (tester) async {
    Future<void> search(String text) async {
      await tester.enterText(find.byType(TextField), text);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
    }

    // Wait for inital load to finish
    await tester.pumpWidget(const DemoApp());
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
