#!/usr/bin/env python3
"""Panelize CH32X-36 LHS + RHS into a single JLC/Elecrow panel.

Layout:
  [ left rail 5mm ] ==pTab== [ LHS 0° ] ==pTab== [ right rail 5mm ]
  [ left rail     ] ==pTab== [ gap 3mm ] ==pTab== [ right rail     ]
  [ left rail     ] ==pTab== [ RHS 0° ] ==pTab== [ right rail ]

Rails only left+right (P&P rails, 5 mm) — full-height side rails with
mouse-bites to the central board column. Top/bottom open. Each board gets
2 tabs per side (4 total / board) via KiKit's fixed tab annotator +
mouse-bites (0.5/0.9 mm). Both halves USB-up.

Ref/net scheme is simple suffix: every ref and net gets `_L` or `_R`
(e.g. `SW_1_1_L` / `SW_1_1_R`, `D_1_1_L` / `D_1_1_R`, `U1_L` / `U1_R`).
SW_/D_ refs are not visible on the fab, so no column-offset remapping.

Tested against KiCad 9 (kicad_pcb version 20241229) + KiKit 1.8.x with
KiCad 10.0.5 (pcbnew 10.0).

Usage:
  ./pcb/container-run-kibot.sh -- python3 pcb/panelize_ch32x36.py \
    --lhs pcb/keyboard-ch32x-36-lhs.kicad_pcb \
    --rhs pcb/keyboard-ch32x-36-rhs.kicad_pcb \
    --output pcb/keyboard-ch32x-36-panel.kicad_pcb
"""

import argparse
import sys
from pathlib import Path

# Quiet pcbnew wx noise if available (mirrors splinter/lib/pcbnew_quiet)
try:
    import lib.pcbnew_quiet  # noqa: F401
    from lib.pcbnew_quiet import pcbnew  # type: ignore
except Exception:
    import pcbnew  # type: ignore

from kikit.panelize import Origin, Panel  # type: ignore
from kikit.units import mm  # type: ignore
from kikit.substrate import Substrate  # type: ignore
from kikit.annotations import TabAnnotation  # type: ignore
from shapely.geometry import box as shapely_box  # type: ignore


def stem(path: str) -> str:
    return Path(path).stem.replace("keyboard-ch32x-36-", "")


def build(lhs: str, rhs: str, output: str, rail: int, gap: int, frame_space: int,
          tabs: int, tab_width: int, mb_dia: int, mb_spacing: int, tab_min: int):
    panel = Panel(output)

    # Simple suffix scheme: every ref/net gets _L or _R. SW_/D_ are not
    # visible on board, so no column offset.
    def lhs_ref(n, r):
        return f"{r}_L"
    def lhs_net(n, net):
        return f"{net}_L"
    def rhs_ref(n, r):
        return f"{r}_R"
    def rhs_net(n, net):
        return f"{net}_R"

    # Both halves USB-up. Same bbox (100×96.5), so TopLeft (0, lhs_h + gap)
    # stacks RHS directly under LHS.
    bbox_lhs = panel.appendBoard(
        lhs,
        pcbnew.VECTOR2I(0, 0),
        origin=Origin.TopLeft,
        refRenamer=lhs_ref,
        netRenamer=lhs_net,
        inheritDrc=False,
    )
    lhs_h = bbox_lhs.GetHeight()
    bbox_rhs = panel.appendBoard(
        rhs,
        pcbnew.VECTOR2I(0, lhs_h + gap),
        origin=Origin.TopLeft,
        refRenamer=rhs_ref,
        netRenamer=rhs_net,
        inheritDrc=False,
    )

    # Rails: full-height left/right rails with mousebites to the board column.
    # Use ghost rail substrates for the partition/tab computation, then
    # realize the rails with makeRailsLr. This gives tabs only on left/right
    # (hcount) and none on the horizontal gap between LHS and RHS (vcount=0).
    def _ghost_rails_lr(panel_, hspace_):
        minx, miny, maxx, maxy = panel_.boardsBBox()
        # 1 mm dummy width, placed 2*hspace away — matches KiKit's
        # dummyFramingSubstrate for railslr so partition lines fall in the
        # hspace gap and tabs are generated on left/right only.
        width = 1 * mm
        left_poly = shapely_box(minx - 2 * hspace_ - width, miny,
                                minx - 2 * hspace_, maxy)
        right_poly = shapely_box(maxx + 2 * hspace_, miny,
                                 maxx + 2 * hspace_ + width, maxy)
        left_s = Substrate([])
        left_s.union(left_poly)
        right_s = Substrate([])
        right_s.union(right_poly)
        return [left_s, right_s]

    # Mousebite drill pattern at 0.9mm pitch is ~4.1mm for 5 holes
    # (with default 0.5mm prolongation), wider than a 3mm tab. Ensure the
    # tab is at least 5mm so the pattern stays within the copper.
    if tab_width < 5 * mm:
        tab_width = 5 * mm
    ghost_rails = _ghost_rails_lr(panel, frame_space)
    panel.buildPartitionLineFromBB(ghost_rails)
    panel.buildTabAnnotationsFixed(
        tabs, 0, tab_width, 0, tab_min, ghost_rails
    )
    # Nudge long inner-edge tabs toward the corners: top up 9mm, bottom
    # down 12mm. Short outer edges stay at the fixed annotator positions.
    # LHS inner is the right side; RHS inner is the left side.
    def _nudge_inner(tabs):
        if len(tabs) != 2:
            return
        tabs = sorted(tabs, key=lambda a: a.origin[1])
        tabs[0].origin = (tabs[0].origin[0], tabs[0].origin[1] - 9 * mm)
        tabs[1].origin = (tabs[1].origin[0], tabs[1].origin[1] + 12 * mm)

    for idx, sub in enumerate(panel.substrates):
        right_tabs = [
            a for a in sub.annotations
            if isinstance(a, TabAnnotation) and a.direction[0] < -0.9
        ]
        left_tabs = [
            a for a in sub.annotations
            if isinstance(a, TabAnnotation) and a.direction[0] > 0.9
        ]
        if idx == 0:
            _nudge_inner(right_tabs)
        elif idx == 1:
            _nudge_inner(left_tabs)
    panel.makeRailsLr(rail, hspace=frame_space)
    cuts = panel.buildTabsFromAnnotations(0)
    # Mousebites must sit on the tab side (gap), not on the PCB copper.
    # KiKit offsets from the cut line; +0.25 is PCB side, -0.25 is tab side.
    # No prolongation so holes don't overhang the tab ends.
    panel.makeMouseBites(cuts, diameter=mb_dia, spacing=mb_spacing,
                         offset=-int(0.25 * mm), prolongation=0)

    # Fiducials/tooling centered on the side rails, not at the rail edge.
    # horizontalOffset = rail/2 centers in the 5 mm rail, verticalOffset
    # insets from top/bottom outer edge so the copper is fully on the rail.
    fid_h = rail // 2
    fid_v = 3 * mm
    # Keep tooling slightly separated vertically so it doesn't coincide with
    # the fiducial at the same corner.
    tool_h = rail // 2
    tool_v = 8 * mm
    panel.addCornerFiducials(4, fid_h, fid_v, 1 * mm, 2 * mm)
    panel.addCornerTooling(4, tool_h, tool_v, round(1.152 * mm), solderMaskMargin=round(0.074 * mm))

    panel.save()
    print(f"wrote {output}: LHS {bbox_lhs.GetWidth()/1e6:.1f}x{bbox_lhs.GetHeight()/1e6:.1f}mm + RHS {bbox_rhs.GetWidth()/1e6:.1f}x{bbox_rhs.GetHeight()/1e6:.1f}mm gap {gap/1e6:.1f}mm")


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--lhs", default="pcb/keyboard-ch32x-36-lhs.kicad_pcb")
    ap.add_argument("--rhs", default="pcb/keyboard-ch32x-36-rhs.kicad_pcb")
    ap.add_argument("--output", default="pcb/keyboard-ch32x-36-panel.kicad_pcb")
    ap.add_argument("--rail", type=float, default=5.0, help="side rail width mm")
    ap.add_argument("--gap", type=float, default=3.0, help="vertical gap between LHS/RHS mm")
    ap.add_argument("--frame-space", type=float, default=3.0, help="board-to-rail gap mm")
    ap.add_argument("--tabs", type=int, default=2, help="tabs per side per board")
    ap.add_argument("--tab-width", type=float, default=5.0, help="tab width mm (5mm fits 6×0.9mm mousebites)")
    ap.add_argument("--mb-dia", type=float, default=0.5, help="mouse-bite drill mm")
    ap.add_argument("--mb-spacing", type=float, default=0.9, help="mouse-bite pitch mm")
    ap.add_argument("--tab-min", type=float, default=8.0, help="min tab spacing mm")
    args = ap.parse_args()

    for f in [args.lhs, args.rhs]:
        if not Path(f).is_file():
            sys.exit(f"ERROR {f}: no such board")

    def nm(v): return round(v * mm)

    Path(args.output).resolve().parent.mkdir(parents=True, exist_ok=True)
    build(args.lhs, args.rhs, args.output, nm(args.rail), nm(args.gap),
          nm(args.frame_space), args.tabs, nm(args.tab_width),
          nm(args.mb_dia), nm(args.mb_spacing), nm(args.tab_min))


if __name__ == "__main__":
    main()
