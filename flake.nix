{
  description = "Mimir";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      utils,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        formatter = pkgs.nixfmt-tree;

        devShells = {
          default = pkgs.mkShell {
            packages = with pkgs; [
              flutter
              rustup
              buf
              protoc-gen-dart
              protoc-gen-prost
              llvmPackages_20.clangUseLLVM
            ];

            env = {
              RUST_BACKTRACE = "1";
              FLUTTER_ROOT = "${pkgs.flutter}";
            };

            shellHook = ''
              export PATH=$HOME/.pub-cache/bin:$PATH
              dart pub global activate melos
            '';
          };

          android =
            let
              arch = builtins.head (builtins.split "-" system);
              androidEnv = pkgs.androidenv.override { licenseAccepted = true; };
              androidComposition = androidEnv.composeAndroidPackages {
                platformVersions = [
                  "35"
                  "36"
                ];
                buildToolsVersions = [ "35.0.0" ];
                cmakeVersions = [ "3.22.1" ];
                includeNDK = true;
                ndkVersions = [ "27.0.12077973" ];

                # For the emulator:
                includeEmulator = true;
                includeSystemImages = true;
                systemImageTypes = [ "default" ];
                abiVersions = [
                  {
                    "x86_64" = "x86_64";
                    "aarch64" = "arm64-v8a";
                  }
                  .${arch} or (throw "Unsupported architecture: ${arch}")
                ];
              };
            in
            pkgs.mkShell {
              packages = with pkgs; [
                androidComposition.androidsdk
                jdk17
              ];

              env = rec {
                ANDROID_HOME = "${androidComposition.androidsdk}/libexec/android-sdk";
                ANDROID_NDK_ROOT = "${ANDROID_HOME}/ndk-bundle";
              };
            };
        };
      }
    );
}
