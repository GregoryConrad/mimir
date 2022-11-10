import 'dart:ffi';

import 'package:mimir/bridge_generated.dart';

typedef ExternalLibrary = DynamicLibrary;

EmbeddedMilli createWrapperImpl(ExternalLibrary dylib) =>
    EmbeddedMilliImpl(dylib);
