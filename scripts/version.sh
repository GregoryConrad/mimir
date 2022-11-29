#!/bin/bash

CURR_VERSION=mimir-v`awk '/^version: /{print $2}' packages/mimir/pubspec.yaml`

# Android
ANDROID_HEADER="def releaseTagVersion = '$CURR_VERSION' \/\/ generated; do not edit"
sed -i.bak "1 s/.*/$ANDROID_HEADER/" packages/flutter_mimir/android/build.gradle
rm packages/flutter_mimir/android/*.bak

# iOS & macOS
APPLE_HEADER="release_tag_name = '$CURR_VERSION' # generated; do not edit"
sed -i.bak "1 s/.*/$APPLE_HEADER/" packages/flutter_mimir/ios/flutter_mimir.podspec
sed -i.bak "1 s/.*/$APPLE_HEADER/" packages/flutter_mimir/macos/flutter_mimir.podspec
rm packages/flutter_mimir/macos/*.bak packages/flutter_mimir/ios/*.bak

# Linux
LINUX_HEADER="set(MimirVersion \"$CURR_VERSION\") # generated; do not edit"
sed -i.bak "1 s/.*/$LINUX_HEADER/" packages/flutter_mimir/linux/CMakeLists.txt
rm packages/flutter_mimir/linux/*.bak

git add packages/flutter_mimir/
