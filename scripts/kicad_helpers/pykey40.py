# Helper script for PyKey40
# to be used with Kicad scripting console.
#
# Use with:
#    import sys
#    sys.path.append('/home/rgoulter/github/keyboard-labs/scripts/kicad_helpers')
#    import pykey40 as p

# pcbnew.GetBoard().FindFootprintByReference("J2").SetPosition(pcbnew.VECTOR2I_MM(100, 100))

import pcbnew
from pcbnew import VECTOR2I_MM

import kicad_common


ROWS = 4
COLS = 12


L_BLs = ["L_BL_{n}".format(n=n) for n in range(1, 4 + 1)]
C_BLs = ["C_BL_{n}".format(n=n) for n in range(1, 4 + 1)]


BL_GRID_COORDS = [(1.5, 1.5), (4.5, 1.5), (6.5, 1.5), (9.5, 1.5)]


def position_SWs():
    kicad_common.position_on_grid(
        ref_prefix = "SW",
        rows = ROWS,
        cols = COLS,
    )

def position_Cs():
    kicad_common.position_on_grid(
        ref_prefix = "C",
        rows = ROWS,
        cols = COLS,
        except_refs = ["C_1_2"],
    )
    kicad_common.set_rotations(
        ref_prefix = "C",
        rows = ROWS,
        cols = COLS,
        except_refs = ["C_1_2"],
        rotation_degrees = -90
    )

def position_Hs():
    # Get position footprint by ref SW_1_1
    sw_1_1 = pcbnew.GetBoard().FindFootprintByReference("SW_1_1")
    sw_1_1_pos = sw_1_1.GetPosition()

    mounts = [
        ("H1", (0.5, 0.5)),
        ("H2", (12 - 1 - 0.5, 0.5)),
        ("H3", (6 - 0.5, 1.5)),
        ("H4", (0.5, 2.5)),
        ("H5", (12 - 1 - 0.5, 2.5)),
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

def position_C_BLs():
    # Get position footprint by ref SW_1_1
    sw_1_1 = pcbnew.GetBoard().FindFootprintByReference("SW_1_1")
    sw_1_1_pos = sw_1_1.GetPosition()

    c_bl_1_1 = pcbnew.GetBoard().FindFootprintByReference("C_BL_1")
    l_bl_1_1 = pcbnew.GetBoard().FindFootprintByReference("L_BL_1")
    c_offset = c_bl_1_1.GetPosition() - l_bl_1_1.GetPosition()

    for idx, ref in enumerate(C_BLs):
        c_bl = pcbnew.GetBoard().FindFootprintByReference(ref)
        if c_bl is None:
            continue
        grid_coord = BL_GRID_COORDS[idx]
        c_bl.SetPosition(sw_1_1_pos + c_offset + VECTOR2I_MM(19.05 * grid_coord[0], 19.05 * grid_coord[1]))
        c_bl.SetOrientationDegrees(c_bl_1_1.GetOrientationDegrees())

def position_L_BLs():
    # Get position footprint by ref SW_1_1
    sw_1_1 = pcbnew.GetBoard().FindFootprintByReference("SW_1_1")
    sw_1_1_pos = sw_1_1.GetPosition()

    for idx, ref in enumerate(L_BLs):
        l_bl = pcbnew.GetBoard().FindFootprintByReference(ref)
        if l_bl is None:
            continue
        grid_coord = BL_GRID_COORDS[idx]
        l_bl.SetPosition(sw_1_1_pos + VECTOR2I_MM(19.05 * grid_coord[0], 19.05 * grid_coord[1]))


# position the Ds
#
# Ds are spaced apart by 19.05mm in rows and columns
# starting from where D_1_1 and D_1_2 are placed.
def position_Ds():
    kicad_common.position_pairs_on_grid(
        ref_prefix = "D",
        rows = ROWS,
        cols = COLS,
        col_spacing_mm = 19.05,
        row_spacing_mm = 19.05
    )


def position_all():
    position_SWs()
    position_Ds()
    position_Cs()
    position_Hs()
    position_Ls()
    position_C_BLs()
    position_L_BLs()
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
    kicad_common.hide_fp_texts(
        refs = kicad_common.grid_refs(
            ref_prefix = "SW",
            rows = ROWS,
            cols = COLS,
        ),
        layer_names = ["F.Silkscreen", "B.Silkscreen"],
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

def hide_c_labels():
    kicad_common.hide_references(
        refs = kicad_common.grid_refs(
            ref_prefix = "C",
            rows = ROWS,
            cols = COLS,
        ),
    )
    pcbnew.Refresh()

def hide_l_bl_labels():
    kicad_common.hide_references(
        refs = L_BLs,
    )
    pcbnew.Refresh()

def hide_c_bl_labels():
    kicad_common.hide_references(
        refs = C_BLs,
    )
    pcbnew.Refresh()

def hide_labels():
    hide_d_labels()
    hide_sw_labels()
    hide_h_labels()
    hide_l_labels()
    hide_c_labels()
    hide_l_bl_labels()
    hide_c_bl_labels()

def fixup():
    position_all()
    hide_labels()
