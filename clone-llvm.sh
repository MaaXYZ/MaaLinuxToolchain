#!/bin/bash

if ! [[ -d llvm-project ]]; then
  git clone https://github.com/llvm/llvm-project --depth 1 -b llvmorg-20.1.7
fi
