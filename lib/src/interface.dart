import 'package:embedded_meilisearch/src/instance.dart';

// ignore: constant_identifier_names
const Meili = MeiliInterface();

class MeiliInterface {
  const MeiliInterface();

  /// Creates a MeiliInstance with the given name and path
  Future<MeiliInstance> getInstance(String name, String path) =>
      MeiliInstance.from(name, path);
}
