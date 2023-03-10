# Contributing
This file is a WIP.

## Dependencies
- [Flutter](https://docs.flutter.dev/get-started/install)
- [Melos](https://melos.invertase.dev)
  - `dart pub global activate melos`
  - Run `melos bs` in the project root once installed
- [rustup](https://rustup.rs)
  - Run `cargo build -r` in the project root once installed
    - Needed for the Dart tests to run
- To build the Flutter binaries (which you only need to do if you choose to run Flutter integration tests locally):
  - macOS (at least for `build-apple.sh`)
  - [Android NDK](https://developer.android.com/ndk/downloads)
    - NDK version 25 (`r25b`)
  - [Zig](https://ziglang.org/learn/getting-started/#installing-zig)
  - llvm (with `clang-cl`!)
    - Need to run `brew install llvm` on macOS since Apple's doesn't have it
