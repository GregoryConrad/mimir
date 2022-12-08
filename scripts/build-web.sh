#!/bin/bash

# Setup
BUILD_DIR=platform-build
mkdir $BUILD_DIR
cd $BUILD_DIR

# Set up wasi-sdk
WASI_SDK_VERSION_TAG=wasi-sdk-17
WASI_SDK_ROOT=wasi-sdk
git clone --recursive --branch $WASI_SDK_VERSION_TAG https://github.com/WebAssembly/wasi-sdk $WASI_SDK_ROOT
(cd $WASI_SDK_ROOT && make package)

# Configure environment variables for cargo build
WASI_SDK_PATH=$WASI_SDK_ROOT/build/install/opt/wasi-sdk
WASI_SDK_PATH=`realpath $WASI_SDK_PATH`
export CC="$WASI_SDK_PATH/bin/clang -D_WASI_EMULATED_MMAN --sysroot=$WASI_SDK_PATH/share/wasi-sysroot"
export LLD="$WASI_SDK_PATH/bin/lld -lwasi-emulated-mman"
export LD="$LLD"
export AR="$WASI_SDK_PATH/bin/llvm-ar"
export NM="$WASI_SDK_PATH/bin/llvm-nm"

# Build for web
TARGET=wasm32-wasi
rustup target add $TARGET
cargo build -r --target=$TARGET
cp ../target/wasm32-wasi/release/embedded_milli.wasm .

# Cleanup
# TODO uncomment following once done with testing
# rm -rf $WASI_SDK_ROOT