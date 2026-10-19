# prefix_map.sh -- v1.1b (2026-10-18). Sourced (". $W/scripts/prefix_map.sh") by build_spooles.sh, build_lapack.sh,
# build_arpack.sh, build_ccx.sh and build_libquadmath.sh; sets PMAP_C (C compiles) and PMAP_F (Fortran compiles).
#
# Purpose: no absolute build-machine path in ccx_stock.exe. GCC writes the source file name, as given on its command
# line, into C __FILE__ strings (SPOOLES error messages) and into debug info; the maps rewrite
#   $W/src -> src     $W/build -> build     $W/prefix -> prefix
# (for $W as given and, if different, for its realpath).
# C:       -ffile-prefix-map (= -fmacro-prefix-map + -fdebug-prefix-map), the two parts also spelled out.
# Fortran: -ffile-prefix-map and -fdebug-prefix-map only. gfortran rejects -fmacro-prefix-map ("valid for
#          C/C++/ObjC/ObjC++ but not for Fortran") and, in GCC 13, does not apply any prefix map to the file name it
#          stores for each I/O statement (run-time error locus "At line N of file ..."). That name is relative when
#          the compile is run with a relative source name: true for the CalculiX and LAPACK Makefiles; CMake (ARPACK)
#          passes absolute names, so build_arpack.sh runs gfortran through fc_relsrc.sh.
# Without -g (none of these builds uses it) the maps change only those strings; the generated code is the same.
W=${W:?set W to the build root, see README_SOURCE.md}
W=${W%/}
PMAP_C=""; PMAP_F=""
for _r in "$W" "$(realpath -m "$W")"; do
  case " $PMAP_C " in *"-ffile-prefix-map=$_r/src=src "*) continue ;; esac
  for _d in src build prefix; do
    PMAP_C="$PMAP_C -ffile-prefix-map=$_r/$_d=$_d -fmacro-prefix-map=$_r/$_d=$_d -fdebug-prefix-map=$_r/$_d=$_d"
    PMAP_F="$PMAP_F -ffile-prefix-map=$_r/$_d=$_d -fdebug-prefix-map=$_r/$_d=$_d"
  done
done
PMAP_C=${PMAP_C# }; PMAP_F=${PMAP_F# }
unset _r _d
