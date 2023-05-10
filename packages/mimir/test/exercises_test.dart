import 'package:mimir/mimir.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  test('Exercises integration test', () async {
    final index = await useTestIndex();
    final exercises = useExercises();

    // Add the exercises into the index
    await index.addDocuments(exercises);
    final allDocs = await index.getAllDocuments();
    expect(allDocs.length, exercises.length);

    // Perform a basic search that should only return the most likely exercise
    expect(
      (await index.search(
        query: 'benchp ress',
        resultsLimit: 1,
      ))
          .single,
      exercises.where((e) => e['name'] == 'Barbell Bench Press').first,
    );

    // Perform a more complicated search that relies on filters
    // This would normally return Barbell Incline Bench Press,
    // but we are using filters which eliminate that possibility
    expect(
      (await index.search(
        query: 'Inclne pwess',
        // These filter fields have not been registered before, so they
        // should trigger the automatic filter field addition feature.
        // If this test fails because of the filterable fields, it means the
        // milli error text has changed and should be updated accordingly.
        filter: const Filter.and([
          Filter.equal(field: 'category', value: 'strength'),
          Filter.inValues(field: 'primary_muscles', values: ['chest']),
          Filter.inValues(field: 'equipment', values: ['dumbbell']),
        ]),
      ))
          .first,
      exercises.where((e) => e['name'] == 'Incline Dumbbell Press').first,
    );
  });
}
