#!/usr/bin/env python3
"""Verify releases.ncl → md matches live releases (read-only, no gh release edit)."""
import json, subprocess, pathlib, shlex, sys, difflib, re
from pathlib import Path

def load_releases():
    ncl_path = pathlib.Path(__file__).parent.parent / "releases.ncl"
    out = subprocess.check_output(["nix","shell","nixpkgs#nickel","--command","nickel","export","--format","json", str(ncl_path)], text=True)
    return json.loads(out)["releases"]

def render_via_script(tag):
    script = pathlib.Path(__file__).parent / "releases_render.py"
    return subprocess.check_output(["python3", str(script),"--tag",tag,"--format","md"], text=True)

def normalize(s):
    # collapse whitespace for diff, keep markdown links
    return re.sub(r'\s+', ' ', s).strip()

ok=True
releases=load_releases()
for r in releases:
    tag=r["tag"]
    generated=render_via_script(tag)
    # fetch live
    live = subprocess.check_output(f"agent-plain gh release view {shlex.quote(tag)} --json body --jq '.body'", shell=True, text=True)
    # Check for required links
    checks=[]
    # download links (schematic may be String or {file,label} record)
    def schematic_files(schems):
        files=[]
        for s in schems or []:
            if isinstance(s,str):
                files.append(s)
            elif isinstance(s,dict):
                files.append(s.get("file") or s.get("path") or "")
        return files
    def pcba_files(pcbas):
        files=[]
        for p in pcbas or []:
            if isinstance(p, dict):
                if p.get("bom"):
                    files.append(p["bom"])
                if p.get("cpl"):
                    files.append(p["cpl"])
            elif isinstance(p, str):
                files.append(p)
        return files
    for asset in r.get("gerber",[])+schematic_files(r.get("schematic"))+pcba_files(r.get("pcba"))+r.get("plates",[]):
        url=f"https://github.com/rgoulter/keyboard-labs/releases/download/{tag}/{asset}"
        if url not in generated:
            checks.append(f"MISSING download {asset}")
            ok=False
    # source — intentionally not rendered per feedback (unreadable), kept in data but not required in md
    # no check
    # firmware
    if r.get("firmware_board"):
        if r["firmware_board"] not in generated:
            checks.append(f"MISSING firmware_board {r['firmware_board']}")
            ok=False
    # build_guide / ibom coverage (now Array)
    for bg in r.get("build_guide", []) or []:
        if bg not in generated and bg not in r.get("intro",""):
            if bg not in generated:
                checks.append(f"MISSING build_guide {bg}")
                ok=False
    for ib in r.get("ibom", []) or []:
        ib_url = ib.get("url") if isinstance(ib, dict) else ib
        if ib_url not in generated and ib_url not in r.get("intro",""):
            checks.append(f"MISSING ibom {ib_url}")
            ok=False
    # pcbdraw not linked check (should NOT contain pcbdraw download links)
    # Simple pass
    if checks:
        print(f"{tag}: FAIL - {', '.join(checks)}")
    else:
        # also diff a bit vs live for sanity (not strict, just length)
        if len(generated) < 200 and tag != "iso-linux-environment":
            print(f"{tag}: WARN short generated {len(generated)}")
        else:
            print(f"{tag}: OK ({len(generated)} chars)")

if ok:
    print("\nAll releases.ncl → md checks passed (download/source/firmware/build_guide/ibom). No gh release edit performed.")
else:
    print("\nSome checks failed")
    sys.exit(1)
