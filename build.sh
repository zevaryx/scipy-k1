#!/bin/bash
set -e

source env.sh

cd $BUILD_DIR

if [ ! -d toolchains/mips-gcc720-glibc229 ]; then
    echo "Getting toolchain..."
    mkdir -p toolchains && cd toolchains
    wget "https://github.com/ballaswag/k1-discovery/releases/download/1.0.0/mips-gcc720-glibc229.tar.gz"
    tar -xf mips-gcc720-glibc229.tar.gz
    rm mips-gcc720-glibc229.tar.gz
    cd $BUILD_DIR
fi

if [ -d local ]; then
    echo "Cleaning up old builds..."
    rm -rf local/*
else
    echo "Creating ./local for prefix target..."
    mkdir -p local
fi

if [ ! -d packages ]; then
    mkdir -p packages
fi

if [ -d cross_venv ]; then
    rm -rf cross_venv
fi

bash scripts/build_zlib.sh
# bash scripts/build_elfutils.sh
bash scripts/build_python.sh

bash scripts/build_openblas.sh

python3 -m pip install crossenv
python3 -m crossenv $BUILD_PREFIX/bin/python3 cross_venv
source ./cross_venv/bin/activate

# This breaks pip, but I think this is required to build scipy
python3 -m pip install --upgrade pip

pip install scipy