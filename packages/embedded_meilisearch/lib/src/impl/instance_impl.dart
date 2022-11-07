import 'package:embedded_meilisearch/bridge_generated.dart';
import 'package:embedded_meilisearch/src/impl/index_impl.dart';
import 'package:embedded_meilisearch/src/instance.dart';

class MeiliInstanceImpl with MeiliInstance {
  static Future<MeiliInstanceImpl> from(
    String path,
    EmbeddedMilli milli,
  ) async {
    await milli.ensureInstanceInitialized(instanceDir: path);
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
