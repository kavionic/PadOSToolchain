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

cp -vua $SOURCE_DIR/newlib/libc/sys/pados/include/*.h $BINARY_DIR/newlib/arm-unknown-pados-eabi/newlib/targ-include/
cp -vua $SOURCE_DIR/newlib/libc/sys/pados/include/PadOS/*.h $BINARY_DIR/newlib/arm-unknown-pados-eabi/newlib/targ-include/PadOS/
cp -vua $SOURCE_DIR/newlib/libc/sys/pados/sys/*.h $BINARY_DIR/newlib/arm-unknown-pados-eabi/newlib/targ-include/sys

cp -vua $BINARY_DIR/newlib/arm-unknown-pados-eabi/newlib/targ-include/*.h $SYSROOT/arm-unknown-pados-eabi/include/
cp -vua $BINARY_DIR/newlib/arm-unknown-pados-eabi/newlib/targ-include/PadOS/*.h $SYSROOT/arm-unknown-pados-eabi/include/PadOS/
cp -vua $BINARY_DIR/newlib/arm-unknown-pados-eabi/newlib/targ-include/sys/*.h $SYSROOT/arm-unknown-pados-eabi/include/sys/
