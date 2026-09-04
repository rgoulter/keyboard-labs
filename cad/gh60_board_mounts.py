#!/usr/bin/env python3
# /// script
# requires-python = ">=3.11"
# dependencies = ["build123d"]
# ///
"""
GH60 board outline + mount points — SVG constructed with build123d.

Minimal visual-confirmation SVG for KiCad import:
 just the board rect and the 4 mount holes as circles.

Board dimensions & mount positions come from
``scripts/kicad_helpers/gh60_dimensions.py``

Usage:
  uv run scripts/gh60_board_build123d.py
  uv run scripts/gh60_board_build123d.py --out /tmp/gh60_build123d.svg
"""

import argparse
import sys
from pathlib import Path

# Allow import from scripts/kicad_helpers when run via uv (cwd = repo root)
sys.path.insert(0, str(Path(__file__).parent / "kicad_helpers"))
sys.path.insert(0, "scripts/kicad_helpers")

import gh60_dimensions as G  # type: ignore

from build123d import Align, BuildSketch, Circle, Location, Locations, Mode, Rectangle
from build123d import Unit
from build123d.exporters import ExportSVG


BOARD_W = G.BOARD_WIDTH_MM
BOARD_H = G.BOARD_HEIGHT_MM

# Mounts: (name, x_top, y_top) in mm from top-left origin
MOUNTS_TOP = [
    ("H1", G.H1_X_TENTHS * G.TENTHS_TO_MM, G.H1_Y_TENTHS * G.TENTHS_TO_MM),
    ("H2", G.H2_X_TENTHS * G.TENTHS_TO_MM, G.H2_Y_TENTHS * G.TENTHS_TO_MM),
    ("H3", G.H3_X_TENTHS * G.TENTHS_TO_MM, G.H3_Y_TENTHS * G.TENTHS_TO_MM),
    ("H4", G.H4_X_TENTHS * G.TENTHS_TO_MM, G.H4_Y_TENTHS * G.TENTHS_TO_MM),
]

MOUNT_D = 2.5  # mm - for visual confirmtion doesn't matter
MOUNT_R = MOUNT_D / 2


def build_outline_face():
    """Board outline as a Face with lower-left at (0,0)."""
    with BuildSketch() as s:
        Rectangle(BOARD_W, BOARD_H, align=(Align.MIN, Align.MIN))

    return s.sketch.face()


def build_mount_faces():
    """4 mount holes as circles at bottom-left origin."""
    with BuildSketch() as s:
        for _name, x_top, y_top in MOUNTS_TOP:
            y_bot = BOARD_H - y_top
            with Locations(Location((x_top, y_bot))):
                Circle(MOUNT_R, mode=Mode.ADD)

    return s.sketch


def export_build123d_svg(out_path: Path) -> Path:
    outline = build_outline_face()
    mounts_sketch = build_mount_faces()

    # With margin=0 and fit_to_stroke=False
    #  the viewBox is exactly (0, -H) .. (W, 0),
    #  so the rect lower-left coincides with the KiCad import point.
    exp = ExportSVG(unit=Unit.MM, margin=0.0, fit_to_stroke=False, line_weight=0.25)
    exp.add_layer("Outline", line_color=(0, 0, 0), fill_color=None, line_weight=0.35)
    exp.add_layer("Mounts", line_color=(220, 20, 20), fill_color=None, line_weight=0.35)
    exp.add_shape(outline, layer="Outline")

    for f in mounts_sketch.faces():
        exp.add_shape(f, layer="Mounts")

    exp.write(str(out_path))

    return out_path


def main() -> None:
    ap = argparse.ArgumentParser(description="GH60 outline + mounts via build123d → SVG (KiCad-importable)")
    ap.add_argument("--out", type=Path, default=Path("gh60_mounts.svg"), help="output SVG path")

    args = ap.parse_args()

    out = export_build123d_svg(args.out)

    print(f"Wrote {out}")


if __name__ == "__main__":
    main()
