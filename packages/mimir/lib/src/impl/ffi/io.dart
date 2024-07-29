import 'dart:ffi';
import 'dart:io';

import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:meta/meta.dart';
import 'package:mimir/src/frb_generated.dart';

@internal
// ignore: public_member_api_docs
Future<RustLibApi> createWrapperImpl(String dylibPath) async {
  await RustLib.init(externalLibrary: ExternalLibrary.open(dylibPath));
  return RustLib.instance.api;
}

/// Needed by https://github.com/GregoryConrad/mimir/issues/170
@internal
String? tmpDir() => Platform.isAndroid ? Directory.systemTemp.path : null;
