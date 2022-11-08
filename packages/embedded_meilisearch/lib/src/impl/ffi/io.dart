import 'dart:ffi';

import 'package:embedded_meilisearch/bridge_generated.dart';

typedef ExternalLibrary = DynamicLibrary;

EmbeddedMilli createWrapperImpl(ExternalLibrary dylib) =>
    EmbeddedMilliImpl(dylib);
