"""
Functional Core / Imperative Shell for KiCad placement (KiCad 10).

Core: pure functions that compute target positions/offsets from specs (no board IO).
Shell: apply_spec(board, spec) reads anchor positions from board, calls core, writes.

Each board helper becomes a declaration:
  SPEC = { "anchor": "SW_1_1", "grids": [...], "rotations": [...], "mounts": [...], "arrays": [...], "hide": [...], "custom": [...] }
  def fixup(board): engine.apply_spec(board, SPEC)

This replaces the previous "I position these then these" imperative scripts.
"""

from pcbnew import VECTOR2I_MM, EDA_ANGLE
import pcbnew

# ---------- Functional Core (pure, no board) ----------

def grid_offsets(rows, cols, col_spacing_mm=19.05, row_spacing_mm=19.05, col_stagger=None):
    """Pure: map logical (r,c) -> offset VECTOR2I_MM from origin."""
    # col_stagger is list per column of y offset mm (e.g. [12,6,0,5.5,8])
    adjusted = None
    if col_stagger:
        adjusted = [x - col_stagger[0] for x in col_stagger]

    out = {}
    for r in range(1, rows + 1):
        for c in range(1, cols + 1):
            base = VECTOR2I_MM(col_spacing_mm * (c - 1), row_spacing_mm * (r - 1))

            if adjusted:
                base = base + VECTOR2I_MM(0, adjusted[c - 1])

            out[(r, c)] = base

    return out


def pair_offsets(rows, cols, col_spacing_mm=19.05, row_spacing_mm=19.05):
    """Pure: for position_pairs_on_grid — returns map for odd/even columns."""
    # Caller needs two anchors (1,1) and (1,2)
    out = {}

    for r in range(1, rows + 1):
        for c in range(1, cols + 1):
            if c % 2 == 1:
                out[(r, c)] = VECTOR2I_MM(col_spacing_mm * (c - 1), row_spacing_mm * (r - 1))
            else:
                # even col offset relative to (1,2) anchor, using c-1
                out[(r, c)] = VECTOR2I_MM(col_spacing_mm * (c - 2), row_spacing_mm * (r - 1))

    return out


def mount_offset_mm(c_mul, r_mul, U=19.05):
    return VECTOR2I_MM(U * c_mul, U * r_mul)


# ---------- Imperative Shell (board IO) ----------

def _apply_grid(board, anchor_ref, spec):
    # spec: {prefix, rows, cols, mapping, except, stagger, col_spacing, row_spacing}
    prefix = spec["prefix"]
    rows, cols = spec["rows"], spec["cols"]
    mapping = spec.get("mapping", lambda x: x)
    except_refs = set(spec.get("except", []))
    col_spacing = spec.get("col_spacing_mm", 19.05)
    row_spacing = spec.get("row_spacing_mm", 19.05)
    stagger = spec.get("col_stagger")
    anchor = board.FindFootprintByReference(anchor_ref)
    if anchor is None:
        raise ValueError(f"Anchor {anchor_ref} not found")
    anchor_pos = anchor.GetPosition()
    offsets = grid_offsets(rows, cols, col_spacing, row_spacing, stagger)

    # Build mapping from logical coord -> grid coord
    for (r, c) in [(r, c) for r in range(1, rows + 1) for c in range(1, cols + 1)]:
        ref = f"{prefix}_{r}_{c}"

        if ref in except_refs:
            continue

        fp = board.FindFootprintByReference(ref)

        if fp is None:
            continue

        logical = (r, c)
        grid_coord = mapping(logical)
        off = offsets.get(grid_coord) or grid_offsets(1,1)[(1,1)]  # fallback

        # For logical->grid mapping, recompute offset via grid_offsets for grid_coord
        # Simpler: compute directly
        off = VECTOR2I_MM(col_spacing * (grid_coord[1] - 1), row_spacing * (grid_coord[0] - 1))

        if stagger:
            adjusted = [x - stagger[0] for x in stagger]
            off = off + VECTOR2I_MM(0, adjusted[grid_coord[1] - 1])

        fp.SetPosition(anchor_pos + off)


def _apply_pair_grid(board, anchor1_ref, anchor2_ref, spec):
    prefix = spec["prefix"]
    rows, cols = spec["rows"], spec["cols"]
    mapping = spec.get("mapping", lambda x: x)
    inv_mapping = spec.get("inv_mapping", lambda x: x)
    col_spacing = spec.get("col_spacing_mm", 19.05)
    row_spacing = spec.get("row_spacing_mm", 19.05)
    a1 = board.FindFootprintByReference(anchor1_ref)
    a2 = board.FindFootprintByReference(anchor2_ref)

    if a1 is None or a2 is None:
        raise ValueError(f"Pair anchors {anchor1_ref}/{anchor2_ref} not found")

    a1_pos, a2_pos = a1.GetPosition(), a2.GetPosition()

    for (r, c) in [(r, c) for r in range(1, rows + 1) for c in range(1, cols + 1)]:
        ref = f"{prefix}_{r}_{c}"
        fp = board.FindFootprintByReference(ref)

        if fp is None:
            continue

        (gr, gc) = mapping((r, c))

        if gc % 2 == 1:
            off = VECTOR2I_MM(col_spacing * (gr - 1), row_spacing * (gc - 1))
            fp.SetPosition(a1_pos + off)
        else:
            off = VECTOR2I_MM(col_spacing * (gr - 1), row_spacing * (gc - 2))
            fp.SetPosition(a2_pos + off)


def _apply_rotations(board, spec):
    prefix = spec["prefix"]
    rows, cols = spec["rows"], spec["cols"]
    deg = spec["degrees"]
    except_refs = set(spec.get("except", []))

    for r in range(1, rows + 1):
        for c in range(1, cols + 1):
            ref = f"{prefix}_{r}_{c}"

            if ref in except_refs:
                continue

            fp = board.FindFootprintByReference(ref)

            if fp is None:
                continue

            fp.SetOrientation(EDA_ANGLE(deg, pcbnew.DEGREES_T))


def _apply_mounts(board, anchor_ref, mounts, U=19.05):
    anchor = board.FindFootprintByReference(anchor_ref)

    if anchor is None:
        raise ValueError(f"Mount anchor {anchor_ref} not found")

    anchor_pos = anchor.GetPosition()

    for m in mounts:
        ref = m["ref"]
        # offset can be (c_mul, r_mul) or explicit VECTOR2I_MM or (dx_mm, dy_mm)
        off = m.get("offset")

        if off is None:
            c_mul, r_mul = m["c"], m["r"]
            off = VECTOR2I_MM(c_mul * U, r_mul * U)

        fp = board.FindFootprintByReference(ref)

        if fp is None:
            continue

        fp.SetPosition(anchor_pos + off)


def _apply_arrays(board, arrays):
    for arr in arrays:
        refs = arr["refs"]
        delta = arr["delta"]  # (dx_mm, dy_mm)
        adjustments = arr.get("adjustments")

        if not refs:
            continue

        fp0 = board.FindFootprintByReference(refs[0])

        if fp0 is None:
            continue

        fp0_pos = fp0.GetPosition()

        for i, ref in enumerate(refs):
            fp = board.FindFootprintByReference(ref)

            if fp is None:
                continue

            delta_vec = VECTOR2I_MM(delta[0] * i, delta[1] * i)
            adj = VECTOR2I_MM(0, 0)

            if adjustments:
                adj = VECTOR2I_MM(adjustments[i][0], adjustments[i][1])

            fp.SetPosition(fp0_pos + delta_vec + adj)

            if "degrees" in arr:
                fp.SetOrientation(EDA_ANGLE(arr["degrees"], pcbnew.DEGREES_T))


def apply_spec(board, spec):
    """
    Shell: interprets declarative spec.

    spec keys:
      anchor: str ref for grid origin (default "SW_1_1")
      grids: list[{prefix, rows, cols, mapping?, col_stagger?, except?, type?}]
             type "pair" uses _apply_pair_grid with anchor2
      rotations: list[{prefix, rows, cols, degrees, except?}]
      mounts: list[{ref, offset? / c,r}] + anchor
      arrays: list[{refs, delta, adjustments?, degrees?}]
      hide: list[{type:"references", prefix, rows, cols} | {type:"references", refs:[...]} | {type:"shapes", ...}]
      custom: list[callable(board, spec)] for bespoke thumb clusters etc.
      anchor2: for pair grids (default derived)
    """
    anchor = spec.get("anchor", "SW_1_1")

    # Grids
    for g in spec.get("grids", []):
        if g.get("type") == "pair":
            a2 = spec.get("anchor2") or g.get("anchor2") or "SW_1_2"
            _apply_pair_grid(board, anchor, a2, g)
        else:
            _apply_grid(board, anchor, g)

    # Rotations
    for r in spec.get("rotations", []):
        _apply_rotations(board, r)

    # Arrays (e.g., ch552_36 diodes)
    for arr in spec.get("arrays", []):
        _apply_arrays(board, [arr])

    # Mounts
    mounts = spec.get("mounts")
    if mounts:
        mount_anchor = spec.get("mount_anchor", anchor)
        _apply_mounts(board, mount_anchor, mounts)

    # Hide (imperative, but declarative list)
    for h in spec.get("hide", []):
        if h["type"] == "references":
            if "refs" in h:
                for ref in h["refs"]:
                    fp = board.FindFootprintByReference(ref)

                    if fp:
                        fp.Reference().SetVisible(False)
            else:
                prefix, rows, cols = h["prefix"], h["rows"], h["cols"]

                for r in range(1, rows + 1):
                    for c in range(1, cols + 1):
                        ref = f"{prefix}_{r}_{c}"
                        fp = board.FindFootprintByReference(ref)

                        if fp:
                            fp.Reference().SetVisible(False)
        elif h["type"] == "shapes":
            layer_names = h.get("layers", ["F.Silkscreen", "B.Silkscreen"])

            for ref in h.get("refs", []):
                fp = board.FindFootprintByReference(ref)

                if fp is None:
                    continue

                for item in fp.GraphicalItems():
                    if isinstance(item, pcbnew.FP_SHAPE) and item.GetLayerName() in layer_names:
                        item.DeleteStructure()

    # Custom hooks (e.g., thumb cluster fan)
    for fn in spec.get("custom", []):
        fn(board, spec)
