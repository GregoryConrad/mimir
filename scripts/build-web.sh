#!/bin/bash

# Setup
BUILD_DIR=platform-build
mkdir $BUILD_DIR
cd $BUILD_DIR

# Build for web
TARGET=wasm32-wasi
rustup target add $TARGET
cargo build -r --target=$TARGET
cp ../target/wasm32-wasi/release/embedded_milli.wasm .
