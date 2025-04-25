#!/bin/bash

# Clear cached files when changing CMAKE_BUILD_TYPE.
# rm -r build/
# rm -r .deps/

build_type="RelWithDebInfo"
post_nvim_args=""

for arg in "$@"; do
  if [ "$arg" == "--clean" ]; then
    rm -r build/
    rm -r .deps/
  elif [ "$arg" == "--debug" ]; then
    build_type="Debug"
  elif [ "$arg" == "--release" ]; then
    build_type="Release"
  elif [ "$arg" == "--nvim-clean" ]; then
    post_nvim_args="$post_nvim_args --clean"
  fi
done

# bundled_off="-DUSE_BUNDLED=OFF -DUSE_BUNDLED_LIBUV=ON -DUSE_BUNDLED_LUV=ON -DUSE_BUNDLED_TS=ON -DUSE_BUNDLED_UTF8PROC=ON"
# make CMAKE_EXTRA_FLAGS="-DCMAKE_C_FLAGS=-no-pie $bundled_off" CMAKE_INSTALL_PREFIX=$HOME/nvim CMAKE_BUILD_TYPE=$build_type && VIMRUNTIME=runtime ./build/bin/nvim ./file.c

# All(?) cmake flags are only supported by make when explicitly defined. Use
# CMAKE_EXTRA_FLAGS otherwise.
ctags -R --languages=C,C++ &&
make CMAKE_EXTRA_FLAGS="-DCMAKE_C_FLAGS=-no-pie" CMAKE_INSTALL_PREFIX=$HOME/nvim CMAKE_BUILD_TYPE=$build_type &&
VIMRUNTIME=runtime ./build/bin/nvim ./file.c${post_nvim_args}
