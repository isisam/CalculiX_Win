# Dependencies of stock ccx.exe

CalculiX 2.21 is GPL-2.0-or-later; upstream headers and LICENSE are retained.
SPOOLES 2.2: public domain. ARPACK-NG 3.9.1: BSD-3-Clause.
Reference BLAS/LAPACK 3.12.0: modified BSD. MinGW-w64/winpthreads: per-file permissive notices.
GCC libgcc/libgfortran/libgomp: GPL-3.0 with GCC Runtime Library Exception 3.1.
libquadmath: LGPL-2.1-or-later. All component notices are in this directory.

Dependency source packages and Debian patches are under upstream/. The exact libquadmath source and relinking recipe are in libquadmath/ and build/cross/build_libquadmath.sh. Rebuild it with an altered source, then link stock ccx.exe using -L/path/to/modified/libquadmath before the toolchain library search. build/build_stock.py accepts QUADMATH_DIR through the linker override documented in build/BUILD.md. Provide this corresponding source with any binary distribution.
