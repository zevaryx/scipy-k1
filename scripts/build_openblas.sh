#!/bin/bash
set -e

VERSION="0.3.29"

cd "$SOURCE_DIR"

if [ ! -d "OpenBLAS-$VERSION" ]; then
    echo "Downloading OpenBLAS..."
    wget "https://github.com/OpenMathLib/OpenBLAS/releases/download/v$VERSION/OpenBLAS-$VERSION.tar.gz"
    tar -xzf OpenBLAS-$VERSION.tar.gz
    rm OpenBLAS-$VERSION.tar.gz
fi

cd OpenBLAS-$VERSION

echo "Building OpenBLAS..."

make BINARY=32 BINARY32=1 \
    CC=$TOOLCHAIN-gcc \
    AR=$TOOLCHAIN-ar \
    FC="$TOOLCHAIN-gfortran -EL" \
    RANLIB=$TOOLCHAIN-ranlib \
    HOSTCC=gcc CFLAGS="-EL" \
    FFLAGS=$CFLAGS \
    LDFLAGS=$CFLAGS \
    TARGET=P5600

make PREFIX="$BUILD_PREFIX" install