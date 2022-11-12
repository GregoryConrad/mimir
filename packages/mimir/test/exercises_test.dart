import 'package:mimir/mimir.dart';
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
    final results1 = await index.search(
      query: 'benchp ress',
      resultsLimit: 1,
    );
    expect(
      results1.first,
      exercises.where((e) => e['name'] == 'Barbell Bench Press').first,
    );

    // Allow filtering based on equipment
    final currSettings = await index.getSettings();
    await index.setSettings(currSettings.copyWith(
      filterableFields: ['equipment'],
    ));

    // Perform a more complicated search
    final results2 = await index.search(
      query: 'Inclne dumbe pess',
      resultsLimit: 1,
      filter: const Filter.inValues(field: 'equipment', values: ['dumbbell']),
    );
    expect(
      results2.first,
      exercises.where((e) => e['name'] == 'Incline Dumbbell Press').first,
    );
  });
}
