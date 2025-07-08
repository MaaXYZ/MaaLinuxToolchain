#!/bin/bash

echo "Build first stage libc++"
cmake -G Ninja -S llvm-project/runtimes -B build-libcxx-stage1 \
  -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=`pwd`/x-tools/x86_64-linux-gnu/sysroot/usr \
  -DCMAKE_TOOLCHAIN_FILE=`pwd`/clang/stage1.cmake \
  -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind;compiler-rt" \
  -DPython3_EXECUTABLE=/usr/bin/python3

cmake --build build-libcxx-stage1 -- -j 16
cmake --install build-libcxx-stage1
