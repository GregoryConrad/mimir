import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';

void main(List<String> args) async {
  await build(args, (input, output) async {
    if (!input.config.buildCodeAssets) return;

    print(input);
    // final packageName = input.packageName;
    // input.userDefines;

    final CodeConfig(:targetOS, :targetArchitecture, :linkModePreference) =
        input.config.code;
    // final targetTriple = switch ((codeConfig.targetArchitecture, codeConfig.targetOS)) {
    //   (Architecture.arm64, OS.macOS) => '',
    //   // TODO: Handle this case.
    //   (_, _) => throw UnsupportedError('Unsupported OS + architecture combination: ${codeConfig.targetOS} ${codeConfig.targetArchitecture}'),
    // }

    final linkMode = switch (linkModePreference) {
      LinkModePreference.dynamic ||
      LinkModePreference.preferDynamic => DynamicLoadingBundled(),
      LinkModePreference.static ||
      LinkModePreference.preferStatic => StaticLinking(),
      _ => throw UnsupportedError(
        'Unsupported LinkModePreference: $linkModePreference',
      ),
    };

    // input.config.linkingEnabled;

    final cargoManifestPath = 'native/Cargo.toml'; // TODO use path package
    // TODO grab from Cargo.toml
    // TODO grab rust version from Cargo.toml
    final packageName = 'embedded_milli';

    // TODO NDK shit (and check min/max version)
    final result = await Process.run('cargo', [
      'build',
      '--release',
      '--manifest-path',
      input.packageRoot.resolve(cargoManifestPath).toFilePath(),
      '--package',
      packageName,
      // '--target',
      // '',
      '--target-dir',
      input.outputDirectory.resolve('target').toFilePath(),
      // '--features',
      // TODO posix sem on apple OS
    ]);
    if (result.exitCode != 0) {
      // TODO look for:
      // - cargo not found
      // - target triple not added
      // and provide suggested remediation for both
      throw result.stderr.toString();
    }

    output.assets.code.add(
      CodeAsset(
        package: input.packageName,
        name: packageName,
        linkMode: linkMode,
        file: input.outputDirectory.resolve(
          // TODO use path package + target triple
          'target/release/${targetOS.libraryFileName(packageName, linkMode)}',
        ),
      ),
    );

    // TODO add dependency on rust files
    // throw 'hi';
  });
}

/*
 {
  "assets": {},
  "config": {
    "build_asset_types": [
      "code_assets/code",
      "data_assets/data"
    ],
    "extensions": {
      "code_assets": {
        "link_mode_preference": "dynamic",
        "macos": {
          "target_version": 12
        },
        "target_architecture": "arm64",
        "target_os": "macos"
      }
    },
    "linking_enabled": false
  },
  "out_dir_shared": "/Users/gconrad/dev/mimir/.dart_tool/hooks_runner/shared/mimir/build/",
  "out_file": "/Users/gconrad/dev/mimir/.dart_tool/hooks_runner/mimir/221e109fbc3eff0a4ea2e8de78e6803e/output.json",
  "package_name": "mimir",
  "package_root": "/Users/gconrad/dev/mimir/packages/mimir/",
  "user_defines": {}
}

 {
  "assets": {},
  "config": {
    "build_asset_types": [
      "code_assets/code"
    ],
    "extensions": {
      "code_assets": {
        "c_compiler": {
          "ar":
          "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolcha
          in/usr/bin/ar",
          "cc":
          "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolcha
          in/usr/bin/clang",
          "ld":
          "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolcha
          in/usr/bin/ld"
        },
        "link_mode_preference": "dynamic",
        "macos": {
          "target_version": 13
        },
        "target_architecture": "arm64",
        "target_os": "macos"
      }
    },
    "linking_enabled": false
  },
  "out_dir_shared":
  "/Users/gconrad/dev/mimir/.dart_tool/hooks_runner/shared/mimir/build/",
  "out_file":
  "/Users/gconrad/dev/mimir/.dart_tool/hooks_runner/mimir/7ad245dadc068daf8ba9d7bb51a8e
  f8e/output.json",
  "package_name": "mimir",
  "package_root": "/Users/gconrad/dev/mimir/packages/mimir/",
  "user_defines": {}
}
*/
