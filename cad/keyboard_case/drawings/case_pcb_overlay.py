#!/usr/bin/env python3
"""
PCB / USB / switch-plate preview overlay for the CNC pykey40 build123d case.

Mirrors OpenSCAD cnc-pykey40-mx.scad preview children:
  - PCB outline extruded 1.6 mm at case_pcb_position
  - mount-hole markers on the PCB
  - USB connector box + short cable stub
  - switch plate (1.5 mm) at Z = pcb_thickness + 3 above PCB bottom

Exports white-bg PNG top + front (+ optional assembly top).
Also prints / writes HOLE_AUDIT.md and PLATE_AUDIT.md.
"""

from __future__ import annotations

from pathlib import Path

from build123d import *

from helpers import ensure_case_import_path, project_to_2d, svg_to_png

ensure_case_import_path()

from case_pykey40_constants import PCB_DIM
from case_pykey40 import (
    CASE_BOTTOM_HEIGHT,
    CASE_LOWER_CAVITY_HEIGHT,
    PCB_SW_1_1_POSITION,
    PCB_SWITCH_PLATE_POSITION,
    PCB_USB_CONNECTOR_MID_X,
    SWITCH_GRID_COLS,
    SWITCH_GRID_ROWS,
    SWITCH_GRID_UNIT,
    SWITCH_PLATE_DIM,
    USB_CONNECTOR_CUTOUT_LENGTH,
    USB_CONNECTOR_HOLE_WIDTH,
    derived_dims,
    make_cnc_pykey40_case,
    mount_hole_positions_case,
    pcb_mounting_hole_positions_on_pcb,
    thread_dim_chains,
)

OUT_DIR = Path(__file__).resolve().parent
OUT_SVG_TOP = OUT_DIR / "cnc_pykey40_pcb_overlay_top.svg"
OUT_PNG_TOP = OUT_DIR / "cnc_pykey40_pcb_overlay_top.png"
OUT_SVG_FRONT = OUT_DIR / "cnc_pykey40_pcb_overlay_front.svg"
OUT_PNG_FRONT = OUT_DIR / "cnc_pykey40_pcb_overlay_front.png"
OUT_SVG_ASM = OUT_DIR / "cnc_pykey40_pcb_overlay_assembly_top.svg"
OUT_PNG_ASM = OUT_DIR / "cnc_pykey40_pcb_overlay_assembly_top.png"
OUT_AUDIT = OUT_DIR / "HOLE_AUDIT.md"
OUT_PLATE_AUDIT = OUT_DIR / "PLATE_AUDIT.md"

PCB_THICKNESS = 1.6
PCB_CORNER_R = 2.25  # jj40 CORNER_R
PCB_MOUNT_HOLE_DIA = 2.2
SWITCH_PLATE_THICKNESS = 1.5
PCB_SWITCH_PLATE_DEPTH_MARGIN = 3.0  # OpenSCAD pcb_switch_plate_depth_margin
SCALE = 0.85
# SVG viewBox pad so cable / labels / plate stay in view (ExportSVG margin, mm)
VIEW_MARGIN = 18.0


def make_pcb_outline_part(z_bottom: float) -> Part:
    """
    PCB outline: rounded PCB_DIM rectangle + simple USB lip (jj40_pcb_outline).

    USB lip matches pcb_outline_usb_connector extents: 11×4 box from y=-2..+2
    at USB mid-X (filigree omitted).
    """
    w, l = PCB_DIM
    usb_w = 9.0 + 2.0  # connector + extraW
    with BuildPart() as bp:
        with BuildSketch():
            RectangleRounded(w, l, PCB_CORNER_R, align=(Align.MIN, Align.MIN))
            with Locations((PCB_USB_CONNECTOR_MID_X, 0)):
                # OpenSCAD: translate([-w/2, -2]) square([w, 4]) → y=-2..2
                Rectangle(usb_w, 4.0, align=(Align.CENTER, Align.CENTER))
        extrude(amount=PCB_THICKNESS)
    return Pos(0, 0, z_bottom) * bp.part


def make_switch_plate_part(z_pcb_bottom: float) -> Part:
    """
    jj40_switch_plate outline at OpenSCAD preview Z.

    OpenSCAD: translate([0,0,pcb_thickness + margin]) linear_extrude(1.5)
    jj40_switch_plate(); plate XY = PCB_SWITCH_PLATE_POSITION in PCB frame.
    """
    w, l = SWITCH_PLATE_DIM
    ox, oy = PCB_SWITCH_PLATE_POSITION
    z = z_pcb_bottom + PCB_THICKNESS + PCB_SWITCH_PLATE_DEPTH_MARGIN
    with BuildPart() as bp:
        with BuildSketch():
            with Locations((ox, oy)):
                RectangleRounded(w, l, PCB_CORNER_R, align=(Align.MIN, Align.MIN))
        extrude(amount=SWITCH_PLATE_THICKNESS)
    return Pos(0, 0, z) * bp.part


def make_mount_hole_markers(z_bottom: float) -> Part:
    """Short cylinders at PCB mount holes (slightly taller than PCB for visibility)."""
    h = PCB_THICKNESS + 0.8
    r = PCB_MOUNT_HOLE_DIA / 2
    parts = [
        Pos(hx, hy, z_bottom - 0.2)
        * Cylinder(r, h + 0.4, align=(Align.CENTER, Align.CENTER, Align.MIN))
        for hx, hy in pcb_mounting_hole_positions_on_pcb()
    ]
    return Part() + parts


def make_usb_preview(z_pcb_bottom: float) -> tuple[Part, Part]:
    """
    OpenSCAD preview: translate([USB_MID_X, -3, -2]) {
        rounded_box(9, 7, 4);          // connector, +Y
        rotate(180) rounded_box(12, 18, 6);  // cable, -Y
    }
    Simplified as plain boxes (no corner rounds).
    """
    ax = PCB_USB_CONNECTOR_MID_X
    ay = -3.0
    az = z_pcb_bottom - 2.0

    connector = Pos(ax, ay + 7.0 / 2, az) * Box(
        9.0, 7.0, 4.0, align=(Align.CENTER, Align.CENTER, Align.CENTER)
    )
    cable = Pos(ax, ay - 18.0 / 2, az) * Box(
        12.0, 18.0, 6.0, align=(Align.CENTER, Align.CENTER, Align.CENTER)
    )
    return connector, cable




def _bbox_of_edges(edge_lists: list[list]):
    """Axis-aligned union bbox of projected edge lists (or None)."""
    xmin = ymin = float("inf")
    xmax = ymax = float("-inf")
    any_e = False
    for edges in edge_lists:
        if not edges:
            continue
        bb = Curve(edges).bounding_box()
        any_e = True
        xmin = min(xmin, bb.min.X)
        ymin = min(ymin, bb.min.Y)
        xmax = max(xmax, bb.max.X)
        ymax = max(ymax, bb.max.Y)
    if not any_e:
        return None
    return xmin, ymin, xmax, ymax


def export_view(
    *,
    layers: list[tuple[str, tuple[int, int, int], Part]],
    ow: float,
    ol: float,
    oh: float,
    viewport_origin: tuple[float, float, float],
    viewport_up: tuple[float, float, float],
    title: str,
    svg_path: Path,
    png_path: Path,
    page_origin: tuple[float, float] = (0.0, 0.0),
    mirror_yz: bool = False,
) -> dict:
    """Project each solid separately onto layers; frame to union bbox + margin."""

    def place(p: Part) -> Part:
        centered = Pos(-ow / 2, -ol / 2, -oh / 2) * p
        return mirror(centered, about=Plane.YZ) if mirror_yz else centered

    placed = [(name, color, place(solid)) for name, color, solid in layers]

    projected: list[tuple[str, tuple[int, int, int], list]] = []
    for name, color, solid in placed:
        vis, _hid = project_to_2d(
            solid, viewport_origin, viewport_up, page_origin, SCALE
        )
        projected.append((name, color, list(vis) if vis else []))

    union = _bbox_of_edges([edges for _n, _c, edges in projected])

    # Title above content (or above theoretical case extent if empty)
    if union:
        label_x = (union[0] + union[2]) / 2
        label_y = union[3] + 8.0
    else:
        label_x = page_origin[0]
        label_y = page_origin[1] + ol * SCALE * 0.55
    label = Text(title, 5.0)
    label.position = Vector(label_x, label_y)

    exporter = ExportSVG(unit=Unit.MM, margin=VIEW_MARGIN)
    for name, color, edges in projected:
        exporter.add_layer(name, line_color=color, line_weight=0.18)
        if edges:
            exporter.add_shape(edges, layer=name)
    exporter.add_layer("Label", fill_color=(0, 0, 0), line_color=(0, 0, 0))
    exporter.add_shape([label], layer="Label")

    # Corner pad markers (tiny) so viewBox always includes intended pad around
    # geometry even if Text bounds are tight — belt-and-suspenders with margin.
    if union:
        pad = 10.0
        corners = [
            Edge.make_line(
                (union[0] - pad, union[1] - pad, 0),
                (union[0] - pad + 0.01, union[1] - pad, 0),
            ),
            Edge.make_line(
                (union[2] + pad, union[3] + pad + 12.0, 0),
                (union[2] + pad - 0.01, union[3] + pad + 12.0, 0),
            ),
        ]
        exporter.add_layer("Pad", line_color=(255, 255, 255), line_weight=0.01)
        exporter.add_shape(corners, layer="Pad")

    exporter.write(str(svg_path))
    print(f"Wrote {svg_path}")
    svg_to_png(svg_path, png_path)

    # Per-layer projected bboxes for overlap audit
    layer_bbs = {}
    for name, _color, edges in projected:
        if edges:
            bb = Curve(edges).bounding_box()
            layer_bbs[name] = (bb.min.X, bb.min.Y, bb.max.X, bb.max.Y)
    return {"union": union, "layers": layer_bbs}


def write_hole_audit() -> None:
    """Deliverable B: compare build123d chains to OpenSCAD expected values."""
    d = derived_dims()
    ow, ol, oh = d["case_outer"]
    chains = thread_dim_chains()
    holes = mount_hole_positions_case()

    expected = {
        "x_edge_to_left_mount": 24.25,
        "x_left_to_centre_mount": 95.25,
        "x_centre_to_right_mount": 95.25,
        "y_edge_to_front_mount": 23.95,
        "y_front_to_middle_mount": 19.05,
        "y_middle_to_back_mount": 19.05,
        "outer": (239.0, 86.0, 12.0),
    }

    def ok(a: float, b: float, tol: float = 0.01) -> bool:
        return abs(a - b) <= tol

    rows = []
    all_ok = True
    for key in ("x_edge_to_left_mount", "x_left_to_centre_mount", "x_centre_to_right_mount", "y_edge_to_front_mount", "y_front_to_middle_mount", "y_middle_to_back_mount"):
        got = chains[key]
        exp = expected[key]
        match = ok(got, exp)
        all_ok = all_ok and match
        rows.append((key, exp, got, match))

    outer_ok = all(ok(a, b) for a, b in zip((ow, ol, oh), expected["outer"]))
    all_ok = all_ok and outer_ok

    lines = [
        "# Hole XY audit — CNC pykey40 case",
        "",
        "Compare build123d `thread_dim_chains()` / `mount_hole_positions_case()`",
        "against OpenSCAD `keyboard_case-threads.scad` / jj40 + case constants.",
        "",
        "Tolerance: **0.01 mm**.",
        "",
        "## Outer dimensions",
        "",
        "| | OpenSCAD expected | build123d | match |",
        "|--|--:|--:|:--:|",
        f"| W × L × H | 239 × 86 × 12 | {ow:.2f} × {ol:.2f} × {oh:.2f} | "
        f"{'YES' if outer_ok else 'NO'} |",
        "",
        "## Dimension chains",
        "",
        "OpenSCAD (`keyboard_case-threads.scad`):",
        "",
        "- X: `x_dim_base + mount_xs[0]`, then consecutive mount X gaps",
        "- Y: `y_dim_base + mount_ys[0]` (front→first row), then consecutive Y gaps",
        "",
        "| Chain | OpenSCAD expected | build123d | Δ | match (≤0.01) |",
        "|-------|------------------:|----------:|--:|:--------------:|",
    ]
    for key, exp, got, match in rows:
        lines.append(
            f"| `{key}` | {exp:.2f} | {got:.6f} | {got - exp:+.6f} | "
            f"{'YES' if match else 'NO'} |"
        )

    lines += [
        "",
        "## Mount hole centres (case XY)",
        "",
        "Origin: front-left outer corner; +Y toward back (USB at Y≈0).",
        "",
        "| # | X | Y |",
        "|--:|--:|--:|",
    ]
    for i, (hx, hy) in enumerate(holes, 1):
        lines.append(f"| {i} | {hx:.6f} | {hy:.6f} |")

    lines += [
        "",
        "## Derived intermediates",
        "",
        f"- `case_pcb_position` = `{d['case_pcb_position']}`",
        f"- `cavity_pcb_position` = `{d['cavity_pcb_position']}`",
        f"- `pcb_cavity_dim` = `{d['pcb_cavity_dim']}`",
        "",
        f"- `mount_xs_case` = `{chains['mount_xs_case']}`",
        f"- `mount_ys_case` = `{chains['mount_ys_case']}`",
        "",
        "## Result",
        "",
        (
            "**PASS** — X chain 24.25 / 95.25 / 95.25 and Y 23.95 / 19.05 / 19.05 "
            "match within 0.01 mm; outer 239×86×12."
            if all_ok
            else "**FAIL** — see mismatches above."
        ),
        "",
        "Source refs:",
        "",
        "- `case/case_pykey40.py` — `thread_dim_chains()`, `mount_hole_positions_case()`",
        "- `keyboard_case-threads.scad` — x_dim1..3 / y_dim1..3",
        "- `jj40_constants.scad` / `keyboard_case-constants.scad`",
        "",
    ]

    text = "\n".join(lines)
    OUT_AUDIT.write_text(text)
    print(text)
    print(f"Wrote {OUT_AUDIT}")


def write_plate_audit() -> None:
    """Assert plate edges vs switch grid (half-unit margin intent)."""
    half = SWITCH_GRID_UNIT / 2.0
    sx0, sy0 = PCB_SW_1_1_POSITION
    sx1 = sx0 + (SWITCH_GRID_COLS - 1) * SWITCH_GRID_UNIT
    sy1 = sy0 + (SWITCH_GRID_ROWS - 1) * SWITCH_GRID_UNIT
    px0, py0 = PCB_SWITCH_PLATE_POSITION
    px1 = px0 + SWITCH_PLATE_DIM[0]
    py1 = py0 + SWITCH_PLATE_DIM[1]

    got_l = sx0 - px0
    got_r = px1 - sx1
    got_f = sy0 - py0
    got_b = py1 - sy1

    # Ideal plate if margin were exactly half unit from outer switch centres
    exp_dim = (
        (SWITCH_GRID_COLS - 1) * SWITCH_GRID_UNIT + 2 * half,
        (SWITCH_GRID_ROWS - 1) * SWITCH_GRID_UNIT + 2 * half,
    )
    # Actual plate is larger (fits case cavity 231×78 with 0.25 margin each side)
    # → margins > half unit. Report expected half-unit vs got.
    lines = [
        "# Switch plate audit — CNC pykey40",
        "",
        "Plate outline from `SWITCH_PLATE_DIM` at `PCB_SWITCH_PLATE_POSITION`",
        "(jj40_switch_plate / case_pykey40.py).",
        "",
        "User intent: plate extends **19.05/2 = 9.525 mm** from outer switch centres",
        f"(grid {SWITCH_GRID_COLS}×{SWITCH_GRID_ROWS}, first switch `PCB_SW_1_1`=",
        f"{PCB_SW_1_1_POSITION}).",
        "",
        "## Switch grid (PCB XY)",
        "",
        f"- First switch centre (col0,row0): **({sx0:.4f}, {sy0:.4f})**",
        f"- Last switch centre (col11,row3): **({sx1:.4f}, {sy1:.4f})**",
        f"- Span: X {(sx1 - sx0):.4f} (=11×19.05), Y {(sy1 - sy0):.4f} (=3×19.05)",
        "",
        "## Plate edges (PCB XY)",
        "",
        f"- `PCB_SWITCH_PLATE_POSITION` = **({px0:.6f}, {py0:.6f})**",
        f"- `SWITCH_PLATE_DIM` = **{SWITCH_PLATE_DIM}**",
        f"- Plate min/max: X [{px0:.4f} .. {px1:.4f}], Y [{py0:.4f} .. {py1:.4f}]",
        "",
        "## Margin: outer switch centre → plate edge",
        "",
        "| Side | Expected (½ unit) | Got | Δ |",
        "|------|------------------:|----:|--:|",
        f"| Left (X) | {half:.4f} | {got_l:.6f} | {got_l - half:+.6f} |",
        f"| Right (X) | {half:.4f} | {got_r:.6f} | {got_r - half:+.6f} |",
        f"| Front (Y) | {half:.4f} | {got_f:.6f} | {got_f - half:+.6f} |",
        f"| Back (Y) | {half:.4f} | {got_b:.6f} | {got_b - half:+.6f} |",
        "",
        "## Plate size vs half-unit ideal",
        "",
        f"- Ideal dim (outer centres ±½u): **{exp_dim[0]:.4f} × {exp_dim[1]:.4f}**",
        f"- Actual `SWITCH_PLATE_DIM`: **{SWITCH_PLATE_DIM[0]} × {SWITCH_PLATE_DIM[1]}**",
        f"- Extra beyond ideal: "
        f"**{SWITCH_PLATE_DIM[0] - exp_dim[0]:+.4f} × "
        f"{SWITCH_PLATE_DIM[1] - exp_dim[1]:+.4f}**",
        "",
        "Note: actual plate is sized to sit in the case cavity (231×78 with",
        "`CASE_SWITCH_PLATE_MARGIN=0.25`), not to a pure half-unit outline.",
        "L/R margins are equal; F/B margins are equal (plate centred on switch grid).",
        "",
        "## Preview placement (OpenSCAD parity)",
        "",
        f"- Z bottom of plate = PCB bottom + {PCB_THICKNESS} + "
        f"{PCB_SWITCH_PLATE_DEPTH_MARGIN} = "
        f"**{CASE_BOTTOM_HEIGHT + CASE_LOWER_CAVITY_HEIGHT + PCB_THICKNESS + PCB_SWITCH_PLATE_DEPTH_MARGIN:.1f}**",
        f"- Thickness = **{SWITCH_PLATE_THICKNESS}**",
        "- XY: same children frame as PCB (`case_pcb_position` + plate local XY)",
        "",
    ]
    text = "\n".join(lines)
    OUT_PLATE_AUDIT.write_text(text)
    print(text)
    print(f"Wrote {OUT_PLATE_AUDIT}")


def _usb_front_overlap_report(
    case: Part,
    usb_conn: Part,
    ow: float,
    ol: float,
    oh: float,
    pcb_xy: tuple[float, float],
) -> None:
    """Confirm USB connector bbox overlaps pocket in projected front coords."""
    def place(p: Part) -> Part:
        return Pos(-ow / 2, -ol / 2, -oh / 2) * p

    # Case already has USB pocket cut; use a proxy pocket solid for bbox compare
    usb_mid_case_x = pcb_xy[0] + PCB_USB_CONNECTOR_MID_X
    pocket = Pos(usb_mid_case_x, 0, 0) * Box(
        USB_CONNECTOR_HOLE_WIDTH,
        USB_CONNECTOR_CUTOUT_LENGTH,
        oh,
        align=(Align.CENTER, Align.MIN, Align.MIN),
    )

    vp = (0, -200, 0)
    up = (0, 0, 1)
    origin = (0.0, 0.0)
    case_vis, _ = project_to_2d(place(case), vp, up, origin, SCALE)
    usb_vis, _ = project_to_2d(place(usb_conn), vp, up, origin, SCALE)
    pocket_vis, _ = project_to_2d(place(pocket), vp, up, origin, SCALE)

    def xr(edges):
        bb = Curve(edges).bounding_box()
        return bb.min.X, bb.max.X, bb.min.Y, bb.max.Y

    ux0, ux1, uy0, uy1 = xr(usb_vis)
    px0, px1, py0, py1 = xr(pocket_vis)
    cx0, cx1, cy0, cy1 = xr(case_vis)

    overlap_x0 = max(ux0, px0)
    overlap_x1 = min(ux1, px1)
    overlaps = overlap_x1 > overlap_x0
    print("=== USB front-projection overlap audit ===")
    print(f"  case   projected X[{cx0:.3f}..{cx1:.3f}] Y[{cy0:.3f}..{cy1:.3f}]")
    print(f"  pocket projected X[{px0:.3f}..{px1:.3f}] Y[{py0:.3f}..{py1:.3f}]")
    print(f"  USB    projected X[{ux0:.3f}..{ux1:.3f}] Y[{uy0:.3f}..{uy1:.3f}]")
    print(
        f"  X overlap [{overlap_x0:.3f}..{overlap_x1:.3f}] "
        f"width={max(0.0, overlap_x1 - overlap_x0):.3f} → "
        f"{'PASS' if overlaps else 'FAIL'}"
    )
    # Centres should match (connector 9 wide vs pocket 12)
    print(
        f"  USB mid X={(ux0 + ux1) / 2:.3f}  pocket mid X={(px0 + px1) / 2:.3f}  "
        f"Δ={((ux0 + ux1) / 2) - ((px0 + px1) / 2):+.4f}"
    )


def main() -> None:
    write_hole_audit()
    write_plate_audit()

    case = make_cnc_pykey40_case(
        cutout_usb_connector=True,
        cutout_feet_holes=False,
        cutout_bumpon_guides=False,
        chamfer_edges=True,
    )
    d = derived_dims()
    ow, ol, oh = d["case_outer"]
    pcb_xy = d["case_pcb_position"]
    z_pcb = CASE_BOTTOM_HEIGHT + CASE_LOWER_CAVITY_HEIGHT  # 6.0

    pcb_local = make_pcb_outline_part(z_pcb)
    plate_local = make_switch_plate_part(z_pcb)
    holes_local = make_mount_hole_markers(z_pcb)
    usb_conn_local, usb_cable_local = make_usb_preview(z_pcb)

    place_xy = Pos(pcb_xy[0], pcb_xy[1], 0)
    pcb = place_xy * pcb_local
    plate = place_xy * plate_local
    holes = place_xy * holes_local
    usb_conn = place_xy * usb_conn_local
    usb_cable = place_xy * usb_cable_local

    print("case bbox", case.bounding_box())
    print("pcb bbox", pcb.bounding_box())
    print("plate bbox", plate.bounding_box())
    print("usb mid case X", pcb_xy[0] + PCB_USB_CONNECTOR_MID_X)

    _usb_front_overlap_report(case, usb_conn, ow, ol, oh, pcb_xy)

    # Colour layers: case / PCB / holes / USB / cable / plate
    base_layers = [
        ("Case", (0x40, 0x40, 0x40), case),
        ("PCB", (0xC0, 0x20, 0x20), pcb),
        ("Plate", (0x80, 0x20, 0xA0), plate),  # purple
        ("Holes", (0x20, 0x80, 0x20), holes),
        ("USB", (0x40, 0x40, 0xA0), usb_conn),
        ("Cable", (0x20, 0x20, 0x20), usb_cable),
    ]

    # Top view: look down −Z; viewport_up=(0,-1,0) → USB/front at top of sheet.
    export_view(
        layers=base_layers,
        ow=ow,
        ol=ol,
        oh=oh,
        viewport_origin=(0, 0, 200),
        viewport_up=(0, -1, 0),
        title="CNC pykey40 — PCB+plate overlay (top)",
        svg_path=OUT_SVG_TOP,
        png_path=OUT_PNG_TOP,
        mirror_yz=True,
    )

    # Front view: look from −Y; same YZ mirror as top → USB page-right
    # (top USB top-left ⇒ front USB right; do not force USB LHS on front).
    front_info = export_view(
        layers=base_layers,
        ow=ow,
        ol=ol,
        oh=oh,
        viewport_origin=(0, -200, 0),
        viewport_up=(0, 0, 1),
        title="CNC pykey40 — PCB+plate overlay (front, USB right)",
        svg_path=OUT_SVG_FRONT,
        png_path=OUT_PNG_FRONT,
        mirror_yz=True,
    )
    print("front layer bboxes:", front_info["layers"])

    # Optional combined assembly top (same layers; distinct filename)
    export_view(
        layers=base_layers,
        ow=ow,
        ol=ol,
        oh=oh,
        viewport_origin=(0, 0, 200),
        viewport_up=(0, -1, 0),
        title="CNC pykey40 — assembly (case+pcb+plate+usb)",
        svg_path=OUT_SVG_ASM,
        png_path=OUT_PNG_ASM,
        mirror_yz=True,
    )


if __name__ == "__main__":
    main()
