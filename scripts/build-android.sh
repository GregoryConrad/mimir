#!/bin/bash

# Setup
BUILD_DIR=platform-build
mkdir $BUILD_DIR
cd $BUILD_DIR || exit

# Create the jniLibs build directory
JNI_DIR=jniLibs
mkdir -p $JNI_DIR

# Set up cargo-ndk
cargo install cargo-ndk --locked

# Add targets
rustup target add \
  aarch64-linux-android \
  armv7-linux-androideabi \
  x86_64-linux-android \
  i686-linux-android

# Build the android libraries in the jniLibs directory
if [ "$#" -eq 0 ]; then
  cargo ndk -o $JNI_DIR \
    --manifest-path ../Cargo.toml \
    -t armeabi-v7a \
    -t arm64-v8a \
    -t x86 \
    -t x86_64 \
    build --release
  # Archive the dynamic libs
  cd $JNI_DIR || exit
  tar -czvf ../EmbeddedMilliAndroid.tar.gz ./*
  cd - || exit
  # Cleanup
  rm -rf $JNI_DIR
elif [ "$1" = "x86" ]; then
  cargo ndk -o $JNI_DIR --manifest-path ../Cargo.toml -t x86 build --release
elif [ "$1" = "x64" ]; then
  cargo ndk -o $JNI_DIR --manifest-path ../Cargo.toml -t x86_64 build --release
elif [ "$1" = "armv7" ]; then
  cargo ndk -o $JNI_DIR --manifest-path ../Cargo.toml -t armeabi-v7a build --release
elif [ "$1" = "arm64" ]; then
  cargo ndk -o $JNI_DIR --manifest-path ../Cargo.toml -t arm64-v8a build --release
else
  echo "Invalid architecture: '$1'"
fi
