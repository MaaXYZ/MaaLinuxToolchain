#!/bin/bash

echo "Build first stage clang"
cmake -G Ninja -S llvm-project/llvm -B build-llvm-stage1 \
  -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=`pwd`/stage1 \
  -DLLVM_ENABLE_PROJECTS="clang;lld" -DLLVM_TARGETS_TO_BUILD="X86" -DLLVM_BUILD_LLVM_DYLIB=ON -DLLVM_LINK_LLVM_DYLIB=ON \
  -DLLVM_INSTALL_TOOLCHAIN_ONLY=ON \
  -DCLANG_DEFAULT_LINKER="lld" -DCLANG_DEFAULT_CXX_STDLIB=  -DCLANG_DEFAULT_RTLIB= -DCLANG_DEFAULT_UNWINDLIB=

cmake --build build-llvm-stage1 -- -j 16
cmake --install build-llvm-stage1
