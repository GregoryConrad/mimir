# Contributing
## Dependencies
It is highly recommended to use the provided `flake.nix`, as this is what I use for development.
In other words, install nix + direnv and everything will "just work".

However, for manually settings things up:
- [Flutter](https://docs.flutter.dev/get-started/install)
- [Melos](https://melos.invertase.dev)
  - `dart pub global activate melos`
  - Run `melos bs` in the project root once installed
- [rustup](https://rustup.rs)
- To build the Flutter binaries (which you only need to do if you choose to run Flutter integration tests locally):
  - [Android NDK](https://developer.android.com/ndk/downloads)
    - NDK version 25 (`r25b`)
  - llvm (with `clang-cl`!)
    - Need to run `brew install llvm` on macOS since Apple's doesn't have it
