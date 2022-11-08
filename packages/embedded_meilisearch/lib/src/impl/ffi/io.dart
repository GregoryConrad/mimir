import 'dart:ffi';

import 'package:embedded_meilisearch/bridge_generated.dart';

EmbeddedMilli createWrapperImpl(DynamicLibrary dylib) =>
    EmbeddedMilliImpl(dylib);
