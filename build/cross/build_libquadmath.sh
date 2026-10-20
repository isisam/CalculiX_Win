#!/usr/bin/env bash
# Build libquadmath (GCC 13.2.0, LGPL-2.1) as a static Windows x86_64 library from libquadmath/gcc-13.2.0 of this
# archive (or your modified copy of it), so that ccx_stock.exe can be relinked with it (LGPL-2.1 section 6).
# usage: build_libquadmath.sh [gcc-13.2.0 source dir]     -> $W/prefix/quadmath/libquadmath.a
# then: QUADMATH_DIR=$W/prefix/quadmath python3 build/build_stock.py --work /new/work --prefix "$W/prefix" --out /new/ccx.exe
# Toolchain as for the rest of the build (Ubuntu 24.04 gcc-mingw-w64-x86-64-posix 13.2.0). Tested 2026-10-17.
# v1.1b (2026-10-18): + $PMAP_C from prefix_map.sh and a map for the source dir; other flags unchanged.
set -euo pipefail
W=${W:?set W to the build root, see build/BUILD.md}
. "$W/scripts/prefix_map.sh"
SRC=$(realpath "${1:-$W/src/gcc-13.2.0}")
B=$W/build/libquadmath
[ ! -e "$B" ] || exit 88; mkdir -p "$B" "$W/prefix/quadmath"; cd "$B"
"$SRC/libquadmath/configure" --host=x86_64-w64-mingw32 --build=x86_64-pc-linux-gnu \
    --disable-shared --enable-static --disable-multilib CC=x86_64-w64-mingw32-gcc-posix \
    CFLAGS="-O2 $PMAP_C -ffile-prefix-map=$SRC=$(basename "$SRC") -ffile-prefix-map=$B=build/libquadmath"
make
cp .libs/libquadmath.a "$W/prefix/quadmath/"
ls -la "$W/prefix/quadmath/libquadmath.a"; sha256sum "$W/prefix/quadmath/libquadmath.a"
