#!/usr/bin/env python3
"""Generate a KiCad switch-plate PCB from a keyboard PCB.

The plate copies Edge.Cuts from the source board, then adds MX switch
 cutouts, stabilizer cutouts for ≥2u keys, mounting holes, and
 B.Silkscreen text.

Back silkscreen is the side that faces the keyboard PCB in a sandwich
 stack. Default placement is small text (<20 mm wide) south of a SW_r_c;
 pass --face-at / --text-ref when that default collides (col stagger).

Requires pcbnew on PYTHONPATH (KiCad's bundled Python, or nix develop .#pcb):

  /Applications/KiCad/KiCad.app/Contents/Frameworks/Python.framework/Versions/3.9/bin/python3 \\
    -m scripts.kicad_helpers.make_switch_plate \\
    --board pcb/keyboard-ch32x-48.kicad_pcb
"""

from __future__ import annotations

import argparse
import math
import re
import sys
from pathlib import Path
from typing import Iterable, Optional, Sequence, Tuple

try:
    import pcbnew
    from pcbnew import EDA_ANGLE, VECTOR2I_MM
except ModuleNotFoundError:
    pcbnew = None
    EDA_ANGLE = None
    VECTOR2I_MM = None


# MX plate cutout and Cherry 2u PCB-mount stab (6 north / 9 south of centre).
SWITCH_CUTOUT_MM = 14.0
STAB_W_MM = 7.0
STAB_H_MM = 15.0
STAB_DX_MM = 11.938
STAB_Y_OFF_MM = 1.5
MOUNT_D_MM = 4.5
EDGE_WIDTH_MM = 0.05

DEFAULT_FACE_TEXT = "this side faces towards\nthe keyboard PCB"
DEFAULT_REPO_TEXT = "github.com/rgoulter/keyboard-labs"
MAX_TEXT_WIDTH_MM = 20.0
DEFAULT_TEXT_REF = "SW_1_1"
# Gap from the south edge of the 14 mm cutout to the top of the face text.
BELOW_SWITCH_GAP_MM = 1.2
STACK_GAP_MM = 0.4

_WIDTH_U_RE = re.compile(r"(\d+(?:\.\d+)?)u", re.IGNORECASE)
_XY_RE = re.compile(r"^\s*([+-]?\d+(?:\.\d+)?)\s*,\s*([+-]?\d+(?:\.\d+)?)\s*$")


# ---------- Functional core (no pcbnew) ----------

def parse_xy(value: str) -> Tuple[float, float]:
    """Parse ``x,y`` millimetres (spaces around the comma are ok)."""
    m = _XY_RE.match(value)
    if m is None:
        raise argparse.ArgumentTypeError(f"expected x,y millimetres, got {value!r}")
    return float(m.group(1)), float(m.group(2))


def parse_switch_width_u(fp_name: str) -> Optional[float]:
    """Width in units from a footprint name such as ``SW_Cherry_MX_PCB_2.00u``.

    Returns None when the name has no ``Nu`` suffix (1u assumed by callers).
    """
    item = fp_name.rsplit(":", 1)[-1]
    m = _WIDTH_U_RE.search(item)
    if m is None:
        return None
    return float(m.group(1))


def needs_stab(width_u: Optional[float]) -> bool:
    return width_u is not None and width_u >= 2.0


def is_switch_ref(ref: str) -> bool:
    # SW_r_c (current boards) or SW_rc (older X-1 / X-2).
    return bool(re.match(r"^SW_\d+_\d+$", ref) or re.match(r"^SW_\d{2}$", ref))


def is_stab_ref(ref: str) -> bool:
    return ref.startswith("ST_")


def is_mount_ref(ref: str) -> bool:
    return bool(re.match(r"^H\d+$", ref))


def rotate_offset(dx: float, dy: float, deg: float) -> Tuple[float, float]:
    """Rotate a local offset by a KiCad footprint orientation (degrees)."""
    rad = math.radians(deg)
    c, s = math.cos(rad), math.sin(rad)
    return dx * c - dy * s, dx * s + dy * c


def oriented_rect_corners(
    cx: float, cy: float, w: float, h: float, deg: float
) -> Sequence[Tuple[float, float]]:
    local = ((-w / 2, -h / 2), (w / 2, -h / 2), (w / 2, h / 2), (-w / 2, h / 2))
    out = []
    for dx, dy in local:
        rx, ry = rotate_offset(dx, dy, deg)
        out.append((cx + rx, cy + ry))
    return out


def stab_centers(cx: float, cy: float, deg: float = 0.0) -> Sequence[Tuple[float, float]]:
    pts = []
    for dx in (-STAB_DX_MM, STAB_DX_MM):
        rx, ry = rotate_offset(dx, STAB_Y_OFF_MM, deg)
        pts.append((cx + rx, cy + ry))
    return pts


def longest_line_chars(text: str) -> int:
    lines = text.splitlines() or [""]
    return max(len(line) for line in lines)


def text_size_for_width(
    text: str,
    max_width_mm: float = MAX_TEXT_WIDTH_MM,
    max_size_mm: float = 0.8,
    min_size_mm: float = 0.5,
    char_width: float = 1.0,
) -> float:
    """Stroke-font size so the longest line stays within ``max_width_mm``."""
    n = longest_line_chars(text)
    if n <= 0:
        return max_size_mm
    size = max_width_mm / (n * char_width)
    return max(min_size_mm, min(max_size_mm, size))


def text_height_mm(text: str, size_mm: float, line_spacing: float = 1.5) -> float:
    n = max(1, len(text.splitlines()))
    return size_mm + (n - 1) * size_mm * line_spacing


def below_switch_offset(
    cutout_mm: float = SWITCH_CUTOUT_MM, gap_mm: float = BELOW_SWITCH_GAP_MM
) -> Tuple[float, float]:
    """Offset from a switch centre to the top of text south of the cutout."""
    return (0.0, cutout_mm / 2.0 + gap_mm)


def stacked_south(
    x: float, y: float, height_mm: float, gap_mm: float = STACK_GAP_MM
) -> Tuple[float, float]:
    return (x, y + height_mm + gap_mm)


def wrap_to_max_chars(text: str, max_chars: int) -> str:
    """Wrap on spaces so no line exceeds ``max_chars`` (keeps existing newlines)."""
    if max_chars < 1:
        return text
    out_lines = []
    for para in text.splitlines() or [""]:
        words = para.split()
        if not words:
            out_lines.append("")
            continue
        line = words[0]
        for w in words[1:]:
            trial = f"{line} {w}"
            if len(trial) <= max_chars:
                line = trial
            else:
                out_lines.append(line)
                line = w
        out_lines.append(line)
    return "\n".join(out_lines)


def fit_text(
    text: str,
    max_width_mm: float = MAX_TEXT_WIDTH_MM,
    max_size_mm: float = 0.8,
    min_size_mm: float = 0.5,
) -> Tuple[str, float]:
    """Wrap if needed, then pick a size that stays within ``max_width_mm``."""
    size = text_size_for_width(text, max_width_mm, max_size_mm, min_size_mm)
    if size > min_size_mm + 1e-9:
        return text, size
    max_chars = max(1, int(max_width_mm / min_size_mm))
    wrapped = wrap_to_max_chars(text, max_chars)
    size = text_size_for_width(wrapped, max_width_mm, max_size_mm, min_size_mm)
    return wrapped, size


def resolve_text_xy(
    origin: Tuple[float, float],
    absolute: Optional[Tuple[float, float]],
    offset: Optional[Tuple[float, float]],
    default_offset: Tuple[float, float],
) -> Tuple[float, float]:
    if absolute is not None:
        return absolute
    dx, dy = default_offset if offset is None else offset
    return origin[0] + dx, origin[1] + dy


# ---------- Imperative shell (pcbnew) ----------

def _require_pcbnew():
    if pcbnew is None:
        print(
            "error: pcbnew not found on PYTHONPATH — requires pcbnew on PYTHONPATH.\n"
            "  Easiest to achieve using KiCad's bundled Python:\n"
            "    /Applications/KiCad/KiCad.app/Contents/Frameworks/Python.framework/Versions/3.9/bin/python3"
            " -m scripts.kicad_helpers.make_switch_plate --board ...\n"
            "  Or any Python with pcbnew on PYTHONPATH (e.g. nix shell with pkgs.kicad).",
            file=sys.stderr,
        )
        raise SystemExit(1)


def _mm(pt) -> Tuple[float, float]:
    return pt.x / 1e6, pt.y / 1e6


def _add_rect(board, cx: float, cy: float, w: float, h: float):
    s = pcbnew.PCB_SHAPE(board)
    s.SetShape(pcbnew.SHAPE_T_RECT)
    s.SetStart(VECTOR2I_MM(cx - w / 2, cy - h / 2))
    s.SetEnd(VECTOR2I_MM(cx + w / 2, cy + h / 2))
    s.SetLayer(pcbnew.Edge_Cuts)
    s.SetWidth(int(EDGE_WIDTH_MM * 1e6))
    s.SetFilled(False)
    board.Add(s)


def _add_poly(board, pts: Iterable[Tuple[float, float]]):
    s = pcbnew.PCB_SHAPE(board)
    s.SetShape(pcbnew.SHAPE_T_POLY)
    s.SetPolyPoints([VECTOR2I_MM(x, y) for x, y in pts])
    s.SetLayer(pcbnew.Edge_Cuts)
    s.SetWidth(int(EDGE_WIDTH_MM * 1e6))
    s.SetFilled(False)
    board.Add(s)


def _add_circle(board, cx: float, cy: float, r: float):
    s = pcbnew.PCB_SHAPE(board)
    s.SetShape(pcbnew.SHAPE_T_CIRCLE)
    s.SetCenter(VECTOR2I_MM(cx, cy))
    s.SetEnd(VECTOR2I_MM(cx + r, cy))
    s.SetLayer(pcbnew.Edge_Cuts)
    s.SetWidth(int(EDGE_WIDTH_MM * 1e6))
    s.SetFilled(False)
    board.Add(s)


def _add_silk_text(
    board,
    text: str,
    xy: Tuple[float, float],
    size_mm: float,
    angle_deg: float = 0.0,
):
    t = pcbnew.PCB_TEXT(board)
    t.SetText(text)
    t.SetLayer(pcbnew.B_SilkS)
    t.SetPosition(VECTOR2I_MM(xy[0], xy[1]))
    t.SetTextSize(VECTOR2I_MM(size_mm, size_mm))
    t.SetTextThickness(int(round(max(0.1, size_mm * 0.15) * 1e6)))
    t.SetMirrored(True)
    t.SetHorizJustify(pcbnew.GR_TEXT_H_ALIGN_CENTER)
    t.SetVertJustify(pcbnew.GR_TEXT_V_ALIGN_TOP)
    if angle_deg:
        t.SetTextAngle(EDA_ANGLE(angle_deg, pcbnew.DEGREES_T))
    board.Add(t)


def _copy_edge_cuts(dst, src):
    for d in src.GetDrawings():
        if d.GetLayer() != pcbnew.Edge_Cuts:
            continue
        if not isinstance(d, pcbnew.PCB_SHAPE):
            continue
        dst.Add(d.Duplicate())


def _orientation_deg(fp) -> float:
    if hasattr(fp, "GetOrientationDegrees"):
        return fp.GetOrientationDegrees()
    return fp.GetOrientation().AsDegrees()


def _fp_name(fp) -> str:
    if hasattr(fp, "GetFPIDAsString"):
        return fp.GetFPIDAsString()
    fpid = fp.GetFPID()
    return f"{fpid.GetLibNickname()}:{fpid.GetLibItemName()}"


def make_switch_plate(
    src,
    *,
    face_text: str = DEFAULT_FACE_TEXT,
    repo_text: str = DEFAULT_REPO_TEXT,
    text_ref: str = DEFAULT_TEXT_REF,
    repo_ref: Optional[str] = None,
    face_at: Optional[Tuple[float, float]] = None,
    repo_at: Optional[Tuple[float, float]] = None,
    face_offset: Optional[Tuple[float, float]] = None,
    repo_offset: Optional[Tuple[float, float]] = None,
    face_angle_deg: float = 0.0,
    repo_angle_deg: float = 0.0,
    max_text_width_mm: float = MAX_TEXT_WIDTH_MM,
    mount_d_mm: float = MOUNT_D_MM,
    switch_cutout_mm: float = SWITCH_CUTOUT_MM,
):
    """Fill a new BOARD with plate geometry taken from ``src``.

    Returns the new board. Does not save.
    """
    _require_pcbnew()

    board = pcbnew.BOARD()
    board.SetDesignSettings(src.GetDesignSettings())

    src_tb = src.GetTitleBlock()
    title = src_tb.GetTitle() or Path(src.GetFileName()).stem
    tb = pcbnew.TITLE_BLOCK()
    tb.SetTitle(f"{title} switch plate")
    tb.SetDate(src_tb.GetDate())
    tb.SetRevision(src_tb.GetRevision())
    tb.SetCompany(src_tb.GetCompany())
    board.SetTitleBlock(tb)

    _copy_edge_cuts(board, src)

    switches = []
    stab_suffixes = set()
    mounts = []

    for fp in src.Footprints():
        ref = fp.GetReference()
        x, y = _mm(fp.GetPosition())
        deg = _orientation_deg(fp)
        if is_switch_ref(ref):
            width_u = parse_switch_width_u(_fp_name(fp))
            switches.append((ref, x, y, deg, width_u))
        elif is_stab_ref(ref):
            stab_suffixes.add(ref[len("ST_") :])
            for sx, sy in stab_centers(x, y, deg):
                corners = oriented_rect_corners(sx, sy, STAB_W_MM, STAB_H_MM, deg)
                _add_poly(board, corners)
        elif is_mount_ref(ref):
            mounts.append((ref, x, y))

    for ref, x, y, deg, width_u in switches:
        _add_rect(board, x, y, switch_cutout_mm, switch_cutout_mm)
        suffix = ref[len("SW_") :]
        if suffix in stab_suffixes:
            continue
        if needs_stab(width_u):
            for sx, sy in stab_centers(x, y, deg):
                corners = oriented_rect_corners(sx, sy, STAB_W_MM, STAB_H_MM, deg)
                _add_poly(board, corners)

    for _ref, x, y in mounts:
        _add_circle(board, x, y, mount_d_mm / 2.0)

    by_ref = {ref: (x, y) for ref, x, y, _deg, _w in switches}
    if text_ref not in by_ref:
        raise SystemExit(f"text origin {text_ref!r} not found among SW_* footprints")
    origin = by_ref[text_ref]
    repo_origin = origin
    if repo_ref:
        if repo_ref not in by_ref:
            raise SystemExit(f"repo text origin {repo_ref!r} not found among SW_* footprints")
        repo_origin = by_ref[repo_ref]

    default_off = below_switch_offset(switch_cutout_mm)

    if face_text:
        fitted, face_size = fit_text(face_text, max_text_width_mm)
        face_xy = resolve_text_xy(origin, face_at, face_offset, default_off)
        _add_silk_text(board, fitted, face_xy, face_size, face_angle_deg)
        auto_repo = stacked_south(face_xy[0], face_xy[1], text_height_mm(fitted, face_size))
    else:
        auto_repo = (origin[0] + default_off[0], origin[1] + default_off[1])

    if repo_text:
        fitted_repo, repo_size = fit_text(repo_text, max_text_width_mm, max_size_mm=0.6)
        if repo_at is not None or repo_offset is not None or repo_ref:
            repo_xy = resolve_text_xy(repo_origin, repo_at, repo_offset, default_off)
        else:
            repo_xy = auto_repo
        _add_silk_text(board, fitted_repo, repo_xy, repo_size, repo_angle_deg)

    return board


def default_out_path(board_path: Path) -> Path:
    return board_path.with_name(f"{board_path.stem}_plate.kicad_pcb")


def build_arg_parser() -> argparse.ArgumentParser:
    ap = argparse.ArgumentParser(
        description="Generate a switch-plate .kicad_pcb from a keyboard PCB (KiCad 10)"
    )
    ap.add_argument("--board", required=True, help="source keyboard .kicad_pcb")
    ap.add_argument("--out", help="output path (default: <board>_plate.kicad_pcb)")
    ap.add_argument(
        "--face-text",
        default=DEFAULT_FACE_TEXT,
        help="B.Silk orientation text (empty string to omit)",
    )
    ap.add_argument(
        "--repo-text",
        default=DEFAULT_REPO_TEXT,
        help="B.Silk repo URL (empty string to omit)",
    )
    ap.add_argument(
        "--text-ref",
        default=DEFAULT_TEXT_REF,
        help="SW_r_c used as the origin for default / offset placement",
    )
    ap.add_argument("--repo-ref", help="SW_r_c origin for repo text (default: --text-ref)")
    ap.add_argument("--face-at", type=parse_xy, help="absolute face-text position x,y mm")
    ap.add_argument("--repo-at", type=parse_xy, help="absolute repo-text position x,y mm")
    ap.add_argument(
        "--face-offset",
        type=parse_xy,
        help="face-text offset from --text-ref (default: south of the cutout)",
    )
    ap.add_argument(
        "--repo-offset",
        type=parse_xy,
        help="repo-text offset from --repo-ref/--text-ref (default: stacked under face text)",
    )
    ap.add_argument("--face-angle", type=float, default=0.0, help="face-text rotation degrees")
    ap.add_argument("--repo-angle", type=float, default=0.0, help="repo-text rotation degrees")
    ap.add_argument(
        "--max-text-width",
        type=float,
        default=MAX_TEXT_WIDTH_MM,
        help="shrink/wrap B.Silk so each line stays under this width (mm)",
    )
    ap.add_argument("--mount-d", type=float, default=MOUNT_D_MM, help="mounting hole diameter mm")
    ap.add_argument(
        "--cutout", type=float, default=SWITCH_CUTOUT_MM, help="switch cutout size mm (MX=14)"
    )
    return ap


def main(argv: Optional[Sequence[str]] = None):
    _require_pcbnew()
    args = build_arg_parser().parse_args(argv)
    board_path = Path(args.board)
    out_path = Path(args.out) if args.out else default_out_path(board_path)

    src = pcbnew.LoadBoard(str(board_path))
    board = make_switch_plate(
        src,
        face_text=args.face_text,
        repo_text=args.repo_text,
        text_ref=args.text_ref,
        repo_ref=args.repo_ref,
        face_at=args.face_at,
        repo_at=args.repo_at,
        face_offset=args.face_offset,
        repo_offset=args.repo_offset,
        face_angle_deg=args.face_angle,
        repo_angle_deg=args.repo_angle,
        max_text_width_mm=args.max_text_width,
        mount_d_mm=args.mount_d,
        switch_cutout_mm=args.cutout,
    )
    pcbnew.SaveBoard(str(out_path), board)
    print(f"Wrote {out_path}")


if __name__ == "__main__":
    main()
