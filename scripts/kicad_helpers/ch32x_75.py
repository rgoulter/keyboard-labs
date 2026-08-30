# Helper for CH32X-75

import pcbnew
from pcbnew import VECTOR2I_MM
from . import engine

ROWS = 5
COLS = 15

SPEC = {
    "anchor": "SW_1_1",
    "grids": [
        {"prefix": "SW", "rows": ROWS, "cols": COLS},
        {"prefix": "R", "rows": ROWS, "cols": COLS, "except": ["R_1_2", "R_3_7"]},
        {"prefix": "L", "rows": ROWS, "cols": COLS},
        {"prefix": "D", "rows": ROWS, "cols": COLS, "except": ["D_1_2","D_1_5","D_1_6","D_1_9","D_1_10","D_3_7"]},
    ],
    "rotations": [
        {"prefix": "SW", "rows": ROWS, "cols": COLS, "degrees": 0},
        {"prefix": "R", "rows": ROWS, "cols": COLS, "except": ["R_1_2","R_3_7"], "degrees": -90},
        {"prefix": "L", "rows": ROWS, "cols": COLS, "degrees": 180},
        {"prefix": "D", "rows": ROWS, "cols": COLS, "degrees": 270},
    ],
    "mounts": [
        {"ref": "H1", "c": 0.5, "r": 0.5},
        {"ref": "H2", "c": 13.5, "r": 0.5}, # 15-1-0.5
        {"ref": "H3", "c": 7, "r": 1.515},
        {"ref": "H4", "c": 0.5, "r": 3.5},
        {"ref": "H5", "c": 13.5, "r": 3.5},
    ],
    "hide": [
        {"type": "references", "prefix": "D", "rows": ROWS, "cols": COLS},
        {"type": "references", "prefix": "SW", "rows": ROWS, "cols": COLS},
        {"type": "references", "prefix": "L", "rows": ROWS, "cols": COLS},
        {"type": "references", "prefix": "R", "rows": ROWS, "cols": COLS},
        {"type": "references", "refs": [f"H{n}" for n in range(1,20)]},
    ],
}

def position_SWs(board): engine.apply_spec(board, {"anchor": SPEC["anchor"], "grids": [SPEC["grids"][0]], "rotations": [SPEC["rotations"][0]]})
def position_Rs(board): engine.apply_spec(board, {"anchor": SPEC["anchor"], "grids": [SPEC["grids"][1]], "rotations": [SPEC["rotations"][1]]})
def position_Ls(board): engine.apply_spec(board, {"anchor": SPEC["anchor"], "grids": [SPEC["grids"][2]], "rotations": [SPEC["rotations"][2]]})
def position_Ds(board): engine.apply_spec(board, {"anchor": SPEC["anchor"], "grids": [SPEC["grids"][3]], "rotations": [SPEC["rotations"][3]]})
def position_Hs(board): engine.apply_spec(board, {"anchor": SPEC["anchor"], "mounts": SPEC["mounts"]})
def position_all(board): engine.apply_spec(board, {k: SPEC[k] for k in ("anchor","grids","rotations","mounts") if k in SPEC})
def hide_labels(board): engine.apply_spec(board, {"hide": SPEC["hide"]})
def fixup(board): engine.apply_spec(board, SPEC)
