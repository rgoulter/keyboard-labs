# /// script
# requires-python = ">=3.11"
# dependencies = ["markdown", "jinja2"]
# ///
#!/usr/bin/env python3
"""Render releases.ncl → markdown (gh release body) + HTML preview.

Template: title; hero image (top photo); prose; errata/changelog; photos; asset sections (build guides, IBOMs, plates, 3DP case, gerber, BOM+CPL, schematic, firmware binaries)

Usage:
  python3 scripts/releases_render.py --tag ch32x-60-improved-rev2026.1 --format md
  python3 scripts/releases_render.py --all --format md --out /tmp
"""

import argparse
import json
import subprocess
import sys
from pathlib import Path

REPO = "rgoulter/keyboard-labs"

def load_releases():
    ncl_path = Path(__file__).parent.parent / "releases.ncl"
    out = subprocess.check_output(
        ["nix", "shell", "nixpkgs#nickel", "--command", "nickel", "export", "--format", "json", str(ncl_path)],
        text=True,
    )
    data = json.loads(out)
    return data["releases"]

def dl_url(tag, asset):
    return f"https://github.com/{REPO}/releases/download/{tag}/{asset}"

def blob_url(tag, path):
    return f"https://github.com/{REPO}/blob/{tag}/{path}"

def photo_caption(url: str) -> str:
    """Fallback caption when Nickel does not provide one.

    Captions are now explicit in Nickel (`Photo = { url, caption }`);
    this is only for legacy strings or missing captions.
    """
    if isinstance(url, dict):
        return url.get("caption") or url.get("url", "").rsplit("/", 1)[-1] or "Photo"
    if "user-attachments" in url or "user-images.githubusercontent.com" in url:
        return "Photo"
    return url.rsplit("/", 1)[-1].rsplit(".", 1)[0] or "Photo"


def render_release(r):
    # Jinja template - single source, no bash echo concatenation
    from jinja2 import Environment, FileSystemLoader, StrictUndefined
    tmpl_path = Path(__file__).parent.parent / "templates" / "release.md.j2"
    env = Environment(
        loader=FileSystemLoader(str(tmpl_path.parent)),
        undefined=StrictUndefined,
        keep_trailing_newline=True,
        autoescape=False,
    )
    env.globals["photo_caption"] = photo_caption
    tmpl = env.get_template(tmpl_path.name)
    # Normalize arrays that may be single string in old data
    for k in ("build_guide","ibom","plates","case_files","gerber","schematic","bom_jlc","cpl_jlc","firmware_bin","photos","pcb_renders","design_goals"):
        if k in r and isinstance(r[k], str):
            r[k] = [r[k]]
    # Normalize prose fields so leading indentation in releases.ncl (m%" blocks)
    # does not become markdown code blocks (4-space indent).
    # Use per-line stripping of the common 4-space base indent, preserving
    # hanging indents (5 spaces -> 1 space) and handling mixed 0-indent lines
    # that break textwrap.dedent's common-prefix heuristic.
    for k in ("intro", "errata", "changelog"):
        if k in r and isinstance(r[k], str):
            lines = r[k].splitlines()
            out_lines = []
            for line in lines:
                if line.startswith("    "):
                    out_lines.append(line[4:])
                else:
                    out_lines.append(line.lstrip())
            r[k] = "\n".join(out_lines).strip()
    return tmpl.render(**r).strip() + "\n"

def main():
    import argparse
    from pathlib import Path
    ap = argparse.ArgumentParser()
    ap.add_argument("--tag", help="single tag to render")
    ap.add_argument("--all", action="store_true", help="render all")
    ap.add_argument("--format", choices=["md","html"], default="md")
    ap.add_argument("--out", default=None, help="output dir for --all")
    args = ap.parse_args()

    releases = load_releases()
    by_tag = {r["tag"]: r for r in releases}

    if args.all:
        outdir = Path(args.out or "/tmp/releases-md")
        outdir.mkdir(parents=True, exist_ok=True)
        for tag, r in by_tag.items():
            md = render_release(r)
            if args.format == "md":
                (outdir / f"{tag}.md").write_text(md)
            else:
                try:
                    import markdown
                    html = markdown.markdown(md, extensions=["extra"])
                except Exception:
                    html = f"<pre>{md}</pre>"
                full = f"<!doctype html><html><head><meta charset='utf-8'><link rel='stylesheet' href='https://cdn.simplecss.org/simple.min.css'><title>{r.get('title') or tag}</title></head><body>{html}</body></html>"
                (outdir / f"{tag}.html").write_text(full)
        print(f"Wrote {len(by_tag)} files to {outdir}")
        return

    if not args.tag:
        print("need --tag or --all", file=sys.stderr)
        sys.exit(2)
    r = by_tag.get(args.tag)
    if not r:
        print(f"tag {args.tag} not found in releases.ncl", file=sys.stderr)
        sys.exit(1)
    md = render_release(r)
    if args.format == "html":
        try:
            import markdown
            html = markdown.markdown(md, extensions=["extra"])
        except Exception:
            html = f"<pre>{md}</pre>"
        html = f"<!doctype html><html><head><meta charset='utf-8'><link rel='stylesheet' href='https://cdn.simplecss.org/simple.min.css'><title>{r.get('title') or args.tag}</title></head><body>{html}</body></html>"
        print(html)
    else:
        print(md, end="")

if __name__ == "__main__":
    main()
