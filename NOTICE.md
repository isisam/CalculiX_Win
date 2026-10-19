# Credits and source

CalculiX CrunchiX 2.21 by Guido Dhondt and Klaus Wittig: https://www.dhondt.de/ . GPL-2.0-or-later, including original per-file notices.
This unofficial teaching distribution uses the upstream stock solver. Its only solver-source portability change moves the Windows _set_output_format call from file scope into main/CalculiXstep; build overrides add static MinGW libraries and path mapping. The upstream source in src/ is pristine. Build changes are dated in build/cross/win_portability.py and the build receipt.
Dependencies and runtime notices: LICENSES/THIRD_PARTY.md. Source archive hashes: upstream/SHA256SUMS. Public stock verification inputs retain upstream provenance in examples/README.md.
