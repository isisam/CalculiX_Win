# Source and provenance

Author: S.Y. Su <isisam@users.noreply.github.com>. Original upstream credits and licences retained.

This release uses stock CalculiX 2.21 with the SPOOLES I2Ohash insert/locate/remove multiplication promoted to 64-bit long long on Windows. It replaces the previous student solver.
ccx.exe SHA256: 7be13a3a1a7f6fbcf9c04629d4990af0a2140d2e1424cd1ec321748f342b7d4b
Corresponding source, dependency sources, build recipe and relinkable objects: CalculiX-2.21-SPOOLES-win64.3-source.zip supplied with this release.
The upstream CalculiX 2.21 source remains stock; the hash fix is in its SPOOLES dependency. The existing Windows portability and runtime notices are retained.

PrePoMax student application baseline: v0.1.0-rc1g8-win.1. Application binaries unchanged in v0.1.0-rc1g8-win.2. Corresponding source: PrePoMax-RCM_student_source_0.1.0-rc1g8-win.2.zip in the PrePoMax release.
ccx_dynamic 2.22 is not rebuilt or replaced. The student Setup continues to include only Solver/ccx.exe.
Third-party notices and source locations remain in Licenses or LICENSES.
