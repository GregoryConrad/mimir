import 'dart:io';

import 'package:meta/meta.dart';

/// Needed by https://github.com/GregoryConrad/mimir/issues/170
@internal
String? tmpDir() => Platform.isAndroid ? Directory.systemTemp.path : null;
