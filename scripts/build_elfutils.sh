#!/bin/bash
set -e

VERSION="0.192"

cd "$SOURCE_DIR"

if [ ! -d "elfutils-$VERSION" ]; then
  wget "https://sourceware.org/elfutils/ftp/$VERSION/elfutils-$VERSION.tar.bz2"
  tar -xf elfutils-$VERSION.tar.bz2
  rm elfutils-$VERSION.tar.bz2
fi

cd elfutils-$VERSION

./configure \
  --prefix="$BUILD_PREFIX" \
  --host=mipsel-buildroot-linux-gnu \
  --build=x86_64-pc-linux-gnu \
  LDFLAGS="-L$BUILD_PREFIX/lib -Wl,-rpath,$BUILD_PREFIX/lib/" \
  LIBS="-l:libz.so" \
  CC="$TOOLCHAIN-gcc" \
  CFLAGS="-I$BUILD_PREFIX/include" \
  CXX="$TOOLCHAIN-g++"
  CXXFLAGS="$CFLAGS"

make -j$COMPILE_CORES && make install

#make PREFIX=$BUILD_PREFIX install
