import 'package:embedded_meilisearch/src/instance.dart';

// Instead of just having a Meili namespace, we have to do this instead,
// because we cannot add static extension methods to a class.
// (We need the extensions for the Flutter version of the package.)
// This approach was taken from Hive, where initFlutter()
// in the hive_flutter package is an extension method.
// To the user this will look like a class/namespace so it is okay.
// ignore: constant_identifier_names
const Meili = MeiliInterface();

class MeiliInterface {
  const MeiliInterface();

  /// Creates a MeiliInstance with the given name and path
  ///
  /// The path has to point to a directory; a directory will be created
  /// for you at the given path if one does not already exist
  Future<MeiliInstance> getInstance(String name, String path) =>
      MeiliInstance.from(name, path);
}
