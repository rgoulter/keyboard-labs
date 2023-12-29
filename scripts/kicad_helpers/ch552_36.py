# Helper script for CH552 36 PCBs
# to be used with Kicad scripting console.
#
# Use with:
#    import sys
#    sys.path.append('/home/rgoulter/github/keyboard-labs-ch552-36/scripts/kicad_helpers')
#    import ch552_36 as p

import math

import pcbnew

from pcbnew import VECTOR2I, VECTOR2I_MM

import kicad_common

ROWS = 4
COLS = 5


def rect(p):
    r, theta = p
    x = r * math.cos(math.radians(theta))
    y = r * math.sin(math.radians(theta))
    return x,y

def polar(pt):
    x, y = pt
    r = (x ** 2 + y ** 2) ** .5
    theta = math.degrees(math.atan2(y,x))
    return r, theta

def rotate_vec(v, degrees):
    vx, vy = v
    r, theta = polar((vx, -vy))
    x, y = rect((r, theta + degrees))
    return VECTOR2I(int(x), int(-y))


def position_offset_for_keyboard_coord(coord):
    (r, c) = coord
    return VECTOR2I_MM(19.05 * (c - 1), 19.05 * (r - 1))


def position_SWs():
    kicad_common.position_on_grid(
        ref_prefix = "SW",
        rows = ROWS,
        cols = COLS,
        col_stagger = [12, 6, 0, 5.5, 8],
    )
    kicad_common.set_rotations(
        ref_prefix = "SW",
        rows = ROWS,
        cols = COLS,
        rotation_degrees = 0
    )

    # Thumb cluster of SW 4_3 - SW 4_5 is fanned about SW 4_4, angled 30 degrees.

    # The middle thumb cluster button should be 2U below the home row's homing key;
    thumb_cluster_mid_offset = VECTOR2I_MM(9, 7.5)
    thumb_cluster_fan_angle_degrees = 10
    half_col_spacing_mm = 19.05 / 2
    row_spacing_mm = 19.05
    half_row_spacing_mm = row_spacing_mm / 2
    down_right = VECTOR2I_MM(half_col_spacing_mm, half_row_spacing_mm)
    down_right_rotated = rotate_vec(down_right, -thumb_cluster_fan_angle_degrees)
    down_left = VECTOR2I_MM(-half_col_spacing_mm, half_row_spacing_mm)
    down_left_rotated = rotate_vec(down_left, -thumb_cluster_fan_angle_degrees)
    up_right = VECTOR2I_MM(half_col_spacing_mm, -half_row_spacing_mm)
    up_right_rotated = rotate_vec(up_right, -thumb_cluster_fan_angle_degrees * 2)
    up_left = VECTOR2I_MM(-half_col_spacing_mm, -half_row_spacing_mm)

    sw_2_4_pos = kicad_common.position_of_reference("SW_2_4")

    sw_4_4_fp = pcbnew.GetBoard().FindFootprintByReference("SW_4_4")
    sw_4_4_pos = sw_2_4_pos + VECTOR2I_MM(0, 2 * row_spacing_mm) + thumb_cluster_mid_offset
    sw_4_4_fp.SetPosition(sw_4_4_pos)
    sw_4_4_fp.SetOrientationDegrees(-thumb_cluster_fan_angle_degrees)

    sw_4_5_fp = pcbnew.GetBoard().FindFootprintByReference("SW_4_5")
    sw_4_5_pos = sw_4_4_pos + down_right_rotated + up_right_rotated
    sw_4_5_fp.SetPosition(sw_4_5_pos)
    sw_4_5_fp.SetOrientationDegrees(-thumb_cluster_fan_angle_degrees * 2)

    sw_4_3_fp = pcbnew.GetBoard().FindFootprintByReference("SW_4_3")
    sw_4_3_pos = sw_4_4_pos + down_left_rotated + up_left
    sw_4_3_fp.SetPosition(sw_4_3_pos)
    sw_4_3_fp.SetOrientationDegrees(0)




def position_Ds():
    # kicad_common.position_pairs_on_grid(
    #     ref_prefix = "D",
    #     rows = ROWS,
    #     cols = COLS,
    #     grid_coord_to_logical_coord = keyboard_coord_to_logical_coord,
    #     logical_coord_to_grid_coord = logical_coord_to_keyboard_coord,
    #     col_spacing_mm = 19.05,
    #     row_spacing_mm = 19.05
    # )
    # 2.2, 5
    kicad_common.position_in_array(
        refs = ["D_1_1", "D_2_1", "D_3_1", "D_4_3"],
        delta_pos_mm = [2.2, 0]
    )
    kicad_common.position_in_array(
        refs = ["D_1_{c}".format(c=c) for c in range(1, 6)],
        delta_pos_mm = [0, 5]
    )
    kicad_common.position_in_array(
        refs = ["D_2_{c}".format(c=c) for c in range(1, 6)],
        delta_pos_mm = [0, 5]
    )
    kicad_common.position_in_array(
        refs = ["D_3_{c}".format(c=c) for c in range(1, 6)],
        delta_pos_mm = [0, 5]
    )
    kicad_common.position_in_array(
        refs = ["D_4_{c}".format(c=c) for c in range(3, 6)],
        delta_pos_mm = [0, 5]
    )
    kicad_common.set_rotations(
        ref_prefix = "D",
        rows = ROWS,
        cols = COLS,
        rotation_degrees = 90
    )


def position_Hs():
    pcbnew.GetBoard().FindFootprintByReference("H1").SetPosition(
        VECTOR2I(
            kicad_common.position_of_x_between_refs("SW_1_1", "SW_1_2"),
            kicad_common.position_of_y_between_refs("SW_1_2", "SW_2_2")
        )
    )
    pcbnew.GetBoard().FindFootprintByReference("H2").SetPosition(
        VECTOR2I(
            kicad_common.position_of_x_between_refs("SW_1_1", "SW_1_2"),
            kicad_common.position_of_y_between_refs("SW_2_1", "SW_3_1")
        )
    )
    pcbnew.GetBoard().FindFootprintByReference("H3").SetPosition(
        VECTOR2I(
            kicad_common.position_of_x_between_refs("SW_1_4", "SW_1_5"),
            kicad_common.position_of_y_between_refs("SW_1_4", "SW_2_4")
        )
    )
    pcbnew.GetBoard().FindFootprintByReference("H4").SetPosition(
        VECTOR2I(
            kicad_common.position_of_x_between_refs("SW_1_4", "SW_1_5"),
            kicad_common.position_of_y_between_refs("SW_2_5", "SW_3_5")
        )
    )
    pcbnew.GetBoard().FindFootprintByReference("H5").SetPosition(
        VECTOR2I(
            kicad_common.position_of_x_between_refs("SW_4_4", "SW_4_5"),
            kicad_common.position_of_y_between_refs("SW_4_4", "SW_4_5")
        )
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
    kicad_common.hide_fp_texts(
        refs = kicad_common.grid_refs(
            ref_prefix = "SW",
            rows = ROWS,
            cols = COLS,
        ),
        layer_names = ["F.Silkscreen", "B.Silkscreen"],
    )
    pcbnew.Refresh()


def delete_sw_silkscreen_graphics():
    kicad_common.delete_fp_shapes(
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
    delete_sw_silkscreen_graphics()

# For creating the RHS,
# the skeleton of the tracing can essentially be reused, etc.,
# but some manual effort is needed to retrace.
#
# The approach I'm taking is just to manually flip the whole board,
# then to flip each footprint, and swap the trace's layers,
# then to re-trace.

def flip_all_footprints():
    footprints = pcbnew.GetBoard().Footprints()
    for fp in footprints:
        fp_pos = fp.GetPosition()
        fp.Flip(fp_pos, True)
    pcbnew.Refresh()

def swap_track_layers():
    # F.Cu, B.Cu
    board = pcbnew.GetBoard()
    tracks = board.GetTracks()
    fcu_tracks = [t for t in tracks if t.GetLayerName() == "F.Cu"]
    bcu_tracks = [t for t in tracks if t.GetLayerName() == "B.Cu"]

    fcu_layer = board.GetLayerID("F.Cu")
    bcu_layer = board.GetLayerID("B.Cu")

    for t in fcu_tracks:
        t.SetLayer(bcu_layer)
    for t in bcu_tracks:
        t.SetLayer(fcu_layer)

    pcbnew.Refresh()
