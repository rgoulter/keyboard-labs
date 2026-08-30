# Helper for Pico42

import pcbnew
from pcbnew import VECTOR2I_MM
from . import engine

ROWS = 4
COLS = 12

def _custom_u1(board, spec):
    sw1 = board.FindFootprintByReference("SW_1_1")
    sw12 = board.FindFootprintByReference("SW_1_12")
    u1 = board.FindFootprintByReference("U1")

    if not (sw1 and sw12 and u1):
        return

    u1.SetPosition(pcbnew.VECTOR2I(int((sw1.GetPosition().x + sw12.GetPosition().x) / 2), u1.GetPosition().y))

SPEC = {
    "anchor": "SW_1_1",
    "grids": [
        {"prefix": "SW", "rows": ROWS, "cols": COLS},
        {"prefix": "D", "rows": ROWS, "cols": COLS, "type": "pair"},
    ],
    "rotations": [
        {"prefix": "SW", "rows": ROWS, "cols": COLS, "degrees": 180},
        {"prefix": "D", "rows": ROWS, "cols": COLS, "degrees": 270},
    ],
    "mounts": [
        {"ref": "H1", "c": 0.5, "r": 0.5},
        {"ref": "H2", "c": 0.5, "r": 2.5},  # (R-1.5)=2.5
        {"ref": "H3", "c": 10.5, "r": 2.5}, # (C-1.5)=10.5
        {"ref": "H4", "c": 10.5, "r": 0.5},
        {"ref": "H5", "c": 5.5, "r": 1.5},  # (C-1)/2=5.5, (R-1)/2=1.5
        # H6 and H7-H10 use absolute mm offsets, encode as offset
        {"ref": "H6", "offset": VECTOR2I_MM(4.5*19.05+5, 1.5*19.05)},
        {"ref": "H7", "offset": VECTOR2I_MM(4.5*19.05+3, -4)},
        {"ref": "H8", "offset": VECTOR2I_MM(4.5*19.05+3, 2.5*19.05-3)},
        {"ref": "H9", "offset": VECTOR2I_MM(6.5*19.05-3, 2.5*19.05-3)},
        {"ref": "H10", "offset": VECTOR2I_MM(6.5*19.05-3, -4)},
    ],
    "hide": [
        {"type": "references", "prefix": "D", "rows": ROWS, "cols": COLS},
        {"type": "references", "prefix": "SW", "rows": ROWS, "cols": COLS},  # via hide_fp_texts in old, but use references
        {"type": "references", "refs": ["U1"]},
        {"type": "references", "refs": [f"H{n}" for n in range(1, 20)]},
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
