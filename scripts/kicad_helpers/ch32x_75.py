# Helper script for CH32X-75
# to be used with Kicad scripting console.
#
# Use with:
#    import sys
#    sys.path.append('/Users/richardgoulter/github/keyboard-labs--ch32x/scripts/kicad_helpers')
#    import pykey40 as p

# pcbnew.GetBoard().FindFootprintByReference("J2").SetPosition(pcbnew.VECTOR2I_MM(100, 100))

import pcbnew
from pcbnew import VECTOR2I_MM

import kicad_common


ROWS = 5
COLS = 15


def position_SWs():
    kicad_common.position_on_grid(
        ref_prefix = "SW",
        rows = ROWS,
        cols = COLS,
    )
    kicad_common.set_rotations(
        ref_prefix = "SW",
        rows = ROWS,
        cols = COLS,
        rotation_degrees = 0
    )

def position_Rs():
    kicad_common.position_on_grid(
        ref_prefix = "R",
        rows = ROWS,
        cols = COLS,
        except_refs = ["R_1_2", "R_3_7"],
    )
    kicad_common.set_rotations(
        ref_prefix = "R",
        rows = ROWS,
        cols = COLS,
        except_refs = ["R_1_2", "R_3_7"],
        rotation_degrees = -90
    )

def position_Hs():
    # Get position footprint by ref SW_1_1
    sw_1_1 = pcbnew.GetBoard().FindFootprintByReference("SW_1_1")
    sw_1_1_pos = sw_1_1.GetPosition()

    mounts = [
        ("H1", (0.5, 0.5)),
        ("H2", (15 - 1 - 0.5, 0.5)),
        ("H3", (7, 1.515)),
        ("H4", (0.5, 3.5)),
        ("H5", (15 - 1 - 0.5, 3.5)),
    ]

    # set position of all SWs relative to SW_1_1
    for (ref, (c, r)) in mounts:
        fp = pcbnew.GetBoard().FindFootprintByReference(ref)
        if fp is None:
            continue
        fp.SetPosition(sw_1_1_pos + VECTOR2I_MM(19.05 * c, 19.05 * r))

def position_Ls():
    kicad_common.position_on_grid(
        ref_prefix = "L",
        rows = ROWS,
        cols = COLS,
    )
    kicad_common.set_rotations(
        ref_prefix = "L",
        rows = ROWS,
        cols = COLS,
        rotation_degrees = 180
    )

# position the Ds
#
# Ds are spaced apart by 19.05mm in rows and columns
# starting from where D_1_1 and D_1_2 are placed.
def position_Ds():
    # kicad_common.position_pairs_on_grid(
    #     ref_prefix = "D",
    #     rows = ROWS,
    #     cols = COLS,
    #     col_spacing_mm = 19.05,
    #     row_spacing_mm = 19.05
    # )
    kicad_common.position_on_grid(
        ref_prefix = "D",
        rows = ROWS,
        cols = COLS,
        except_refs = ["D_1_2", "D_1_5", "D_1_6", "D_1_9", "D_1_10", "D_3_7"],
    )
    kicad_common.set_rotations(
        ref_prefix = "D",
        rows = ROWS,
        cols = COLS,
        rotation_degrees = 270
    )


def position_all():
    position_SWs()
    position_Ds()
    position_Rs()
    position_Hs()
    position_Ls()
    pcbnew.Refresh()

def hide_d_labels():
    kicad_common.hide_references(
        refs = kicad_common.grid_refs(
            ref_prefix = "D",
            rows = ROWS,
            cols = COLS,
        ),
    )
    pcbnew.Refresh()

def hide_sw_labels():
    kicad_common.hide_references(
        refs = kicad_common.grid_refs(
            ref_prefix = "SW",
            rows = ROWS,
            cols = COLS,
        ),
    )
    pcbnew.Refresh()

# H1-5
def hide_h_labels():
    # H1-19, because there are surely less than 20 H footprints.
    refs = ["H" + str(n) for n in range(1, 20)]
    kicad_common.hide_references(refs = refs)
    pcbnew.Refresh()

def hide_l_labels():
    kicad_common.hide_references(
        refs = kicad_common.grid_refs(
            ref_prefix = "L",
            rows = ROWS,
            cols = COLS,
        ),
    )
    pcbnew.Refresh()

def hide_r_labels():
    kicad_common.hide_references(
        refs = kicad_common.grid_refs(
            ref_prefix = "R",
            rows = ROWS,
            cols = COLS,
        ),
    )
    pcbnew.Refresh()

def hide_labels():
    hide_d_labels()
    hide_sw_labels()
    hide_h_labels()
    hide_l_labels()
    hide_r_labels()

def fixup():
    position_all()
    hide_labels()
