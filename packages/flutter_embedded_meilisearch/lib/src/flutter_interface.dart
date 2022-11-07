import 'package:flutter_embedded_meilisearch/flutter_embedded_meilisearch.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as pp;

/// Flutter extensions for the MeiliInterface to make it easier to work with
extension FlutterMeiliInterface on MeiliInterface {
  /// Creates the default MeiliInstance instance for Flutter
  Future<MeiliInstance> get defaultInstance {
    const defaultName = 'default';
    return getInstanceForName(defaultName);
  }

  /// Creates a MeiliInstance with the given path-friendly name for Flutter
  Future<MeiliInstance> getInstanceForName(String name) async {
    try {
      const defaultSubDir = 'embedded_meili';
      final appSupportDir = await pp.getApplicationSupportDirectory();
      final path = p.join(appSupportDir.path, defaultSubDir, name);
      return getInstanceForPath(path);
    } on pp.MissingPlatformDirectoryException {
      throw UnsupportedError(
        'Looks like this platform does not have an application support '
        'directory. Please call Meili.getInstanceForPath(someDirPath) instead.',
      );
    }
  }

  /// Creates a MeiliInstance from the given path for Flutter
  MeiliInstance getInstanceForPath(String path) =>
      getInstance(path: path, milli: createFlutterWrapper());
}
