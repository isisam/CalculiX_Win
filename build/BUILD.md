# Rebuild stock CalculiX 2.21 with the Windows SPOOLES fix

For the tested native WinLibs GCC/gfortran 13.2.0 recipe and exact binary relinking, download CalculiX-2.21-SPOOLES-win64.3-source.zip from this release and follow README_BUILD.md. It includes CalculiX and dependency sources, the I2Ohash patch, stock-only native build script, relinkable objects and libquadmath replacement sources. Rebuilding numerical libraries can change diagnostic source-path strings and executable hashes; relinking the supplied objects reproduces the distributed ccx.exe exactly.

The historical MSYS2/cross build entry points remain. build/cross/build_spooles.sh now applies the same 64-bit I2Ohash multiplication fix before compiling the dependency. These alternative entry points were not rebuilt in this packaging task. The upstream CalculiX src/ remains stock 2.21. See the release verification.json for tested installation and numerical results.
