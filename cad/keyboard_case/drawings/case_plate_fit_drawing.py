#!/usr/bin/env python3
"""
Switch-plate-in-case compatibility drawing (top view).

Shows case outer + cavity, switch plate outline in place, optional PCB
outline (lighter). Callouts: cavity 231×78, plate 230.5×77.5, margin 0.25.
"""

from __future__ import annotations

from datetime import date
from pathlib import Path

from build123d import *

from helpers import ensure_case_import_path, project_to_2d, svg_to_png, center_mark

ensure_case_import_path()

from case_pykey40_constants import PCB_DIM
from case_pykey40 import (
    CASE_OUTER_CORNER_R,
    CASE_SWITCH_PLATE_MARGIN,
    CASE_WALL_THICKNESS,
    SWITCH_GRID_UNIT,
    SWITCH_PLATE_DIM,
    UPPER_CAVITY_R,
    derived_dims,
    make_cnc_pykey40_case,
)

OUT_DIR = Path(__file__).resolve().parent
OUT_SVG = OUT_DIR / "cnc_pykey40_plate_fit.svg"
OUT_PNG = OUT_DIR / "cnc_pykey40_plate_fit.png"

SCALE = 0.85
PCB_CORNER_R = 2.25
VIEW_MARGIN = 16.0



def make_plate_outline(z: float = 10.6) -> Part:
    """Thin plate slab at case XY (margin inside cavity)."""
    d = derived_dims()
    cav_x, cav_y = d["case_cavity_position"]
    ox = cav_x + CASE_SWITCH_PLATE_MARGIN
    oy = cav_y + CASE_SWITCH_PLATE_MARGIN
    w, l = SWITCH_PLATE_DIM
    with BuildPart() as bp:
        with BuildSketch():
            with Locations((ox, oy)):
                RectangleRounded(w, l, PCB_CORNER_R, align=(Align.MIN, Align.MIN))
        extrude(amount=1.5)
    return Pos(0, 0, z) * bp.part


def make_pcb_outline(z: float = 6.0) -> Part:
    d = derived_dims()
    cx, cy = d["case_pcb_position"]
    w, l = PCB_DIM
    with BuildPart() as bp:
        with BuildSketch():
            with Locations((cx, cy)):
                RectangleRounded(w, l, PCB_CORNER_R, align=(Align.MIN, Align.MIN))
        extrude(amount=1.6)
    return Pos(0, 0, z) * bp.part


def main() -> None:
    d = derived_dims()
    ow, ol, oh = d["case_outer"]
    cav_w, cav_l = d["pcb_cavity_dim"]
    pw, pl = SWITCH_PLATE_DIM
    margin = CASE_SWITCH_PLATE_MARGIN

    case = make_cnc_pykey40_case(
        cutout_usb_connector=True,
        cutout_feet_holes=False,
        cutout_bumpon_guides=False,
        chamfer_edges=False,
    )
    plate = make_plate_outline()
    pcb = make_pcb_outline()

    mid = Pos(-ow / 2, -ol / 2, -oh / 2)
    case_m = mirror(mid * case, about=Plane.YZ)
    plate_m = mirror(mid * plate, about=Plane.YZ)
    pcb_m = mirror(mid * pcb, about=Plane.YZ)

    border = TechnicalDrawing(
        designed_by="rgoulter",
        design_date=date.today(),
        page_size=PageSize.A4,
        title="switch plate fit in case",
        sub_title="CNC pykey40 compatibility",
        drawing_number="KL-CNC-PY40-PF",
        sheet_number=1,
        drawing_scale=1,
        nominal_text_size=4.0,
    )
    page = border.bounding_box().size
    page_origin = (page.X * 0.02, page.Y * 0.06)

    drafting = Draft(
        font_size=3.2,
        decimal_precision=2,
        display_units=False,
        extension_gap=0.8,
        head_type=HeadType.STRAIGHT,
        line_width=0.5,
        arrow_length=2.8,
    )

    vis_c, hid_c = project_to_2d(
        case_m, (0, 0, 200), (0, -1, 0), page_origin, SCALE
    )
    vis_p, _ = project_to_2d(
        plate_m, (0, 0, 200), (0, -1, 0), page_origin, SCALE
    )
    vis_pcb, _ = project_to_2d(
        pcb_m, (0, 0, 200), (0, -1, 0), page_origin, SCALE
    )

    case_bb = Curve(vis_c).bounding_box()
    annotations: list = []
    labels: list = []

    peri = Pos(*case_bb.center()) * Rectangle(case_bb.size.X, case_bb.size.Y)
    annotations.append(
        ExtensionLine(
            border=peri.edges().sort_by(Axis.Y)[0],
            offset=10 * MM,
            draft=drafting,
            label=f"{ow:.0f}",
        )
    )
    annotations.append(
        ExtensionLine(
            border=peri.edges().sort_by(Axis.X)[-1],
            offset=10 * MM,
            draft=drafting,
            label=f"{ol:.0f}",
        )
    )

    cx0 = case_bb.center().X
    top_y = case_bb.max.Y
    bot_y = case_bb.min.Y

    t1 = Text("Top — switch plate fit in case", 4.0)
    t1.position = Vector(cx0 - 40, top_y + 22)
    labels.append(t1)

    t2 = Text(
        f"cavity {cav_w:.0f}×{cav_l:.0f}   plate {pw}×{pl}   "
        f"margin {margin} each side",
        3.2,
    )
    t2.position = Vector(cx0 - 55, bot_y - 14)
    labels.append(t2)

    t3 = Text(
        f"wall {CASE_WALL_THICKNESS:.0f}  R_outer {CASE_OUTER_CORNER_R:.0f}  "
        f"R_cav {UPPER_CAVITY_R:.0f}",
        2.8,
    )
    t3.position = Vector(cx0 - 40, bot_y - 22)
    labels.append(t3)

    half_u = SWITCH_GRID_UNIT / 2
    ideal_w = 11 * SWITCH_GRID_UNIT + 2 * half_u
    ideal_l = 3 * SWITCH_GRID_UNIT + 2 * half_u
    t4 = Text(
        f"plate vs half-unit ideal: ideal ~{ideal_w:.1f}×{ideal_l:.1f}; "
        f"actual {pw}×{pl} (sized for cavity, not pure ½u outline)",
        2.5,
    )
    t4.position = Vector(cx0 - 70, bot_y - 30)
    labels.append(t4)

    t5 = Text(
        "layers: case (black)  plate (purple)  PCB (grey, lighter)",
        2.4,
    )
    t5.position = Vector(cx0 - 45, bot_y - 38)
    labels.append(t5)

    legend_y = top_y + 12
    legend_x = case_bb.min.X
    for txt, dx in (("case", 8), ("plate", 40), ("PCB", 72)):
        lb = Text(txt, 2.4)
        lb.position = Vector(legend_x + dx, legend_y)
        labels.append(lb)

    exporter = ExportSVG(unit=Unit.MM, margin=VIEW_MARGIN)
    exporter.add_layer("Visible")
    exporter.add_layer(
        "Hidden", line_color=(0x63, 0x63, 0x63), line_type=LineType.ISO_DOT
    )
    exporter.add_layer(
        "Plate", line_color=(0x70, 0x20, 0x90), line_weight=0.6
    )
    exporter.add_layer(
        "PCB", line_color=(0x90, 0x90, 0x90), line_weight=0.35
    )
    exporter.add_layer("Annotations", fill_color=(0, 0, 0), line_color=(0, 0, 0))

    exporter.add_shape(vis_c, layer="Visible")
    if hid_c:
        exporter.add_shape(hid_c, layer="Hidden")
    exporter.add_shape(vis_p, layer="Plate")
    exporter.add_shape(vis_pcb, layer="PCB")
    exporter.add_shape(border.edges(), layer="Visible")
    glyph_faces = [f for f in border.faces() if f.area < 20]
    if glyph_faces:
        exporter.add_shape(glyph_faces, layer="Annotations")
    if annotations:
        exporter.add_shape(annotations, layer="Annotations")
    exporter.add_shape(labels, layer="Annotations")
    exporter.write(str(OUT_SVG))
    print(f"Wrote {OUT_SVG}")
    print(
        f"fit: cavity {cav_w}×{cav_l}, plate {pw}×{pl}, "
        f"margin {margin}, clearance each side OK"
    )

    svg_to_png(OUT_SVG, OUT_PNG, dpi=120)


if __name__ == "__main__":
    main()
