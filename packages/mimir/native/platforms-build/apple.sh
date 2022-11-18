#!/bin/bash

# Build static libs
cd $( dirname -- "$0"; )
cd ..
for TARGET in \
        aarch64-apple-ios x86_64-apple-ios aarch64-apple-ios-sim \
        x86_64-apple-darwin aarch64-apple-darwin
do
    rustup target add $TARGET
    cargo build -r --target=$TARGET
done

# Create XCFramework
FRAMEWORK="EmbeddedMilli.xcframework"
LIBNAME=libembedded_milli.a
mkdir mac-lipo ios-sim-lipo
IOS_SIM_LIPO=ios-sim-lipo/$LIBNAME
MAC_LIPO=mac-lipo/$LIBNAME
lipo -create -output $IOS_SIM_LIPO \
        target/aarch64-apple-ios-sim/release/$LIBNAME \
        target/x86_64-apple-ios/release/$LIBNAME
lipo -create -output $MAC_LIPO \
        target/aarch64-apple-darwin/release/$LIBNAME \
        target/x86_64-apple-darwin/release/$LIBNAME
xcodebuild -create-xcframework \
        -library $IOS_SIM_LIPO \
        -library $MAC_LIPO \
        -library target/aarch64-apple-ios/release/$LIBNAME \
        -output $FRAMEWORK
rm -rf ios-sim-lipo mac-lipo

# Copy XCFramework to macOS and iOS folders
for OS in macos ios
do
mkdir ../../flutter_mimir/$OS/Frameworks
cp -r $FRAMEWORK ../../flutter_mimir/$OS/Frameworks/
done

# Delete the intermediary XCFramework
rm -rf $FRAMEWORK
