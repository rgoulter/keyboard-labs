#!/usr/bin/env python3
# /// script
# requires-python = ">=3.11"
# dependencies = ["build123d"]
# ///
"""
CH32X-60-improved switch plate — build123d, FR4 1.6mm, GH60 285×94.6
Cutouts: 14×14 MX + 2× stab 7×15 (6 north / 9 south, big hole south) for ≥2U, Ø4.5 H1-H4.
Source: SW_1_1 + U offsets (ch32x_60_positions.scad).
"""

import argparse
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent.parent / "scripts" / "kicad_helpers"))
import gh60_dimensions as G  # type: ignore

from build123d import Align, BuildSketch, Circle, Location, Locations, Mode, Rectangle, RectangleRounded
from build123d import Unit
from build123d.exporters import ExportSVG

# GH60 tray-mount outline (tenths from gh60_dimensions.py)
BOARD_W = G.BOARD_WIDTH_MM
BOARD_H = G.BOARD_HEIGHT_MM
# H1-H4 top-left, tenths → mm
MOUNTS_TOP = [
    (G.H1_X_TENTHS * G.TENTHS_TO_MM, G.H1_Y_TENTHS * G.TENTHS_TO_MM),
    (G.H2_X_TENTHS * G.TENTHS_TO_MM, G.H2_Y_TENTHS * G.TENTHS_TO_MM),
    (G.H3_X_TENTHS * G.TENTHS_TO_MM, G.H3_Y_TENTHS * G.TENTHS_TO_MM),
    (G.H4_X_TENTHS * G.TENTHS_TO_MM, G.H4_Y_TENTHS * G.TENTHS_TO_MM),
]
# Mounts: M2 Dk ≤4.0 → need >4 so screw head passes through soldered plate
MOUNT_D = 4.5
MOUNT_R = MOUNT_D / 2

# Stab: 7×15 (6 north / 9 south of centre, big hole = wire side south), 2U spacing ±11.938
STAB_DX = 11.938
STAB_W = 7
STAB_H = 15
STAB_Y_OFF = 1.5  # stab centre 1.5 south of switch centre

# Switch grid: keep SW_1_1 anchor, compute rest via U (from ch32x_60_improved.py)
U = 19.05
SW_1_1 = [9.15, 8.875]  # centre top-left from pcb 59.15-50, 58.875-50

ROW_WIDTHS = [
    [1]*13 + [2],            # row1: 14 keys, Backspace 2U
    [1.5] + [1]*12 + [1.5],   # row2: Tab 1.5 / \| 1.5
    [1.75] + [1]*11 + [2.25], # row3: Caps 1.75 / Enter 2.25
    [2.25] + [1]*10 + [2.75], # row4: Shift 2.25 / RShift 2.75
    [1.25]*3 + [1.25,1,1,1,1,1] + [1.25]*4,  # row5: 1.25×3 + 1.25+5×1 + 1.25×4
]

def switch_centers():
    pts=[]

    for r, widths in enumerate(ROW_WIDTHS):
        x = 0

        for c, w in enumerate(widths):
            cx = SW_1_1[0] + x + w*U/2 - 9.525
            cy = SW_1_1[1] + r*U
            pts.append((cx, cy, w))
            x += w*U

    return pts

def build_plate():
    pts = switch_centers()

    with BuildSketch() as s:
        RectangleRounded(BOARD_W, BOARD_H, 2.25, align=(Align.MIN, Align.MIN))

        for x_top, y_top in MOUNTS_TOP:
            with Locations(Location((x_top, BOARD_H - y_top))):
                Circle(MOUNT_R, mode=Mode.SUBTRACT)

        hx = G.HALF_HOLE_X_MM
        hy = G.HALF_HOLE_Y_MM
        hr = G.HALF_HOLE_R_MM
        for x0, y0 in [(hx / 2, BOARD_H - hy), (BOARD_W - hx / 2, BOARD_H - hy)]:
            with Locations(Location((x0, y0))):
                Rectangle(hx, 2 * hr, align=(Align.CENTER, Align.CENTER), mode=Mode.SUBTRACT)
        for x0, y0 in [(hx, BOARD_H - hy), (BOARD_W - hx, BOARD_H - hy)]:
            with Locations(Location((x0, y0))):
                Circle(hr, mode=Mode.SUBTRACT)

        for cx, cy, w in pts:
            with Locations(Location((cx, BOARD_H - cy))):
                Rectangle(14, 14, align=(Align.CENTER, Align.CENTER), mode=Mode.SUBTRACT)

            if w >= 2:
                cy_s = BOARD_H - (cy + STAB_Y_OFF)

                for dx in (-STAB_DX, STAB_DX):
                    with Locations(Location((cx+dx, cy_s))):
                        Rectangle(STAB_W, STAB_H, align=(Align.CENTER, Align.CENTER), mode=Mode.SUBTRACT)

    return s.sketch

def export(out: Path):
    sk = build_plate()

    if out.suffix.lower() == ".svg":
        exp = ExportSVG(unit=Unit.MM, margin=0.0, fit_to_stroke=False, line_weight=0.1)

        exp.add_layer("Edge.Cuts", line_color=(0,0,0), fill_color=None, line_weight=0.15)

        for f in sk.faces():
            exp.add_shape(f, layer="Edge.Cuts")

        exp.write(str(out))
    elif out.suffix.lower() == ".dxf":
        from build123d import export_dxf

        export_dxf(sk, str(out))
    else:
        raise SystemExit("out must be .svg or .dxf")

    print(f"Wrote {out}")

if __name__ == "__main__":
    ap = argparse.ArgumentParser(description="CH32X-60-improved plate → SVG/DXF")
    ap.add_argument("--out", type=Path, required=True, help="output .svg or .dxf")

    args = ap.parse_args()

    export(args.out)
