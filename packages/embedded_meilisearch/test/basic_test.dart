import 'dart:ffi';
import 'dart:io';

import 'package:embedded_meilisearch/embedded_meilisearch.dart';
import 'package:test/test.dart';

void main() {
  final instanceDir = Directory.systemTemp.createTempSync('testInstanceTemp-');

  test('Basic integration test with movies', () async {
    // TODO the dylibPath might be .so in CI/linux. might need to do Platform.isX
    const dylibPath = 'native/target/debug/libembedded_milli.dylib';
    final milli = Meili.createWrapper(DynamicLibrary.open(dylibPath));

    final instance = Meili.getInstance(
      path: instanceDir.path,
      milli: milli,
    );
    final index = instance.getIndex('movies');

    final allDocs = [
      {
        "id": 2,
        "title": "Prideand Prejudice",
        "author": "Jane Austin",
        "genre": "romance",
        "price": "3.5",
      },
      {
        "id": 456,
        "title": "Le Petit Prince",
        "author": "Antoine de Saint-Exupéry",
        "genre": "adventure",
        "price": "10.0",
      },
      {
        "id": 1,
        "title": "Wonderland",
        "author": "Lewis Carroll",
        "genre": "fantasy",
        "price": "25.99",
      },
      {
        "id": 4,
        "title": "Harry Potter ing fantasy\0lood Prince",
        "author": "J. K. Rowling",
        "genre": "fantasy\0",
      },
    ];
    await index.addDocuments(allDocs);
    final foundDocs = await index.search('horry');
    expect(
      foundDocs,
      [allDocs[3]],
      reason: 'Search for horry should only return harry',
    );
  });

  instanceDir.deleteSync();
}