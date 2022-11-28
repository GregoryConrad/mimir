#!/bin/bash

# Setup
BUILD_DIR=platform-build
mkdir $BUILD_DIR
cd $BUILD_DIR

# Create aar build directory
AAR_DIR=aar
JNI_DIR=$AAR_DIR/jni
mkdir -p $JNI_DIR

# Set up cargo-ndk
cargo install cargo-ndk
rustup target add \
        aarch64-linux-android \
        armv7-linux-androideabi \
        x86_64-linux-android \
        i686-linux-android

# Build the android libraries in the aar directory
cargo ndk -o $JNI_DIR \
        --manifest-path ../Cargo.toml \
        -t armeabi-v7a \
        -t arm64-v8a \
        -t x86 \
        -t x86_64 \
        build --release 

# Add the required AndroidManifest.xml to the aar directory
cat << EOF > $AAR_DIR/AndroidManifest.xml
<?xml version="1.0" encoding="utf-8"?>
<manifest package="com.gsconrad.embedded_milli" />
EOF

# Create the aar (which is actually just a zip)
cd $AAR_DIR
zip -r ../EmbeddedMilli.aar *
cd -

# Cleanup
rm -rf $AAR_DIR
