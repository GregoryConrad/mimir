#!/bin/bash

# Setup
BUILD_DIR=platform-build
mkdir $BUILD_DIR
cd $BUILD_DIR

# Set up WASI Libc sysroot
LLVM_BIN="/opt/homebrew/opt/llvm/bin"
WASI_VERSION_TAG="wasi-sdk-19"
WASI_LIBC_ROOT=wasi-libc
git clone --recursive https://github.com/WebAssembly/wasi-libc $WASI_LIBC_ROOT
(
    cd $WASI_LIBC_ROOT &&
    git checkout $WASI_VERSION_TAG &&
    make CC=$LLVM_BIN/clang AR=$LLVM_BIN/llvm-ar NM=$LLVM_BIN/llvm-nm THREAD_MODEL=posix
)

# Configure environment variables for cargo build
WASI_LIBC_ROOT=`realpath $WASI_LIBC_ROOT`
export CC="$LLVM_BIN/clang -D_WASI_EMULATED_MMAN -D_WASI_EMULATED_SIGNAL -D_WASI_EMULATED_GETPID --sysroot=$WASI_LIBC_ROOT/sysroot"
export LLD="$LLVM_BIN/lld -lwasi-emulated-mman -lwasi-emulated-signal -lwasi-emulated-getpid"
export LD="$LLD"
export AR="$LLVM_BIN/llvm-ar"
export NM="$LLVM_BIN/llvm-nm"

# Build for web
TARGET=wasm32-wasi
rustup target add $TARGET
cargo build -r --target=$TARGET --features posix-sem
cp ../target/wasm32-wasi/release/embedded_milli.wasm .
