#!/usr/bin/env bash
# Cross-build reference BLAS + LAPACK 3.12.0 (Ubuntu source 3.12.0-3build1.1, Debian patches applied) as static
# Windows libraries with Debian's Fortran flags (-O2 -frecursive; NOOPT files -O0 -frecursive), via make.inc.
# v1.1b (2026-10-18): + $PMAP_C / $PMAP_F from prefix_map.sh (relative file names in the exe); other flags unchanged.
set -euo pipefail
W=${W:?set W to the build root, see README_SOURCE.md}
. "$W/scripts/prefix_map.sh"
B=$W/build/lapack; [ ! -e "$B" ] || exit 88; mkdir -p $B
cp -a $W/src/lapack/lapack-3.12.0/. $B/
cd $B
cp INSTALL/make.inc.gfortran make.inc
sed -i -e 's|^CC *=.*|CC = x86_64-w64-mingw32-gcc-posix|' \
       -e "s|^CFLAGS *=.*|CFLAGS = -O2 $PMAP_C|" \
       -e 's|^FC *=.*|FC = x86_64-w64-mingw32-gfortran-posix|' \
       -e "s|^FFLAGS *=.*|FFLAGS = -O2 -frecursive $PMAP_F|" \
       -e "s|^FFLAGS_NOOPT *=.*|FFLAGS_NOOPT = -O0 -frecursive $PMAP_F|" \
       -e 's|^AR *=.*|AR = x86_64-w64-mingw32-ar|' \
       -e 's|^RANLIB *=.*|RANLIB = x86_64-w64-mingw32-ranlib|' make.inc
grep -E '^(CC|CFLAGS|FC|FFLAGS|FFLAGS_NOOPT|AR|RANLIB|BLASLIB|LAPACKLIB) ' make.inc
make -j2 blaslib
make -j2 lapacklib
ls -la librefblas.a liblapack.a
cp librefblas.a $W/prefix/lib/libblas.a; cp liblapack.a $W/prefix/lib/liblapack.a
