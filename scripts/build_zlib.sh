#!/bin/bash
VERSION="1.2.11"

cd $SOURCE_DIR

if [ ! -d "zlib-$VERSION" ]; then
    wget "https://zlib.net/fossils/zlib-$VERSION.tar.gz"
    tar -zxf zlib-$VERSION.tar.gz
    rm zlib-$VERSION.tar.gz
fi

cd zlib-$VERSION

CHOST=mipsel CC=$TOOLCHAIN-gcc \
AR=$TOOLCHAIN-ar \
RANLIB=$TOOLCHAIN-ranlib \
./configure --prefix=$BUILD_PREFIX

make && make install