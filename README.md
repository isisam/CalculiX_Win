# CalculiX_Win — stock CalculiX 2.21 for Windows

公開教學用 Windows x64 求解器，採用原版 CalculiX 2.21。這是非官方發行，授權 GPL-2.0-or-later。
Download ccx.exe from [Releases](https://github.com/isisam/CalculiX_Win/releases), unpack to a writable folder and run `ccx.exe -i job` next to job.inp.

- [下載與安裝](docs/下載與安裝.md) · [使用教學](docs/使用教學.md) · [FAQ](docs/FAQ.md) · [回報問題](docs/回報問題.md)
- [Download and install](docs/INSTALL.en.md) · [Tutorial](docs/TUTORIAL.en.md) · [FAQ](docs/FAQ.en.md) · [Report an issue](docs/ISSUES.en.md)
- [Build and provenance](build/BUILD.md) · [Stock verification](examples/README.md) · [Credits](NOTICE.md) · [License](LICENSE)

The release binary runs directly on Windows x64 without a separate Fortran runtime installation. The recorded build host is WSL/Ubuntu with MinGW; native MSYS2 commands are supplied but have not been executed in this preparation. Native Windows execution tests and compilation provenance are reported separately.
