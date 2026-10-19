# Tutorial

Copy a stock .inp from examples/ into a new work folder. Run `ccx.exe -i beamp` there (base name, no extension). Require Job finished and valid .sta/.dat/.frd results; exit code alone is insufficient. In PrePoMax create/import the model, assign material, boundary conditions and a step, run the analysis and open its .frd. Run the scripted suite with `python scripts/verify_stock.py --exe /path/ccx.exe --work /new/work`.
