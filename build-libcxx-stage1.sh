#!/bin/bash

echo "Build first stage libc++ rt"
cmake -G Ninja -S llvm-project/runtimes -B build-libcxx-stage1-rt \
  -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=`pwd`/stage1/lib/clang/20 \
  -DCMAKE_TOOLCHAIN_FILE=`pwd`/clang/stage1.cmake \
  -DLLVM_ENABLE_RUNTIMES="compiler-rt" \
  -DPython3_EXECUTABLE=/usr/bin/python3

cmake --build build-libcxx-stage1-rt -- -j 16
cmake --install build-libcxx-stage1-rt

echo "Build first stage libc++"
cmake -G Ninja -S llvm-project/runtimes -B build-libcxx-stage1 \
  -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=`pwd`/x-tools/x86_64-linux-gnu/x86_64-linux-gnu/sysroot/usr \
  -DCMAKE_TOOLCHAIN_FILE=`pwd`/clang/stage1.cmake \
  -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind" \
  -DPython3_EXECUTABLE=/usr/bin/python3

cmake --build build-libcxx-stage1 -- -j 16
cmake --install build-libcxx-stage1
