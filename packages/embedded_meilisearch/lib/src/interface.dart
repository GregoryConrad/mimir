import 'package:embedded_meilisearch/bridge_generated.dart';
import 'package:embedded_meilisearch/src/instance.dart';

/// The exposed API to interact with embedded_meilisearch
// Instead of just having a Meili namespace, we have to do this instead,
// because we cannot add static extension methods to a class.
// This approach was taken from Hive, where initFlutter()
// in the hive_flutter package is an extension method.
// To the user this will look like a class/namespace so it is okay.
// ignore: constant_identifier_names
const Meili = MeiliInterface._();

/// The interface of the API to interact with embedded_meilisearch
class MeiliInterface {
  const MeiliInterface._();

  /// Creates a MeiliInstance from the given [path] and [milli]
  ///
  /// The [path] has to point to a directory; a directory will be
  /// created for you at the given path if one does not already exist.
  ///
  /// [milli] is the ffi wrapper that is used internally to call the Rust APIs
  Future<MeiliInstance> getInstance({
    required String path,
    required EmbeddedMilli milli,
  }) =>
      MeiliInstance.from(path: path, milli: milli);
}
