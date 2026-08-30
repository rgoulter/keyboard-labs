"""KiCad 10 helpers — board-aware, headless + Action Plugin.

Assumes KiCad 10 (IU nm, EDA_ANGLE).

Usage:
  CLI:   board = pcbnew.LoadBoard("pcb/foo.kicad_pcb"); kicad_common.position_on_grid(board, ...)
  GUI:   board = pcbnew.GetBoard(); kicad_common.position_on_grid(board, ...)
"""

import pcbnew
from pcbnew import EDA_ANGLE, VECTOR2I_MM


def _set_orientation_deg(fp, degrees: float):
    fp.SetOrientation(EDA_ANGLE(degrees, pcbnew.DEGREES_T))


def footprints(board):
    return board.Footprints()


def footprint_ref(fp):
    return fp.Reference().GetText()


def lock(board, refs):
    for f in board.Footprints():
        if footprint_ref(f) in refs:
            f.SetLocked(True)


def unlock(board, refs):
    for f in board.Footprints():
        if footprint_ref(f) in refs:
            f.SetLocked(False)


def unlock_all(board):
    for f in board.Footprints():
        f.SetLocked(False)


def grid_ref(prefix, coord):
    (r, c) = coord
    return f"{prefix}_{r}_{c}"


def position_offset_for_grid_coord(coord, col_spacing_mm=19.05, row_spacing_mm=19.05):
    (r, c) = coord
    return VECTOR2I_MM(col_spacing_mm * (c - 1), row_spacing_mm * (r - 1))


def position_of_reference(board, ref):
    fp = board.FindFootprintByReference(ref)

    if fp:
        return fp.GetPosition()

    raise ValueError(f"No footprint with reference {ref}")


def position_of_x_between_refs(board, ref1, ref2):
    x1, _ = position_of_reference(board, ref1)
    x2, _ = position_of_reference(board, ref2)
    return int((x1 + x2) / 2)


def position_of_y_between_refs(board, ref1, ref2):
    _, y1 = position_of_reference(board, ref1)
    _, y2 = position_of_reference(board, ref2)
    return int((y1 + y2) / 2)


def position_in_array(board, refs, delta_pos_mm, adjustments_mm=None):
    if not refs:
        return

    fp0_pos = position_of_reference(board, refs[0])

    for i, ref in enumerate(refs):
        fp = board.FindFootprintByReference(ref)

        if fp is None:
            continue

        delta = VECTOR2I_MM(delta_pos_mm[0] * i, delta_pos_mm[1] * i)
        adj = VECTOR2I_MM(0, 0)

        if adjustments_mm:
            adj = VECTOR2I_MM(adjustments_mm[i][0], adjustments_mm[i][1])

        fp.SetPosition(fp0_pos + delta + adj)


def position_on_grid(
    board,
    ref_prefix,
    rows,
    cols,
    logical_coord_to_grid_coord=lambda x: x,
    col_spacing_mm=19.05,
    row_spacing_mm=19.05,
    col_stagger=None,
    except_refs=(),
):
    fp0_pos = position_of_reference(board, grid_ref(ref_prefix, (1, 1)))
    adjusted_stagger = None

    if col_stagger:
        adjusted_stagger = [x - col_stagger[0] for x in col_stagger]

    for logical_coord in [(r, c) for r in range(1, rows + 1) for c in range(1, cols + 1)]:
        ref = grid_ref(ref_prefix, logical_coord)

        if ref in except_refs:
            continue

        fp = board.FindFootprintByReference(ref)

        if fp is None:
            continue

        grid_coord = logical_coord_to_grid_coord(logical_coord)
        stagger = VECTOR2I_MM(0, 0)

        if adjusted_stagger:
            stagger = VECTOR2I_MM(0, adjusted_stagger[grid_coord[1] - 1])

        offset = position_offset_for_grid_coord(grid_coord, col_spacing_mm, row_spacing_mm)
        fp.SetPosition(fp0_pos + offset + stagger)


def position_pairs_on_grid(
    board,
    ref_prefix,
    rows,
    cols,
    grid_coord_to_logical_coord=lambda x: x,
    logical_coord_to_grid_coord=lambda x: x,
    col_spacing_mm=19.05,
    row_spacing_mm=19.05,
):
    fp0_pos = position_of_reference(board, grid_ref(ref_prefix, (1, 1)))
    fp1_pos = position_of_reference(board, grid_ref(ref_prefix, grid_coord_to_logical_coord((1, 2))))

    for logical_coord in [(r, c) for r in range(1, rows + 1) for c in range(1, cols + 1)]:
        ref = grid_ref(ref_prefix, logical_coord)
        fp = board.FindFootprintByReference(ref)

        if fp is None:
            continue

        (gr, gc) = logical_coord_to_grid_coord(logical_coord)

        if gc % 2 == 1:
            offset = position_offset_for_grid_coord((gr, gc), col_spacing_mm, row_spacing_mm)
            fp.SetPosition(fp0_pos + offset)
        else:
            offset = position_offset_for_grid_coord((gr, gc - 1), col_spacing_mm, row_spacing_mm)
            fp.SetPosition(fp1_pos + offset)


def set_array_rotations(board, refs, rotation_degrees):
    for ref in refs:
        fp = board.FindFootprintByReference(ref)

        if fp is None:
            continue

        _set_orientation_deg(fp, rotation_degrees)


def set_rotations(board, ref_prefix, rows, cols, rotation_degrees, except_refs=()):
    for logical_coord in [(r, c) for r in range(1, rows + 1) for c in range(1, cols + 1)]:
        ref = grid_ref(ref_prefix, logical_coord)

        if ref in except_refs:
            continue

        fp = board.FindFootprintByReference(ref)

        if fp is None:
            continue

        _set_orientation_deg(fp, rotation_degrees)


def grid_refs(ref_prefix, rows, cols):
    return [grid_ref(ref_prefix, (r, c)) for r in range(1, rows + 1) for c in range(1, cols + 1)]


def hide_references(board, refs):
    for ref in refs:
        fp = board.FindFootprintByReference(ref)

        if fp is None:
            continue

        fp.Reference().SetVisible(False)


def hide_fp_texts(board, refs, layer_names=("F.Silkscreen", "B.Silkscreen")):
    for ref in refs:
        fp = board.FindFootprintByReference(ref)

        if fp is None:
            continue

        for t in fp.GraphicalItems():
            pass


def delete_fp_shapes(board, refs, layer_names=("F.Silkscreen", "B.Silkscreen")):
    for ref in refs:
        fp = board.FindFootprintByReference(ref)

        if fp is None:
            continue

        for t in fp.GraphicalItems():
            if isinstance(t, pcbnew.FP_SHAPE) and t.GetLayerName() in layer_names:
                t.DeleteStructure()


def hide_footprint_silkscreen_text(f, layer_names=("F.Silkscreen", "B.Silkscreen")):
    for t in f.GraphicalItems():
        if isinstance(t, pcbnew.FP_TEXT) and t.GetLayerName() in layer_names:
            t.SetVisible(False)
