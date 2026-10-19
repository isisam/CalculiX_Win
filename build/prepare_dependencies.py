"""Expand shipped dependency source and apply Debian quilt patches in a fresh destination."""
from pathlib import Path
import argparse,tarfile,subprocess
p=argparse.ArgumentParser();p.add_argument('destination',type=Path);a=p.parse_args()
r=Path(__file__).resolve().parents[1];a.destination.mkdir(parents=True,exist_ok=False)
for pkg,version in [('spooles','2.2'),('lapack','3.12.0'),('arpack','3.9.1')]:
    out=a.destination/pkg;out.mkdir();t=tarfile.open(next((r/'upstream').glob(pkg+'_*.orig.tar.*')))
    # Archives are pinned by upstream/SHA256SUMS; reject traversal/special files.
    root=out/(pkg+'-'+version);root.mkdir()
    members=[m for m in t if m.isfile() or m.isdir()]
    tops={m.name.strip('./').split('/')[0] for m in members}
    for m in members:
        parts=Path(m.name).parts
        if parts and parts[0]=='.':parts=parts[1:]
        if len(tops)==1:parts=parts[1:]
        if not parts:continue
        if '..' in parts:raise ValueError(m.name)
        q=root.joinpath(*parts)
        if m.isdir():q.mkdir(parents=True,exist_ok=True)
        else:q.parent.mkdir(parents=True,exist_ok=True);q.write_bytes(t.extractfile(m).read())
    with tarfile.open(next((r/'upstream').glob(pkg+'_*.debian.tar.*'))) as dt:
        for m in dt:
            if not m.isfile():continue
            if '..' in Path(m.name).parts or Path(m.name).is_absolute():raise ValueError(m.name)
            q=root/m.name;q.parent.mkdir(parents=True,exist_ok=True);q.write_bytes(dt.extractfile(m).read())
    series=root/'debian/patches/series'
    if series.exists():
        for line in series.read_text().splitlines():
            line=line.strip()
            if not line or line.startswith('#'):continue
            patch=root/'debian/patches'/line.split()[0]
            with patch.open('rb') as f:subprocess.run(['patch','-p1','--batch'],cwd=root,stdin=f,check=True)
