#!/bin/bash

CURR_VERSION=mimir-v`awk '/^version: /{print $2}' packages/mimir/pubspec.yaml`

# iOS & macOS
APPLE_HEADER="release_tag_name = '$CURR_VERSION' # generated; do not edit"
sed -i.bak "1 s/.*/$APPLE_HEADER/" packages/flutter_mimir/ios/flutter_mimir.podspec
sed -i.bak "1 s/.*/$APPLE_HEADER/" packages/flutter_mimir/macos/flutter_mimir.podspec
rm packages/flutter_mimir/macos/*.bak packages/flutter_mimir/ios/*.bak

# CMake platforms (Linux, Windows, and Android)
CMAKE_HEADER="set(MimirVersion \"$CURR_VERSION\") # generated; do not edit"
for CMAKE_PLATFORM in android linux windows
do
    sed -i.bak "1 s/.*/$CMAKE_HEADER/" packages/flutter_mimir/$CMAKE_PLATFORM/CMakeLists.txt
    rm packages/flutter_mimir/$CMAKE_PLATFORM/*.bak
done

git add packages/flutter_mimir/
