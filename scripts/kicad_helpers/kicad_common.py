import pcbnew

from pcbnew import VECTOR2I_MM


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


def grid_ref(prefix, coord):
    (r, c) = coord
    return "{prefix}_{r}_{c}".format(prefix=prefix, r=r, c=c)


def position_offset_for_grid_coord(coord, col_spacing_mm = 19.05, row_spacing_mm = 19.05):
    (r, c) = coord
    return VECTOR2I_MM(col_spacing_mm * (c - 1), row_spacing_mm * (r - 1))


# Convenience function to get the position of a footprint
def position_of_reference(ref):
    footprint = pcbnew.GetBoard().FindFootprintByReference(ref)
    if footprint:
        return footprint.GetPosition()
    else:
        raise ValueError("No footprint with reference {ref}".format(ref=ref))

def position_in_array(
        refs,
        delta_pos_mm,
        adjustments_mm
):
    if len(refs) == 0:
        return

    fp_1_1_pos = position_of_reference(refs[0])

    for i, ref in enumerate(refs):
        footprint = pcbnew.GetBoard().FindFootprintByReference(ref)
        if footprint is None:
            continue

        delta_vec = VECTOR2I_MM(delta_pos_mm[0] * i, delta_pos_mm[1] * i)
        adjustment_vec = VECTOR2I_MM(adjustments_mm[i][0], adjustments_mm[i][1])
        footprint.SetPosition(fp_1_1_pos + delta_vec + adjustment_vec)


# My PCB designs all tend to be oriented around ortholinear grids.
# This helper function updates positions of footprints.
#
# e.g. for positioning SW_1_1 to SW_4_12 all relative to SW_1_1.
#
# Assumes refs are labelled by "logical" coords.
# (e.g. on CH552-44 where it's SW_1_1 to SW_7_7).
#
# rows: number of rows in the "logical" grid (e.g. 4)
# cols: number of columns in the "logical" grid (e.g. 12)
# logical_coord_to_grid_coord: function to convert from logical coord to grid coord (useful for CH552-44)
def position_on_grid(
        ref_prefix,
        rows,
        cols,
        logical_coord_to_grid_coord = lambda x: x,
        col_spacing_mm = 19.05,
        row_spacing_mm = 19.05
):
    fp_1_1_pos = position_of_reference(grid_ref(ref_prefix, (1, 1)))

    for logical_coord in [(r, c) for r in range(1, rows + 1) for c in range(1, cols + 1)]:
        footprint = pcbnew.GetBoard().FindFootprintByReference(grid_ref(ref_prefix, logical_coord))
        if footprint is None:
            continue
        grid_coord = logical_coord_to_grid_coord(logical_coord)
        offset = position_offset_for_grid_coord(
            coord = grid_coord,
            col_spacing_mm = col_spacing_mm,
            row_spacing_mm = row_spacing_mm
        )
        footprint.SetPosition(fp_1_1_pos + offset)


# Same as "Position on grid",
# but for pairs (like the diode pairs on PyKey40, etc.)
def position_pairs_on_grid(
    ref_prefix,
    rows,
    cols,
    grid_coord_to_logical_coord = lambda x: x,
    logical_coord_to_grid_coord = lambda x: x,
    col_spacing_mm = 19.05,
    row_spacing_mm = 19.05
):
    fp_1_1_pos = position_of_reference(grid_ref(ref_prefix, (1, 1)))
    fp_1_2_pos = position_of_reference(grid_ref(ref_prefix, grid_coord_to_logical_coord((1, 2))))

    for logical_coord in [(r, c) for r in range(1, rows + 1) for c in range(1, cols + 1)]:
        footprint = pcbnew.GetBoard().FindFootprintByReference(grid_ref(ref_prefix, logical_coord))
        if footprint is None:
            continue
        (gr, gc) = logical_coord_to_grid_coord(logical_coord)
        if gc % 2 == 1:
            offset = position_offset_for_grid_coord(
                coord = (gr, gc),
                col_spacing_mm = col_spacing_mm,
                row_spacing_mm = row_spacing_mm
            )
            footprint.SetPosition(fp_1_1_pos + offset)
        else:
            offset = position_offset_for_grid_coord(
                coord = (gr, gc - 1),
                col_spacing_mm = col_spacing_mm,
                row_spacing_mm = row_spacing_mm
            )
            footprint.SetPosition(fp_1_2_pos + offset)


def set_array_rotations(
    refs,
    rotation_degrees
):
    for ref in refs:
        footprint = pcbnew.GetBoard().FindFootprintByReference(ref)
        if footprint is None:
            continue
        footprint.SetOrientationDegrees(rotation_degrees)


def set_rotations(
    ref_prefix,
    rows,
    cols,
    rotation_degrees
):
    for logical_coord in [(r, c) for r in range(1, rows + 1) for c in range(1, cols + 1)]:
        footprint = pcbnew.GetBoard().FindFootprintByReference(grid_ref(ref_prefix, logical_coord))
        if footprint is None:
            continue
        footprint.SetOrientationDegrees(rotation_degrees)


def grid_refs(
    ref_prefix,
    rows,
    cols
):
    return [grid_ref(ref_prefix, (r, c)) for r in range(1, rows + 1) for c in range(1, cols + 1)]


def hide_references(
    refs
):
    for ref in refs:
        footprint = pcbnew.GetBoard().FindFootprintByReference(ref)
        if footprint is None:
            continue
        footprint.Reference().SetVisible(False)


def hide_fp_texts(
    refs,
    layer_names = ["F.Silkscreen", "B.Silkscreen"]
):
    for ref in refs:
        footprint = pcbnew.GetBoard().FindFootprintByReference(ref)
        if footprint is None:
            continue
        for t in footprint.GraphicalItems():
            if isinstance(t, pcbnew.FP_TEXT) and t.GetLayerName() in layer_names:
                t.SetVisible(False)


# Hide the text items in the footprint
# for the given layer_names
def hide_footprint_silkscreen_text(f, layer_names = ["F.Silkscreen", "B.Silkscreen"]):
    for t in f.GraphicalItems():
        if isinstance(t, pcbnew.FP_TEXT) and t.GetLayerName() in layer_names:
            t.SetVisible(False)
