#!/bin/bash

SCRIPT_PATH="$(command -v -- "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname -- "$SCRIPT_PATH")"

SOURCE_DIR="$(cd -- "${SCRIPT_DIR}/openocd-pados" &> /dev/null && pwd)" || exit 1
BINARY_DIR="$(cd -- "${SCRIPT_DIR}" &> /dev/null && pwd)/Build"

SYSROOT="$(cygpath -au "${PADOS_TOOLCHAIN_PATH:?PADOS_TOOLCHAIN_PATH must be set}")" || exit 1

echo "Script is stored in: $SCRIPT_DIR"
echo "Source dir: $SOURCE_DIR"
echo "Binary dir: $BINARY_DIR"
echo "SysRoot:    $SYSROOT"

(cd "${SOURCE_DIR}" && ./bootstrap) || exit 1

mkdir -p "${BINARY_DIR}/openocd-pados" || exit 1
cd "${BINARY_DIR}/openocd-pados" && "${SOURCE_DIR}/configure" \
--prefix="${SYSROOT}" \
--build=x86_64-w64-mingw32 \
--host=x86_64-w64-mingw32 \
--enable-internal-jimtcl \
--enable-internal-libjaylink \
--enable-stlink \
--enable-cmsis-dap \
--enable-ftdi \
--enable-jlink \
--enable-dummy
