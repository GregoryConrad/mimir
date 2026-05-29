import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:logging/logging.dart';
import 'package:native_toolchain_rust/native_toolchain_rust.dart';

void main(List<String> args) async {
  Logger.root.level = Level.CONFIG;

  await build(args, (input, output) async {
    // NOTE: we want to get output for our build logs
    // ignore: avoid_print
    final logger = Logger('mimir_build')..onRecord.listen(print);

    final isAppleOS = [OS.macOS, OS.iOS].contains(input.config.code.targetOS);

    await RustBuilder(
      assetName: 'src/native/ffi.g.dart',
      features: [
        if (isAppleOS) 'posix-sem',
      ],
    ).run(
      input: input,
      output: output,
      logger: logger,
    );
  });
}
