"""Shared TechDraw helpers for CNC pykey40 case drawings."""

from __future__ import annotations

import shutil
import subprocess
from pathlib import Path

from build123d import *


def project_to_2d(
    part: Part,
    viewport_origin: VectorLike,
    viewport_up: VectorLike,
    page_origin: VectorLike,
    scale_factor: float = 1.0,
    look_at: VectorLike = (0, 0, 0),
) -> tuple[ShapeList[Edge], ShapeList[Edge]]:
    """Project after scaling about shared origin (0,0,0).

    build123d ``scale()`` defaults to each object's location; after Pos-centering
    that location ≠ origin, so multi-part overlays misalign unless about=(0,0,0).
    """
    scaled = (
        part if scale_factor == 1.0 else scale(part, scale_factor, about=(0, 0, 0))
    )
    visible, hidden = scaled.project_to_viewport(
        viewport_origin, viewport_up, look_at=look_at
    )
    visible = [Pos(*page_origin) * e for e in visible]
    hidden = [Pos(*page_origin) * e for e in hidden]
    return ShapeList(visible), ShapeList(hidden)


def center_mark(cx: float, cy: float, half: float) -> list:
    return [
        Edge.make_line((cx - half, cy, 0), (cx + half, cy, 0)),
        Edge.make_line((cx, cy - half, 0), (cx, cy + half, 0)),
    ]


def svg_to_png(svg_path: Path, png_path: Path, dpi: int = 150) -> None:
    """Rasterize SVG via rsvg-convert (PATH or nixpkgs#librsvg)."""
    rsvg = shutil.which("rsvg-convert")
    if rsvg:
        cmd = [
            rsvg,
            "-f",
            "png",
            "-b",
            "white",
            "-d",
            str(dpi),
            "-p",
            str(dpi),
            "-o",
            str(png_path),
            str(svg_path),
        ]
    else:
        cmd = [
            "nix",
            "shell",
            "nixpkgs#librsvg",
            "-c",
            "rsvg-convert",
            "-f",
            "png",
            "-b",
            "white",
            "-d",
            str(dpi),
            "-p",
            str(dpi),
            "-o",
            str(png_path),
            str(svg_path),
        ]
    subprocess.run(cmd, check=True)
    print(f"Wrote {png_path}")


def ensure_case_import_path() -> Path:
    """Put ``cad/keyboard_case`` on sys.path; return that directory."""
    import sys

    case_dir = Path(__file__).resolve().parents[1]
    if str(case_dir) not in sys.path:
        sys.path.insert(0, str(case_dir))
    return case_dir


def thin_slab_section(
    solid: Part,
    *,
    center: tuple[float, float, float],
    size: tuple[float, float, float],
) -> Part:
    """Intersect ``solid`` with a thin box (horizontal or vertical cut)."""
    slab = Pos(*center) * Box(
        size[0],
        size[1],
        size[2],
        align=(Align.CENTER, Align.CENTER, Align.CENTER),
    )
    return solid & slab


def mirror_yz_centered(part: Part, ow: float, ol: float, oh: float) -> Part:
    """Center then mirror about YZ (TOP USB top-left with up=(0,-1,0))."""
    return mirror(Pos(-ow / 2, -ol / 2, -oh / 2) * part, about=Plane.YZ)
