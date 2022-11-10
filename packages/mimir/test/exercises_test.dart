import 'package:test/test.dart';

import 'utils.dart';

void main() {
  test('Exercises integration test', () async {
    final index = useTestIndex();
    final exercises = useExercises();

    // Add the exercises into the index
    await index.addDocuments(exercises);
    final allDocs = await index.getAllDocuments();
    expect(allDocs.length, exercises.length);

    // Perform a basic search
    final results = await index.search(query: 'benchp ress');
    expect(
      results[0],
      exercises.where((e) => e['name'] == 'Barbell Bench Press').first,
    );
  });
}
