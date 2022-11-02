import 'dart:io';

import 'package:embedded_meilisearch/src/index.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as pp;

part 'impl/instance_impl.dart';

/// Represents an instance (essentially a group of indices)
/// of milli (the engine of meilisearch)
///
/// You will often only need one instance, but you can
/// make more if you so choose
mixin MeiliInstance {
  /// Creates the default MeiliInstance instance
  static Future<MeiliInstance> get defaultInstance => getInstance('default');

  /// Creates a MeiliInstance with the given name and (optional) path
  static Future<MeiliInstance> getInstance(String name, [String? path]) =>
      _MeiliInstanceImpl.getInstance(name, path);

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
