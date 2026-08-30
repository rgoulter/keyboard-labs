# Helper for CH592-60 (GH60 lumberjack)

import pcbnew
from pcbnew import VECTOR2I_MM, EDA_ANGLE
from . import engine

LOGICAL_ROWS = 8
LOGICAL_COLS = 8
GRID_ROWS = 5
GRID_COLS = 12

def keyboard_coord_to_logical_coord(coord):
    (r, c) = coord
    idx = (c - 1) * GRID_ROWS + (r - 1)
    # Laying out switches "lumberjack"-style on GH-60
    # skip the central 3 columns (of 5 rows);
    # So, after the first 6 columns of 5 rows,
    #  the index jumps by 3 columns.
    if idx >= 30:
        idx -= 3*5
    return (idx % LOGICAL_ROWS + 1, int(idx / LOGICAL_ROWS) + 1)

def logical_coord_to_keyboard_coord(coord):
    (r, c) = coord
    idx = (c - 1) * LOGICAL_ROWS + (r - 1)
    # Laying out switches "lumberjack"-style on GH-60
    # skip the central 3 columns (of 5 rows);
    # So, after the first 6 columns of 5 rows,
    #  the index jumps by 3 columns.
    if idx >= 30:
        idx += 3*5
    return (idx % GRID_ROWS + 1, int(idx / GRID_ROWS) + 1)

def _custom_diodes(board, spec):
    # 24 diodes on the left, 12 on the bottom, 24 on the right.
    #
    # It's easiest to trace if
    #  the 30 diodes on the left have the same (logical) columns
    #  as the 30 switches on the left;
    # and if the logical rows are grouped within that.

    lhs_32 = [f"D_{r}_{c}" for r in range(1,9) for c in range(1,5)]
    lhs_30 = lhs_32[:30]
    rhs_30 = lhs_32[30:] + [f"D_{r}_{c}" for r in range(8,0,-1) for c in range(5,9) if c < 8 or r < 5]
    lhs_ds, bottom_ds, rhs_ds = lhs_30[:24], lhs_30[24:]+rhs_30[:6], list(reversed(rhs_30[6:]))
    dx = 2.5
    engine._apply_arrays(board, [
        {"refs": lhs_ds, "delta": (0,3), "adjustments": [(0,0) if i%2==0 else (-dx,0) for i in range(len(lhs_ds))]},
        {"refs": bottom_ds, "delta": (3,0), "adjustments": [(0,0) if i%2==0 else (0,-dx) for i in range(len(bottom_ds))], "degrees": 90},
        {"refs": rhs_ds, "delta": (0,3), "adjustments": [(0,0) if i%2==0 else (dx,0) for i in range(len(rhs_ds))], "degrees": 180},
    ])

    for ref in lhs_ds:
        fp = board.FindFootprintByReference(ref)
        if fp: fp.SetOrientation(EDA_ANGLE(0, pcbnew.DEGREES_T))

SPEC = {
    "anchor": "SW_1_1",
    "grids": [
        {"prefix": "SW", "rows": LOGICAL_ROWS, "cols": LOGICAL_COLS, "mapping": logical_coord_to_keyboard_coord},
    ],
    "rotations": [
        {"prefix": "SW", "rows": LOGICAL_ROWS, "cols": LOGICAL_COLS, "degrees": 0},
    ],
    "mounts": [
        # H6-H9 for CH592 case (subset of lumberjack mounts)
        {"ref": "H6", "c": 0.5, "r": 0.5},
        {"ref": "H7", "c": 0.5, "r": 3.5},
    ],
    "hide": [
        {"type": "references", "prefix": "SW", "rows": LOGICAL_ROWS, "cols": LOGICAL_COLS},
    ],
    "custom": [_custom_diodes],
}

def position_SWs(board): engine.apply_spec(board, {"anchor": SPEC["anchor"], "grids": [SPEC["grids"][0]], "rotations": [SPEC["rotations"][0]]})
def position_Ds(board): _custom_diodes(board, SPEC)
def position_Hs(board): engine.apply_spec(board, {"anchor": SPEC["anchor"], "mounts": SPEC["mounts"]})
def position_all(board): engine.apply_spec(board, SPEC)
def hide_labels(board): engine.apply_spec(board, {"hide": SPEC["hide"]})
def fixup(board): engine.apply_spec(board, SPEC)
