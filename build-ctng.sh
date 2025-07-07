#!/bin/bash

if ! [[ -d build-ctng ]]; then
  git clone https://github.com/crosstool-ng/crosstool-ng -b crosstool-ng-1.27.0 --depth 1 build-ctng
fi
cd build-ctng
./bootstrap
./configure --prefix=`pwd`/../install-ctng
make
make install
