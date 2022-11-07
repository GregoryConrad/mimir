import 'package:embedded_meilisearch/bridge_generated.dart';
import 'package:embedded_meilisearch/src/impl/index_impl.dart';
import 'package:embedded_meilisearch/src/instance.dart';

class MeiliInstanceImpl with MeiliInstance {
  const MeiliInstanceImpl(this.path, this.milli);

  final EmbeddedMilli milli;

  @override
  final String path;

  @override
  MeiliIndexImpl getIndex(String name) => MeiliIndexImpl(this, name);
}
