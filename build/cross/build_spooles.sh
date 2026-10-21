#!/usr/bin/env bash
# Cross-build SPOOLES 2.2 (Ubuntu source 2.2-14.1build2, Debian patches applied by apt-get source) as a static
# Windows x86_64 library, single-threaded modules + MT (pthreads via winpthreads); the MPI module is left out
# (CalculiX does not use it). Object list per module = the $(OBJ).a(...) list of <module>/src/makefile (as makeLib).
# v1.1b (2026-10-18): + $PMAP_C / $PMAP_F from prefix_map.sh (relative file names in the exe); other flags unchanged.
set -euo pipefail
W=${W:?set W to the build root, see README_SOURCE.md}
. "$W/scripts/prefix_map.sh"
S=$W/src/spooles/spooles-2.2
# Windows LLP64: multiply I2Ohash indices as long long (2026-10-21).
python3 - "$S/I2Ohash/src/util.c" <<'PY'
from pathlib import Path
import sys
p=Path(sys.argv[1]);s=p.read_text()
old='loc3  = (long int)loc1*(long int)loc2 % hashtable->nlist ;'
new='loc3  = (long long)loc1 * loc2 % hashtable->nlist ;'
assert s.count(old)==3 or s.count(new)==3
s=s.replace(old,new).replace('long int loc3 ;','long long loc3 ;').replace('loc3 = %ld','loc3 = %lld')
p.write_text(s)
PY
B=$W/build/spooles; [ ! -e "$B" ] || exit 88; mkdir -p $B
CC=x86_64-w64-mingw32-gcc-posix; AR=x86_64-w64-mingw32-ar
CFLAGS="-O2 -fcommon -std=gnu99 -D_POSIX_C_SOURCE=199506L -w $PMAP_C"
MODS="A2 BKL BPG Chv ChvList ChvManager Coords DSTree DV DenseMtx Drand EGraph ETree FrontMtx GPart Graph I2Ohash IIheap IV IVL Ideq InpMtx Lock MSMD Network PatchAndGoInfo Pencil Perm SemiImplMtx SolveMap SubMtx SubMtxList SubMtxManager SymbFac Tree Utilities ZV misc MT"
n=0
for m in $MODS; do
  srcs=$(perl -ne 'print "$1.c\n" if /\$\(OBJ\)\.a\((\w+)\.o\)/' $S/$m/src/makefile)
  for f in $srcs; do
    $CC $CFLAGS -c $S/$m/src/$f -o $B/${m}_${f%.c}.o -I$S
    n=$((n+1))
  done
done
$AR rcs $B/libspooles.a $B/*.o
echo "compiled $n objects"; ls -la $B/libspooles.a
# headers (as Debian: /usr/include/spooles/<module>/...)
D=$W/prefix/include/spooles; [ ! -e "$D" ] || exit 88; mkdir -p $D
(cd $S && find . -name '*.h' -not -path './.pc/*' -not -path './debian/*' | while read h; do install -D -m644 "$h" "$D/$h"; done)
cp $B/libspooles.a $W/prefix/lib/
