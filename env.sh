#!/bin/bash

export BUILD_DIR="$HOME/scipy-k1"
export SOURCE_DIR="$BUILD_DIR/packages"
export BUILD_PREFIX="$BUILD_DIR/local"
export TOOLCHAIN_DIR="$BUILD_DIR/toolchains/mips-gcc720-glibc229/bin"
export GCC_PREFIX=mips-linux-gnu
export TOOLCHAIN=${TOOLCHAIN_DIR}/${GCC_PREFIX}
export COMPILE_CORES=$(($(nproc)-1))

export PATH="$TOOLCHAIN_DIR:$PATH"