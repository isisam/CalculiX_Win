#!/usr/bin/env bash
# Cross-build arpack-ng 3.9.1 (Ubuntu source 3.9.1-1.1build2) as a static Windows library (serial, no ICB/MPI),
# linked against our static reference BLAS/LAPACK 3.12.0. Fortran flags -O2 (Debian: dpkg-buildflags -O2).
# v1.1b (2026-10-18): + $PMAP_C / $PMAP_F from prefix_map.sh, and gfortran started through fc_relsrc.sh (CMake passes
#   absolute source names, which gfortran 13 stores for I/O statements unmapped); other flags unchanged.
set -euo pipefail
W=${W:?set W to the build root, see README_SOURCE.md}; export W
. "$W/scripts/prefix_map.sh"
B=$W/build/arpack; [ ! -e "$B" ] || exit 88; mkdir -p $B; cd $B
ln -s ../../src src          # for fc_relsrc.sh: src/... from $B is $W/src/...
cmake $W/src/arpack/arpack-3.9.1 -DCMAKE_TOOLCHAIN_FILE=$W/scripts/mingw64.cmake \
  -DCMAKE_BUILD_TYPE=None -DCMAKE_Fortran_FLAGS="-O2 $PMAP_F" -DCMAKE_C_FLAGS="-O2 $PMAP_C" \
  -DCMAKE_Fortran_COMPILER_LAUNCHER="bash;$W/scripts/fc_relsrc.sh" \
  -DBUILD_SHARED_LIBS=OFF -DMPI=OFF -DICB=OFF -DEIGEN=OFF -DPYTHON3=OFF -DEXAMPLES=OFF -DTESTS=OFF \
  -DBLAS_LIBRARIES=$W/prefix/lib/libblas.a -DLAPACK_LIBRARIES="$W/prefix/lib/liblapack.a;$W/prefix/lib/libblas.a" \
  -DCMAKE_INSTALL_PREFIX=$B/inst
make -j2 VERBOSE=1 | grep -E 'gfortran|Error|error' | tail -5
make install > /dev/null
ls -la inst/lib*/libarpack.a; cp inst/lib*/libarpack.a $W/prefix/lib/libarpack.a
