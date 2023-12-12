# Helper script for CH592 60 PCB
# to be used with Kicad scripting console.
#
# Use with:
#    import sys
#    sys.path.append('/home/rgoulter/github/keyboard-labs--ch592-60/scripts/kicad_helpers')
#    import ch592_60 as p

# pcbnew.GetBoard().FindFootprintByReference("J2").SetPosition(pcbnew.VECTOR2I_MM(100, 100))

import pcbnew

from pcbnew import VECTOR2I_MM

import kicad_common

# the logical grid is 8 rows and 8 columns.
# the keyboard is 5 rows and 12 columns.

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
        idx -= 3 * 5
    return (idx % LOGICAL_ROWS + 1, int(idx / LOGICAL_ROWS) + 1)


def logical_coord_to_keyboard_coord(coord):
    (r, c) = coord
    idx = (c - 1) * LOGICAL_ROWS + (r - 1)
    # Laying out switches "lumberjack"-style on GH-60
    # skip the central 3 columns (of 5 rows);
    # So, after the first 6 columns of 5 rows,
    #  the index jumps by 3 columns.
    if idx >= 30:
        idx += 3 * 5
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
    # Position diodes in "lumberjack" style:
    # 24 diodes on the left, 12 on the bottom, 24 on the right.
    #
    # It's easiest to trace if
    #  the 30 diodes on the left have the same (logical) columns
    #  as the 30 switches on the left;
    # and if the logical rows are grouped within that.

    lhs_32_ds = ["D_{0}_{1}".format(r, c) for r in range(1, 9) for c in range(1, 5)]
    lhs_30_ds = lhs_32_ds[:30]
    rhs_30_ds = lhs_32_ds[30:] + ["D_{0}_{1}".format(r, c) for r in range(8, 0, -1) for c in range(5, 9) if c < 8 or r < 5]

    assert len(lhs_30_ds) == 30
    assert len(rhs_30_ds) == 30

    lhs_ds = lhs_30_ds[:24]
    bottom_ds = lhs_30_ds[24:] + rhs_30_ds[:6]
    rhs_ds = list(reversed(rhs_30_ds[6:]))

    assert len(lhs_ds) == 24
    assert len(bottom_ds) == 12
    assert len(rhs_ds) == 24

    # - Diode grid (left): (172, 60), dx,dy = (2.5, 3)
    # - Diode grid (below): (191, 60), dx,dy = (3, 2.5)
    # - Diode grid (right): (213, 60), dx,dy = (2.5, 3)
    dx = 2.5
    kicad_common.position_in_array(
            refs = lhs_ds,
            delta_pos_mm = (0, 3),
            adjustments_mm = [
                (0, 0),
                (-dx, 0),
                (0, 0),
                (-dx, 0),
                (0, 0),
                (-dx, 0),
                (0, 0),
                (-dx, 0),
                (0, 0),
                (-dx, 0),
                (0, 0),
                (0, 0),
                (-dx, 0),
                (-dx, 0),
                (0, 0),
                (-dx, 0),
                (0, 0),
                (-dx, 0),
                (0, 0),
                (-dx, 0),
                (0, 0),
                (-dx, 0),
                (0, 0),
                (-dx, 0),
            ]
    )
    kicad_common.position_in_array(
            refs = bottom_ds,
            delta_pos_mm = (3, 0),
            adjustments_mm = [
                (0, 0),
                (0, -dx),
                (0, 0),
                (0, -dx),
                (0, 0),
                (0, -dx),
                (0, -dx),
                (0, 0),
                (0, -dx),
                (0, 0),
                (0, -dx),
                (0, 0),
            ]
    )
    kicad_common.position_in_array(
            refs = rhs_ds,
            delta_pos_mm = (0, 3),
            adjustments_mm = [
                (0, 0),
                (dx, 0),
                (0, 0),
                (dx, 0),
                (0, 0),
                (dx, 0),
                (0, 0),
                (dx, 0),
                (0, 0),
                (dx, 0),
                (0, 0),
                (dx, 0),
                (0, 0),
                (dx, 0),
                (0, 0),
                (dx, 0),
                (0, 0),
                (dx, 0),
                (0, 0),
                (dx, 0),
                (0, 0),
                (dx, 0),
                (0, 0),
                (dx, 0),
            ]
    )
    kicad_common.set_array_rotations(lhs_ds, 0)
    kicad_common.set_array_rotations(bottom_ds, 90)
    kicad_common.set_array_rotations(rhs_ds, 180)


def position_Hs():
    # Get position footprint by ref SW_1_1
    sw_1_1 = pcbnew.GetBoard().FindFootprintByReference("SW_1_1")
    sw_1_1_pos = sw_1_1.GetPosition()

    U = 19.05
    C = 15
    R = 5

    # Hs aren't a consistent grid,
    # but some are similar.

    # H6 - H9, mount for a 3DP case
    pcbnew.GetBoard().FindFootprintByReference("H6").SetPosition(
        sw_1_1_pos + VECTOR2I_MM(0.5 * U, 0.5 * U)
    )
    pcbnew.GetBoard().FindFootprintByReference("H7").SetPosition(
        sw_1_1_pos + VECTOR2I_MM(0.5 * U, (R - 1.5) * U)
    )
    pcbnew.GetBoard().FindFootprintByReference("H8").SetPosition(
        sw_1_1_pos + VECTOR2I_MM((C - 1.5) * U, (R - 1.5) * U)
    )
    pcbnew.GetBoard().FindFootprintByReference("H9").SetPosition(
        sw_1_1_pos + VECTOR2I_MM((C - 1.5) * U, 0.5 * U)
    )
    pcbnew.Refresh()


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
