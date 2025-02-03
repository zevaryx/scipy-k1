#!/bin/bash
set -e

VERSION="1.1.1g"

cd $SOURCE_DIR

if [ ! -d "openssl-$VERSION" ]; then
    wget "https://github.com/openssl/openssl/releases/download/OpenSSL_${VERSION//./_}/openssl-$VERSION.tar.gz"
    tar -xzf "openssl-$VERSION.tar.gz"
    rm "openssl-$VERSION.tar.gz"
fi

cd "openssl-$VERSION"

./Configure linux-mips32 shared \
    --prefix=$BUILD_PREFIX \
    --openssldir=$BUILD_PREFIX

make CC=$TOOLCHAIN-gcc RANLIB=$TOOLCHAIN-ranlib LD=$TOOLCHAIN-ld MAKEDEPPROG=$TOOLCHAIN-gcc PROCESSOR=MIPSEL -j$(($(nproc)-1)) && make install
