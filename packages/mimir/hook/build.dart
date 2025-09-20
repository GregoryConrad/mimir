import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

void main(List<String> args) async {
  await build(args, (input, output) async {
    Logger.root.level = Level.CONFIG;
    final logger = Logger('mimir_build')
      // NOTE: we want to get output for our build logs
      // ignore: avoid_print
      ..onRecord.listen(print)
      ..config(input)
      ..config(Platform.environment);
    final processRunner = ProcessRunner(logger);
    final toolchainResolver = RustToolchainResolver(logger, processRunner);
    final targetResolver = RustTargetResolver(logger, processRunner);

    if (!input.config.buildCodeAssets) {
      logger.info('buildCodeAssets is false, skipping build of native assets');
      return;
    }

    const rustDirName = 'native';
    const cargoPackageName = 'embedded_milli';
    const cargoBuildMode = 'release';
    const codeAssetName = 'src/native/ffi.g.dart';

    final rustPath = path.join(path.fromUri(input.packageRoot), rustDirName);
    final manifestPath = path.join(rustPath, 'Cargo.toml');
    final outputDir = path.join(path.fromUri(input.outputDirectory), 'target');

    // NOTE: re-run build whenever anything in the Rust directory changes
    output.dependencies.add(path.toUri(rustPath));

    final CodeConfig(:targetOS, :targetTriple, :linkMode) = input.config.code;
    final rustToolchainName = await toolchainResolver
        .resolveToolchainForProject(rustPath);
    final installedTargets = await targetResolver
        .resolveInstalledTargetsForToolchain(rustToolchainName);
    if (!installedTargets.contains(targetTriple)) {
      throw RustupBuildException(
        '$targetTriple was not found in the list of installed targets '
        'for $rustToolchainName: $installedTargets. '
        'This may not be a supported target; '
        'if it is, please add it to the rust-toolchain.toml.',
      );
    }

    await processRunner.invokeRustup([
      'run',
      rustToolchainName,
      'cargo',
      'build',
      '--$cargoBuildMode',
      '--manifest-path',
      manifestPath,
      '--package',
      cargoPackageName,
      '--target',
      targetTriple,
      '--target-dir',
      outputDir,
      if ([OS.macOS, OS.iOS].contains(targetOS)) ...[
        '--features',
        'posix-sem',
      ],
    ], environment: createBuildEnvVars(input.config.code));

    output.assets.code.add(
      CodeAsset(
        package: input.packageName,
        name: codeAssetName,
        linkMode: linkMode,
        file: path.toUri(
          path.join(
            outputDir,
            targetTriple,
            cargoBuildMode,
            targetOS.libraryFileName(cargoPackageName, linkMode),
          ),
        ),
      ),
    );
  });
}

class RustupBuildException implements Exception {
  const RustupBuildException(this.message);
  final String message;

  @override
  String toString() => 'RustupBuildException(message: $message)';
}

final class ProcessRunner {
  const ProcessRunner(this.logger);
  final Logger logger;

  Future<String> invoke(
    String executable,
    List<String> arguments, {
    String? workingDirectory,
    Map<String, String>? environment,
  }) async {
    try {
      logger.info(
        'Invoking "$executable $arguments" '
        '${workingDirectory != null ? 'in directory $workingDirectory ' : ''}'
        'with environment: ${environment ?? {}}',
      );
      final result = await Process.run(
        executable,
        arguments,
        environment: environment,
        workingDirectory: workingDirectory,
      );
      if (result.exitCode != 0) {
        throw RustupBuildException(
          'Process finished with non-zero exit code: "$executable $arguments" '
          'with stdout: "${result.stdout}" and stderr: "${result.stderr}"',
        );
      }
      return result.stdout as String;
    } on ProcessException catch (exception, stackTrace) {
      logger.severe(
        'Failed to invoke "$executable $arguments"',
        exception,
        stackTrace,
      );
      rethrow;
    }
  }
}

extension on ProcessRunner {
  Future<String> invokeRustup(
    List<String> arguments, {
    String? workingDirectory,
    Map<String, String>? environment,
  }) async {
    try {
      return await invoke(
        'rustup',
        arguments,
        workingDirectory: workingDirectory,
        environment: environment,
      );
    } on ProcessException {
      throw const RustupBuildException(
        'Failed to invoke rustup; is it installed? '
        'For help installing rust, see https://rustup.rs',
      );
    }
  }
}

final class RustToolchainResolver {
  const RustToolchainResolver(this.logger, this.processRunner);
  final Logger logger;
  final ProcessRunner processRunner;

  Future<String> resolveToolchainForProject(String rustPath) async {
    final showToolchainOutput = await processRunner.invokeRustup([
      'show',
      'active-toolchain',
    ], workingDirectory: rustPath);

    final rustToolchainName = RegExp(
      r'^([^\s]+)\s+\(overridden by',
      multiLine: true,
    ).allMatches(showToolchainOutput).singleOrNull?.group(1);

    if (rustToolchainName == null) {
      logger.severe(
        'Failed to parse active toolchain from output: $showToolchainOutput',
      );
      throw const RustupBuildException(
        'Failed to get the active Rust toolchain. '
        'Are you missing a rust-toolchain.toml, or is it invalid?',
      );
    }

    return rustToolchainName;
  }
}

final class RustTargetResolver {
  const RustTargetResolver(this.logger, this.processRunner);
  final Logger logger;
  final ProcessRunner processRunner;

  /// Returns the list of installed targets for the given [rustToolchain].
  Future<Set<String>> resolveInstalledTargetsForToolchain(
    String rustToolchain,
  ) async {
    final listTargetsOutput = await processRunner.invokeRustup([
      'target',
      'list',
      '--toolchain',
      rustToolchain,
    ]);

    final installedTargets =
        RegExp(r'^([^\s]+)\s+\(installed\)$', multiLine: true)
            .allMatches(listTargetsOutput)
            .map((match) => match.group(1))
            .nonNulls
            .toSet();

    if (installedTargets.isEmpty) {
      logger.warning(
        'No installed targets found for toolchain $rustToolchain.\n'
        'Are the targets properly listed in rust-toolchain.toml?\n'
        'Output: $listTargetsOutput',
      );
    }

    return installedTargets;
  }
}

Map<String, String> createBuildEnvVars(CodeConfig codeConfig) {
  final CodeConfig(:targetOS, :targetTriple, :cCompiler) = codeConfig;
  final targetTripleEnvVar = targetTriple.replaceAll('-', '_');
  final cCompilerBinDir = cCompiler == null
      ? null
      : path.dirname(path.fromUri(cCompiler.compiler));
  return {
    // NOTE: XCode makes some injections into PATH that break host build
    // for crates with a build.rs.
    // See also: https://github.com/irondash/native_toolchain_rust/issues/17
    if (Platform.isMacOS) ...{
      'PATH': Platform.environment['PATH']!
          .split(':')
          .where((e) => !e.contains('Contents/Developer/'))
          .join(':'),
    },

    // TODO(GregoryConrad): remove this work-around for:
    // https://github.com/dart-lang/native/issues/2623
    if (targetOS == OS.macOS &&
        (Platform.environment['PATH']?.contains('/nix/store/') ?? false))
      'CARGO_TARGET_${targetTripleEnvVar.toUpperCase()}_LINKER':
          '/usr/bin/clang',

    // TODO(GregoryConrad): check for NDK >= 27 and expected files existing?
    // inspo: https://github.com/isar/isar/blob/main/tool/build_android.sh
    if (targetOS == OS.android) ...{
      'AR_$targetTripleEnvVar': path.join(
        cCompilerBinDir!,
        OS.current.executableFileName('llvm-ar'),
      ),
      'CC_$targetTripleEnvVar': path.join(
        cCompilerBinDir,
        OS.current.executableFileName('${targetTriple}35-clang'),
      ),
      'CXX_$targetTripleEnvVar': path.join(
        cCompilerBinDir,
        OS.current.executableFileName('${targetTriple}35-clang++'),
      ),
      'CARGO_TARGET_${targetTripleEnvVar.toUpperCase()}_LINKER': path.join(
        cCompilerBinDir,
        OS.current.executableFileName('${targetTriple}35-clang'),
      ),
    },
  };
}

extension on CodeConfig {
  String get targetTriple {
    return switch ((targetOS, targetArchitecture)) {
      // Android
      (OS.android, Architecture.arm64) => 'aarch64-linux-android',
      (OS.android, Architecture.arm) => 'armv7-linux-androideabi',
      (OS.android, Architecture.x64) => 'x86_64-linux-android',

      // iOS
      (OS.iOS, Architecture.arm64)
          when iOS.targetSdk == IOSSdk.iPhoneSimulator =>
        'aarch64-apple-ios-sim',
      (OS.iOS, Architecture.arm64) when iOS.targetSdk == IOSSdk.iPhoneOS =>
        'aarch64-apple-ios',
      (OS.iOS, Architecture.arm64) => throw UnsupportedError(
        'Unknown IOSSdk: ${iOS.targetSdk}',
      ),
      (OS.iOS, Architecture.x64) => 'x86_64-apple-ios',

      // Windows
      (OS.windows, Architecture.arm64) => 'aarch64-pc-windows-msvc',
      (OS.windows, Architecture.x64) => 'x86_64-pc-windows-msvc',

      // Linux
      (OS.linux, Architecture.arm64) => 'aarch64-unknown-linux-gnu',
      (OS.linux, Architecture.x64) => 'x86_64-unknown-linux-gnu',

      // macOS
      (OS.macOS, Architecture.arm64) => 'aarch64-apple-darwin',
      (OS.macOS, Architecture.x64) => 'x86_64-apple-darwin',

      (_, _) => throw UnsupportedError(
        'Unsupported target: $targetOS on $targetArchitecture',
      ),
    };
  }

  LinkMode get linkMode {
    return switch (linkModePreference) {
      LinkModePreference.dynamic ||
      LinkModePreference.preferDynamic => DynamicLoadingBundled(),
      LinkModePreference.static ||
      LinkModePreference.preferStatic => StaticLinking(),
      _ => throw UnsupportedError(
        'Unsupported LinkModePreference: $linkModePreference',
      ),
    };
  }
}
