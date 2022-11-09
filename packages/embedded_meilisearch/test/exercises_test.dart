import 'package:test/test.dart';

import 'utils.dart';

void main() {
  test('Exercises integration test', () async {
    final index = useTestIndex();
    final exercises = useExercises();

    // TODO why is this dummy document needed?
    await index.addDocument({'SomeId': 123456});
    await index.deleteDocument('123456');

    // Add the exercises into the index
    await index.addDocuments(exercises);
    final allDocs = await index.getAllDocuments();
    expect(allDocs.length, exercises.length);

    // Perform a basic search
    final results = await index.search('benchp ress');
    results.forEach((doc) => print(doc['name']));
  });
}
