# Rebuild stock CalculiX 2.21

The solver source under src/ is byte-for-byte upstream 2.21 source. The build applies only Windows output-format call relocation and dated packaging/libquadmath notices; it does not add constitutive models or change numerical algorithms. Source source-package SHA256 values are under upstream/SHA256SUMS.

## Native Windows / MSYS2 recipe

Use an already installed MSYS2 MINGW64 shell and existing GCC/gfortran, binutils, make, CMake, Python 3, patch and Perl. No installer is run by these scripts. In that shell:

```bash
bash build/build_native_msys2.sh /c/build/ccx-stock-new
```

This builds SPOOLES 2.2 with MT/pthreads, reference BLAS/LAPACK 3.12.0, ARPACK-NG 3.9.1, then ccx.exe. The script refuses existing output roots. `-ffile-prefix-map`, C macro/debug maps and the Fortran relative-source launcher prevent build-host paths in diagnostics. ARCH="Linux" selects Fortran trailing-underscore name mangling; the executable target is Windows. Use Default/Spooles and ARPACK. PaStiX/Pardiso are not linked.

**Native MSYS2 compilation has not been executed in this preparation: no existing MSYS2/gfortran toolchain was found, and Windows installation was forbidden.** Compiler versions differ from the recorded GCC 13 cross build; validate numerical results and privacy again after native compilation.

## Recorded Windows-target build

The release was built on Ubuntu 24.04/WSL using the existing extracted MinGW-w64 GCC 13.2 posix toolchain and clean, previously built source-pinned dependencies. `build/build_stock.py --work /new/work --prefix /dependency/prefix --out /new/ccx.exe` builds with those existing cross compilers. The release is a native Windows PE x64 program; compilation was a cross build. All three stock inputs were run directly on Windows with only system directories on PATH, and compared to independent Ubuntu stock 2.21 results. See verification.json in the release.

For a complete dependency rebuild on Ubuntu with existing MinGW tools: run `python3 build/prepare_dependencies.py /new/root/src`; copy build/cross/* to /new/root/scripts; create scripts/shim/ar pointing to x86_64-w64-mingw32-ar, set W=/new/root and build_spooles.sh, build_lapack.sh, build_arpack.sh in that order. Then invoke build_stock.py. Runtime/dependency source and notices are supplied; no dependency binaries are tracked in Git.

For LGPL libquadmath relinking, use the shipped source under libquadmath/gcc-13.2.0 and build/cross/build_libquadmath.sh (GCC 13 cross recipe), then set `QUADMATH_DIR=/modified/library/directory` when invoking build_stock.py. This adds that directory before the default linker search. Retain the source, all notices and relinking instructions with binary redistribution.
