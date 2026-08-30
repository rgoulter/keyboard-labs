# Helper for CH552-44

import pcbnew
from pcbnew import VECTOR2I_MM
from . import engine

LOGICAL_ROWS = 7
LOGICAL_COLS = 7
GRID_ROWS = 4
GRID_COLS = 12

def keyboard_coord_to_logical_coord(coord):
    (r, c) = coord
    idx = (c - 1) * GRID_ROWS + (r - 1)
    return (idx % LOGICAL_ROWS + 1, int(idx / LOGICAL_ROWS) + 1)

def logical_coord_to_keyboard_coord(coord):
    (r, c) = coord
    idx = (c - 1) * LOGICAL_ROWS + (r - 1)
    return (idx % GRID_ROWS + 1, int(idx / GRID_ROWS) + 1)

def _custom_u1(board, spec):
    sw1 = board.FindFootprintByReference("SW_1_1")
    (lr, lc) = keyboard_coord_to_logical_coord((1, 12))
    sw12 = board.FindFootprintByReference(f"SW_{lr}_{lc}")
    u1 = board.FindFootprintByReference("U1")
    if not (sw1 and sw12 and u1):
        return
    off = VECTOR2I_MM(15.24/2, 0)
    u1.SetPosition(pcbnew.VECTOR2I(int((sw1.GetPosition().x + sw12.GetPosition().x)/2), u1.GetPosition().y) - off)

SPEC = {
    "anchor": "SW_1_1",
    "grids": [
        {"prefix": "SW", "rows": LOGICAL_ROWS, "cols": LOGICAL_COLS, "mapping": logical_coord_to_keyboard_coord},
        {"prefix": "D", "rows": LOGICAL_ROWS, "cols": LOGICAL_COLS, "type": "pair", "mapping": logical_coord_to_keyboard_coord, "inv_mapping": keyboard_coord_to_logical_coord},
    ],
    "rotations": [
        {"prefix": "SW", "rows": LOGICAL_ROWS, "cols": LOGICAL_COLS, "degrees": 0},
        {"prefix": "D", "rows": LOGICAL_ROWS, "cols": LOGICAL_COLS, "degrees": 270},
    ],
    "mounts": [
        {"ref": "H1", "c": 0.5, "r": 0.5},
        {"ref": "H2", "c": 0.5, "r": 2.5},
        {"ref": "H3", "c": 10.5, "r": 2.5},
        {"ref": "H4", "c": 10.5, "r": 0.5},
        {"ref": "H5", "c": 5.5, "r": 1.5},
        {"ref": "H7", "offset": VECTOR2I_MM(4.5*19.05+3, -4)},
        {"ref": "H8", "offset": VECTOR2I_MM(4.5*19.05+3, 1.5*19.05-3)},
        {"ref": "H9", "offset": VECTOR2I_MM(6.5*19.05-3, 1.5*19.05-3)},
        {"ref": "H10", "offset": VECTOR2I_MM(6.5*19.05-3, -4)},
    ],
    "hide": [
        {"type": "references", "prefix": "D", "rows": LOGICAL_ROWS, "cols": LOGICAL_COLS},
        {"type": "references", "prefix": "SW", "rows": LOGICAL_ROWS, "cols": LOGICAL_COLS},
        {"type": "references", "refs": ["U1"]},
        {"type": "references", "refs": [f"H{n}" for n in range(1,20)]},
    ],
    "custom": [_custom_u1],
}

def position_SWs(board): engine.apply_spec(board, {"anchor": SPEC["anchor"], "grids": [SPEC["grids"][0]], "rotations": [SPEC["rotations"][0]]})
def position_Ds(board): engine.apply_spec(board, {"anchor": SPEC["anchor"], "grids": [SPEC["grids"][1]], "rotations": [SPEC["rotations"][1]]})
def position_U1(board): _custom_u1(board, SPEC)
def position_Hs(board): engine.apply_spec(board, {"anchor": SPEC["anchor"], "mounts": SPEC["mounts"]})
def position_all(board): engine.apply_spec(board, {k: SPEC[k] for k in ("anchor","grids","rotations","mounts") if k in SPEC}); _custom_u1(board, SPEC)
def hide_labels(board): engine.apply_spec(board, {"hide": SPEC["hide"]})
def fixup(board): engine.apply_spec(board, SPEC)
