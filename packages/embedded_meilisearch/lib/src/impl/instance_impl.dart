import 'package:embedded_meilisearch/bridge_generated.dart';
import 'package:embedded_meilisearch/src/impl/index_impl.dart';
import 'package:embedded_meilisearch/src/instance.dart';

class MimirInstanceImpl with MimirInstance {
  const MimirInstanceImpl(this.path, this.milli);

  final EmbeddedMilli milli;

  @override
  final String path;

  @override
  MimirIndexImpl getIndex(String name) => MimirIndexImpl(this, name);
}
