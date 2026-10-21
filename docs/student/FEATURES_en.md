# CalculiX_Win features

Version: 2.21-win64.3. Author: S.Y. Su. Original upstream credits and licences are retained.

## What it does

Runs finite element analyses supported by stock CalculiX 2.21, including static, frequency and heat transfer cases. Reads `.inp` and writes requested result files such as `.dat` and `.frd`. Includes spring and beam examples. Adds ccx to the current user's PATH; open a new terminal after installation.

## Differences from upstream

Uses stock CalculiX 2.21 with a fix for a 64-bit index overflow in SPOOLES that could stop large-mesh jobs. Adds a per-user installer, user PATH integration, Start menu help and an uninstaller.

## Limitations

Command-line solver only: no CAD editor, meshing GUI or result viewer. Pair with PrePoMax-RCM if a GUI is needed.
No private fatigue or custom material solver extensions are supplied. Supported analyses depend on CalculiX 2.21 and your input model. Teaching examples are not engineering certification.

## Requirements

Windows 10/11 x64. Recommended: 4 GB RAM and 200 MB free disk space. No separate Fortran runtime installation. Larger jobs need more resources. Use a writable work folder; simple ASCII work paths are recommended for legacy native tools.

## Install

Download `CalculiX_Win_Setup_2.21.exe` from [GitHub Releases](https://github.com/isisam/CalculiX_Win/releases) → double-click → Next → Install → Finish. No administrator password is required. Default folder: `%LOCALAPPDATA%\Programs\CalculiX_Win`.

Open a new terminal. Copy `examples\spring1.inp` into a work folder, change to that folder, and run `ccx -i spring1`.

Silent installation: `CalculiX_Win_Setup_2.21.exe /S`. Optional `/D=full path` must be the last argument and is unquoted, e.g. `/S /D=C:\Student Apps\CalculiX_Win`.

## Uninstall

Use Windows Settings → Apps → Installed apps, or run `Uninstall.exe` in the installation folder (`/S` for silent removal). Removes shipped files, shortcuts and registration. Removes only the user PATH entry added by this installer, retaining pre-existing entries. Save edited examples outside the install folder. Your separately saved models and results remain.

## SmartScreen: unknown publisher

The installer is unsigned. Verify the GitHub release source and SHA256SUMS. If SmartScreen appears, choose More info → Run anyway. If school policy blocks execution, contact school IT. Do not disable antivirus or change security settings.

Recommended for all users: fixes a possible solver stop on large meshes. Close the application and solver, then install over the same folder; no prior uninstall is needed. Tested from the previous student installer.
