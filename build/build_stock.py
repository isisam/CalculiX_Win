"""Build pristine CalculiX 2.21 for Windows with existing MinGW dependencies; no installs/deletions."""
from pathlib import Path
import argparse,subprocess,shutil,os,json,hashlib
p=argparse.ArgumentParser();p.add_argument('--work',type=Path,required=True);p.add_argument('--prefix',type=Path,required=True);p.add_argument('--out',type=Path,required=True);p.add_argument('--native',action='store_true');p.add_argument('--jobs',type=int,default=4);a=p.parse_args()
r=Path(__file__).resolve().parents[1];w=a.work.resolve();w.mkdir(parents=True,exist_ok=False)
t=w/'build/stock/ccx_2.21/src';shutil.copytree(r/'src',t)
subprocess.run(['python3',str(r/'build/cross/win_portability.py'),str(t)],check=True)
for name in ('ccx_2.21.c','ccx_2.21step.c'):
 q=t/name;s=q.read_text(encoding='latin1')
 s='/* 2026-10-20: Windows portability call relocation; stock solver physics unchanged. */\n'+s
 if name=='ccx_2.21.c':
  anchor='  printf("certain conditions, see gpl.htm\\n\\n");'
  assert anchor in s
  s=s.replace(anchor,anchor+'\n  printf("Windows teaching build; contains libquadmath (C) Free Software Foundation, Inc.\\n");\n  printf("libquadmath: LGPL-2.1-or-later; see LICENSES/LGPL-2.1_libquadmath.txt.\\n\\n");',1)
 q.write_text(s,encoding='latin1')
shutil.copyfile(r/'build/stock.mk',t/'stock.mk')
c='' if a.native else 'x86_64-w64-mingw32-'
cc=c+'gcc'+('' if a.native else '-posix');fc=c+'gfortran'+('' if a.native else '-posix')
prefix=a.prefix.resolve();flags=' '.join(f'-ffile-prefix-map={x}={y} -fdebug-prefix-map={x}={y}' for x,y in [(w,'buildroot'),(prefix,'prefix')])
cmd=['make','-f','stock.mk',f'-j{a.jobs}',f'CC={cc}',f'FC={fc}',f'AR={c}ar',
 'CFLAGS=-Wall -O2 -I'+str(prefix/'include/spooles')+' -DARCH="Linux" -DSPOOLES -DARPACK -DMATRIXSTORAGE -DUSE_MT=1 '+flags+' '+f'-fmacro-prefix-map={w}=buildroot',
 'FFLAGS=-O2 -fallow-argument-mismatch '+flags,
 'LIBS='+str(prefix/'lib/libspooles.a')+' -lpthread '+str(prefix/'lib/libarpack.a')+' '+str(prefix/'lib/liblapack.a')+' '+str(prefix/'lib/libblas.a')+' -lm',
 'LDFLAGS=-static -static-libgfortran -static-libgcc -Wl,--no-insert-timestamp'+(' -L'+os.environ['QUADMATH_DIR'] if os.environ.get('QUADMATH_DIR') else ''),'ccx.exe']
with (w/'build.log').open('wb') as log:subprocess.run(cmd,cwd=t,stdout=log,stderr=subprocess.STDOUT,check=True)
if a.out.exists():raise FileExistsError(a.out)
a.out.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(t/'ccx.exe',a.out)
(w/'receipt.json').write_text(json.dumps(dict(host=os.name,native=a.native,command=cmd,sha256=hashlib.sha256(a.out.read_bytes()).hexdigest()),indent=2))
print('Built',a.out,flush=True)
