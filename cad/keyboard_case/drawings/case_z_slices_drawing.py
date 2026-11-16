#!/usr/bin/env python3
"""
Horizontal Z-slices of the CNC pykey40 case (thin-slab intersect).

Three panels on one A3 sheet:
  - bottom plate (Z through bottom height)
  - lower cavity (mount posts visible)
  - upper cavity

PCB outline (red) overlaid at case_pcb_position for reference.
Annotates the Z height used for each cut.
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
    CASE_LOW_PROFILE_MX_UPPER_CAVITY_HEIGHT,
    PCB_USB_CONNECTOR_MID_X,
    derived_dims,
    make_cnc_pykey40_case,
    mount_hole_positions_case,
)
from case_pykey40_constants import PCB_DIM

OUT_DIR = Path(__file__).resolve().parent
OUT_SVG = OUT_DIR / "cnc_pykey40_z_slices_a3.svg"
OUT_PNG = OUT_DIR / "cnc_pykey40_z_slices_a3.png"

SCALE = 0.50
DETAIL_SCALE = 1.35
SLAB_T = 0.05
MARGIN = 14.0
PCB_THICKNESS = 1.6
PCB_CORNER_R = 2.25
USB_LIP_W = 11.0
USB_LIP_H = 4.0
# Room above first panel for multi-line legend
LEGEND_BAND = 16.0


def make_pcb(z_bottom: float) -> Part:
    w, l = PCB_DIM
    with BuildPart() as bp:
        with BuildSketch():
            RectangleRounded(w, l, PCB_CORNER_R, align=(Align.MIN, Align.MIN))
            with Locations((PCB_USB_CONNECTOR_MID_X, 0)):
                Rectangle(USB_LIP_W, USB_LIP_H, align=(Align.CENTER, Align.CENTER))
        extrude(amount=PCB_THICKNESS)
    return Pos(0, 0, z_bottom) * bp.part


def main() -> None:
    d = derived_dims()
    ow, ol, oh = d["case_outer"]
    pcb_xy = d["case_pcb_position"]
    bottom_h = CASE_BOTTOM_HEIGHT
    lower_h = CASE_LOWER_CAVITY_HEIGHT
    upper_h = CASE_LOW_PROFILE_MX_UPPER_CAVITY_HEIGHT

    z_bottom = bottom_h / 2.0  # 1.0 — through bottom plate
    z_lower = bottom_h + lower_h / 2.0  # 4.0 — lower cavity + posts
    z_upper = bottom_h + lower_h + upper_h / 2.0  # 9.0 — upper cavity
    z_pcb = CASE_BOTTOM_HEIGHT + CASE_LOWER_CAVITY_HEIGHT  # 6.0
    z_pcb_mid = z_pcb + PCB_THICKNESS / 2.0  # 6.8

    case = make_cnc_pykey40_case(
        cutout_usb_connector=True,
        cutout_feet_holes=False,
        cutout_bumpon_guides=False,
        chamfer_edges=False,
    )
    pcb = Pos(pcb_xy[0], pcb_xy[1], 0) * make_pcb(z_pcb)

    # Thin slab through PCB mid-thickness (truth for PCB outline projection).
    pcb_slab = thin_slab_section(
        pcb,
        center=(ow / 2, ol / 2, z_pcb_mid),
        size=(ow + 40, ol + 40, SLAB_T),
    )

    slices = [
        ("Bottom plate", z_bottom, f"Z={z_bottom:.1f} (through bottom h={bottom_h:.0f})"),
        ("Lower cavity", z_lower, f"Z={z_lower:.1f} (lower cavity + mount posts)"),
        ("Upper cavity", z_upper, f"Z={z_upper:.1f} (upper cavity)"),
    ]

    border = TechnicalDrawing(
        designed_by="rgoulter",
        design_date=date.today(),
        page_size=PageSize.A3,
        title="CNC pykey40 case",
        sub_title="horizontal Z-slices",
        drawing_number="KL-CNC-PY40-ZS",
        sheet_number=1,
        drawing_scale=1,
        nominal_text_size=4.0,
    )
    faces_by_area = sorted(border.faces(), key=lambda f: -f.area)
    frame_bb = faces_by_area[0].bounding_box()
    title_bb = faces_by_area[1].bounding_box()

    case_edges: list = []
    pcb_edges: list = []
    detail_case: list = []
    detail_pcb: list = []
    labels: list = []
    frames: list = []

    # Layout: legend band under top border, then three stacked panels
    usable_top = frame_bb.max.Y - MARGIN
    usable_bot = max(frame_bb.min.Y + MARGIN, title_bb.max.Y + 10.0)
    usable_left = frame_bb.min.X + MARGIN
    usable_right = frame_bb.max.X - MARGIN
    # Panels start below the legend band
    panels_top = usable_top - LEGEND_BAND
    panel_h = (panels_top - usable_bot) / 3.0
    # Main view center biased left; leave ~95 mm on right for USB detail insets
    main_right = usable_right - 95.0
    cx = usable_left + (main_right - usable_left) * 0.48

    def center_mirror(sec: Part, z_ref: float) -> Part:
        centered = Pos(-ow / 2, -ol / 2, -z_ref) * sec
        return mirror(centered, about=Plane.YZ)

    # Shared PCB drawing solid (centered at PCB mid-Z so top projection matches case)
    pcb_draw = center_mirror(pcb_slab, z_pcb_mid)

    # Legend ABOVE panels, left-aligned with main panel column (not sheet edge)
    holes = mount_hole_positions_case()
    legend_lines = [
        f"Top views of horizontal sections (USB top-left). Outer {ow:.0f}×{ol:.0f}×{oh:.0f}.",
        f"Red = PCB outline (case placement). Thin-slab ±{SLAB_T/2:.3f} mm.",
        f"Mount posts at Z={z_lower:.1f}: {len(holes)}× ⌀6. Detail insets: USB notch @ {DETAIL_SCALE:.2f}×.",
    ]
    # Probe main view width so legend shares the panel column X
    _probe = thin_slab_section(
        case, center=(ow / 2, ol / 2, z_bottom), size=(ow + 20, ol + 20, SLAB_T)
    )
    _probe_draw = center_mirror(_probe, z_bottom)
    _pvis, _ = project_to_2d(_probe_draw, (0, 0, 200), (0, -1, 0), (0, 0), SCALE)
    _pbb = Curve(_pvis).bounding_box()
    legend_x = cx - _pbb.size.X / 2.0
    legend_y0 = usable_top - 3.5
    for i, line in enumerate(legend_lines):
        t = Text(line, 2.8, align=(Align.MIN, Align.MIN))
        t.position = Vector(legend_x, legend_y0 - i * 4.2)
        labels.append(t)

    for i, (name, z_cut, note) in enumerate(slices):
        sec = thin_slab_section(
            case,
            center=(ow / 2, ol / 2, z_cut),
            size=(ow + 20, ol + 20, SLAB_T),
        )
        draw = center_mirror(sec, z_cut)

        vis0, _ = project_to_2d(draw, (0, 0, 200), (0, -1, 0), (0, 0), SCALE)
        bb0 = Curve(vis0).bounding_box()
        panel_top = panels_top - i * panel_h
        panel_bot = panel_top - panel_h
        panel_cy = (panel_top + panel_bot) / 2.0 - 2.0
        # Slight downward bias so title sits above; USB notch toward panel top-left
        origin = (cx - bb0.center().X, panel_cy - bb0.center().Y)

        vis, _ = project_to_2d(draw, (0, 0, 200), (0, -1, 0), origin, SCALE)
        case_edges.extend(vis)

        # Always overlay PCB outline (red) at same placement / top view
        pvis, _ = project_to_2d(pcb_draw, (0, 0, 200), (0, -1, 0), origin, SCALE)
        pcb_edges.extend(pvis)

        bb = Curve(vis).bounding_box()
        t1 = Text(f"{name} — {note}", 3.4, align=(Align.MIN, Align.MIN))
        t1.position = Vector(bb.min.X, bb.max.Y + 5)
        labels.append(t1)

        # USB-notch detail inset (right of main panel) — bottom + lower only
        if i < 2:
            dvis0, _ = project_to_2d(draw, (0, 0, 200), (0, -1, 0), (0, 0), DETAIL_SCALE)
            dbb0 = Curve(dvis0).bounding_box()
            detail_cx = main_right + 42.0
            detail_cy = panel_cy + 4.0
            usb_focus_x = dbb0.min.X + dbb0.size.X * 0.18
            usb_focus_y = dbb0.max.Y - dbb0.size.Y * 0.12
            d_origin = (detail_cx - usb_focus_x, detail_cy - usb_focus_y)
            dvis, _ = project_to_2d(draw, (0, 0, 200), (0, -1, 0), d_origin, DETAIL_SCALE)
            dpvis, _ = project_to_2d(
                pcb_draw, (0, 0, 200), (0, -1, 0), d_origin, DETAIL_SCALE
            )

            inset_w, inset_h = 78.0, 42.0
            frame = Pos(detail_cx, detail_cy) * Rectangle(inset_w, inset_h)
            frames.append(frame)

            def in_inset(edges):
                kept = []
                for e in edges:
                    ebb = e.bounding_box()
                    if (
                        abs(ebb.center().X - detail_cx) < inset_w / 2 + 2
                        and abs(ebb.center().Y - detail_cy) < inset_h / 2 + 2
                    ):
                        kept.append(e)
                return kept

            detail_case.extend(in_inset(dvis))
            detail_pcb.extend(in_inset(dpvis))

            dt = Text("USB notch detail", 2.4, align=(Align.MIN, Align.MIN))
            dt.position = Vector(detail_cx - 28, detail_cy + inset_h / 2 + 3)
            labels.append(dt)

    exporter = ExportSVG(unit=Unit.MM)
    exporter.add_layer("Visible", line_weight=0.35)
    exporter.add_layer("PCB", line_color=(0xC0, 0x20, 0x20), line_weight=0.40)
    exporter.add_layer("Detail", line_weight=0.45)
    exporter.add_layer("DetailPCB", line_color=(0xC0, 0x20, 0x20), line_weight=0.50)
    exporter.add_layer("Frames", line_color=(0x80, 0x80, 0x80), line_weight=0.25)
    exporter.add_layer("Annotations", fill_color=(0, 0, 0), line_color=(0, 0, 0))
    exporter.add_shape(case_edges, layer="Visible")
    if pcb_edges:
        exporter.add_shape(pcb_edges, layer="PCB")
    if detail_case:
        exporter.add_shape(detail_case, layer="Detail")
    if detail_pcb:
        exporter.add_shape(detail_pcb, layer="DetailPCB")
    if frames:
        exporter.add_shape([e for fr in frames for e in fr.edges()], layer="Frames")
    exporter.add_shape(border.edges(), layer="Visible")
    glyph_faces = [f for f in border.faces() if f.area < 20]
    if glyph_faces:
        exporter.add_shape(glyph_faces, layer="Annotations")
    exporter.add_shape(labels, layer="Annotations")
    exporter.write(str(OUT_SVG))
    print(f"Wrote {OUT_SVG}")
    svg_to_png(OUT_SVG, OUT_PNG, dpi=120)


if __name__ == "__main__":
    main()
