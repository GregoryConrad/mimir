import 'dart:ffi';
import 'dart:io';

import 'package:embedded_meilisearch/bridge_generated.dart';
import 'package:embedded_meilisearch/src/impl/index_impl.dart';
import 'package:embedded_meilisearch/src/instance.dart';

class MeiliInstanceImpl with MeiliInstance {
  static Future<MeiliInstanceImpl> from(String path, String dylibPath) async {
    // Create the directory for this instance
    await Directory(path).create();

    // Create an instance of the ffi wrapper
    final dylib = DynamicLibrary.open(dylibPath);
    final milli = EmbeddedMilliImpl(dylib);
    await milli.initInstance(instanceDir: path);

    // If all went well, return this instance
    return MeiliInstanceImpl._(path, milli);
  }

  const MeiliInstanceImpl._(this.path, this.milli);

  final EmbeddedMilli milli;

  @override
  final String path;

  @override
  Future<MeiliIndexImpl> getIndex(String name) =>
      MeiliIndexImpl.from(this, name);
}
