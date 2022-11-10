import 'package:mimir/bridge_generated.dart';
import 'package:mimir/src/impl/index_impl.dart';
import 'package:mimir/src/instance.dart';

class MimirInstanceImpl with MimirInstance {
  const MimirInstanceImpl(this.path, this.milli);

  final EmbeddedMilli milli;

  @override
  final String path;

  @override
  MimirIndexImpl getIndex(String name) => MimirIndexImpl(this, name);
}
