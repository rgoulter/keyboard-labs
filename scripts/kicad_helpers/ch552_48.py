# Helper script for CH552 48 PCB
# to be used with Kicad scripting console.
#
# Use with:
#    import sys
#    sys.path.append('/home/rgoulter/github/keyboard-labs/scripts/kicad_helpers')
#    import ch552_48 as p

# pcbnew.GetBoard().FindFootprintByReference("J2").SetPosition(pcbnew.VECTOR2I_MM(100, 100))

import pcbnew

from pcbnew import VECTOR2I_MM

import kicad_common

# the logical grid is 7 rows and 7 columns.
# the keyboard is 4 rows and 12 columns.

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


def position_offset_for_keyboard_coord(coord):
    (r, c) = coord
    return VECTOR2I_MM(19.05 * (c - 1), 19.05 * (r - 1))


def position_SWs():
    kicad_common.position_on_grid(
        ref_prefix = "SW",
        rows = LOGICAL_ROWS,
        cols = LOGICAL_COLS,
        logical_coord_to_grid_coord = logical_coord_to_keyboard_coord,
    )
    kicad_common.set_rotations(
        ref_prefix = "SW",
        rows = LOGICAL_ROWS,
        cols = LOGICAL_COLS,
        rotation_degrees = 0
    )


def position_Ds():
    kicad_common.position_pairs_on_grid(
        ref_prefix = "D",
        rows = LOGICAL_ROWS,
        cols = LOGICAL_COLS,
        grid_coord_to_logical_coord = keyboard_coord_to_logical_coord,
        logical_coord_to_grid_coord = logical_coord_to_keyboard_coord,
        col_spacing_mm = 19.05,
        row_spacing_mm = 19.05
    )
    kicad_common.set_rotations(
        ref_prefix = "D",
        rows = LOGICAL_ROWS,
        cols = LOGICAL_COLS,
        rotation_degrees = 270
    )


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


def position_all():
    position_SWs()
    position_Ds()
    position_Hs()
    pcbnew.Refresh()


def hide_d_labels():
    kicad_common.hide_references(
        refs = kicad_common.grid_refs(
            ref_prefix = "D",
            rows = LOGICAL_ROWS,
            cols = LOGICAL_COLS,
        ),
    )
    pcbnew.Refresh()


def hide_sw_labels():
    kicad_common.hide_fp_texts(
        refs = kicad_common.grid_refs(
            ref_prefix = "SW",
            rows = LOGICAL_ROWS,
            cols = LOGICAL_COLS,
        ),
        layer_names = ["F.Silkscreen"],
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
