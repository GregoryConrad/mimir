import 'package:embedded_meilisearch/src/impl/instance_impl.dart';
import 'package:embedded_meilisearch/src/index.dart';

/// Represents an instance (essentially a group of indices)
/// in milli (the engine that powers Meilisearch).
///
/// You will often only need one instance, but you can
/// make more if you so choose.
///
/// While we could embed all of Meilisearch in Flutter, it would hardly
/// make sense; you can just use ffi to access the engine (milli) directly.
/// With this approach, its easier on constrained resources (no http server)
/// and more simple (no management of the server needed).
mixin MeiliInstance {
  /// Creates a MeiliInstance from the given [path] and [dylibPath]
  static Future<MeiliInstance> from({
    required String path,
    required String dylibPath,
  }) =>
      MeiliInstanceImpl.from(path, dylibPath);

  /// The file-system path for the directory of this instance
  String get path;

  /// Gets the index with the given name (also acts as its id).
  /// One will be created for you if an index with the same name
  /// does not yet exist.
  ///
  /// The name of the index must be filesystem-path safe.
  /// When in doubt, just stick with a-z, A-Z, 0-9, -, and _ for the name.
  Future<MeiliIndex> getIndex(String name);
}
