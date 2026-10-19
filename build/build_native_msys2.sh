#!/usr/bin/env bash
# Native Windows build with an EXISTING MSYS2 MINGW64 toolchain. No installations or deletion.
set -euo pipefail
[[ "${MSYSTEM:-}" == MINGW64 ]] || { echo 'Use an existing MSYS2 MINGW64 shell'; exit 2; }
repo=$(cd "$(dirname "$0")/.." && pwd)
export W=${1:?absolute fresh build root without spaces}
[[ ! -e "$W" ]] || { echo 'Choose a fresh build root'; exit 2; }
for tool in gcc gfortran ar ranlib make cmake python3 patch perl; do command -v "$tool" >/dev/null;done
mkdir -p "$W/scripts/shim" "$W/prefix/lib"
cp "$repo"/build/cross/* "$W/scripts/"
for pair in gcc:gcc-posix g++:g++-posix gfortran:gfortran-posix ar:ar ranlib:ranlib windres:windres;do
  native=${pair%%:*};alias=${pair#*:}
  ln -s "$(command -v "$native")" "$W/scripts/shim/x86_64-w64-mingw32-$alias"
done
ln -s "$(command -v ar)" "$W/scripts/shim/ar"
export PATH="$W/scripts/shim:$PATH"
python3 "$repo/build/prepare_dependencies.py" "$W/src"
bash "$W/scripts/build_spooles.sh"
bash "$W/scripts/build_lapack.sh"
bash "$W/scripts/build_arpack.sh"
python3 "$repo/build/build_stock.py" --native --prefix "$W/prefix" --work "$W/solver" --out "$W/ccx.exe"
echo "Verify with: python3 $repo/scripts/verify_stock.py --exe $W/ccx.exe --work $W/verification"
