# Contributing
This file is a WIP.

## Dependencies
- [Flutter](https://docs.flutter.dev/get-started/install)
- [rustup](https://rustup.rs)
  - Run `cargo build -r` in the project root once installed
    - Needed for the Dart tests to run
- [Melos](https://melos.invertase.dev)
  - `dart pub global activate melos`
  - Run `melos bs` in the project root once installed
- To build the Flutter binaries (which you only need to do if you choose to run Flutter integration tests locally):
  - macOS (at least for `build-apple.sh`)
  - [Android NDK](https://developer.android.com/ndk/downloads)
    - API level 21 (`r21e`)
  - [Zig](https://ziglang.org/learn/getting-started/#installing-zig)
  - llvm (with `clang-cl`!)
    - Need to run `brew install llvm` on macOS since Apple's doesn't have it
  - ninja
    - Need to run `brew install ninja` on macOS
  - cmake
    - Need to run `brew install cmake` on macOS
