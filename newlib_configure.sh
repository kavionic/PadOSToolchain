#!/bin/bash

SCRIPT_PATH="$(command -v -- "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname -- "$SCRIPT_PATH")"

SOURCE_DIR="$(cd -- "${SCRIPT_DIR}/newlib-pados" &> /dev/null && pwd)"
BINARY_DIR="$(cd -- "${SCRIPT_DIR}" &> /dev/null && pwd)/Build"


SYSROOT=`cygpath -au $PADOS_TOOLCHAIN_PATH`

echo "Script is stored in: $SCRIPT_DIR"
echo "Source dir: $SOURCE_DIR"
echo "Binary dir: $BINARY_DIR"
echo "SysRoot:    $SYSROOT"

mkdir -p ${BINARY_DIR}/newlib && \
cd ${BINARY_DIR}/newlib && ${SOURCE_DIR}/configure \
--prefix=${SYSROOT} \
--build=x86_64-w64-mingw32 \
--host=x86_64-w64-mingw32 \
--target=arm-unknown-pados-eabi \
--enable-newlib-hw-misaligned-access=no \
--enable-newlib-multithread \
--enable-newlib-retargetable-locking \
--disable-newlib-supplied-syscalls \
--disable-werror \
CFLAGS_FOR_TARGET="-g -O2 -I${PADOS_INCLUDE}" \
CXXFLAGS_FOR_TARGET="-g -O2 -I${PADOS_INCLUDE}"

#--disable-nls \
#--with-newlib \
