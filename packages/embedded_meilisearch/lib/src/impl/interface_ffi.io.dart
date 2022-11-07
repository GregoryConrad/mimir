import 'dart:ffi';

import 'package:embedded_meilisearch/bridge_generated.dart';
import 'package:embedded_meilisearch/src/interface.dart';

/// Adds ffi wrapper functionality
extension IoFfiMeiliInterface on MeiliInterface {
  /// Creates an [EmbeddedMilli] ffi wrapper
  EmbeddedMilli createWrapper(DynamicLibrary dylib) => EmbeddedMilliImpl(dylib);
}
