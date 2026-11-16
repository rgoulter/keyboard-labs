#!/usr/bin/env python3
"""
Standalone PCB technical drawing for CNC pykey40.

Dims: overall PCB size, mount-hole positions relative to PCB edges / SW_1_1,
USB connector mid-X and lip on the PCB outline.
"""

from __future__ import annotations

from datetime import date
from pathlib import Path

from build123d import *

from helpers import (
    center_mark,
    ensure_case_import_path,
    project_to_2d,
    svg_to_png,
)

ensure_case_import_path()

from case_pykey40 import (
    PCB_SW_1_1_POSITION,
    PCB_USB_CONNECTOR_MID_X,
    SWITCH_GRID_UNIT,
    derived_dims,
    pcb_mounting_hole_positions_on_pcb,
)
from case_pykey40_constants import PCB_DIM

OUT_DIR = Path(__file__).resolve().parent
OUT_SVG = OUT_DIR / "cnc_pykey40_pcb_a4.svg"
OUT_PNG = OUT_DIR / "cnc_pykey40_pcb_a4.png"

PCB_THICKNESS = 1.6
PCB_CORNER_R = 2.25
USB_LIP_W = 11.0  # connector 9 + extraW 2
USB_LIP_H = 4.0
SCALE = 0.80
CENTER_MARK_HALF = 2.0


def make_pcb_part() -> Part:
    w, l = PCB_DIM
    with BuildPart() as bp:
        with BuildSketch():
            RectangleRounded(w, l, PCB_CORNER_R, align=(Align.MIN, Align.MIN))
            with Locations((PCB_USB_CONNECTOR_MID_X, 0)):
                Rectangle(USB_LIP_W, USB_LIP_H, align=(Align.CENTER, Align.CENTER))
        extrude(amount=PCB_THICKNESS)
        for hx, hy in pcb_mounting_hole_positions_on_pcb():
            with Locations((hx, hy, 0)):
                Hole(1.1, depth=PCB_THICKNESS + 0.1)
    return bp.part


def _dim_arrow_v(x: float, y_lo: float, y_hi: float, arrow_len: float, half_w: float):
    """Vertical dim line + V-arrows between y_lo and y_hi at page X."""
    edges = [Edge.make_line((x, y_lo, 0), (x, y_hi, 0))]
    for y_end, s in ((y_lo, 1), (y_hi, -1)):
        edges.append(Edge.make_line((x, y_end, 0), (x - half_w, y_end + s * arrow_len, 0)))
        edges.append(Edge.make_line((x, y_end, 0), (x + half_w, y_end + s * arrow_len, 0)))
    return edges


def _dim_arrow_h(y: float, x_lo: float, x_hi: float, arrow_len: float, half_w: float):
    """Horizontal dim line + V-arrows between x_lo and x_hi at page Y."""
    edges = [Edge.make_line((x_lo, y, 0), (x_hi, y, 0))]
    for x_end, s in ((x_lo, 1), (x_hi, -1)):
        edges.append(Edge.make_line((x_end, y, 0), (x_end + s * arrow_len, y - half_w, 0)))
        edges.append(Edge.make_line((x_end, y, 0), (x_end + s * arrow_len, y + half_w, 0)))
    return edges


def main() -> None:
    w, l = PCB_DIM
    pcb = make_pcb_part()
    # Mirror about YZ so USB lip is top-left after viewport_up X-flip.
    pcb_draw = mirror(Pos(-w / 2, -l / 2, -PCB_THICKNESS / 2) * pcb, about=Plane.YZ)

    holes = pcb_mounting_hole_positions_on_pcb()
    # Page X tracks physical X after YZ-mirror + top viewport (USB / SW_1_1 LHS).
    sw11 = PCB_SW_1_1_POSITION
    usb_x = PCB_USB_CONNECTOR_MID_X
    xs = sorted({round(h[0], 6) for h in holes})
    ys = sorted({round(h[1], 6) for h in holes})

    border = TechnicalDrawing(
        designed_by="rgoulter",
        design_date=date.today(),
        page_size=PageSize.A4,
        title="CNC pykey40 PCB",
        sub_title="outline + mounts + USB lip",
        drawing_number="KL-CNC-PY40-PCB",
        sheet_number=1,
        drawing_scale=1,
        nominal_text_size=4.0,
    )
    page = border.bounding_box().size
    # Shift geometry slightly up to leave room for hole-chain + overall below.
    page_origin = (page.X * -0.02, page.Y * 0.14)

    drafting = Draft(
        font_size=3.2,
        decimal_precision=2,
        display_units=False,
        extension_gap=0.8,
        head_type=HeadType.STRAIGHT,
        line_width=0.5,
        arrow_length=2.8,
    )

    vis, hid = project_to_2d(
        pcb_draw, (0, 0, 200), (0, -1, 0), page_origin, SCALE
    )

    def mx(x_phys: float) -> float:
        return page_origin[0] + (x_phys - w / 2) * SCALE

    def my(y: float) -> float:
        return page_origin[1] - (y - l / 2) * SCALE

    annotations: list = []
    labels: list = []
    centerlines: list = []
    dim_edges: list = []

    half = CENTER_MARK_HALF * SCALE
    for hx, hy in holes:
        centerlines.extend(center_mark(mx(hx), my(hy), half))
    centerlines.extend(center_mark(mx(sw11[0]), my(sw11[1]), half))

    bb = Curve(vis).bounding_box()
    front_y, back_y = bb.max.Y, bb.min.Y

    peri = Pos(*bb.center()) * Rectangle(bb.size.X, bb.size.Y)

    # --- Overall dims on OUTER rails (large offsets, clear of hole chains) ---
    annotations.append(
        ExtensionLine(
            border=peri.edges().sort_by(Axis.Y)[0],  # page-bottom = PCB back
            offset=24 * MM,
            draft=drafting,
            label=f"{w:.0f}",
        )
    )
    annotations.append(
        ExtensionLine(
            border=peri.edges().sort_by(Axis.X)[-1],  # page-right
            offset=22 * MM,
            draft=drafting,
            label=f"{l:.0f}",
        )
    )

    gap = drafting.extension_gap
    arrow_len = drafting.arrow_length
    arrow_half_w = arrow_len / 3.0

    # --- Horizontal hole chain BELOW PCB, above overall-width rail ---
    # Page L→R = phys left→right (USB / SW_1_1 on LHS).
    hpx = [mx(x) for x in xs]
    hpy = [my(y) for y in ys]
    hpx_sorted = sorted(hpx)
    pcb_page_left = mx(0)
    pcb_page_right = mx(w)
    edge_and_holes_x = [pcb_page_left] + hpx_sorted + [pcb_page_right]
    vals_ltr = [xs[0] - 0.0, xs[1] - xs[0], xs[2] - xs[1], w - xs[2]]
    chain_y = back_y - 10.0  # between PCB and overall (overall ~ back_y-22)
    for (xa, xb), val in zip(
        zip(edge_and_holes_x[:-1], edge_and_holes_x[1:]), vals_ltr
    ):
        x_lo, x_hi = (xa, xb) if xa < xb else (xb, xa)
        # Extension ticks from PCB back edge down to chain rail
        dim_edges.append(Edge.make_line((xa, back_y - gap, 0), (xa, chain_y + gap, 0)))
        dim_edges.append(Edge.make_line((xb, back_y - gap, 0), (xb, chain_y + gap, 0)))
        dim_edges.extend(_dim_arrow_h(chain_y, x_lo, x_hi, arrow_len, arrow_half_w))
        mid_x = (xa + xb) / 2
        lbl = Text(f"{val:.2f}", 3.0)
        lbl.position = Vector(mid_x, chain_y - 5.5)
        labels.append(lbl)

    # --- Vertical hole chain on LEFT with clear gap; text outside arrows ---
    feat_x = hpx_sorted[0]
    y_dim_x = feat_x - 34.0
    front_edge_y = my(0)
    y_segs = [
        (hpy[2], hpy[1], ys[2] - ys[1]),
        (hpy[1], hpy[0], ys[1] - ys[0]),
        (hpy[0], front_edge_y, ys[0] - 0.0),
    ]
    for y_a, y_b, val in y_segs:
        y_lo, y_hi = (y_a, y_b) if y_a < y_b else (y_b, y_a)
        dim_edges.append(Edge.make_line((feat_x - gap, y_a, 0), (y_dim_x + gap, y_a, 0)))
        dim_edges.append(Edge.make_line((feat_x - gap, y_b, 0), (y_dim_x + gap, y_b, 0)))
        dim_edges.extend(_dim_arrow_v(y_dim_x, y_lo, y_hi, arrow_len, arrow_half_w))
        mid_y = (y_a + y_b) / 2
        lbl = Text(f"{val:.2f}", 3.2)
        lbl.position = Vector(y_dim_x - 14.0, mid_y)
        labels.append(lbl)

    # SW_1_1 near its mark (clear of USB callout block)
    sw_lbl = Text(
        f"SW_1_1 ({PCB_SW_1_1_POSITION[0]:.1f}, {PCB_SW_1_1_POSITION[1]:.1f})",
        2.8,
    )
    # Place to the RIGHT of the mark so it clears the left vertical hole-chain.
    sw_lbl.position = Vector(mx(sw11[0]) + 10, my(sw11[1]) + 5)
    labels.append(sw_lbl)

    # USB callout block ABOVE geometry (single clear corner, no dim collision)
    usb_block_x = page_origin[0] - 5
    usb_block_y = front_y + 20
    usb_hdr = Text("USB callout (PCB-local)", 2.6)
    usb_hdr.position = Vector(usb_block_x, usb_block_y + 7)
    labels.append(usb_hdr)
    usb_lbl = Text(
        f"mid-X {PCB_USB_CONNECTOR_MID_X:.3f}  "
        f"(= SW_1_1.x + 1.5×{SWITCH_GRID_UNIT})",
        2.8,
    )
    usb_lbl.position = Vector(usb_block_x, usb_block_y)
    labels.append(usb_lbl)
    lip_lbl = Text(f"lip {USB_LIP_W:.0f}×{USB_LIP_H:.0f} (y=−2..+2 at mid-X)", 2.6)
    lip_lbl.position = Vector(usb_block_x, usb_block_y - 7)
    labels.append(lip_lbl)

    title = Text("Top — PCB outline (USB top-left)", 4.0)
    title.position = Vector(page_origin[0] + 55, front_y + 20)
    labels.append(title)

    note = Text(
        f"PCB {w:.0f}×{l:.0f}×{PCB_THICKNESS}  |  5× mount ⌀2.2  |  "
        f"mounts from SW_1_1 + grid offsets",
        2.6,
    )
    note.position = Vector(page_origin[0], back_y - 36)
    labels.append(note)

    d = derived_dims()
    note2 = Text(
        f"case_pcb_position {tuple(round(v, 3) for v in d['case_pcb_position'])} "
        f"(placement in case; this sheet is PCB-local)",
        2.3,
    )
    note2.position = Vector(page_origin[0], back_y - 43)
    labels.append(note2)

    exporter = ExportSVG(unit=Unit.MM)
    exporter.add_layer("Visible")
    exporter.add_layer(
        "Hidden", line_color=(0x63, 0x63, 0x63), line_type=LineType.ISO_DOT
    )
    exporter.add_layer(
        "Center", line_color=(0x40, 0x40, 0x40), line_type=LineType.ISO_DASH_DOT
    )
    exporter.add_layer("Annotations", fill_color=(0, 0, 0), line_color=(0, 0, 0))
    exporter.add_layer(
        "DimLines", line_color=(0, 0, 0), line_weight=drafting.line_width
    )
    exporter.add_shape(list(vis), layer="Visible")
    if hid:
        exporter.add_shape(list(hid), layer="Hidden")
    if centerlines:
        exporter.add_shape(centerlines, layer="Center")
    if dim_edges:
        exporter.add_shape(dim_edges, layer="DimLines")
    exporter.add_shape(border.edges(), layer="Visible")
    glyph_faces = [f for f in border.faces() if f.area < 20]
    if glyph_faces:
        exporter.add_shape(glyph_faces, layer="Annotations")
    if annotations:
        exporter.add_shape(annotations, layer="Annotations")
    exporter.add_shape(labels, layer="Annotations")
    exporter.write(str(OUT_SVG))
    print(f"Wrote {OUT_SVG}")
    svg_to_png(OUT_SVG, OUT_PNG)


if __name__ == "__main__":
    main()
