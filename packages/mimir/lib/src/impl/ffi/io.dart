import 'dart:ffi';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:mimir/src/bridge_generated.dart';

/// Represents the external library for mimir
///
/// Will be a DynamicLibrary for dart:io or WasmModule for dart:html
typedef ExternalLibrary = DynamicLibrary;

@internal
// ignore: public_member_api_docs
EmbeddedMilli createWrapperImpl(ExternalLibrary dylib) =>
    EmbeddedMilliImpl(dylib);

/// Needed by https://github.com/GregoryConrad/mimir/issues/170
@internal
String? tmpDir() => Platform.isAndroid ? Directory.systemTemp.path : null;
