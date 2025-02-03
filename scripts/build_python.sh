#!/bin/bash
set -e

VERSION="3.8.2"

cd $SOURCE_DIR

if [ ! -d "Python-$VERSION" ]; then
  wget "https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tgz"
  tar -xzf "Python-$VERSION.tgz"
  rm "Python-$VERSION.tgz"
fi

cd Python-$VERSION

./configure \
  --target=mips-linux-gnu \
  --host=mips-linux-gnu \
  --build=x86_64-pc-linux-gnu \
  --prefix=$BUILD_PREFIX \
  --exec-prefix=$BUILD_PREFIX \
  --sysconfdir=$BUILD_PREFIX/etc \
  --localstatedir=$BUILD_PREFIX/var \
  --program-prefix= \
  --disable-gtk-doc \
  --disable-gtk-doc-html \
  --disable-doc \
  --disable-docs \
  --disable-documentation \
  --with-xmlto=no \
  --with-fop=no \
  --disable-dependency-tracking \
  --enable-ipv6 \
  --disable-nls \
  --disable-static \
  --enable-shared \
  --disable-readline \
  --with-libmpdec=none \
  --with-expat=system \
  --disable-codecs-cjk \
  --disable-uuid \
  --disable-bzip2 \
  --disable-xz \
  --disable-ossaudiodev \
  --without-ensurepip \
  --without-cxx-main \
  --with-system-ffi \
  --disable-pydoc \
  --disable-test-modules \
  --disable-lib2to3 \
  --disable-tk \
  --disable-nis \
  --disable-idle3 \
  --disable-pyc-build \
  ac_cv_buggy_getaddrinfo=no \
  ac_cv_file__dev_ptmx=yes \
  ac_cv_file__dev_ptc=no \
  build_alias=x86_64-pc-linux-gnu \
  host_alias=mips-linux-gnu \
  target_alias=mips-linux-gnu \
  READELF="$TOOLCHAIN-readelf" \
  CC="$TOOLCHAIN-gcc" \
  CFLAGS='-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D__USE_TIME_BITS64  -Os' \
  LDFLAGS="-L$BUILD_PREFIX/lib" \
  CPPFLAGS='-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D__USE_TIME_BITS64' \
  CPP="$TOOLCHAIN-cpp" \
  OPENSSL_INCLUDES="" \
  OPENSSL_LDFLAGS="-L$BUILD_PREFIX/lib" \
  OPENSSL_LIBS="-lssl -lcrypto"
  #PKG_CONFIG=/opt/wuhui/code/creality/Pre-release/ingenic_linux_CR4CU220812S11/buildroot/buildroot/output/host/bin/pkg-config'"

make clean
make -j$COMPILE_CORES
make install