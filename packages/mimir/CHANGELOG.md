## 0.0.1-dev.0

 - **REFACTOR**: switch macOS and iOS build to use C generation.
 - **REFACTOR**: auto filter/sortby cleanup.
 - **REFACTOR**: refactor to use all_obkv_to_json.
 - **REFACTOR**: update rust code with suggestions from clippy.
 - **REFACTOR**: remove obkv dependency.
 - **REFACTOR**: move generated ffi files to src dir.
 - **REFACTOR**: switched over to parking_lot.
 - **REFACTOR**: clean up some cargo dependencies.
 - **PERF**: remove old macros and improve concurrency support.
 - **FIX**: search method contains true optional args.
 - **FIX**: switch Rust build script to copy ios gen c files to macos.
 - **FIX**: switch to POSIX semaphores for App Sandbox ([#100](https://github.com/GregoryConrad/mimir/issues/100)).
 - **FIX**: adding invalid documents throws exception instead of silently failing.
 - **FIX**: fix ci build failures by updating frb to 1.53.
 - **FIX**: increase the max db size.
 - **FIX**: no more autogenerate id & set_documents fix.
 - **FIX**: do not fail build on format fail.
 - **FIX**: fix dylib path in another test.
 - **FIX**: refactored repo to use root Cargo.toml.
 - **FIX**: update pubspec.yaml to meet pub.dev guidelines.
 - **FIX**: default resultsLimit to u32::MAX.
 - **FIX**: add android ffi support ([#58](https://github.com/GregoryConrad/mimir/issues/58)).
 - **FIX**: cocoapod source distribution ([#56](https://github.com/GregoryConrad/mimir/issues/56)).
 - **FIX**: add proper rust support for macOS/iOS ([#44](https://github.com/GregoryConrad/mimir/issues/44)).
 - **FEAT**: add automatic sortable fields.
 - **FEAT**: support for migration between milli versions ([#79](https://github.com/GregoryConrad/mimir/issues/79)).
 - **FEAT**: added convenience method updateSettings.
 - **FEAT**: add automatic filterable fields ([#60](https://github.com/GregoryConrad/mimir/issues/60)).
 - **FEAT**: Add filter convenience ([#45](https://github.com/GregoryConrad/mimir/issues/45)).
 - **DOCS**: added inline documentation for some ffi types.
 - **DOCS**: update package description to make pub.dev happy.
 - **DOCS**: update the changelog to remove previous commits.

## 0.0.0

 - Graduate package to a stable release. See pre-releases prior to this version for changelog entries.

## 0.0.0-dev.5

 - **FIX**: fix dylib path in another test.
 - **FIX**: refactored repo to use root Cargo.toml.

## 0.0.0-dev.4

 - **REFACTOR**: move generated ffi files to src dir.
 - **DOCS**: added inline documentation for some ffi types.

## 0.0.0-dev.3

 - **DOCS**: update package description to make pub.dev happy.

## 0.0.0-dev.2

 - **FIX**: update pubspec.yaml to meet pub.dev guidelines.

## 0.0.0-dev.1

 - **DOCS**: update the changelog to remove previous commits.

## 0.0.0
Initial codebase
