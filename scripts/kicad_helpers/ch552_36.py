# Helper for CH552-36

import math
import pcbnew
from pcbnew import VECTOR2I, VECTOR2I_MM, EDA_ANGLE
from . import engine

ROWS = 4
COLS = 5

def rect(p):
    r, theta = p
    return (r * math.cos(math.radians(theta)), r * math.sin(math.radians(theta)))

def polar(pt):
    x, y = pt
    return ((x**2 + y**2)**0.5, math.degrees(math.atan2(y, x)))

def rotate_vec(v, deg):
    vx, vy = v
    r, theta = polar((vx, -vy))
    x, y = rect((r, theta + deg))
    return VECTOR2I(int(x), int(-y))

def _custom_thumb(board, spec):
    thumb_mid = VECTOR2I_MM(9, 7.5)

    fan = 10
    half_c = 19.05/2
    half_r = 19.05/2

    down_right = VECTOR2I_MM(half_c, half_r)
    down_right_r = rotate_vec(down_right, -fan)
    down_left = VECTOR2I_MM(-half_c, half_r)
    down_left_r = rotate_vec(down_left, -fan)

    up_right = VECTOR2I_MM(half_c, -half_r)
    up_right_r = rotate_vec(up_right, -fan*2)
    up_left = VECTOR2I_MM(-half_c, -half_r)

    sw24_pos = board.FindFootprintByReference("SW_2_4").GetPosition()

    sw44 = board.FindFootprintByReference("SW_4_4")
    pos44 = sw24_pos + VECTOR2I_MM(0, 2*19.05) + thumb_mid
    sw44.SetPosition(pos44)
    sw44.SetOrientation(EDA_ANGLE(-fan, pcbnew.DEGREES_T))

    sw45 = board.FindFootprintByReference("SW_4_5")
    sw45.SetPosition(pos44 + down_right_r + up_right_r)
    sw45.SetOrientation(EDA_ANGLE(-fan*2, pcbnew.DEGREES_T))

    sw43 = board.FindFootprintByReference("SW_4_3")
    sw43.SetPosition(pos44 + down_left_r + up_left)
    sw43.SetOrientation(EDA_ANGLE(0, pcbnew.DEGREES_T))

def _custom_h(board, spec):
    import pcbnew
    from pcbnew import VECTOR2I

    # functional: H positions are midpoints between SW refs -> pure calc
    def x_between(a,b): return int((board.FindFootprintByReference(a).GetPosition().x + board.FindFootprintByReference(b).GetPosition().x)/2)
    def y_between(a,b): return int((board.FindFootprintByReference(a).GetPosition().y + board.FindFootprintByReference(b).GetPosition().y)/2)

    board.FindFootprintByReference("H1").SetPosition(VECTOR2I(x_between("SW_1_1","SW_1_2"), y_between("SW_1_2","SW_2_2")))
    board.FindFootprintByReference("H2").SetPosition(VECTOR2I(x_between("SW_1_1","SW_1_2"), y_between("SW_2_1","SW_3_1")))
    board.FindFootprintByReference("H3").SetPosition(VECTOR2I(x_between("SW_1_4","SW_1_5"), y_between("SW_1_4","SW_2_4")))
    board.FindFootprintByReference("H4").SetPosition(VECTOR2I(x_between("SW_1_4","SW_1_5"), y_between("SW_2_5","SW_3_5")))
    board.FindFootprintByReference("H5").SetPosition(VECTOR2I(x_between("SW_4_4","SW_4_5"), y_between("SW_4_4","SW_4_5")))

SPEC = {
    "anchor": "SW_1_1",
    "grids": [
        {"prefix": "SW", "rows": ROWS, "cols": COLS, "col_stagger": [12,6,0,5.5,8]},
    ],
    "rotations": [
        {"prefix": "SW", "rows": ROWS, "cols": COLS, "degrees": 0},
        {"prefix": "D", "rows": ROWS, "cols": COLS, "degrees": 90},
    ],
    "arrays": [ # diode arrays
        {"refs": ["D_1_1","D_2_1","D_3_1","D_4_3"], "delta": (2.2, 0)},
        {"refs": [f"D_1_{c}" for c in range(1,6)], "delta": (0, 5)},
        {"refs": [f"D_2_{c}" for c in range(1,6)], "delta": (0, 5)},
        {"refs": [f"D_3_{c}" for c in range(1,6)], "delta": (0, 5)},
        {"refs": [f"D_4_{c}" for c in range(3,6)], "delta": (0, 5)},
    ],
    "hide": [
        {"type": "references", "prefix": "D", "rows": ROWS, "cols": COLS},
        {"type": "references", "prefix": "SW", "rows": ROWS, "cols": COLS},
        {"type": "shapes", "refs": [f"SW_{r}_{c}" for r in range(1,ROWS+1) for c in range(1,COLS+1)]},
        {"type": "references", "refs": ["U1"]},
        {"type": "references", "refs": [f"H{n}" for n in range(1,20)]},
    ],
    "custom": [_custom_thumb, _custom_h],
}

def position_SWs(board): engine.apply_spec(board, {"anchor": SPEC["anchor"], "grids": [SPEC["grids"][0]], "rotations": [SPEC["rotations"][0]]}); _custom_thumb(board, SPEC)
def position_Ds(board): engine.apply_spec(board, {"arrays": SPEC["arrays"], "rotations": [SPEC["rotations"][1]]})
def position_Hs(board): _custom_h(board, SPEC)
def position_all(board): engine.apply_spec(board, SPEC)
def hide_labels(board): engine.apply_spec(board, {"hide": SPEC["hide"]})
def fixup(board): engine.apply_spec(board, SPEC)
