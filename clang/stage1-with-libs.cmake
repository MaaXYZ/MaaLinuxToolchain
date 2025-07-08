set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

set(XTOOLS_ROOT ${CMAKE_CURRENT_LIST_DIR}/../x-tools/x86_64-linux-gnu)
set(STAGE1_ROOT ${CMAKE_CURRENT_LIST_DIR}/../stage1)
set(CMAKE_C_COMPILER ${STAGE1_ROOT}/bin/clang)
set(CMAKE_CXX_COMPILER ${STAGE1_ROOT}/bin/clang++)
set(CMAKE_ASM_COMPILER ${STAGE1_ROOT}/bin/clang)
set(CMAKE_SYSROOT ${XTOOLS_ROOT}/x86_64-linux-gnu/sysroot)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC --sysroot=${CMAKE_SYSROOT} --gcc-toolchain=${XTOOLS_ROOT} --start-no-unused-arguments --rtlib=compiler-rt --unwindlib=libunwind --end-no-unused-arguments")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC --sysroot=${CMAKE_SYSROOT} --gcc-toolchain=${XTOOLS_ROOT} --start-no-unused-arguments --rtlib=compiler-rt --unwindlib=libunwind --stdlib=libc++ --end-no-unused-arguments")
