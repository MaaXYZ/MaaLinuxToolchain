set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm64)

set(XTOOLS_ROOT ${CMAKE_CURRENT_LIST_DIR}/../x-tools/aarch64-linux-gnu)
set(STAGE2_ROOT ${CMAKE_CURRENT_LIST_DIR}/../stage2)
set(CMAKE_C_COMPILER ${STAGE2_ROOT}/bin/clang)
set(CMAKE_CXX_COMPILER ${STAGE2_ROOT}/bin/clang++)
set(CMAKE_ASM_COMPILER ${STAGE2_ROOT}/bin/clang)
set(CMAKE_SYSROOT ${XTOOLS_ROOT}/aarch64-linux-gnu/sysroot)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC --sysroot=${CMAKE_SYSROOT} --gcc-toolchain=${XTOOLS_ROOT}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC --sysroot=${CMAKE_SYSROOT} --gcc-toolchain=${XTOOLS_ROOT}")
