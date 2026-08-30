#!/usr/bin/env python3
"""
CLI entrypoint - KiCad 10 only (requires pcbnew on PYTHONPATH).

All helpers are board-aware (def foo(board): ...).

Requires pcbnew on PYTHONPATH; easiest to achieve using KiCad's bundled Python:

  /Applications/KiCad/KiCad.app/Contents/Frameworks/Python.framework/Versions/3.9/bin/python3 -m scripts.kicad_helpers.cli --board pcb/keyboard-pico42.kicad_pcb --helper pico42
  /Applications/KiCad/KiCad.app/Contents/Frameworks/Python.framework/Versions/3.9/bin/python3 -m scripts.kicad_helpers.cli --board pcb/keyboard-ch32x-75.kicad_pcb --helper ch32x_75 --func fixup
  # or any Python where pcbnew is on PYTHONPATH (e.g. nix shell with pkgs.kicad):
  nix develop .#pcb --command python -m scripts.kicad_helpers.cli --board pcb/keyboard-pykey40-hsrgb.kicad_pcb --helper pykey40

GUI: use action_plugin.py instead (Tools → External Plugins).
"""

import argparse
import importlib
import sys
from pathlib import Path
from typing import Optional

try:
    import pcbnew
except ModuleNotFoundError:
    pcbnew = None  # requires pcbnew on PYTHONPATH; easiest via KiCad's bundled Python


def _require_pcbnew():
    if pcbnew is None:
        print(
            "error: pcbnew not found on PYTHONPATH — requires pcbnew on PYTHONPATH.\n"
            "  Easiest to achieve using KiCad's bundled Python:\n"
            "    /Applications/KiCad/KiCad.app/Contents/Frameworks/Python.framework/Versions/3.9/bin/python3 -m scripts.kicad_helpers.cli --board ...\n"
            "  Or any Python with pcbnew on PYTHONPATH (e.g. nix shell with pkgs.kicad).\n"
            "  GUI alternative: KiCad → PCB Editor → Tools → External Plugins (see action_plugin.py)",
            file=sys.stderr,
        )
        raise SystemExit(1)


def run_helper(board_path: Path, helper_name: str, func: str = "fixup", out_path: Optional[Path] = None):
    _require_pcbnew()

    board = pcbnew.LoadBoard(str(board_path))

    mod = importlib.import_module(f"scripts.kicad_helpers.{helper_name}")

    fn = getattr(mod, func, None) or getattr(mod, "fixup", None) or getattr(mod, "position_all", None)

    if fn is None:
        raise SystemExit(f"Helper {helper_name} has no {func}/fixup/position_all")

    fn(board)

    board.Save(str(out_path or board_path))
    print(f"Saved {out_path or board_path}")


def main():
    ap = argparse.ArgumentParser(description="Run kicad_helpers headless (KiCad 10, board-aware)")
    ap.add_argument("--board", required=True, help="path to .kicad_pcb")
    ap.add_argument("--helper", required=True, help="pykey40, pico42, ch552_48, ch552_36, ch552_44, ch32x_75, ch592_60")
    ap.add_argument("--func", default="fixup", help="function to call (default: fixup)")
    ap.add_argument("--out", help="output path (default: overwrite --board)")

    args = ap.parse_args()

    run_helper(Path(args.board), args.helper, args.func, Path(args.out) if args.out else None)


if __name__ == "__main__":
    main()
