#!/usr/bin/env python3
"""
USB mount cross-sections for CNC pykey40 case.

Two clearly separated panels on A3 landscape:
  1. SIDE — YZ cut through USB mid-X (look along +X)
  2. FRONT — XZ cut through front wall at pocket Y (look along -Y)

Each panel is a titled rectangle; geometry is cropped tightly to the USB
pocket neighborhood (wall + pocket + PCB + USB).

FRONT note: the wall cut (Y≈2) does not intersect the PCB/USB solids
(which sit at Y≳6). Case wall notch comes from the wall slab; PCB/USB
are overlaid from an X-cropped slab at their own Y so the pocket stack
reads clearly.
"""

from __future__ import annotations

from datetime import date
from pathlib import Path

from build123d import *

from helpers import (
    ensure_case_import_path,
    project_to_2d,
    svg_to_png,
    thin_slab_section,
)

ensure_case_import_path()

from case_pykey40 import (
    CASE_BOTTOM_HEIGHT,
    CASE_LOWER_CAVITY_HEIGHT,
    PCB_USB_CONNECTOR_MID_X,
    USB_CONNECTOR_CUTOUT_LENGTH,
    USB_CONNECTOR_HEIGHT,
    USB_CONNECTOR_HOLE_HEIGHT,
    USB_CONNECTOR_HOLE_WIDTH,
    derived_dims,
    make_cnc_pykey40_case,
)
from case_pykey40_constants import PCB_DIM

OUT_DIR = Path(__file__).resolve().parent
OUT_SVG = OUT_DIR / "cnc_pykey40_usb_sections_a3.svg"
OUT_PNG = OUT_DIR / "cnc_pykey40_usb_sections_a3.png"

PCB_THICKNESS = 1.6
PCB_CORNER_R = 2.25
USB_LIP_W = 11.0
SLAB_T = 0.08
MARGIN = 14.0
PANEL_PAD = 10.0
LEGEND_BAND = 18.0
TITLE_BAND = 14.0

SIDE_Y_MIN = -1.0
SIDE_Y_MAX = 18.0
FRONT_CUT_Y = 2.0  # mid wall (thickness 4)
FRONT_COMP_Y = 6.5  # through PCB lip / USB body
FRONT_X_HALF = 10.0
Z_MIN = -0.5
Z_MAX = 13.0


def make_pcb(z_bottom: float) -> Part:
    w, l = PCB_DIM
    with BuildPart() as bp:
        with BuildSketch():
            RectangleRounded(w, l, PCB_CORNER_R, align=(Align.MIN, Align.MIN))
            with Locations((PCB_USB_CONNECTOR_MID_X, 0)):
                Rectangle(USB_LIP_W, 4.0, align=(Align.CENTER, Align.CENTER))
        extrude(amount=PCB_THICKNESS)
    return Pos(0, 0, z_bottom) * bp.part


def make_usb_connector(z_pcb_bottom: float) -> Part:
    ax = PCB_USB_CONNECTOR_MID_X
    ay = -3.0
    az = z_pcb_bottom - 2.0
    return Pos(ax, ay + 7.0 / 2, az) * Box(
        9.0, 7.0, 4.0, align=(Align.CENTER, Align.CENTER, Align.CENTER)
    )


def pocket_cutout_height() -> float:
    margin_above = (USB_CONNECTOR_HOLE_HEIGHT / 2) - (USB_CONNECTOR_HEIGHT / 2)
    return CASE_BOTTOM_HEIGHT + CASE_LOWER_CAVITY_HEIGHT + margin_above


def page_fill_rect(edges, shrink: float = 0.15) -> Face | None:
    """Filled rectangle covering projected edge bbox (schematic body)."""
    if not edges:
        return None
    bb = Curve(list(edges)).bounding_box()
    w = max(bb.size.X - shrink, 0.5)
    h = max(bb.size.Y - shrink, 0.5)
    return Pos(bb.center().X, bb.center().Y) * Rectangle(w, h)


def main() -> None:
    d = derived_dims()
    ow, ol, oh = d["case_outer"]
    pcb_xy = d["case_pcb_position"]
    z_pcb = CASE_BOTTOM_HEIGHT + CASE_LOWER_CAVITY_HEIGHT
    usb_case_x = pcb_xy[0] + PCB_USB_CONNECTOR_MID_X
    cut_h = pocket_cutout_height()

    case = make_cnc_pykey40_case(
        cutout_usb_connector=True,
        cutout_feet_holes=False,
        cutout_bumpon_guides=False,
        chamfer_edges=False,
    )
    pcb = Pos(pcb_xy[0], pcb_xy[1], 0) * make_pcb(z_pcb)
    usb = Pos(pcb_xy[0], pcb_xy[1], 0) * make_usb_connector(z_pcb)

    # Schematic solids (pocket void + local PCB/USB boxes)
    pocket = Pos(usb_case_x, 0, 0) * Box(
        USB_CONNECTOR_HOLE_WIDTH,
        USB_CONNECTOR_CUTOUT_LENGTH,
        cut_h,
        align=(Align.CENTER, Align.MIN, Align.MIN),
    )
    pcb_local = Pos(usb_case_x, pcb_xy[1], z_pcb) * Box(
        USB_CONNECTOR_HOLE_WIDTH + 6,
        16.0,
        PCB_THICKNESS,
        align=(Align.CENTER, Align.MIN, Align.MIN),
    )
    usb_local = usb  # already a box

    z_span = Z_MAX - Z_MIN
    z_mid = (Z_MIN + Z_MAX) / 2.0

    # --- SIDE: YZ slab at USB mid-X (all parts) ---
    side_y_mid = (SIDE_Y_MIN + SIDE_Y_MAX) / 2.0
    side_y_span = SIDE_Y_MAX - SIDE_Y_MIN
    yz_size = (SLAB_T, side_y_span, z_span)
    yz_center = (usb_case_x, side_y_mid, z_mid)

    def yz(solid: Part) -> Part:
        return thin_slab_section(solid, center=yz_center, size=yz_size)

    # --- FRONT case: wall slab; FRONT comps: slab at PCB/USB Y ---
    xz_wall_size = (2 * FRONT_X_HALF, SLAB_T, z_span)
    xz_wall_center = (usb_case_x, FRONT_CUT_Y, z_mid)
    xz_comp_size = (2 * FRONT_X_HALF, SLAB_T, z_span)
    xz_comp_center = (usb_case_x, FRONT_COMP_Y, z_mid)

    def xz_wall(solid: Part) -> Part:
        return thin_slab_section(solid, center=xz_wall_center, size=xz_wall_size)

    def xz_comp(solid: Part) -> Part:
        return thin_slab_section(solid, center=xz_comp_center, size=xz_comp_size)

    def prep(p: Part | None) -> Part | None:
        if p is None or p.volume == 0:
            return None
        return mirror(Pos(-ow / 2, -ol / 2, -oh / 2) * p, about=Plane.YZ)

    CAM_SIDE = ((200.0, 0.0, 0.0), (0.0, 0.0, 1.0))
    CAM_FRONT = ((0.0, -200.0, 0.0), (0.0, 0.0, 1.0))

    side_case = prep(yz(case))
    side_pcb = prep(yz(pcb))
    side_usb = prep(yz(usb))
    side_sch_p = prep(yz(pocket))
    side_sch_pcb = prep(yz(pcb_local))
    side_sch_usb = prep(yz(usb_local))

    front_case = prep(xz_wall(case))
    front_pcb = prep(xz_comp(pcb))
    front_usb = prep(xz_comp(usb))
    front_sch_p = prep(xz_wall(pocket))  # pocket notch at wall Y
    front_sch_pcb = prep(xz_comp(pcb_local))
    front_sch_usb = prep(xz_comp(usb_local))

    layers_side = [
        ("Case", (0x10, 0x10, 0x10), 0.60, side_case),
        ("PCB", (0xC0, 0x20, 0x20), 0.75, side_pcb),
        ("USB", (0x30, 0x30, 0xA0), 0.75, side_usb),
    ]
    layers_front = [
        ("CaseF", (0x10, 0x10, 0x10), 0.60, front_case),
        ("PCBF", (0xC0, 0x20, 0x20), 0.75, front_pcb),
        ("USBF", (0x30, 0x30, 0xA0), 0.75, front_usb),
    ]

    def probe_bb(solids, cam, scale: float):
        edges = []
        for solid in solids:
            if solid is None:
                continue
            vis, _ = project_to_2d(solid, cam[0], cam[1], (0, 0), scale)
            edges.extend(vis)
        return Curve(edges).bounding_box() if edges else None

    side_solids = [s for _, _, _, s in layers_side]
    front_solids = [s for _, _, _, s in layers_front]
    # Include schematic pocket so FRONT bbox covers the notch height
    bb_s1 = probe_bb(side_solids + [side_sch_p], CAM_SIDE, 1.0)
    bb_f1 = probe_bb(front_solids + [front_sch_p], CAM_FRONT, 1.0)
    if bb_s1 is None or bb_f1 is None:
        raise RuntimeError("USB section probe produced empty geometry")

    border = TechnicalDrawing(
        designed_by="rgoulter",
        design_date=date.today(),
        page_size=PageSize.A3,
        title="CNC pykey40 USB mount",
        sub_title="cross-sections (SIDE + FRONT)",
        drawing_number="KL-CNC-PY40-USB",
        sheet_number=1,
        drawing_scale=1,
        nominal_text_size=4.0,
    )
    faces_by_area = sorted(border.faces(), key=lambda f: -f.area)
    frame_bb = faces_by_area[0].bounding_box()
    title_bb = faces_by_area[1].bounding_box()

    usable_left = frame_bb.min.X + MARGIN
    usable_right = frame_bb.max.X - MARGIN
    usable_top = frame_bb.max.Y - MARGIN
    usable_bot = max(frame_bb.min.Y + MARGIN, title_bb.max.Y + 8.0)
    usable_w = usable_right - usable_left

    content_top = usable_top - LEGEND_BAND
    content_bot = usable_bot + 4.0
    content_h = content_top - content_bot

    gap = 12.0
    panel_w = (usable_w - gap) / 2.0
    panel_h = content_h
    side_cx = usable_left + panel_w / 2.0
    front_cx = usable_right - panel_w / 2.0
    panel_cy = (content_top + content_bot) / 2.0

    def inner_box(cx: float):
        left = cx - panel_w / 2.0 + PANEL_PAD
        right = cx + panel_w / 2.0 - PANEL_PAD
        top = content_top - TITLE_BAND
        bot = content_bot + PANEL_PAD
        return left, right, top, bot, (left + right) / 2.0, (top + bot) / 2.0

    s_left, s_right, s_top, s_bot, s_icx, s_icy = inner_box(side_cx)
    f_left, f_right, f_top, f_bot, f_icx, f_icy = inner_box(front_cx)
    s_iw, s_ih = s_right - s_left, s_top - s_bot
    f_iw, f_ih = f_right - f_left, f_top - f_bot

    def fit_scale(bb, iw, ih, target=0.68) -> float:
        sx = (iw * target) / max(bb.size.X, 0.1)
        sy = (ih * target) / max(bb.size.Y, 0.1)
        return min(sx, sy)

    scale_side = max(4.0, min(fit_scale(bb_s1, s_iw, s_ih, 0.68), 10.0))
    scale_front = max(5.0, min(fit_scale(bb_f1, f_iw, f_ih, 0.70), 10.0))

    bb_s = probe_bb(side_solids + [side_sch_p], CAM_SIDE, scale_side)
    bb_f = probe_bb(front_solids + [front_sch_p], CAM_FRONT, scale_front)
    assert bb_s is not None and bb_f is not None

    origin_side = (s_icx - bb_s.center().X, s_icy - bb_s.center().Y)
    origin_front = (f_icx - bb_f.center().X, f_icy - bb_f.center().Y)

    side_frame = Pos(side_cx, panel_cy) * Rectangle(panel_w, panel_h)
    front_frame = Pos(front_cx, panel_cy) * Rectangle(panel_w, panel_h)

    exporter = ExportSVG(unit=Unit.MM)
    labels: list = []
    fill_faces: list[tuple[str, Face]] = []

    def project_and_maybe_fill(solid, cam, origin, scale, fill_layer, fill_rgb):
        if solid is None:
            return []
        vis, _ = project_to_2d(solid, cam[0], cam[1], origin, scale)
        if not vis:
            return []
        fr = page_fill_rect(vis)
        if fr is not None:
            fill_faces.append((fill_layer, fr, fill_rgb))
        return list(vis)

    # Filled schematic bodies first (under edges)
    exporter.add_layer("FillPocket", fill_color=(0xD8, 0xD8, 0xD8), line_color=None, line_weight=0.01)
    exporter.add_layer("FillPCB", fill_color=(0xF0, 0xB0, 0xB0), line_color=None, line_weight=0.01)
    exporter.add_layer("FillUSB", fill_color=(0xB0, 0xB0, 0xE8), line_color=None, line_weight=0.01)

    # SIDE schematic fills + outlines
    for solid, fl, rgb in [
        (side_sch_p, "FillPocket", (0xD8, 0xD8, 0xD8)),
        (side_sch_pcb, "FillPCB", (0xF0, 0xB0, 0xB0)),
        (side_sch_usb, "FillUSB", (0xB0, 0xB0, 0xE8)),
    ]:
        project_and_maybe_fill(solid, CAM_SIDE, origin_side, scale_side, fl, rgb)

    for solid, fl, rgb in [
        (front_sch_p, "FillPocket", (0xD8, 0xD8, 0xD8)),
        (front_sch_pcb, "FillPCB", (0xF0, 0xB0, 0xB0)),
        (front_sch_usb, "FillUSB", (0xB0, 0xB0, 0xE8)),
    ]:
        project_and_maybe_fill(solid, CAM_FRONT, origin_front, scale_front, fl, rgb)

    # Deduplicate fill layers — add shapes
    for fl in ("FillPocket", "FillPCB", "FillUSB"):
        faces = [f for (layer, f, _) in fill_faces if layer == fl]
        if faces:
            exporter.add_shape(faces, layer=fl)

    # True section edges (on top)
    for name, color, weight, solid in layers_side:
        if solid is None:
            continue
        exporter.add_layer(name, line_color=color, line_weight=weight)
        vis, _ = project_to_2d(solid, *CAM_SIDE, origin_side, scale_side)
        if vis:
            exporter.add_shape(list(vis), layer=name)

    for name, color, weight, solid in layers_front:
        if solid is None:
            continue
        exporter.add_layer(name, line_color=color, line_weight=weight)
        vis, _ = project_to_2d(solid, *CAM_FRONT, origin_front, scale_front)
        if vis:
            exporter.add_shape(list(vis), layer=name)

    # Pocket outline (schematic edge) for clarity
    exporter.add_layer("SchPocket", line_color=(0x60, 0x60, 0x60), line_weight=0.35)
    for solid, cam, origin, scale in [
        (side_sch_p, CAM_SIDE, origin_side, scale_side),
        (front_sch_p, CAM_FRONT, origin_front, scale_front),
    ]:
        if solid is None:
            continue
        vis, _ = project_to_2d(solid, cam[0], cam[1], origin, scale)
        if vis:
            exporter.add_shape(list(vis), layer="SchPocket")

    exporter.add_layer("Frames", line_color=(0x70, 0x70, 0x70), line_weight=0.40)
    exporter.add_shape(
        list(side_frame.edges()) + list(front_frame.edges()), layer="Frames"
    )

    t1 = Text("SIDE — YZ @ USB mid-X  (look +X)", 3.8, align=(Align.MIN, Align.MIN))
    t1.position = Vector(side_cx - panel_w / 2 + 6, content_top - 6)
    labels.append(t1)
    t1b = Text(
        f"cut X={usb_case_x:.2f}   Y {SIDE_Y_MIN:.0f}…{SIDE_Y_MAX:.0f}   "
        f"scale ≈{scale_side:.1f}×",
        2.4,
        align=(Align.MIN, Align.MIN),
    )
    t1b.position = Vector(side_cx - panel_w / 2 + 6, content_top - 11.5)
    labels.append(t1b)

    t2 = Text("FRONT — XZ @ wall Y + comps @ PCB Y", 3.8, align=(Align.MIN, Align.MIN))
    t2.position = Vector(front_cx - panel_w / 2 + 6, content_top - 6)
    labels.append(t2)
    t2b = Text(
        f"wall cut Y={FRONT_CUT_Y:.1f}   comps Y={FRONT_COMP_Y:.1f}   "
        f"pocket {USB_CONNECTOR_HOLE_WIDTH:.0f}×{USB_CONNECTOR_CUTOUT_LENGTH:.0f}   "
        f"scale ≈{scale_front:.1f}×",
        2.4,
        align=(Align.MIN, Align.MIN),
    )
    t2b.position = Vector(front_cx - panel_w / 2 + 6, content_top - 11.5)
    labels.append(t2b)

    # Key callouts under each panel (left-aligned inside panel)
    for cx, lines in [
        (
            side_cx,
            [
                "① floor  ② pocket recess  ③ wall",
                "PCB (red) nests above USB (blue)",
            ],
        ),
        (
            front_cx,
            [
                "① wall notch  ② PCB  ③ USB",
                "USB page-right (YZ-mirrored)",
            ],
        ),
    ]:
        base_y = content_bot + 8
        for i, line in enumerate(lines):
            t = Text(line, 2.3, align=(Align.MIN, Align.MIN))
            t.position = Vector(cx - panel_w / 2 + 6, base_y - i * 3.8)
            labels.append(t)

    legend_lines = [
        "Legend: case black / PCB red / USB blue. Filled boxes = schematic pocket·PCB·USB extents.",
        f"Pocket {USB_CONNECTOR_HOLE_WIDTH:.0f}×{USB_CONNECTOR_CUTOUT_LENGTH:.0f}×{cut_h:.0f} (W×L×H). "
        f"PCB Z={z_pcb:.0f}…{z_pcb + PCB_THICKNESS:.1f}. Cropped to USB neighborhood (not full case).",
        "SIDE: Z up, Y into case (wall → pocket → cavity). FRONT: wall notch + PCB/USB overlay.",
    ]
    for i, line in enumerate(legend_lines):
        t = Text(line, 2.6, align=(Align.MIN, Align.MIN))
        t.position = Vector(usable_left + 2, usable_top - 3.5 - i * 4.2)
        labels.append(t)

    exporter.add_layer("Annotations", fill_color=(0, 0, 0), line_color=(0, 0, 0))
    exporter.add_shape(border.edges(), layer="Case")
    glyph_faces = [f for f in border.faces() if f.area < 20]
    if glyph_faces:
        exporter.add_shape(glyph_faces, layer="Annotations")
    exporter.add_shape(labels, layer="Annotations")
    exporter.write(str(OUT_SVG))
    print(f"Wrote {OUT_SVG}")
    print(f"scales: side={scale_side:.2f} front={scale_front:.2f}")
    print(f"side bb ({bb_s.size.X:.1f}×{bb_s.size.Y:.1f}) inner {s_iw:.0f}×{s_ih:.0f}")
    print(f"front bb ({bb_f.size.X:.1f}×{bb_f.size.Y:.1f}) inner {f_iw:.0f}×{f_ih:.0f}")
    svg_to_png(OUT_SVG, OUT_PNG, dpi=120)


if __name__ == "__main__":
    main()
