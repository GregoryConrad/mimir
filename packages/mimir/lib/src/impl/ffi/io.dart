import 'dart:ffi';

import 'package:mimir/src/bridge_generated.dart';

typedef ExternalLibrary = DynamicLibrary;

EmbeddedMilli createWrapperImpl(ExternalLibrary dylib) =>
    EmbeddedMilliImpl(dylib);
