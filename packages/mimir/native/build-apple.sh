#!/bin/bash

# Builds the Rust code for Apple platforms and places static libs
# in the proper directories
 
BUILDDIR=$( dirname -- "$0"; )
LIBNAME=libembedded_milli.a

cd $BUILDDIR

# iOS
OUTDIR=$BUILDDIR/../../flutter_mimir/ios
for TARGET in aarch64-apple-ios x86_64-apple-ios aarch64-apple-ios-sim
do
rustup target add $TARGET
cargo build -r --target=$TARGET
COPY_TO=$OUTDIR/target/$TARGET/release/
mkdir -p $COPY_TO
cp target/$TARGET/release/$LIBNAME $COPY_TO
done

# macOS
OUTDIR=$BUILDDIR/../../flutter_mimir/macos
for TARGET in x86_64-apple-darwin aarch64-apple-darwin
do
rustup target add $TARGET
cargo build -r --target=$TARGET
COPY_TO=$OUTDIR/target/$TARGET/release/
mkdir -p $COPY_TO
cp target/$TARGET/release/$LIBNAME $COPY_TO
done
