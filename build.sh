#!/bin/bash

# Clear cached files when changing CMAKE_BUILD_TYPE.
# rm -r build/
# rm -r .deps/

if [ "$1" == "-clean" ]; then
  rm -r build/
  rm -r .deps/
elif [ "$2" == "-clean" ]; then
  rm -r build/
  rm -r .deps/
fi

build_type="Release"
if [ "$1" == "-debug" ]; then
  build_type="RelWithDebInfo"
elif [ "$2" == "-debug" ]; then
  build_type="RelWithDebInfo"
fi

# bundled_off="-DUSE_BUNDLED=OFF -DUSE_BUNDLED_LIBUV=ON -DUSE_BUNDLED_LUV=ON -DUSE_BUNDLED_TS=ON -DUSE_BUNDLED_UTF8PROC=ON"
# make CMAKE_EXTRA_FLAGS="-DCMAKE_C_FLAGS=-no-pie $bundled_off" CMAKE_INSTALL_PREFIX=$HOME/nvim CMAKE_BUILD_TYPE=$build_type && VIMRUNTIME=runtime ./build/bin/nvim ./file.c

# All(?) cmake flags are only supported by make when explicitly defined. Use
# CMAKE_EXTRA_FLAGS otherwise.
make CMAKE_EXTRA_FLAGS="-DCMAKE_C_FLAGS=-no-pie" CMAKE_INSTALL_PREFIX=$HOME/nvim CMAKE_BUILD_TYPE=$build_type && VIMRUNTIME=runtime ./build/bin/nvim ./file.c

ctags -R
