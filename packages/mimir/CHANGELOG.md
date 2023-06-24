## 0.0.1

 - Graduate package to a stable release. See pre-releases prior to this version for changelog entries.

## 0.0.1-dev.13

 - **FIX**: switch initial version of milli to latest with needed changes ([#83](https://github.com/GregoryConrad/mimir/issues/83)). ([c76b1469](https://github.com/GregoryConrad/mimir/commit/c76b14697a915f1284fa68b705244feb9d1eb828))
 - **FEAT**: add isNull and isEmpty filters ([#215](https://github.com/GregoryConrad/mimir/issues/215)). ([4752aaa1](https://github.com/GregoryConrad/mimir/commit/4752aaa10f2926e72395aade31679bad6d8302d6))

## 0.0.1-dev.12

> Note: This release has breaking changes.

 - **BREAKING** **FEAT**: Dart 3 support ([#194](https://github.com/GregoryConrad/mimir/issues/194)). ([b987daca](https://github.com/GregoryConrad/mimir/commit/b987daca1a48bbec3fdd815f01b0bb1a62f31bd8))

## 0.0.1-dev.11

 - **REVERT**: "feat: use Dart 3 records for isBetween query field ([#140](https://github.com/GregoryConrad/mimir/issues/140))". ([922debf2](https://github.com/GregoryConrad/mimir/commit/922debf2896fcac5839b9f50e34c8e0daaf5c18b))
 - **FEAT**: pagination and infinite scroll support ([#195](https://github.com/GregoryConrad/mimir/issues/195)). ([293db82b](https://github.com/GregoryConrad/mimir/commit/293db82b9af97c86cb18bb9bd393bf3195bee0e0))
 - **FEAT**: use Dart 3 records for isBetween query field ([#140](https://github.com/GregoryConrad/mimir/issues/140)). ([115ab5e4](https://github.com/GregoryConrad/mimir/commit/115ab5e42d8e70fada062de35b6747843e8d6cd9))

## 0.0.1-dev.10

 - **FIX**: milli update and fixes ([#189](https://github.com/GregoryConrad/mimir/issues/189)). ([d3511566](https://github.com/GregoryConrad/mimir/commit/d35115661929bdf93251840fe921ca986a7fb446))

## 0.0.1-dev.9

 - **FIX**: android tmp files now use application cache dir ([#184](https://github.com/GregoryConrad/mimir/issues/184)). ([7504e2e3](https://github.com/GregoryConrad/mimir/commit/7504e2e30fb88a96ebc461fbae8003c87b696121))

## 0.0.1-dev.8

 - **FIX**: add (unused) uuid dependency. ([67a15a91](https://github.com/GregoryConrad/mimir/commit/67a15a913a23d3f6a3a666a5fd3905a813d8fdb8))

## 0.0.1-dev.7

 - **FEAT**: add manual primary key selection ([#157](https://github.com/GregoryConrad/mimir/issues/157)). ([714533b5](https://github.com/GregoryConrad/mimir/commit/714533b5b2f5b943323bf7ba495f757c7707127d))

## 0.0.1-dev.6

 - **REFACTOR**: update melos to v3 ([#131](https://github.com/GregoryConrad/mimir/issues/131)). ([0c6c2b8b](https://github.com/GregoryConrad/mimir/commit/0c6c2b8ba013ec6e56e869d498e246cce3cf923b))
 - **REFACTOR**: switch API to use proper OOP. ([66a2846a](https://github.com/GregoryConrad/mimir/commit/66a2846a6f88fd48f57a5c7002aacdbdbdeb0e1d))
 - **DOCS**: improve quality of examples ([#150](https://github.com/GregoryConrad/mimir/issues/150)). ([5bcbf664](https://github.com/GregoryConrad/mimir/commit/5bcbf664d7e1ac361e3fb6554eb6553a75cfca81))

## 0.0.1-dev.5

 - **REFACTOR**: move macOS C codegen back to FRB.
 - **FIX**: remove pubspec screenshot attribute.

## 0.0.1-dev.4

 - **DOCS**: fix pub.dev screenshot.

## 0.0.1-dev.3

 - **DOCS**: update with in-repo demo gif.

## 0.0.1-dev.2

 - **REFACTOR**: clean up some of the example code.
 - **FIX**: make macos example app work with flutter 3.7.
 - **DOCS**: clarify some wording.

## 0.0.1-dev.1

 - **FIX**: update to use latest milli api.
 - **FIX**: remove the invalid id (from video) TODO.

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
