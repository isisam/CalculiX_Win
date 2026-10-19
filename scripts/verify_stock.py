"""Verify upstream stock cases against independently recorded CalculiX 2.21 references."""
from pathlib import Path
import argparse,subprocess,os,shutil,json,re,math,hashlib

def values(name,text):
    if name=='beamf':
        text=text.split('P A R T I C I P A T I O N')[0]
        rows=re.findall(r'^\s*\d+\s+((?:[-+]?\d*\.\d+E[-+]\d+\s+){3}[-+]?\d*\.\d+E[-+]\d+)',text,re.M)
        return [float(x) for row in rows for x in row.split()]
    return [float(x) for x in re.findall(r'[-+]?\d*\.\d+E[-+]\d+',text)]

def main():
    p=argparse.ArgumentParser();p.add_argument('--exe',type=Path,required=True);p.add_argument('--work',type=Path,required=True);a=p.parse_args()
    r=Path(__file__).resolve().parents[1];exe=a.exe.resolve();w=a.work.resolve();w.mkdir(parents=True,exist_ok=False)
    expected=json.loads((r/'examples/reference.json').read_text())
    env=dict(os.environ,OMP_NUM_THREADS='1',CCX_NPROC_EQUATION_SOLVER='1',CCX_NPROC_STIFFNESS='1',CCX_NPROC_RESULTS='1',OPENBLAS_NUM_THREADS='1',MKL_NUM_THREADS='1')
    if os.name=='nt':env['PATH']=os.path.join(os.environ['SystemRoot'],'System32')+';'+os.environ['SystemRoot']
    result={'exe_sha256':hashlib.sha256(exe.read_bytes()).hexdigest(),'cases':[],'status':'PASS'}
    for name in ('beamp','beamf','spring1'):
        d=w/name;d.mkdir();shutil.copy2(r/'examples'/f'{name}.inp',d/f'{name}.inp')
        with (d/'console.txt').open('wb') as log:
            q=subprocess.run([str(exe),'-i',name],cwd=d,env=env,stdout=log,stderr=subprocess.STDOUT,timeout=180,**({'creationflags':0x08000000} if os.name=='nt' else {}))
        console=(d/'console.txt').read_text(errors='replace');actual=values(name,(d/f'{name}.dat').read_text())
        ref=expected['cases'][name]['values'];assert len(actual)==len(ref)>0,(name,len(actual),len(ref))
        errors=[abs(x-y) for x,y in zip(actual,ref)];ok=all(math.isfinite(x) and abs(x-y)<=1e-7+1e-6*abs(y) for x,y in zip(actual,ref))
        ok=ok and q.returncode==0 and 'Job finished' in console and '*ERROR' not in console
        if name=='beamf':ok=ok and len(actual)==40
        if name=='spring1':ok=ok and any(abs(x-.1)<1e-10 for x in actual)
        result['cases'].append({'case':name,'status':'PASS' if ok else 'FAIL','numbers':len(actual),'maximum_absolute_difference':max(errors),'dat_sha256':hashlib.sha256((d/f'{name}.dat').read_bytes()).hexdigest()})
        if not ok:result['status']='FAIL'
    (w/'verification.json').write_text(json.dumps(result,indent=2));print(json.dumps(result,indent=2))
    raise SystemExit(0 if result['status']=='PASS' else 1)
if __name__=='__main__':main()
