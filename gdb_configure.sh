#!/bin/bash

SCRIPT_PATH="$(command -v -- "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname -- "$SCRIPT_PATH")"

SOURCE_DIR="$(cd -- "${SCRIPT_DIR}/gdb-pados" &> /dev/null && pwd)"
BINARY_DIR="$(cd -- "${SCRIPT_DIR}" &> /dev/null && pwd)/Build"

SYSROOT="$(cygpath -au "$PADOS_TOOLCHAIN_PATH")"

echo "Script is stored in: $SCRIPT_DIR"
echo "Source dir: $SOURCE_DIR"
echo "Binary dir: $BINARY_DIR"
echo "SysRoot:    $SYSROOT"

mkdir -p "${BINARY_DIR}/gdb-pados" || exit 1
cd "${BINARY_DIR}/gdb-pados" && "${SOURCE_DIR}/configure" \
--prefix="${SYSROOT}" \
--build=x86_64-w64-mingw32 \
--host=x86_64-w64-mingw32 \
--target=arm-unknown-pados-eabi \
--disable-nls \
--disable-binutils \
--disable-gas \
--disable-ld \
--disable-gold \
--disable-gprof \
--disable-gprofng \
--disable-gdbserver \
--disable-sim \
--with-expat \
--with-libexpat-prefix=/c/msys64/mingw64 \
--with-python=python3 \
--with-lzma \
--with-zlib \
--enable-tui
