#!/usr/bin/env python3
"""
Multi-view TechDraw of the FULL CNC pykey40 case (manufacturing truth).

A3 sheet — third-angle style stack:
      Top
      Front   Side
      Bottom
      (+ isometric upper-right, off the ortho chain)

Feet / bumpons / rim chamfers ON.

Orthographic discipline (one mirrored drawing solid; cameras only differ):
  Drawing solid = center then mirror(Plane.YZ). That undoes the X-flip from
  top's viewport_up=(0,-1,0) so TOP shows USB top-left; the same solid makes
  FRONT / BOTTOM / ISO show USB page-right without per-view ad-hoc mirrors.

  Cameras (look_at origin; one 90° step between adjacent ortho views):
    TOP     cam (0, 0, +200)  up (0,-1, 0)   USB top-left, front at top of sheet
    FRONT   cam (0,-200,  0)  up (0, 0,+1)   USB page-right
    BOTTOM  cam (0, 0,-200)  up (0,-1, 0)   = FRONT rotated +90° about X
                                            front edge at top of view (toward
                                            Front); USB stays page-right
    SIDE    cam (+200, 0, 0)  up (0, 0,+1)   = FRONT rotated −90° about Z
                                            (+X of mirrored solid = physical L)
    ISO     cam (+200,-200,+150) up (0,0,+1) USB page-right (illustration only)

Richard USB rule: TOP USB top-left ⇒ FRONT USB right ⇒ ISO USB right.
BOTTOM under one rotation from FRONT keeps USB right when front-of-part is
at the top of the bottom drawing.

Classic third-angle would put the front edge at the *bottom* of the top view
(shared edge with Front). We keep front-at-top / USB top-left on Top per prior
direction; left/right therefore flip between Top and Front — that is expected,
not a bug. Dims use the USB-side / front-edge corner as datum in every view
so the zero edge does not jump arbitrarily (on Bottom, USB-side = page-right).
"""

from __future__ import annotations

from datetime import date
from pathlib import Path

from build123d import *

from helpers import ensure_case_import_path, project_to_2d, svg_to_png, center_mark

ensure_case_import_path()

from case_pykey40 import (
    BUMPON_GUIDE_DIA,
    BUMPON_GUIDE_HEIGHT,
    CASE_BUMPON_GUIDE_POSITIONS,
    CASE_OUTER_CORNER_R,
    CASE_WALL_THICKNESS,
    EDGE_CHAMFER,
    FOOT_HOLE_COUNTERSINK_DIA,
    FOOT_HOLE_DIA,
    FOOT_OFFSET,
    LOWER_CAVITY_R,
    UPPER_CAVITY_R,
    USB_CONNECTOR_CUTOUT_LENGTH,
    USB_CONNECTOR_HOLE_HEIGHT,
    USB_CONNECTOR_HOLE_WIDTH,
    PCB_USB_CONNECTOR_MID_X,
    derived_dims,
    make_cnc_pykey40_case,
    mount_hole_positions_case,
    thread_dim_chains,
)

OUT_DIR = Path(__file__).resolve().parent
OUT_SVG = OUT_DIR / "cnc_pykey40_full_a3.svg"
OUT_PNG = OUT_DIR / "cnc_pykey40_full_a3.png"

# Fit top/front/side/bottom/iso + dims on A3, clear of title block
SCALE = 0.34
CENTER_MARK_HALF = 2.0
MARGIN = 20.0
VIEW_GAP = 8.0
TITLE_CLEAR = 6.0
# Pads (L, R, T, B) — tighter vertically for Top→Front→Bottom stack
TOP_PAD = (26.0, 12.0, 18.0, 14.0)
FRONT_PAD = (8.0, 12.0, 12.0, 16.0)
SIDE_PAD = (8.0, 12.0, 12.0, 12.0)
BOTTOM_PAD = (14.0, 26.0, 14.0, 16.0)  # extra R for USB-side X dims
ISO_PAD = (6.0, 6.0, 10.0, 6.0)




def y_chain_manual(
    feat_x: float,
    y_dim_x: float,
    segs: list[tuple[float, float, float]],
    drafting: Draft,
) -> tuple[list, list]:
    """Upright Text Y-chain (same pattern as threads sheet)."""
    dim_edges: list = []
    labels: list = []
    gap = drafting.extension_gap
    arrow_len = drafting.arrow_length
    arrow_half_w = arrow_len / 3.0
    for y_a, y_b, val in segs:
        y_lo, y_hi = (y_a, y_b) if y_a < y_b else (y_b, y_a)
        dim_edges.append(Edge.make_line((feat_x - gap, y_a, 0), (y_dim_x - gap, y_a, 0)))
        dim_edges.append(Edge.make_line((feat_x - gap, y_b, 0), (y_dim_x - gap, y_b, 0)))
        dim_edges.append(Edge.make_line((y_dim_x, y_lo, 0), (y_dim_x, y_hi, 0)))
        dim_edges.append(
            Edge.make_line((y_dim_x, y_lo, 0), (y_dim_x - arrow_half_w, y_lo + arrow_len, 0))
        )
        dim_edges.append(
            Edge.make_line((y_dim_x, y_lo, 0), (y_dim_x + arrow_half_w, y_lo + arrow_len, 0))
        )
        dim_edges.append(
            Edge.make_line((y_dim_x, y_hi, 0), (y_dim_x - arrow_half_w, y_hi - arrow_len, 0))
        )
        dim_edges.append(
            Edge.make_line((y_dim_x, y_hi, 0), (y_dim_x + arrow_half_w, y_hi - arrow_len, 0))
        )
        mid_y = (y_a + y_b) / 2
        lbl = Text(f"{val:.2f}", 3.2)
        lbl.position = Vector(y_dim_x - 8.0, mid_y)
        labels.append(lbl)
    return dim_edges, labels


def _bumpon_xy(pt, outer_length: float) -> tuple[float, float]:
    x, y = float(pt[0]), float(pt[1])
    if y < 0:
        y = outer_length + y
    return x, y


def main() -> None:
    case = make_cnc_pykey40_case(
        cutout_usb_connector=True,
        cutout_feet_holes=True,
        cutout_bumpon_guides=True,
        chamfer_edges=True,
    )
    d = derived_dims()
    ow, ol, oh = d["case_outer"]
    cav_w, cav_l = d["pcb_cavity_dim"]
    wall = CASE_WALL_THICKNESS
    chains = thread_dim_chains()
    holes_case = mount_hole_positions_case()

    # One drawing solid for every view (cameras differ only).
    case_c = Pos(-ow / 2, -ol / 2, -oh / 2) * case
    case_draw = mirror(case_c, about=Plane.YZ)

    # Physical XY (front-left origin) for features — page mapping is per-view.
    xs_phys = list(chains["mount_xs_case"])
    ys_phys = list(chains["mount_ys_case"])
    usb_case_x = d["case_pcb_position"][0] + PCB_USB_CONNECTOR_MID_X

    bumpon_phys: list[tuple[float, float]] = []
    for pt in CASE_BUMPON_GUIDE_POSITIONS:
        bx, by = _bumpon_xy(pt, ol)
        bumpon_phys.append((bx, by))
        bumpon_phys.append((ow - bx, by))
    fx, fy = FOOT_OFFSET
    foot_phys = [(fx, fy), (ow - fx, fy)]

    border = TechnicalDrawing(
        designed_by="rgoulter",
        design_date=date.today(),
        page_size=PageSize.A3,
        title="CNC pykey40 case",
        sub_title="full multi-view (mfg)",
        drawing_number="KL-CNC-PY40-F",
        sheet_number=1,
        drawing_scale=1,
        nominal_text_size=4.0,
    )
    faces_by_area = sorted(border.faces(), key=lambda f: -f.area)
    frame_bb = faces_by_area[0].bounding_box()
    title_bb = faces_by_area[1].bounding_box()
    print(
        f"frame  LRTB "
        f"{frame_bb.min.X:.1f} {frame_bb.max.X:.1f} "
        f"{frame_bb.max.Y:.1f} {frame_bb.min.Y:.1f}"
    )
    print(
        f"title  LRTB "
        f"{title_bb.min.X:.1f} {title_bb.max.X:.1f} "
        f"{title_bb.max.Y:.1f} {title_bb.min.Y:.1f} "
        f"({title_bb.size.X:.1f}×{title_bb.size.Y:.1f})"
    )

    drafting = Draft(
        font_size=3.0,
        decimal_precision=2,
        display_units=False,
        extension_gap=0.8,
        head_type=HeadType.STRAIGHT,
        line_width=0.5,
        arrow_length=2.5,
    )

    # Cameras (documented in module docstring)
    CAM_TOP = ((0, 0, 200), (0, -1, 0))
    CAM_FRONT = ((0, -200, 0), (0, 0, 1))
    CAM_SIDE = ((200, 0, 0), (0, 0, 1))
    CAM_BOTTOM = ((0, 0, -200), (0, -1, 0))  # FRONT +90° about X
    CAM_ISO = ((200, -200, 150), (0, 0, 1))

    vis0, _ = project_to_2d(case_draw, *CAM_TOP, (0, 0), SCALE)
    vis_f0, _ = project_to_2d(case_draw, *CAM_FRONT, (0, 0), SCALE)
    vis_s0, _ = project_to_2d(case_draw, *CAM_SIDE, (0, 0), SCALE)
    vis_b0, _ = project_to_2d(case_draw, *CAM_BOTTOM, (0, 0), SCALE)
    vis_i0, _ = project_to_2d(case_draw, *CAM_ISO, (0, 0), SCALE)
    top0 = Curve(vis0).bounding_box()
    front0 = Curve(vis_f0).bounding_box()
    side0 = Curve(vis_s0).bounding_box()
    bot0 = Curve(vis_b0).bounding_box()
    iso0 = Curve(vis_i0).bounding_box()
    print(
        f"SCALE={SCALE}  top {top0.size.X:.1f}×{top0.size.Y:.1f}  "
        f"front {front0.size.X:.1f}×{front0.size.Y:.1f}  "
        f"side {side0.size.X:.1f}×{side0.size.Y:.1f}  "
        f"bot {bot0.size.X:.1f}×{bot0.size.Y:.1f}  "
        f"iso {iso0.size.X:.1f}×{iso0.size.Y:.1f}"
    )

    uL = frame_bb.min.X + MARGIN
    uR = frame_bb.max.X - MARGIN
    uB = frame_bb.min.Y + MARGIN
    uT = frame_bb.max.Y - MARGIN
    title_top = title_bb.max.Y
    floor_right = title_top + TITLE_CLEAR

    tL, tR, tT, tB = TOP_PAD
    fL, fR, fT, fB = FRONT_PAD
    sL, sR, sT, sB = SIDE_PAD
    bL, bR, bT, bB = BOTTOM_PAD
    iL, iR, iT, iB = ISO_PAD

    # ------------------------------------------------------------------
    # Layout (third-angle stack, shared centre X for top/front/bottom):
    #
    #        Top              Iso
    #        Front   Side
    #        Bottom
    #                              title block BR
    # ------------------------------------------------------------------
    # Place Top at upper-left; its geometric centre X is the stack axis.
    top_origin = (uL - top0.min.X + tL, uT - top0.max.Y - tT)
    top_cx = top_origin[0] + (top0.min.X + top0.max.X) / 2
    top_cbot = top_origin[1] + top0.min.Y - tB

    # Front directly below Top, same centre X
    front_origin = (
        top_cx - (front0.min.X + front0.max.X) / 2,
        top_cbot - VIEW_GAP - front0.max.Y - fT,
    )
    front_cy = front_origin[1] + (front0.min.Y + front0.max.Y) / 2
    front_cbot = front_origin[1] + front0.min.Y - fB
    front_cright = front_origin[0] + front0.max.X + fR

    # Side to the right of Front, same vertical centre
    side_origin = (
        front_cright + VIEW_GAP - side0.min.X + sL,
        front_cy - (side0.min.Y + side0.max.Y) / 2,
    )
    side_cright = side_origin[0] + side0.max.X + sR
    side_cbot = side_origin[1] + side0.min.Y - sB

    # Bottom directly below Front, same centre X (front edge toward Front)
    bot_origin = (
        top_cx - (bot0.min.X + bot0.max.X) / 2,
        front_cbot - VIEW_GAP - bot0.max.Y - bT,
    )
    bot_cbot = bot_origin[1] + bot0.min.Y - bB

    # Iso upper-right, clear of ortho chain and right frame
    iso_origin = (
        max(side_cright, top_origin[0] + top0.max.X + tR) + VIEW_GAP - iso0.min.X + iL,
        uT - iso0.max.Y - iT,
    )
    iso_cright = iso_origin[0] + iso0.max.X + iR
    if iso_cright > uR:
        iso_origin = (iso_origin[0] - (iso_cright - uR), iso_origin[1])

    # If bottom / front / side collide with floor or title, lift the stack
    # (prefer keeping bottom clear of title on the right by shifting left column).
    title_left = title_bb.min.X
    lift = 0.0
    if bot_cbot < uB:
        lift = max(lift, uB - bot_cbot)
    # Side may sit above title; if its bottom invades title band while over title X:
    if side_cbot < floor_right and side_origin[0] + side0.min.X > title_left - 20:
        lift = max(lift, floor_right - side_cbot)
    if lift > 0:
        # Pull from top pad / gaps instead of pushing into title: shift all down? No —
        # lift means move views UP. We are already at uT; instead shrink by moving
        # bottom up into front gap is wrong. Better: shift whole stack... can't.
        # Reduce: move bottom up by reducing VIEW_GAP outcome — actually lift the
        # lower views by reducing space: re-place with smaller effective floor.
        # Simplest: nudge bot/front/side up by `lift` and accept less gap under top.
        front_origin = (front_origin[0], front_origin[1] + lift)
        side_origin = (side_origin[0], side_origin[1] + lift)
        bot_origin = (bot_origin[0], bot_origin[1] + lift)
        front_cy = front_origin[1] + (front0.min.Y + front0.max.Y) / 2
        front_cbot = front_origin[1] + front0.min.Y - fB
        side_cbot = side_origin[1] + side0.min.Y - sB
        bot_cbot = bot_origin[1] + bot0.min.Y - bB

    notes_origin = (
        side_origin[0] + side0.max.X + 40.0,
        front_origin[1] + front0.max.Y - 4.0,
    )

    print(f"top_origin   ({top_origin[0]:.1f}, {top_origin[1]:.1f})  cx={top_cx:.1f}")
    print(f"front_origin ({front_origin[0]:.1f}, {front_origin[1]:.1f})")
    print(f"side_origin  ({side_origin[0]:.1f}, {side_origin[1]:.1f})")
    print(f"bot_origin   ({bot_origin[0]:.1f}, {bot_origin[1]:.1f})")
    print(f"iso_origin   ({iso_origin[0]:.1f}, {iso_origin[1]:.1f})")
    print(
        f"stack centres X: top={top_cx:.1f}  "
        f"front={front_origin[0] + (front0.min.X + front0.max.X) / 2:.1f}  "
        f"bot={bot_origin[0] + (bot0.min.X + bot0.max.X) / 2:.1f}"
    )

    visible: list = []
    hidden: list = []
    annotations: list = []
    labels: list = []
    centerlines: list = []
    dim_edges: list = []

    # --- TOP: cam +Z, up −Y; mirrored solid → USB top-left, front at top ---
    vis, hid = project_to_2d(case_draw, *CAM_TOP, top_origin, SCALE)
    visible.extend(vis)
    hidden.extend(hid)

    def top_xy(px: float, py: float) -> tuple[float, float]:
        """Physical XY → top page. Viewport X-flip of mirrored solid ⇒ page X
        tracks physical X (USB / left stay left). Front (py=0) at top of sheet."""
        return (
            top_origin[0] + (px - ow / 2) * SCALE,
            top_origin[1] - (py - ol / 2) * SCALE,
        )

    half_mark = CENTER_MARK_HALF * SCALE
    for hx, hy in holes_case:
        cx, cy = top_xy(hx, hy)
        centerlines.extend(center_mark(cx, cy, half_mark))

    front_y = top_xy(0, 0)[1]
    back_y = top_xy(0, ol)[1]
    hpx = [top_xy(xc, 0)[0] for xc in xs_phys]
    hpy = [top_xy(0, yc)[1] for yc in ys_phys]
    top_bb = Curve(vis).bounding_box()
    left_x, right_x = top_bb.min.X, top_bb.max.X

    usb_top_x = top_xy(usb_case_x, 0)[0]
    print(
        f"USB check top page X={usb_top_x:.2f}  "
        f"top centre={(left_x + right_x) / 2:.2f}  "
        f"LHS={usb_top_x < (left_x + right_x) / 2}"
    )

    pad = 3.0
    for px in hpx:
        centerlines.append(Edge.make_line((px, back_y - pad, 0), (px, front_y + pad, 0)))
    for py in hpy:
        centerlines.append(Edge.make_line((left_x - pad, py, 0), (right_x + pad, py, 0)))

    peri = Pos(*top_bb.center()) * Rectangle(top_bb.size.X, top_bb.size.Y)
    annotations.append(
        ExtensionLine(
            border=peri.edges().sort_by(Axis.Y)[0],
            offset=9 * MM,
            draft=drafting,
            label=f"{ow:.0f}",
        )
    )
    annotations.append(
        ExtensionLine(
            border=peri.edges().sort_by(Axis.X)[-1],
            offset=9 * MM,
            draft=drafting,
            label=f"{ol:.0f}",
        )
    )

    # X dims from USB-side (page-left = physical left)
    feat_y = hpy[0]
    x_offset = -((front_y - feat_y) + 9.0) * MM
    for (x_a, x_b), val in [
        ((left_x, hpx[0]), chains["x_edge_to_left_mount"]),
        ((hpx[0], hpx[1]), chains["x_left_to_centre_mount"]),
        ((hpx[1], hpx[2]), chains["x_centre_to_right_mount"]),
    ]:
        annotations.append(
            ExtensionLine(
                border=[(x_a, feat_y, 0), (x_b, feat_y, 0)],
                offset=x_offset,
                draft=drafting,
                label=f"{val:.2f}",
            )
        )

    feat_x = hpx[0]
    y_dim_x = feat_x - 18.0
    y_segs = [
        (hpy[2], hpy[1], chains["y_middle_to_back_mount"]),
        (hpy[1], hpy[0], chains["y_front_to_middle_mount"]),
        (hpy[0], front_y, chains["y_edge_to_front_mount"]),
    ]
    ye, yl = y_chain_manual(feat_x, y_dim_x, y_segs, drafting)
    dim_edges.extend(ye)
    labels.extend(yl)

    t_top = Text("Top", 3.8)
    t_top.position = Vector(top_origin[0], front_y + 16)
    labels.append(t_top)
    t_cav = Text(
        f"cavity {cav_w:.0f}×{cav_l:.0f}  wall {wall:.0f}  "
        f"R_outer {CASE_OUTER_CORNER_R:.0f}  "
        f"R_cav↑{UPPER_CAVITY_R:.0f}/↓{LOWER_CAVITY_R:.0f}  "
        f"chamfer {EDGE_CHAMFER}",
        2.3,
    )
    t_cav.position = Vector(top_origin[0], back_y - 10)
    labels.append(t_cav)

    for fpx, fpy in foot_phys:
        cx, cy = top_xy(fpx, fpy)
        centerlines.extend(center_mark(cx, cy, 1.4 * SCALE))
    t_foot = Text(
        f"feet ⌀{FOOT_HOLE_DIA}/CS⌀{FOOT_HOLE_COUNTERSINK_DIA} "
        f"@ offset {fx:.0f},{fy:.0f}",
        2.2,
    )
    t_foot.position = Vector(top_origin[0], back_y - 16)
    labels.append(t_foot)

    # --- FRONT: cam −Y, up +Z; same solid → USB page-right ---
    vis_f, hid_f = project_to_2d(case_draw, *CAM_FRONT, front_origin, SCALE)
    visible.extend(vis_f)
    hidden.extend(hid_f)
    front_bb = Curve(vis_f).bounding_box()
    # Mirrored solid, no viewport X-flip: page X = −(phys_x − ow/2)*SCALE → USB RHS
    usb_front_x = front_origin[0] - (usb_case_x - ow / 2) * SCALE
    print(
        f"USB check front page X={usb_front_x:.2f}  "
        f"front centre={front_bb.center().X:.2f}  "
        f"RHS={usb_front_x > front_bb.center().X}"
    )
    fperi = Pos(*front_bb.center()) * Rectangle(front_bb.size.X, front_bb.size.Y)
    annotations.append(
        ExtensionLine(
            border=fperi.edges().sort_by(Axis.Y)[0],
            offset=7 * MM,
            draft=drafting,
            label=f"{ow:.0f}",
        )
    )
    annotations.append(
        ExtensionLine(
            border=fperi.edges().sort_by(Axis.X)[-1],
            offset=7 * MM,
            draft=drafting,
            label=f"{oh:.0f}",
        )
    )
    t_front = Text("Front (USB right)", 3.8)
    t_front.position = Vector(front_origin[0], front_bb.max.Y + 8)
    labels.append(t_front)
    t_usb = Text(
        f"USB pocket ~W{USB_CONNECTOR_HOLE_WIDTH}×H{USB_CONNECTOR_HOLE_HEIGHT} "
        f"depth {USB_CONNECTOR_CUTOUT_LENGTH} (simplified box)",
        2.2,
    )
    t_usb.position = Vector(front_origin[0], front_bb.min.Y - 9)
    labels.append(t_usb)

    # --- SIDE: cam +X, up +Z; +X of mirrored = physical left ---
    vis_s, hid_s = project_to_2d(case_draw, *CAM_SIDE, side_origin, SCALE)
    visible.extend(vis_s)
    hidden.extend(hid_s)
    side_bb = Curve(vis_s).bounding_box()
    speri = Pos(*side_bb.center()) * Rectangle(side_bb.size.X, side_bb.size.Y)
    annotations.append(
        ExtensionLine(
            border=speri.edges().sort_by(Axis.Y)[0],
            offset=7 * MM,
            draft=drafting,
            label=f"{ol:.0f}",
        )
    )
    annotations.append(
        ExtensionLine(
            border=speri.edges().sort_by(Axis.X)[-1],
            offset=7 * MM,
            draft=drafting,
            label=f"{oh:.0f}",
        )
    )
    t_side = Text("Side (L)", 3.8)
    t_side.position = Vector(side_origin[0], side_bb.max.Y + 8)
    labels.append(t_side)

    # --- BOTTOM: cam −Z, up −Y (= FRONT +90° about X); USB right, front at top ---
    vis_b, hid_b = project_to_2d(case_draw, *CAM_BOTTOM, bot_origin, SCALE)
    visible.extend(vis_b)
    hidden.extend(hid_b)
    bot_bb = Curve(vis_b).bounding_box()

    def bot_xy(px: float, py: float) -> tuple[float, float]:
        """Physical XY → bottom page. Mirrored solid, no viewport X-flip ⇒ page X
        flips vs physical (USB / phys-left → page-right). Front (py=0) at top."""
        return (
            bot_origin[0] - (px - ow / 2) * SCALE,
            bot_origin[1] - (py - ol / 2) * SCALE,
        )

    for bx, by in bumpon_phys:
        cx, cy = bot_xy(bx, by)
        centerlines.extend(center_mark(cx, cy, 1.6 * SCALE))
    for fpx, fpy in foot_phys:
        cx, cy = bot_xy(fpx, fpy)
        centerlines.extend(center_mark(cx, cy, 1.4 * SCALE))

    b_front_y = bot_xy(0, 0)[1]
    b_back_y = bot_xy(0, ol)[1]
    # USB-side on bottom = page-RIGHT (= physical left). Datum = that corner.
    usb_bot_x = bot_xy(usb_case_x, 0)[0]
    print(
        f"USB check bottom page X={usb_bot_x:.2f}  "
        f"bot centre={bot_bb.center().X:.2f}  "
        f"RHS={usb_bot_x > bot_bb.center().X}  "
        f"front_at_top={b_front_y > b_back_y}"
    )

    b_ys = sorted({round(p[1], 3) for p in bumpon_phys})
    # Front-row bumpons (smallest physical Y); USB-side = smaller physical X
    front_row = [p for p in bumpon_phys if abs(p[1] - b_ys[0]) < 0.1]
    front_row_xs = sorted(p[0] for p in front_row)  # phys: 35, 204
    if len(front_row_xs) >= 2 and len(b_ys) >= 2:
        # Page X: phys 35 (USB-side) → right; phys 204 → left
        px_usb = bot_xy(front_row_xs[0], 0)[0]   # rightish
        px_far = bot_xy(front_row_xs[1], 0)[0]   # leftish
        right_b = bot_bb.max.X
        left_b = bot_bb.min.X
        # X dims from USB-side (page-right): 35 to near bumpon, then span
        annotations.append(
            ExtensionLine(
                border=[(right_b, b_front_y, 0), (px_usb, b_front_y, 0)],
                offset=-8 * MM,
                draft=drafting,
                label=f"{front_row_xs[0]:.0f}",
            )
        )
        annotations.append(
            ExtensionLine(
                border=[(px_usb, b_front_y, 0), (px_far, b_front_y, 0)],
                offset=-8 * MM,
                draft=drafting,
                label=f"{front_row_xs[1] - front_row_xs[0]:.0f}",
            )
        )
        py0 = bot_xy(0, b_ys[0])[1]
        py1 = bot_xy(0, b_ys[1])[1]
        # Y chain on USB-side of the near front bumpon (page-right of that mark)
        ye2, yl2 = y_chain_manual(
            px_usb,
            px_usb + 14.0,  # outward toward USB-side / page-right
            [
                (py1, py0, abs(b_ys[1] - b_ys[0])),
                (py0, b_front_y, b_ys[0]),
            ],
            drafting,
        )
        # y_chain_manual draws labels to the left of y_dim_x; for RHS chain flip label side
        for lbl in yl2:
            lbl.position = Vector(px_usb + 14.0 + 2.0, lbl.position.Y)
        dim_edges.extend(ye2)
        labels.extend(yl2)

    t_bot = Text("Bottom (USB right, front↑)", 3.6)
    t_bot.position = Vector(bot_origin[0] - 10, b_front_y + 14)
    labels.append(t_bot)
    t_bump = Text(
        f"bumpons ⌀{BUMPON_GUIDE_DIA}×{BUMPON_GUIDE_HEIGHT} deep  "
        f"guides {CASE_BUMPON_GUIDE_POSITIONS}  (L/R mirror)  "
        f"dims from USB-side",
        2.1,
    )
    t_bump.position = Vector(bot_origin[0] - 10, b_back_y - 10)
    labels.append(t_bump)
    t_feet_b = Text(
        f"feet ⌀{FOOT_HOLE_DIA}/CS⌀{FOOT_HOLE_COUNTERSINK_DIA} "
        f"visible from below",
        2.1,
    )
    t_feet_b.position = Vector(bot_origin[0] - 10, b_back_y - 15)
    labels.append(t_feet_b)

    # --- ISOMETRIC (illustration; USB right) ---
    vis_i, hid_i = project_to_2d(case_draw, *CAM_ISO, iso_origin, SCALE)
    visible.extend(vis_i)
    iso_bb = Curve(vis_i).bounding_box()
    t_iso = Text("Isometric (USB right)", 3.8)
    t_iso.position = Vector(iso_origin[0], iso_bb.max.Y + 8)
    labels.append(t_iso)
    print(f"ISO centre page X={iso_bb.center().X:.2f} (mirrored solid → USB right)")

    # Manufacturing + orthographic notes
    note = Text("5× M2×2.4 taps  pilot ⌀1.6  posts ⌀6", 2.5)
    note.position = Vector(notes_origin[0], notes_origin[1])
    labels.append(note)
    note2 = Text("mfg: feet + bumpons + rim chamfer ON", 2.3)
    note2.position = Vector(notes_origin[0], notes_origin[1] - 6)
    labels.append(note2)
    note3 = Text(
        "Ortho: one YZ-mirrored solid; cameras only.",
        2.1,
    )
    note3.position = Vector(notes_origin[0], notes_origin[1] - 12)
    labels.append(note3)
    note4 = Text(
        "TOP USB top-left ⇒ FRONT/BOTTOM/ISO USB right",
        2.1,
    )
    note4.position = Vector(notes_origin[0], notes_origin[1] - 18)
    labels.append(note4)
    note5 = Text(
        "Stack Top→Front→Bottom = one 90° each; Side←Front.",
        2.1,
    )
    note5.position = Vector(notes_origin[0], notes_origin[1] - 24)
    labels.append(note5)
    note6 = Text(
        "Top keeps front-at-top (not classic shared-edge).",
        2.0,
    )
    note6.position = Vector(notes_origin[0], notes_origin[1] - 30)
    labels.append(note6)

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
    exporter.add_shape(visible, layer="Visible")
    if hidden:
        exporter.add_shape(hidden, layer="Hidden")
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

    svg_to_png(OUT_SVG, OUT_PNG, dpi=120)


if __name__ == "__main__":
    main()
