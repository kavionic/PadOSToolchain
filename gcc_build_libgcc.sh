#!/bin/bash

SCRIPT_PATH="$(command -v -- "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname -- "$SCRIPT_PATH")"

BINARY_DIR="$(cd -- "${SCRIPT_DIR}" &> /dev/null && pwd)/Build"

cd ${BINARY_DIR}/gcc-pados

make -j 8 all-target-libgcc MAKEINFO=true
