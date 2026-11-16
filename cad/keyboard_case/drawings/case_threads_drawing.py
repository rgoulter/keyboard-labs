#!/usr/bin/env python3
"""
A4 TechDraw-style sheet: CNC pykey40 case top view + M2 tap locations.

Mirrors keyboard-labs intent in:
  cad/docs/freecad-techdraw-threads.md
  cad/keyboard_case/keyboard_case-threads.scad

Exports SVG + PNG (PNG via rsvg-convert).
"""

from __future__ import annotations

from datetime import date
from pathlib import Path

from build123d import *

from helpers import ensure_case_import_path, project_to_2d, svg_to_png, center_mark

ensure_case_import_path()

from case_pykey40 import (
    MOUNT_THREAD_HOLE_TAPPING_DIA,
    derived_dims,
    make_cnc_pykey40_case,
    mount_hole_positions_case,
    thread_dim_chains,
)

OUT_DIR = Path(__file__).resolve().parent
OUT_SVG = OUT_DIR / "cnc_pykey40_threads_a4.svg"
OUT_PNG = OUT_DIR / "cnc_pykey40_threads_a4.png"

# Case ~239×86 on A4 with dim room
SCALE = 0.70
CENTER_MARK_HALF = 2.5  # mm on part



def main() -> None:
    case = make_cnc_pykey40_case(
        cutout_usb_connector=True,
        cutout_feet_holes=False,
        cutout_bumpon_guides=False,
        chamfer_edges=False,
    )
    d = derived_dims()
    ow, ol, oh = d["case_outer"]
    chains = thread_dim_chains()
    holes_case = mount_hole_positions_case()

    # Center, then mirror about YZ so USB lands on the LHS of the sheet.
    # After mirror + viewport_up=(0,-1,0), page X still tracks physical X
    # (phys left / USB → page left). Do NOT remap hole X (that would mirror dims).
    case_centered = mirror(Pos(-ow / 2, -ol / 2, -oh / 2) * case, about=Plane.YZ)
    xs = list(chains["mount_xs_case"])
    ys = list(chains["mount_ys_case"])

    border = TechnicalDrawing(
        designed_by="rgoulter",
        design_date=date.today(),
        page_size=PageSize.A4,
        title="CNC pykey40 case",
        sub_title="5× M2×2.4mm taps",
        drawing_number="KL-CNC-PY40-T",
        sheet_number=1,
        drawing_scale=1,
        nominal_text_size=4.0,
    )
    page_size = border.bounding_box().size

    page_origin = (page_size.X * -0.02, page_size.Y * 0.08)

    drafting = Draft(
        font_size=3.5,
        decimal_precision=2,
        display_units=False,
        extension_gap=0.8,
        head_type=HeadType.STRAIGHT,
        line_width=0.5,  # ExportSVG DimLines line_weight matches this
        arrow_length=3.0,
    )

    # viewport_up=(0,-1,0): model +Y (back) → page −Y, so USB/front is at TOP
    vis, hid = project_to_2d(
        case_centered,
        (0, 0, 200),
        (0, -1, 0),
        page_origin,
        SCALE,
        look_at=(0, 0, 0),
    )
    visible_lines: list = list(vis)
    hidden_lines: list = list(hid)

    def hole_page(hx: float, hy: float) -> tuple[float, float]:
        return (
            page_origin[0] + (hx - ow / 2) * SCALE,
            page_origin[1] - (hy - ol / 2) * SCALE,
        )

    def model_x_to_page(mx: float) -> float:
        return page_origin[0] + (mx - ow / 2) * SCALE

    def model_y_to_page(my: float) -> float:
        return page_origin[1] - (my - ol / 2) * SCALE

    annotations: list = []
    labels: list = []
    centerlines: list = []
    dim_edges: list = []  # manual Y-chain geometry

    half_mark = CENTER_MARK_HALF * SCALE
    for hx, hy in holes_case:
        px, py = hole_page(hx, hy)
        centerlines.extend(center_mark(px, py, half_mark))

    front_y = model_y_to_page(0)  # top of sheet
    back_y = model_y_to_page(ol)  # bottom of sheet
    hpx = [model_x_to_page(xc) for xc in xs]
    hpy = [model_y_to_page(yc) for yc in ys]

    top_bbox = Curve(vis).bounding_box()
    left_x = top_bbox.min.X
    right_x = top_bbox.max.X

    # Full-span hole grid centerlines
    pad = 4.0
    for px in hpx:
        centerlines.append(
            Edge.make_line((px, back_y - pad, 0), (px, front_y + pad, 0))
        )
    for py in hpy:
        centerlines.append(
            Edge.make_line((left_x - pad, py, 0), (right_x + pad, py, 0))
        )

    try:
        perimeter = Pos(*top_bbox.center()) * Rectangle(top_bbox.size.X, top_bbox.size.Y)
        annotations.append(
            ExtensionLine(
                border=perimeter.edges().sort_by(Axis.Y)[0],
                offset=12 * MM,
                draft=drafting,
                label=f"{ow:.0f}",
            )
        )
        annotations.append(
            ExtensionLine(
                border=perimeter.edges().sort_by(Axis.X)[-1],
                offset=12 * MM,
                draft=drafting,
                label=f"{ol:.0f}",
            )
        )

        # --- X chain near front (top of sheet) ---
        # Border on measured features (left edge & hole centres at front hole-row
        # Y); negative offset (L→R border) places the dim line above the case.
        feat_y = hpy[0]
        x_offset = -((front_y - feat_y) + 12.0) * MM
        x_pairs = [
            ((left_x, hpx[0]), chains["x_edge_to_left_mount"]),
            ((hpx[0], hpx[1]), chains["x_left_to_centre_mount"]),
            ((hpx[1], hpx[2]), chains["x_centre_to_right_mount"]),
        ]
        for (x_a, x_b), val in x_pairs:
            annotations.append(
                ExtensionLine(
                    border=[(x_a, feat_y, 0), (x_b, feat_y, 0)],
                    offset=x_offset,
                    draft=drafting,
                    label=f"{val:.2f}",
                )
            )

        # --- Y chain on the left ---
        # Border at left hole-column X between feature Ys so extension lines
        # meet hole centres / front edge; offset leftward. Manual horizontal
        # Text labels (ExtensionLine rotates text along the vertical path).
        feat_x = hpx[0]
        y_dim_x = feat_x - 26.0  # page X of the dimension line
        y_segs = [
            (hpy[2], hpy[1], chains["y_middle_to_back_mount"]),
            (hpy[1], hpy[0], chains["y_front_to_middle_mount"]),
            (hpy[0], front_y, chains["y_edge_to_front_mount"]),
        ]
        # Match Draft/ExtensionLine: gap at feature + overshoot past dim line;
        # STRAIGHT head is a triangle of length arrow_length, half-width size/3.
        gap = drafting.extension_gap
        arrow_len = drafting.arrow_length
        arrow_half_w = arrow_len / 3.0
        for y_a, y_b, val in y_segs:
            y_lo, y_hi = (y_a, y_b) if y_a < y_b else (y_b, y_a)
            # Extension lines: feature → left, translated by gap (like ExtensionLine)
            dim_edges.append(
                Edge.make_line((feat_x - gap, y_a, 0), (y_dim_x - gap, y_a, 0))
            )
            dim_edges.append(
                Edge.make_line((feat_x - gap, y_b, 0), (y_dim_x - gap, y_b, 0))
            )
            # Dimension line (vertical)
            dim_edges.append(Edge.make_line((y_dim_x, y_lo, 0), (y_dim_x, y_hi, 0)))
            # STRAIGHT-ish arrow ticks (two sides of the triangle outline)
            dim_edges.append(
                Edge.make_line(
                    (y_dim_x, y_lo, 0),
                    (y_dim_x - arrow_half_w, y_lo + arrow_len, 0),
                )
            )
            dim_edges.append(
                Edge.make_line(
                    (y_dim_x, y_lo, 0),
                    (y_dim_x + arrow_half_w, y_lo + arrow_len, 0),
                )
            )
            dim_edges.append(
                Edge.make_line(
                    (y_dim_x, y_hi, 0),
                    (y_dim_x - arrow_half_w, y_hi - arrow_len, 0),
                )
            )
            dim_edges.append(
                Edge.make_line(
                    (y_dim_x, y_hi, 0),
                    (y_dim_x + arrow_half_w, y_hi - arrow_len, 0),
                )
            )
            mid_y = (y_a + y_b) / 2
            lbl = Text(f"{val:.2f}", 4.0)
            lbl.position = Vector(y_dim_x - 10.0, mid_y)
            labels.append(lbl)

    except Exception as exc:  # noqa: BLE001
        print(f"WARNING: dimensioning failed ({exc!r})")

    l_view = Text("Top view", 4.0)
    l_view.position = Vector(page_origin[0], front_y + 28)
    labels.append(l_view)

    note = Text("5 threaded holes, M2x2.4mm", 4.0)
    note.position = Vector(page_origin[0], back_y - 18)
    labels.append(note)

    note2 = Text(
        f"pilot ⌀{MOUNT_THREAD_HOLE_TAPPING_DIA}  |  case {ow:.0f}×{ol:.0f}×{oh:.0f}",
        3.0,
    )
    note2.position = Vector(page_origin[0], back_y - 26)
    labels.append(note2)

    # Linework: no fill. Glyphs/arrows: solid black fill (not hollow white-centre).
    exporter = ExportSVG(unit=Unit.MM)
    exporter.add_layer("Visible")
    exporter.add_layer(
        "Hidden", line_color=(0x63, 0x63, 0x63), line_type=LineType.ISO_DOT
    )
    exporter.add_layer(
        "Center", line_color=(0x40, 0x40, 0x40), line_type=LineType.ISO_DASH_DOT
    )
    exporter.add_layer(
        "Annotations",
        fill_color=(0, 0, 0),
        line_color=(0, 0, 0),
    )
    # Manual Y-chain strokes: match Draft.line_width (ExtensionLine pen), not Visible 0.09
    exporter.add_layer(
        "DimLines",
        line_color=(0, 0, 0),
        line_weight=drafting.line_width,
    )
    exporter.add_shape(visible_lines, layer="Visible")
    if hidden_lines:
        exporter.add_shape(hidden_lines, layer="Hidden")
    if centerlines:
        exporter.add_shape(centerlines, layer="Center")
    if dim_edges:
        exporter.add_shape(dim_edges, layer="DimLines")
    # Title-block frame on Visible; small faces (glyphs) on filled Annotations.
    # (Large title-block cell faces must not be filled or they paint black boxes.)
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
