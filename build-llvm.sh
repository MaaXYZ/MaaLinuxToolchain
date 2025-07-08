#!/bin/bash

if ! [[ -d llvm-project ]]; then
  git clone https://github.com/llvm/llvm-project --depth 1 -b llvmorg-20.1.7
fi

echo "Build first stage clang"
cmake -G Ninja -S llvm-project/llvm -B build-llvm-stage1 \
  -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=`pwd`/stage1 \
  -DLLVM_ENABLE_PROJECTS="clang;lld" -DLLVM_TARGETS_TO_BUILD="X86" -DLLVM_BUILD_LLVM_DYLIB=ON -DLLVM_LINK_LLVM_DYLIB=ON \
  -DLLVM_INSTALL_TOOLCHAIN_ONLY=ON \
  -DCLANG_DEFAULT_LINKER="lld" -DCLANG_DEFAULT_CXX_STDLIB="libc++" -DCLANG_DEFAULT_RTLIB="compiler-rt" -DCLANG_DEFAULT_UNWINDLIB="libunwind"
cmake --build build-llvm-stage1 -- -j 16
cmake --install build-llvm-stage1

echo "Build first stage libc++"
cmake -G Ninja -S llvm-project/runtimes -B build-libcxx-stage1 \
  -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=`pwd`/x-tools/x86_64-linux-gnu/sysroot/usr \
  -DCMAKE_TOOLCHAIN_FILE=`pwd`/clang/stage1.cmake \
  -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind;compiler-rt" \
  -DLIBUNWIND_USE_COMPILER_RT=ON \
  -DLIBCXXABI_USE_LLVM_UNWINDER=ON \
  -DLIBCXXABI_USE_COMPILER_RT=ON \
  -DLIBCXX_USE_COMPILER_RT=ON \
  -DPython3_EXECUTABLE=/usr/bin/python3
cmake --build build-libcxx-stage1 -- -j 16
cmake --install build-libcxx-stage1

echo "Build second stage clang"
cmake -G Ninja -S llvm-project/llvm -B build-llvm-stage2 \
  -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=`pwd`/stage2 \
  -DCMAKE_TOOLCHAIN_FILE=`pwd`/clang/stage1.cmake \
  -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld;lldb" -DLLVM_TARGETS_TO_BUILD="X86;AArch64" -DLLVM_BUILD_LLVM_DYLIB=ON -DLLVM_LINK_LLVM_DYLIB=ON \
  -DLLVM_INSTALL_TOOLCHAIN_ONLY=ON \
  -DCLANG_DEFAULT_LINKER="lld" -DCLANG_DEFAULT_CXX_STDLIB="libc++" -DCLANG_DEFAULT_RTLIB="compiler-rt" -DCLANG_DEFAULT_UNWINDLIB="libunwind" \
  -DLLVM_ENABLE_LTO=Thin -DLLVM_DEFAULT_TARGET_TRIPLE=x86_64-linux-gnu \
cmake --build build-llvm-stage2 -- -j 16
cmake --install build-llvm-stage2

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

echo "Build second stage libc++ arm64"
cmake -G Ninja -S llvm-project/runtimes -B build-libcxx-stage2-arm64 \
  -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=`pwd`/x-tools/aarch64-linux-gnu/sysroot/usr \
  -DCMAKE_TOOLCHAIN_FILE=`pwd`/clang/stage2-arm64.cmake \
  -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind;compiler-rt" \
  -DLIBUNWIND_USE_COMPILER_RT=ON \
  -DLIBCXXABI_USE_LLVM_UNWINDER=ON \
  -DLIBCXXABI_USE_COMPILER_RT=ON \
  -DLIBCXX_USE_COMPILER_RT=ON \
  -DPython3_EXECUTABLE=/usr/bin/python3
cmake --build build-libcxx-stage2-arm64 -- -j 16
cmake --install build-libcxx-stage2-arm64
