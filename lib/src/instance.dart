import 'dart:io';

import 'package:embedded_meilisearch/src/index.dart';

part 'impl/instance_impl.dart';

/// Represents an instance (essentially a group of indices)
/// of milli (the engine of meilisearch)
///
/// You will often only need one instance, but you can
/// make more if you so choose
mixin MeiliInstance {
  /// Creates a MeiliInstance from the given name and path
  static Future<MeiliInstance> from(String name, String path) =>
      _MeiliInstanceImpl.from(name, path);

  /// The path-friendly name of this instance
  String get name;

  /// The file-system path of this instance
  String get path;

  // TODO milli version/dumps/indexes?

  /// Returns the index with the given name (id)
  ///
  /// The name of the index must be filesystem-path safe
  /// When in doubt, just stick with a-z, A-Z, 0-9, -, and _ for the name
  Future<MeiliIndex> getIndex(String name);
}
