import 'package:mimir/src/bridge_generated.dart';
import 'package:mimir/src/impl/index_impl.dart';
import 'package:mimir/src/instance.dart';

class MimirInstanceImpl with MimirInstance {
  MimirInstanceImpl(this.path, this.milli);

  final EmbeddedMilli milli;

  @override
  final String path;

  final _indices = <String, MimirIndexImpl>{};

  @override
  MimirIndexImpl getIndex(String name) =>
      _indices.putIfAbsent(name, () => MimirIndexImpl(this, name));
}
