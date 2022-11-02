part of '../instance.dart';

class _MeiliInstanceImpl with MeiliInstance {
  static Future<_MeiliInstanceImpl> from(String name, String path) async {
    // Create the directory for this instance
    await Directory(path).create();

    // TODO do initialization in rust for this instance
    //  https://github.com/fzyzcjy/flutter_rust_bridge/issues/252#issuecomment-1002322865

    return _MeiliInstanceImpl._(name, path);
  }

  const _MeiliInstanceImpl._(this.name, this.path);

  @override
  final String name;

  @override
  final String path;

  @override
  Future<MeiliIndex> getIndex(String name) => MeiliIndex.from(this, name);
}
