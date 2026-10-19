#!/usr/bin/env bash
# fc_relsrc.sh -- v1.1b (2026-10-18). CMAKE_Fortran_COMPILER_LAUNCHER used by build_arpack.sh.
# CMake gives gfortran every source as an absolute path ($W/src/arpack/arpack-3.9.1/SRC/dnaupd.f). gfortran 13 stores
# that name for each I/O statement (run-time error locus) and ignores -ffile-prefix-map for it. This launcher passes
# such a source as "src/arpack/arpack-3.9.1/..." instead -- the same name -ffile-prefix-map=$W/src=src gives the C
# files -- which is reachable from CMake's working directory $W/build/arpack through the symbolic link
# $W/build/arpack/src -> ../../src made by build_arpack.sh. Every other argument is passed unchanged.
set -euo pipefail
W=${W:?set W to the build root, see README_SOURCE.md}; W=${W%/}
args=()
for a in "$@"; do
  case "$a" in
    "$W"/src/*)
      r=${a#"$W"/}
      [ "$(realpath -m "$r")" = "$(realpath -m "$a")" ] || { echo "fc_relsrc.sh: $r is not $a from $PWD" >&2; exit 1; }
      args+=("$r") ;;
    *) args+=("$a") ;;
  esac
done
exec "${args[@]}"
