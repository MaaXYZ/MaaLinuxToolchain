#!/bin/bash

echo "Build second stage clang"
cmake -G Ninja -S llvm-project/llvm -B build-llvm-stage2 \
  -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=`pwd`/stage2 \
  -DCMAKE_TOOLCHAIN_FILE=`pwd`/clang/stage1-build-stage2.cmake \
  -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld" -DLLVM_TARGETS_TO_BUILD="X86;AArch64" -DLLVM_BUILD_LLVM_DYLIB=ON -DLLVM_LINK_LLVM_DYLIB=ON \
  -DLLVM_INSTALL_TOOLCHAIN_ONLY=ON \
  -DCLANG_DEFAULT_LINKER="lld" -DCLANG_DEFAULT_CXX_STDLIB="libc++" -DCLANG_DEFAULT_RTLIB="compiler-rt" -DCLANG_DEFAULT_UNWINDLIB="libunwind" \
  -DLLVM_DEFAULT_TARGET_TRIPLE=x86_64-linux-gnu

cmake --build build-llvm-stage2 -- -j 16
cmake --install build-llvm-stage2
