# Helper script for CH552 44 PCB
# to be used with Kicad scripting console.
#
# Use with:
#    import sys
#    sys.path.append('/home/rgoulter/github/keyboard-labs/scripts')
#    import ch552_44

# pcbnew.GetBoard().FindFootprintByReference("J2").SetPosition(pcbnew.VECTOR2I_MM(100, 100))

import pcbnew
from pcbnew import wxPoint, VECTOR2I_MM
from pcbnew import VECTOR2I_MM

logical_rows = [r for r in range(1, 7 + 1)]
logical_cols = [r for r in range(1, 7 + 1)]

rows = [r for r in range(1, 4 + 1)]
cols = [c for c in range(1, 12 + 1)]

logical_7x7_rc = [(r, c) for r in logical_rows for c in logical_cols]
ortho_4x12_rc = [(r, c) for r in rows for c in cols]

def suffix(p):
    (r, c) = p
    return "_{r}_{c}".format(r=r, c=c)

def with_rc(f):
    return [f(p) for p in logical_7x7_rc]

SWs = with_rc(lambda p: "SW{suf}".format(suf=suffix(p)))
Ds = with_rc(lambda p: "D{suf}".format(suf=suffix(p)))

def footprints():
    return pcbnew.GetBoard().Footprints()

def footprint_ref(fp):
    return fp.Reference().GetText()

def lock(refs):
    all_fps = footprints()
    fps = [f for f in all_fps if footprint_ref(f) in refs]
    for f in fps:
        f.SetLocked(True)
    pcbnew.Refresh()

def unlock(refs):
    all_fps = footprints()
    fps = [f for f in all_fps if footprint_ref(f) in refs]
    for f in fps:
        f.SetLocked(False)
    pcbnew.Refresh()

def unlock_all():
    fps = footprints()
    for f in fps:
        f.SetLocked(False)
    pcbnew.Refresh()

# the logical grid is 7 rows and 7 columns.
# the keyboard is 4 rows and 12 columns.
def keyboard_coord_to_logical_coord(coord):
    (r, c) = coord
    idx = (c - 1) * 4 + (r - 1)
    return (idx % 7 + 1, int(idx / 7) + 1)

def logical_coord_to_keyboard_coord(coord):
    (r, c) = coord
    idx = (c - 1) * 7 + (r - 1)
    return (idx % 4 + 1, int(idx / 4) + 1)

def position_offset_for_keyboard_coord(coord):
    (r, c) = coord
    return VECTOR2I_MM(19.05 * (c - 1), 19.05 * (r - 1))

# position the SWs
#
# SWs are spaced apart by 19.05mm in rows and columns
# starting from where SW_1_1 is placed.
def position_SWs():
    # Get position footprint by ref SW_1_1
    sw_1_1 = pcbnew.GetBoard().FindFootprintByReference("SW_1_1")
    sw_1_1_pos = sw_1_1.GetPosition()

    # set position of all SWs relative to SW_1_1
    for p in logical_7x7_rc:
        (r, c) = p
        fp = pcbnew.GetBoard().FindFootprintByReference("SW_{r}_{c}".format(r=r, c=c))
        if fp is None:
            continue
        keyboard_coord = logical_coord_to_keyboard_coord(p)
        fp.SetPosition(sw_1_1_pos + position_offset_for_keyboard_coord(keyboard_coord))

        # and set to 0 degrees
        fp.SetOrientationDegrees(0)

# position the Ds
#
# Ds are spaced apart by 19.05mm in rows and columns
# starting from where D_1_1 and D_1_2 are placed.
def position_Ds():
    # Get position footprint by ref D_1_1 and D_1_2.
    d_1_1 = pcbnew.GetBoard().FindFootprintByReference("D_1_1")
    (lr, lc) = keyboard_coord_to_logical_coord((1, 2))
    d_1_2 = pcbnew.GetBoard().FindFootprintByReference("D_{r}_{c}".format(r=lr, c=lc))
    d_1_1_pos = d_1_1.GetPosition()
    d_1_2_pos = d_1_2.GetPosition()

    # set position of all Ds relative to D_1_1 and D_1_2.
    # Odd columns are relative to D_1_1, even columns are relative to D_1_2.
    for p in logical_7x7_rc:
        (r, c) = p
        fp = pcbnew.GetBoard().FindFootprintByReference("D_{r}_{c}".format(r=r, c=c))
        if fp is None:
            continue
        (kr, kc) = logical_coord_to_keyboard_coord(p)
        if kc % 2 == 1:
            fp.SetPosition(d_1_1_pos + position_offset_for_keyboard_coord((kr, kc)))

        else:
            fp.SetPosition(d_1_2_pos + position_offset_for_keyboard_coord((kr, kc - 1)))

        # and set to 270 degrees
        fp.SetOrientationDegrees(270)

# position U1
# so its x position is halfway between the
# x of SW_1_1 and SW_1_12
def position_U1():
    sw_1_1 = pcbnew.GetBoard().FindFootprintByReference("SW_1_1")
    (lr, lc) = keyboard_coord_to_logical_coord((1, 12))
    sw_1_12 = pcbnew.GetBoard().FindFootprintByReference("SW_{r}_{c}".format(r=lr, c=lc))
    sw_1_1_pos = sw_1_1.GetPosition()
    sw_1_12_pos = sw_1_12.GetPosition()

    u1 = pcbnew.GetBoard().FindFootprintByReference("U1")
    u1_pos = u1.GetPosition()

    board_middle_x_offset = 15.24 / 2
    u1.SetPosition(pcbnew.VECTOR2I(int((sw_1_1_pos.x + sw_1_12_pos.x ) / 2), u1_pos.y) - VECTOR2I_MM(board_middle_x_offset, 0))

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

    # H7 - H10: mount holes for cover plate over dev board
    m = 3
    pcbnew.GetBoard().FindFootprintByReference("H7").SetPosition(
        sw_1_1_pos + VECTOR2I_MM(4.5 * U + m, -7 + 3)
    )
    pcbnew.GetBoard().FindFootprintByReference("H8").SetPosition(
        sw_1_1_pos + VECTOR2I_MM(4.5 * U + m, 1.5 * U - 3)
    )
    pcbnew.GetBoard().FindFootprintByReference("H9").SetPosition(
        sw_1_1_pos + VECTOR2I_MM(6.5 * U - m, 1.5 * U - 3)
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
    for d in Ds:
        f = pcbnew.GetBoard().FindFootprintByReference(d)
        if f is None:
            continue
        f.Reference().SetVisible(False)
    pcbnew.Refresh()

def hide_sw_labels():
    for sw in SWs:
        f = pcbnew.GetBoard().FindFootprintByReference(sw)
        if f is None:
            continue
        # Get the text items in the footprint
        # and hide them if they're on silkscreen layers
        for t in f.GraphicalItems():
            if isinstance(t, pcbnew.FP_TEXT) and t.GetLayerName() in ["F.Silkscreen"]:
                t.SetVisible(False)
    pcbnew.Refresh()

def hide_u1_labels():
    u1 = pcbnew.GetBoard().FindFootprintByReference("U1")
    # Get the text items in the footprint
    # and hide them if they're on silkscreen layers
    for t in u1.GraphicalItems():
        if isinstance(t, pcbnew.FP_TEXT) and t.GetLayerName() in ["F.Silkscreen", "B.Silkscreen"]:
            t.SetVisible(False)
    pcbnew.Refresh()

# H1-5
def hide_h_labels():
    for h in ["H1", "H2", "H3", "H4", "H5", "H6", "H7", "H8", "H9", "H10", "H11", "H12", "H13", "H14", "H15"]:
        f = pcbnew.GetBoard().FindFootprintByReference(h)
        if f is None:
            continue
        f.Reference().SetVisible(False)
    pcbnew.Refresh()

def hide_labels():
    hide_d_labels()
    hide_sw_labels()
    hide_u1_labels()
    hide_h_labels()

def fixup():
    position_all()
    hide_labels()
