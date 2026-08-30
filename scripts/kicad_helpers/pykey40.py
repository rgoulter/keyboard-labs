# Helper for PyKey40

import pcbnew
from pcbnew import VECTOR2I_MM
from . import engine

ROWS = 4
COLS = 12
L_BLs = [f"L_BL_{n}" for n in range(1, 5)]
C_BLs = [f"C_BL_{n}" for n in range(1, 5)]
BL_GRID_COORDS = [(1.5, 1.5), (4.5, 1.5), (6.5, 1.5), (9.5, 1.5)]

def _custom_bl(board, spec):
    # L_BLs and C_BLs relative to SW_1_1, with c_bl offset from l_bl
    sw1 = board.FindFootprintByReference("SW_1_1")

    if sw1 is None:
        return

    sw1_pos = sw1.GetPosition()
    c_bl_1 = board.FindFootprintByReference("C_BL_1")
    l_bl_1 = board.FindFootprintByReference("L_BL_1")

    if c_bl_1 is None or l_bl_1 is None:
        c_offset = VECTOR2I_MM(0, 0)
    else:
        c_offset = c_bl_1.GetPosition() - l_bl_1.GetPosition()

    for idx, ref in enumerate(L_BLs):
        fp = board.FindFootprintByReference(ref)

        if fp is None:
            continue

        gc = BL_GRID_COORDS[idx]
        fp.SetPosition(sw1_pos + VECTOR2I_MM(19.05*gc[0], 19.05*gc[1]))

    for idx, ref in enumerate(C_BLs):
        fp = board.FindFootprintByReference(ref)

        if fp is None:
            continue

        gc = BL_GRID_COORDS[idx]
        # orientation copies l_bl
        l_ref = L_BLs[idx]
        l_fp = board.FindFootprintByReference(l_ref)
        fp.SetPosition(sw1_pos + c_offset + VECTOR2I_MM(19.05*gc[0], 19.05*gc[1]))

        if l_fp:
            fp.SetOrientation(l_fp.GetOrientation())

SPEC = {
    "anchor": "SW_1_1",
    "grids": [
        {"prefix": "SW", "rows": ROWS, "cols": COLS},
        {"prefix": "C", "rows": ROWS, "cols": COLS, "except": ["C_1_2"]},
        {"prefix": "L", "rows": ROWS, "cols": COLS},
        {"prefix": "D", "rows": ROWS, "cols": COLS, "type": "pair"},
    ],
    "rotations": [
        {"prefix": "C", "rows": ROWS, "cols": COLS, "except": ["C_1_2"], "degrees": -90},
    ],
    "mounts": [
        {"ref": "H1", "c": 0.5, "r": 0.5},
        {"ref": "H2", "c": 10.5, "r": 0.5}, # 12-1-0.5 =10.5
        {"ref": "H3", "c": 5.5, "r": 1.5},  # 6-0.5=5.5
        {"ref": "H4", "c": 0.5, "r": 2.5},
        {"ref": "H5", "c": 10.5, "r": 2.5},
    ],
    "custom": [_custom_bl],
    "hide": [
        {"type": "references", "prefix": "D", "rows": ROWS, "cols": COLS},
        {"type": "references", "prefix": "SW", "rows": ROWS, "cols": COLS},
        {"type": "references", "refs": ["U1"]},
        {"type": "references", "refs": [f"H{n}" for n in range(1,20)]},
    ],
}

def position_SWs(board): engine.apply_spec(board, {"anchor": SPEC["anchor"], "grids": [SPEC["grids"][0]]})
def position_Cs(board): engine.apply_spec(board, {"anchor": SPEC["anchor"], "grids": [SPEC["grids"][1]], "rotations": [SPEC["rotations"][0]]})
def position_Hs(board): engine.apply_spec(board, {"anchor": SPEC["anchor"], "mounts": SPEC["mounts"]})
def position_Ls(board): engine.apply_spec(board, {"anchor": SPEC["anchor"], "grids": [SPEC["grids"][2]]})
def position_C_BLs(board): _custom_bl(board, SPEC)
def position_L_BLs(board): _custom_bl(board, SPEC)
def position_Ds(board): engine.apply_spec(board, {"anchor": SPEC["anchor"], "grids": [SPEC["grids"][3]]})
def position_all(board): engine.apply_spec(board, {k: SPEC[k] for k in ("anchor","grids","rotations","mounts") if k in SPEC}); _custom_bl(board, SPEC)
def hide_labels(board): engine.apply_spec(board, {"hide": SPEC["hide"]})
def fixup(board): engine.apply_spec(board, SPEC)
