#!/bin/bash

echo "Build second stage libc++ x64"
cmake -G Ninja -S llvm-project/runtimes -B build-libcxx-stage2-x64 \
  -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=`pwd`/x-tools/x86_64-linux-gnu/sysroot/usr \
  -DCMAKE_TOOLCHAIN_FILE=`pwd`/clang/stage2-x64.cmake \
  -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind;compiler-rt" \
  -DLIBUNWIND_USE_COMPILER_RT=ON \
  -DLIBCXXABI_USE_LLVM_UNWINDER=ON \
  -DLIBCXXABI_USE_COMPILER_RT=ON \
  -DLIBCXX_USE_COMPILER_RT=ON \
  -DPython3_EXECUTABLE=/usr/bin/python3

cmake --build build-libcxx-stage2-x64 -- -j 16
cmake --install build-libcxx-stage2-x64
