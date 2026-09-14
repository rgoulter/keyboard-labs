# Helper for CH32X-60-improved — GH60-compatible, CH32X, split spacebar (KiCad 10, FCIS)
# Reuses SW_1_1 anchor and Edge.Cuts from ch32x-75 (5×15 @19.05, 15u = 285mm).
# GH60 61-ish with 6.25U → 1.25+5×1U (=13 keys bottom), row-staggered, non-1U per row.
# For universal plate, use 1u/1.25/1.5/1.75/2/2.25 footprints like pykey60.
import pcbnew
from pcbnew import VECTOR2I_MM, EDA_ANGLE
from . import engine

# GH60-ish widths per row (U units, sums to 15u). 1.25+5×1U bottom =13 keys (was 8).
# Row1: Esc 1, 12×1, Backspace 2  → 14 keys
# Row2: Tab 1.5, 11×1, \| 1.5 + extra 1 → 14 keys (universal)
# Row3: Caps 1.75, 11×1, Enter 2.25 → 13 keys (ANSI)
# Row4: Shift 2.25, 10×1, RShift 2.75 → 12 keys (ANSI, was 1.75+1 split)
# Row5: 1.25×3, (1.25+5×1), 1.25×4 → 13 keys
ROW_WIDTHS = {
    1: [1]*13 + [2],                # 14 keys
    2: [1.5] + [1]*12 + [1.5],       # 14 keys (1.5+12+1.5=15)
    3: [1.75] + [1]*11 + [2.25],     # 13 keys (ANSI 1.75/2.25)
    4: [2.25] + [1]*10 + [2.75],     # 12 keys ANSI (was 1.75+1 split, now single 2.75)
    5: [1.25]*3 + [1.25,1,1,1,1,1] + [1.25]*4, # 13 keys split
}
# Stabilizer-requiring widths (PCB-mount Cherry): 2u, 2.25u, 2.75u, 6.25/7u (not needed for split 1U)
# Separate Mounting_Keyboard_Stabilizer:Stabilizer_Cherry_MX_2.00u covers 2/2.25/2.75
STAB_WIDTHS = {2, 2.25, 2.75}

def _row_offsets(widths):
    """Pure: widths list -> list of x offsets (mm) from row start."""
    offs = []
    x = 0
    for w in widths:
        offs.append(x)
        x += w * 19.05
    return offs

ROW_OFFSETS = {r: _row_offsets(ws) for r, ws in ROW_WIDTHS.items()}

# Reuse ch32x-75 Edge.Cuts origin: anchor SW_1_1 at same position. Engine mounts follow GH60 U-grid.
# GH60 interior M2 — 4× expressed in U (19.05mm) and as mid-gap between adjacent SW centres:
# y is U-aligned from SW_1_1: H1/H2 r≈1U, H3 r≈2U, H4 r≈4U; x is 0.5U mid-gap between two switches.
SPEC = {
    "anchor": "SW_1_1",
    "grids": [], # handled via custom per-row (non-uniform)
    "rotations": [],
    "mounts": [], # GH60 mounts via custom U/mid-gap (see _custom_gh60_mounts)
    "hide": [
        # Hide all SW/ST refs up to 14 cols (covers unused SW_4_13 after ANSI 2.75 change + ST_* stabs)
        {"type": "references", "refs": [f"SW_{r}_{c}" for r in range(1, 6) for c in range(1, 15)] + [f"ST_{r}_{c}" for r in range(1, 6) for c in range(1, 15)]},
    ],
}

def _custom_gh60(board, spec):
    sw1 = board.FindFootprintByReference("SW_1_1")
    if sw1 is None:
        return
    sw1_pos = sw1.GetPosition()
    U = 19.05
    for r, widths in ROW_WIDTHS.items():
        y = (r - 1) * U
        x_offs = ROW_OFFSETS[r]
        # Map logical col index to GH60 col: SW_r_c where c indexes within row
        for c_idx, (w, x_off) in enumerate(zip(widths, x_offs), start=1):
            ref = f"SW_{r}_{c_idx}"
            fp = board.FindFootprintByReference(ref)
            if fp is None:
                continue
            # x is center of key: offset + w/2 *U
            fp.SetPosition(sw1_pos + VECTOR2I_MM(x_off + w*19.05/2 - 9.525, y))
            # For non-1U, footprint variant already sized; orientation 0
            fp.SetOrientation(EDA_ANGLE(0, pcbnew.DEGREES_T))
            fp.SetLocked(True)
            # Place separate stabilizer footprint ST_r_c at same center if width needs it
            if w in STAB_WIDTHS:
                st = board.FindFootprintByReference(f"ST_{r}_{c_idx}")
                if st is not None:
                    st.SetPosition(fp.GetPosition())
                    st.SetOrientation(EDA_ANGLE(0, pcbnew.DEGREES_T))
                    st.SetLocked(True)

    # Diodes: follow switches 1:1, offset a few mm south (reuse pair logic simplified)
    for r, widths in ROW_WIDTHS.items():
        y = (r - 1) * U + 5
        x_offs = ROW_OFFSETS[r]
        for c_idx, (w, x_off) in enumerate(zip(widths, x_offs), start=1):
            ref = f"D_{r}_{c_idx}"
            fp = board.FindFootprintByReference(ref)
            if fp is None:
                continue
            sw_ref = f"SW_{r}_{c_idx}"
            sw_fp = board.FindFootprintByReference(sw_ref)
            if sw_fp is None:
                continue
            fp.SetPosition(sw_fp.GetPosition() + VECTOR2I_MM(2.54, 4))
            fp.SetOrientation(EDA_ANGLE(90, pcbnew.DEGREES_T))
            fp.SetLocked(True)

def _custom_gh60_mounts(board, spec):
    """GH60 interior 4× M2 — tenths-absolute from GH60, no U constraint.

    Board 112205×37244 tenths (≈285.0×94.6 mm), 1 tenth = 0.00254 mm.
    H1 9921,10984 25.20,27.90 / H2 102382,10984 260.05,27.90
    / H3 50472,18504 128.20,47.00 / H4 75000,33543 190.50,85.20
    Placed at ch32x Edge.Cuts bbox + GH60 mm — discard U-aligned y.
    """
    from . import gh60_dimensions as G
    try:
        bb = board.GetBoardEdgesBoundingBox()
        ox_mm = bb.GetX() / 1e6
        oy_mm = bb.GetY() / 1e6
    except Exception:
        sw1 = board.FindFootprintByReference("SW_1_1")
        if sw1 is None:
            return
        return
    for ref, mx, my in [("H1", G.H1_X_TENTHS, G.H1_Y_TENTHS), ("H2", G.H2_X_TENTHS, G.H2_Y_TENTHS),
                        ("H3", G.H3_X_TENTHS, G.H3_Y_TENTHS), ("H4", G.H4_X_TENTHS, G.H4_Y_TENTHS)]:
        fp = board.FindFootprintByReference(ref)
        if fp is None:
            continue
        mm_x = ox_mm + mx * G.TENTHS_TO_MM
        mm_y = oy_mm + my * G.TENTHS_TO_MM
        fp.SetPosition(pcbnew.VECTOR2I_MM(mm_x, mm_y))
        fp.SetOrientation(EDA_ANGLE(0, pcbnew.DEGREES_T))
        fp.SetLocked(True)
    # H5 left hidden at old pos — delete in KiCad if strictly 4×

SPEC["custom"] = [_custom_gh60, _custom_gh60_mounts]

def position_SWs(board): _custom_gh60(board, SPEC)
def position_Ds(board): _custom_gh60(board, SPEC)
def position_all(board): engine.apply_spec(board, {"anchor": SPEC["anchor"], "mounts": SPEC["mounts"], "hide": SPEC["hide"]}); _custom_gh60(board, SPEC); _custom_gh60_mounts(board, SPEC)
def hide_labels(board): engine.apply_spec(board, {"hide": SPEC["hide"]})
def fixup(board): engine.apply_spec(board, SPEC); _custom_gh60_mounts(board, SPEC)

# For engine declarative completeness, expose row info
def row_stagger_mm(row): return 0  # GH60 is row-staggered via widths, not stagger column
