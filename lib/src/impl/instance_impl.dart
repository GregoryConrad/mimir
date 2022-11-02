part of '../instance.dart';

class _MeiliInstanceImpl with MeiliInstance {
  static Future<_MeiliInstanceImpl> getInstance(
    String name, [
    String? path,
  ]) async {
    // Create the directory for this instance
    if (path == null) {
      try {
        final appSupportDir = await pp.getApplicationSupportDirectory();
        path = p.join(appSupportDir.path, 'embedded_meili', name);
        await Directory(path).create();
      } on pp.MissingPlatformDirectoryException {
        throw UnsupportedError(
          'Looks like this platform does not have an application support '
          'directory. Please call '
          'MeiliInstance.getInstance(\'$name\', someWriteableDir) '
          'manually.',
        );
      }
    }

    // TODO do initialization of the rust thread for this instance path and name

    return _MeiliInstanceImpl._(name, path);
  }

  const _MeiliInstanceImpl._(this.name, this.path);

  @override
  final String name;

  @override
  final String path;

  // TODO milli version/dumps?

  @override
  Future<MeiliIndex> getIndex(String name) => MeiliIndex.from(this, name);
}
