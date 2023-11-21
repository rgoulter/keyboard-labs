# Helper script for Pico42 PCB
# to be used with Kicad scripting console.
#
# Use with:
#    import sys
#    sys.path.append('/home/rgoulter/github/keyboard-labs/scripts/kicad_helpers')
#    import pico42

# pcbnew.GetBoard().FindFootprintByReference("J2").SetPosition(pcbnew.VECTOR2I_MM(100, 100))

import pcbnew
from pcbnew import wxPoint, VECTOR2I_MM
from pcbnew import VECTOR2I_MM

import kicad_common


ROWS = 4
COLS = 12


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
        rotation_degrees = 180
    )


def position_Ds():
    kicad_common.position_pairs_on_grid(
        ref_prefix = "D",
        rows = ROWS,
        cols = COLS,
        col_spacing_mm = 19.05,
        row_spacing_mm = 19.05
    )
    kicad_common.set_rotations(
        ref_prefix = "D",
        rows = ROWS,
        cols = COLS,
        rotation_degrees = 270
    )


# position U1
# so its x position is halfway between the
# x of SW_1_1 and SW_1_12
def position_U1():
    sw_1_1 = pcbnew.GetBoard().FindFootprintByReference("SW_1_1")
    sw_1_12 = pcbnew.GetBoard().FindFootprintByReference("SW_1_12")
    sw_1_1_pos = sw_1_1.GetPosition()
    sw_1_12_pos = sw_1_12.GetPosition()

    u1 = pcbnew.GetBoard().FindFootprintByReference("U1")
    u1_pos = u1.GetPosition()

    u1.SetPosition(pcbnew.VECTOR2I(int((sw_1_1_pos.x + sw_1_12_pos.x) / 2), u1_pos.y))


def position_Hs():
    # Get position footprint by ref SW_1_1
    sw_1_1 = pcbnew.GetBoard().FindFootprintByReference("SW_1_1")
    sw_1_1_pos = sw_1_1.GetPosition()

    U = 19.05
    C = 12
    R = 4

    # Hs aren't a consistent grid,
    # but some are similar.

    # H1 - H5, the JJ40 mount hole positions
    pcbnew.GetBoard().FindFootprintByReference("H1").SetPosition(
        sw_1_1_pos + VECTOR2I_MM(0.5 * U, 0.5 * U)
    )
    pcbnew.GetBoard().FindFootprintByReference("H2").SetPosition(
        sw_1_1_pos + VECTOR2I_MM(0.5 * U, (R - 1.5) * U)
    )
    pcbnew.GetBoard().FindFootprintByReference("H3").SetPosition(
        sw_1_1_pos + VECTOR2I_MM((C - 1.5) * U, (R - 1.5) * U)
    )
    pcbnew.GetBoard().FindFootprintByReference("H4").SetPosition(
        sw_1_1_pos + VECTOR2I_MM((C - 1.5) * U, 0.5 * U)
    )
    pcbnew.GetBoard().FindFootprintByReference("H5").SetPosition(
        sw_1_1_pos + VECTOR2I_MM((C - 1) / 2 * U, (R - 1) / 2 * U)
    )

    # H6: additional mount, for sandwich cases
    pcbnew.GetBoard().FindFootprintByReference("H6").SetPosition(
        sw_1_1_pos + VECTOR2I_MM(4.5 * U + 5, (R - 1) / 2 * U)
    )

    # H7 - H10: mount holes for cover plate over dev board
    m = 3
    pcbnew.GetBoard().FindFootprintByReference("H7").SetPosition(
        sw_1_1_pos + VECTOR2I_MM(4.5 * U + m, -7 + 3)
    )
    pcbnew.GetBoard().FindFootprintByReference("H8").SetPosition(
        sw_1_1_pos + VECTOR2I_MM(4.5 * U + m, 2.5 * U - 3)
    )
    pcbnew.GetBoard().FindFootprintByReference("H9").SetPosition(
        sw_1_1_pos + VECTOR2I_MM(6.5 * U - m, 2.5 * U - 3)
    )
    pcbnew.GetBoard().FindFootprintByReference("H10").SetPosition(
        sw_1_1_pos + VECTOR2I_MM(6.5 * U - m, -7 + 3)
    )


def position_all():
    position_SWs()
    position_Ds()
    position_U1()
    position_Hs()
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


def hide_u1_labels():
    kicad_common.hide_fp_texts(refs = ["U1"])
    pcbnew.Refresh()


def hide_h_labels():
    # H1-19, because there are surely less than 20 H footprints.
    refs = ["H" + str(n) for n in range(1, 20)]
    kicad_common.hide_references(refs = refs)
    pcbnew.Refresh()


def hide_labels():
    hide_d_labels()
    hide_sw_labels()
    hide_u1_labels()
    hide_h_labels()


def fixup():
    position_all()
    hide_labels()
