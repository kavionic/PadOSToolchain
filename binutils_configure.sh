#!/bin/bash

SCRIPT_PATH="$(command -v -- "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname -- "$SCRIPT_PATH")"

SOURCE_DIR="$(cd -- "${SCRIPT_DIR}/binutils-gdb-pados" &> /dev/null && pwd)"
BINARY_DIR="$(cd -- "${SCRIPT_DIR}" &> /dev/null && pwd)/Build"


SYSROOT=`cygpath -au $PADOS_TOOLCHAIN_PATH`

echo "Script is stored in: $SCRIPT_DIR"
echo "Source dir: $SOURCE_DIR"
echo "Binary dir: $BINARY_DIR"
echo "SysRoot:    $SYSROOT"

mkdir -p ${BINARY_DIR}/binutils-gdb-pados
cd ${BINARY_DIR}/binutils-gdb-pados && ../../binutils-gdb-pados/configure \
--prefix=${SYSROOT} \
--build=x86_64-w64-mingw32 \
--host=x86_64-w64-mingw32 \
--target=arm-unknown-pados-eabi \
--enable-languages=c,c++ \
--disable-nls \
--with-newlib \
--with-expat \
--with-libexpat-prefix=/c/msys64/mingw64 \
--with-python=python3 \
--with-lzma \
--with-zlib \
--enable-tui

#--with-sysroot=${SYSROOT}/arm-unknown-pados-eabi \
#--disable-shared \
#--enable-static \
#--enable-threads=posix \
#CFLAGS_FOR_TARGET="-mno-unaligned-access -ffunction-sections -fdata-sections -O3 -D_POSIX_C_SOURCE=200809L -D_XOPEN_SOURCE=700 -D_POSIX_THREADS -D_UNIX98_THREAD_MUTEX_ATTRIBUTES" \
#CXXFLAGS_FOR_TARGET="-mno-unaligned-access -ffunction-sections -fdata-sections -O3 -D_POSIX_C_SOURCE=200809L -D_XOPEN_SOURCE=700 -D_POSIX_THREADS -D_UNIX98_THREAD_MUTEX_ATTRIBUTE" \
#LDFLAGS_FOR_TARGET="-pthread" \
#LIBS="-lpthread"

