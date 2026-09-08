"""
CNC pykey40 MX keyboard case — build123d port of OpenSCAD simple_keyboard_case.

Source of truth (keyboard-labs):
  cad/keyboard_case/keyboard_case.scad  (simple_keyboard_case)
  cad/keyboard_case/cnc-pykey40-mx.scad
  cad/keyboard_case/keyboard_case-constants.scad
  cad/keyboard_plates/keyboard-pykey40/jj40_constants.scad

Coordinate semantics (preserves hole XY vs keyboard_case-threads.scad):
  OpenSCAD wraps the solid in scale([1,-1,1]) so the PCB “top” / USB edge sits
  at world Y≈0. Here we build with front (USB) at Y=0 and +Y toward the back,
  matching flipped OpenSCAD after reflecting Y to positive. Hole centres share
  the same X and |Y| numbers as threads.scad dimension chains.
  Z=0 is the outer bottom (same as OpenSCAD cube origin).
"""

from __future__ import annotations

import math
from pathlib import Path

from build123d import *

# --- jj40 / case constants (mm) ---------------------------------------------
PCB_DIM = (227.0, 75.0)
PCB_SW_1_1_POSITION = (7.5, 8.5)
SWITCH_GRID_UNIT = 19.05
SWITCH_GRID_COLS = 12
SWITCH_GRID_ROWS = 4

PCB_MOUNTING_HOLE_GRID = (
    (0.5, 0.5),
    (10.5, 0.5),
    (10.5, 2.5),
    (0.5, 2.5),
    (5.5, 1.5),
)

SWITCH_PLATE_DIM = (230.5, 77.5)
CASE_SWITCH_PLATE_MARGIN = 0.25
CASE_WALL_THICKNESS = 4.0
CASE_BOTTOM_HEIGHT = 2.0
CASE_LOW_PROFILE_MX_UPPER_CAVITY_HEIGHT = 6.0
CASE_LOWER_CAVITY_HEIGHT = 4.0

CASE_OUTER_CORNER_R = 3.0
UPPER_CAVITY_R = 2.0
LOWER_CAVITY_R = 4.0

MOUNT_HOLE_POST_DIA = 6.0
MOUNT_THREAD_HOLE_TAPPING_DIA = 1.6  # M2 pilot
MOUNT_THREAD_HOLE_THREADED_HEIGHT = 2.4
MOUNT_THREAD_HOLE_THREADED_EXTRA_HEIGHT = 1.6

PCB_USB_CONNECTOR_MID_X = PCB_SW_1_1_POSITION[0] + 1.5 * SWITCH_GRID_UNIT
USB_CONNECTOR_HOLE_WIDTH = 12.0
USB_CONNECTOR_HOLE_HEIGHT = 8.0
USB_CONNECTOR_CUTOUT_LENGTH = 7.0
USB_CONNECTOR_HEIGHT = 4.0

# Feet (M4-ish countersunk) — OpenSCAD foot_offset / foot_hole_* defaults
FOOT_OFFSET = (16.0, 12.0)
FOOT_HOLE_DIA = 4.0
FOOT_HOLE_COUNTERSINK_DIA = 8.0
FOOT_HOLE_COUNTERSINK_ANGLE = 90.0  # degrees

# Bumpon guide pockets on bottom (OpenSCAD CASE_BUMPON_GUIDE_POSITIONS)
CASE_BUMPON_GUIDE_POSITIONS = [[35.0, 15.0], [10.0, -10.0]]
BUMPON_GUIDE_DIA = 8.1
BUMPON_GUIDE_HEIGHT = 0.5

EDGE_CHAMFER = 0.5


def _pcb_switch_plate_position() -> tuple[float, float]:
    half = (
        (SWITCH_GRID_COLS - 1) / 2 * SWITCH_GRID_UNIT,
        (SWITCH_GRID_ROWS - 1) / 2 * SWITCH_GRID_UNIT,
    )
    pcb_grid_center = (
        PCB_SW_1_1_POSITION[0] + half[0],
        PCB_SW_1_1_POSITION[1] + half[1],
    )
    plate_center = (SWITCH_PLATE_DIM[0] / 2, SWITCH_PLATE_DIM[1] / 2)
    return (
        pcb_grid_center[0] - plate_center[0],
        pcb_grid_center[1] - plate_center[1],
    )


PCB_SWITCH_PLATE_POSITION = _pcb_switch_plate_position()
SWITCH_PLATE_PCB_POSITION = (
    -PCB_SWITCH_PLATE_POSITION[0],
    -PCB_SWITCH_PLATE_POSITION[1],
)

PCB_MOUNTING_HOLE_OFFSETS = tuple(
    (gx * SWITCH_GRID_UNIT, gy * SWITCH_GRID_UNIT) for gx, gy in PCB_MOUNTING_HOLE_GRID
)


def derived_dims() -> dict:
    pcb_cavity_dim = (
        SWITCH_PLATE_DIM[0] + 2 * CASE_SWITCH_PLATE_MARGIN,
        SWITCH_PLATE_DIM[1] + 2 * CASE_SWITCH_PLATE_MARGIN,
    )
    case_outer = (
        CASE_WALL_THICKNESS + pcb_cavity_dim[0] + CASE_WALL_THICKNESS,
        CASE_WALL_THICKNESS + pcb_cavity_dim[1] + CASE_WALL_THICKNESS,
        CASE_LOW_PROFILE_MX_UPPER_CAVITY_HEIGHT
        + CASE_LOWER_CAVITY_HEIGHT
        + CASE_BOTTOM_HEIGHT,
    )
    case_cavity_position = (CASE_WALL_THICKNESS, CASE_WALL_THICKNESS)
    cavity_pcb_position = (
        CASE_SWITCH_PLATE_MARGIN + SWITCH_PLATE_PCB_POSITION[0],
        CASE_SWITCH_PLATE_MARGIN + SWITCH_PLATE_PCB_POSITION[1],
    )
    case_pcb_position = (
        case_cavity_position[0] + cavity_pcb_position[0],
        case_cavity_position[1] + cavity_pcb_position[1],
    )
    return {
        "pcb_cavity_dim": pcb_cavity_dim,
        "case_outer": case_outer,
        "case_cavity_position": case_cavity_position,
        "cavity_pcb_position": cavity_pcb_position,
        "case_pcb_position": case_pcb_position,
    }


def pcb_mounting_hole_positions_on_pcb() -> list[tuple[float, float]]:
    return [
        (PCB_SW_1_1_POSITION[0] + ox, PCB_SW_1_1_POSITION[1] + oy)
        for ox, oy in PCB_MOUNTING_HOLE_OFFSETS
    ]


def mount_hole_positions_case() -> list[tuple[float, float]]:
    """Hole centres in case XY (front-left origin, +Y toward back)."""
    d = derived_dims()
    cx, cy = d["case_pcb_position"]
    return [(cx + hx, cy + hy) for hx, hy in pcb_mounting_hole_positions_on_pcb()]


def thread_dim_chains() -> dict:
    """
    Dimension chain lengths matching keyboard_case-threads.scad.

    X (left edge → cols): x_dim1, x_dim2, x_dim3
    Y (back→front in threads.scad order): y_dim3, y_dim2, y_dim1
      where y_dim1 is front-edge → front hole row.
    """
    holes_pcb = pcb_mounting_hole_positions_on_pcb()
    xs = sorted({round(h[0], 6) for h in holes_pcb})
    ys = sorted({round(h[1], 6) for h in holes_pcb})
    x_base = (
        CASE_WALL_THICKNESS
        + CASE_SWITCH_PLATE_MARGIN
        + SWITCH_PLATE_PCB_POSITION[0]
    )
    y_base = (
        CASE_WALL_THICKNESS
        + CASE_SWITCH_PLATE_MARGIN
        + SWITCH_PLATE_PCB_POSITION[1]
    )
    return {
        "x_dim1": x_base + xs[0],
        "x_dim2": xs[1] - xs[0],
        "x_dim3": xs[2] - xs[1],
        "y_dim1": y_base + ys[0],  # front edge → front row
        "y_dim2": ys[1] - ys[0],
        "y_dim3": ys[2] - ys[1],
        "mount_xs_case": [
            x_base + xs[0],
            x_base + xs[1],
            x_base + xs[2],
        ],
        "mount_ys_case": [
            y_base + ys[0],
            y_base + ys[1],
            y_base + ys[2],
        ],
    }


def _rounded_rect_prism(
    width: float,
    length: float,
    height: float,
    corner_r: float,
    *,
    origin_xy: tuple[float, float],
    z_bottom: float,
) -> Part:
    with BuildPart() as bp:
        with Locations((origin_xy[0] + width / 2, origin_xy[1] + length / 2, z_bottom)):
            Box(width, length, height, align=(Align.CENTER, Align.CENTER, Align.MIN))
        if corner_r > 0:
            fillet(
                bp.edges().filter_by(Axis.Z),
                radius=min(corner_r, width / 2 - 0.01, length / 2 - 0.01),
            )
    return bp.part


def _foot_hole_cutter(height: float) -> Part:
    """OpenSCAD countersunk_foot_hole: shaft + 90° cone, wide at top of bottom plate."""
    shaft_r = FOOT_HOLE_DIA / 2
    cs_r = FOOT_HOLE_COUNTERSINK_DIA / 2
    # countersink_height = r / tan(angle/2); 90° → tan(45°)=1 → height = r
    cs_h = cs_r / math.tan(math.radians(FOOT_HOLE_COUNTERSINK_ANGLE / 2))
    shaft = Pos(0, 0, -0.1) * Cylinder(
        shaft_r, height + 0.2, align=(Align.CENTER, Align.CENTER, Align.MIN)
    )
    # Tip (r=0) below inner face; wide (cs_r) at z=height (inner face of bottom).
    cone = Pos(0, 0, height - cs_h) * Cone(
        0, cs_r, cs_h, align=(Align.CENTER, Align.CENTER, Align.MIN)
    )
    return shaft + cone


def _bumpon_xy(pt: list | tuple, outer_length: float) -> tuple[float, float]:
    """OpenSCAD Y wrap: negative Y → from back edge (outer_length + y)."""
    x, y = float(pt[0]), float(pt[1])
    if y < 0:
        y = outer_length + y
    return x, y


def _outer_wire_edges(face: Face) -> ShapeList:
    wires = sorted(face.wires(), key=lambda w: w.length, reverse=True)
    return wires[0].edges()


def make_cnc_pykey40_case(
    *,
    cutout_usb_connector: bool = True,
    cutout_feet_holes: bool = True,
    cutout_bumpon_guides: bool = True,
    chamfer_edges: bool = True,
) -> Part:
    """
    Port of simple_keyboard_case (CNC pykey40 MX defaults).

    Feet / bumpons / rim chamfers default on (OpenSCAD parity / STEP).
    Pass all three False for a clear threads drawing sheet.
    """
    d = derived_dims()
    ow, ol, oh = d["case_outer"]
    cav_w, cav_l = d["pcb_cavity_dim"]
    cav_x, cav_y = d["case_cavity_position"]
    upper_h = CASE_LOW_PROFILE_MX_UPPER_CAVITY_HEIGHT
    lower_h = CASE_LOWER_CAVITY_HEIGHT
    bottom_h = CASE_BOTTOM_HEIGHT

    z_bottom_top = bottom_h
    z_lower_top = bottom_h + lower_h

    holes = mount_hole_positions_case()
    post_r = MOUNT_HOLE_POST_DIA / 2
    tap_r = MOUNT_THREAD_HOLE_TAPPING_DIA / 2
    tap_h = (
        MOUNT_THREAD_HOLE_THREADED_HEIGHT + MOUNT_THREAD_HOLE_THREADED_EXTRA_HEIGHT
    )

    with BuildPart() as shell:
        Box(ow, ol, oh, align=(Align.MIN, Align.MIN, Align.MIN))
        fillet(shell.edges().filter_by(Axis.Z), radius=CASE_OUTER_CORNER_R)
    outer = shell.part

    upper = _rounded_rect_prism(
        cav_w,
        cav_l,
        upper_h + 0.02,
        UPPER_CAVITY_R,
        origin_xy=(cav_x, cav_y),
        z_bottom=z_lower_top - 0.01,
    )
    lower = _rounded_rect_prism(
        cav_w,
        cav_l,
        lower_h + 0.02,
        LOWER_CAVITY_R,
        origin_xy=(cav_x, cav_y),
        z_bottom=z_bottom_top - 0.01,
    )
    posts = Part() + [
        Pos(hx, hy, z_bottom_top) * Cylinder(post_r, lower_h) for hx, hy in holes
    ]
    body = outer - ((upper + lower) - posts)

    taps = Part() + [
        Pos(hx, hy, z_lower_top - tap_h) * Cylinder(tap_r, tap_h + 0.02)
        for hx, hy in holes
    ]
    body = body - taps

    if cutout_usb_connector:
        usb_mid_x = d["case_pcb_position"][0] + PCB_USB_CONNECTOR_MID_X
        margin_above = (USB_CONNECTOR_HOLE_HEIGHT / 2) - (USB_CONNECTOR_HEIGHT / 2)
        cutout_h = bottom_h + lower_h + margin_above
        usb = Pos(usb_mid_x, 0, 0) * Box(
            USB_CONNECTOR_HOLE_WIDTH,
            USB_CONNECTOR_CUTOUT_LENGTH,
            cutout_h,
            align=(Align.CENTER, Align.MIN, Align.MIN),
        )
        body = body - usb

    if cutout_feet_holes:
        # Near front: Y=foot_offset_y; X mirrored L/R.
        fx, fy = FOOT_OFFSET
        cutter = _foot_hole_cutter(bottom_h)
        feet = Part() + [
            Pos(fx, fy, 0) * cutter,
            Pos(ow - fx, fy, 0) * cutter,
        ]
        body = body - feet

    if cutout_bumpon_guides:
        # Shallow pockets on outer bottom; Y wraps when negative (OpenSCAD).
        guides = []
        for pt in CASE_BUMPON_GUIDE_POSITIONS:
            bx, by = _bumpon_xy(pt, ol)
            for px in (bx, ow - bx):
                guides.append(
                    Pos(px, by, -0.01)
                    * Cylinder(
                        BUMPON_GUIDE_DIA / 2,
                        BUMPON_GUIDE_HEIGHT,
                        align=(Align.CENTER, Align.CENTER, Align.MIN),
                    )
                )
        body = body - (Part() + guides)

    if chamfer_edges:
        # Approximate OpenSCAD 0.5 mm top+bottom outer-rim chamfer.
        # Skips OpenSCAD's cone corner filigree (see NOTES).
        try:
            with BuildPart() as bp:
                add(body)
                faces_z = bp.faces().sort_by(Axis.Z)
                top_e = _outer_wire_edges(faces_z[-1])
                bot_e = _outer_wire_edges(faces_z[0])
                chamfer(top_e + bot_e, length=EDGE_CHAMFER)
            body = bp.part
        except Exception as exc:  # noqa: BLE001
            print(f"WARNING: rim chamfer skipped ({exc!r})")

    return body


if __name__ == "__main__":
    full_case = make_cnc_pykey40_case()
    print("bbox", full_case.bounding_box())
    print("derived", derived_dims())
    print("holes_case", mount_hole_positions_case())
    print("thread_dims", thread_dim_chains())
    here = Path(__file__).resolve().parent
    stl_out = here / "case_pykey40.stl"
    step_out = here / "cnc_pykey40.step"
    export_stl(full_case, str(stl_out))
    export_step(full_case, str(step_out))
    print("wrote", stl_out)
    print("wrote", step_out)
