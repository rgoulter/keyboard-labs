"""
KiCad 10 Action Plugins - keyboard-labs.

Linux: ~/.config/kicad/10.0/scripting/plugins/
macOS: ~/Library/Preferences/kicad/10.0/scripting/plugins
Windows: %APPDATA%/kicad/10.0/scripting/plugins/

Install (KiCad 10, macOS):
  mkdir -p ~/Library/Preferences/kicad/10.0/scripting/plugins
  cp scripts/kicad_helpers/action_plugin.py ~/Library/Preferences/kicad/10.0/scripting/plugins/
  cp -r scripts/kicad_helpers ~/Library/Preferences/kicad/10.0/scripting/plugins/kicad_helpers

After restart: PCB Editor → Tools → External Plugins → Place pico42 / pykey40 / …
"""

import pcbnew


class _BasePlacePlugin(pcbnew.ActionPlugin):
    helper_name = None
    helper_func = "fixup"

    def defaults(self):
        self.name = f"Place {self.helper_name}"
        self.category = "Keyboard Labs"
        self.description = f"Run {self.helper_name}.{self.helper_func} (KiCad 10, board-aware)"
        self.show_toolbar_button = False
        self.icon_file_name = ""

    def Run(self):
        import importlib

        mod = importlib.import_module(f"kicad_helpers.{self.helper_name}")

        board = pcbnew.GetBoard()

        fn = getattr(mod, self.helper_func, None) or getattr(mod, "fixup", None) or getattr(mod, "position_all", None)

        if fn is None:
            raise RuntimeError(f"{self.helper_name} has no {self.helper_func}/fixup/position_all")

        fn(board)


class PlacePyKey40Plugin(_BasePlacePlugin):
    helper_name = "pykey40"

class PlacePico42Plugin(_BasePlacePlugin):
    helper_name = "pico42"

class PlaceCh55248Plugin(_BasePlacePlugin):
    helper_name = "ch552_48"

class PlaceCh55236Plugin(_BasePlacePlugin):
    helper_name = "ch552_36"

class PlaceCh55244Plugin(_BasePlacePlugin):
    helper_name = "ch552_44"

class PlaceCh32x75Plugin(_BasePlacePlugin):
    helper_name = "ch32x_75"

class PlaceCh59260Plugin(_BasePlacePlugin):
    helper_name = "ch592_60"

for _cls in [PlacePyKey40Plugin, PlacePico42Plugin, PlaceCh55248Plugin, PlaceCh55236Plugin, PlaceCh55244Plugin, PlaceCh32x75Plugin, PlaceCh59260Plugin]:
    try:
        _cls().register()
    except Exception:
        pass
