#!/bin/bash

SCRIPT_PATH="$(command -v -- "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname -- "$SCRIPT_PATH")"

SOURCE_DIR="$(cd -- "${SCRIPT_DIR}/gcc-pados" &> /dev/null && pwd)"
BINARY_DIR="$(cd -- "${SCRIPT_DIR}" &> /dev/null && pwd)/Build"


SYSROOT=`cygpath -au $PADOS_TOOLCHAIN_PATH`

echo "Script is stored in: $SCRIPT_DIR"
echo "Source dir: $SOURCE_DIR"
echo "Binary dir: $BINARY_DIR"
echo "SysRoot:    $SYSROOT"

mkdir -p ${BINARY_DIR}/gcc-pados
cd ${BINARY_DIR}/gcc-pados && ../../gcc-pados/configure \
--prefix=${SYSROOT} \
--build=x86_64-w64-mingw32 \
--host=x86_64-w64-mingw32 \
--target=arm-unknown-pados-eabi \
--with-sysroot=${SYSROOT}/arm-unknown-pados-eabi \
--with-native-system-header-dir=/include \
--enable-languages=c,c++ \
--disable-shared \
--enable-static \
--with-newlib \
--with-libatomic \
--enable-threads=posix \
--disable-multilib \
--with-mode=thumb --with-arch=armv7e-m --with-fpu=fpv5-d16 --with-float=hard \
CFLAGS_FOR_TARGET="-mno-unaligned-access -ffunction-sections -fdata-sections -g -O2 -I${PADOS_INCLUDE}" \
CXXFLAGS_FOR_TARGET="-mno-unaligned-access -ffunction-sections -fdata-sections -g -O2 -I${PADOS_INCLUDE}"

#--disable-nls \
