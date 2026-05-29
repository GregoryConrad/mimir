import 'package:mimir/mimir.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as pp;

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
      return getInstance(path: path);
    } on pp.MissingPlatformDirectoryException {
      throw UnsupportedError(
        'Looks like this platform does not have an application support '
        'directory. Please call Mimir.getInstance() instead.',
      );
    }
  }
}
