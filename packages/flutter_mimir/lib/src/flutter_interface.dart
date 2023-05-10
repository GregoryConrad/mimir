import 'package:flutter_mimir/flutter_mimir.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as pp;

// ignore: always_use_package_imports
import 'ffi/stub.dart'
    if (dart.library.io) 'ffi/io.dart'
    if (dart.library.html) 'ffi/web.dart';

/// Flutter extensions for the MimirInterface to make it easier to work with
extension FlutterMimirInterface on MimirInterface {
  /// Creates the default [MimirInstance] instance for Flutter
  Future<MimirInstance> get defaultInstance {
    const defaultName = 'default';
    return getInstanceForName(defaultName);
  }

  /// Creates a [MimirInstance] with the given path-friendly [name] for Flutter
  Future<MimirInstance> getInstanceForName(String name) async {
    try {
      const defaultSubDir = 'mimir';
      final appSupportDir = await pp.getApplicationSupportDirectory();
      final path = p.join(appSupportDir.path, defaultSubDir, name);
      return getInstanceForPath(path);
    } on pp.MissingPlatformDirectoryException {
      throw UnsupportedError(
        'Looks like this platform does not have an application support '
        'directory. Please call Mimir.getInstanceForPath(someDirPath) instead.',
      );
    }
  }

  /// Creates a [MimirInstance] from the given path for Flutter
  Future<MimirInstance> getInstanceForPath(String path) =>
      getInstance(path: path, library: createLibraryImpl());
}
