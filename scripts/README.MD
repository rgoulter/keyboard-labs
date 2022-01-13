# Scripts

## Nix-Shells

### shell-kibot.nix

[KiBot](https://github.com/INTI-CMNB/KiBot) can be used to generate
assets for the KiCad PCBs in this project's `pcb/` directory.

With [Nix](https://nixos.org/) installed, run:

```
nix-shell shell-kibot.nix
```

This provides a shell which has `kibot` on its `PATH`.

### shell-interactive-html-bom.nix

Provides a standalone script of
[InteractiveHtmlBom](https://github.com/openscopeproject/InteractiveHtmlBom),
`InteractiveHtmlBom`.

The script requires that the netlist be generated from eeschema,
so that symbol fields (like comment, description) can be used in the ibom.

Some convenience scripts e.g. `generate-x1-ibom.sh` are provided which can
be called with:

```
nix-shell generate-x1-ibom.sh
```

## Transform .kicad_pcb to .scad

### Examples

e.g. OpenSCAD code for a top plate:

```
plate(
    edge_cuts_data = edge_cuts_data,
    modules_data = modules_data,
    /// Include these footprints in the cutout:
    include_footprints = [
        "Keebio-Parts:TRRS-PJ-320A",
        "ProjectLocal:SW_MX_PG1350_reversible",
        "ProjectLocal:WeAct_MiniF4_ZigZag",
        "Rotary_Encoder:RotaryEncoder_Alps_EC11E-Switch_Vertical_H20mm",
        "ProjectLocal:H_M2_Spacer_Hole",
    ],
    /// Don't cutout any with those footprints:
    // exclude_footprints = [],
    /// Don't cutout if reference has any of these as prefix:
    // exclude_reference_prefixes = ["C", "D", "Q", "R", "TP"],
    /// Don't cutout with this reference:
    // exclude_references = [],
    /// Cutout modules with these references,
    /// even if otherwise excluded / not included from cutout:
    force_include_references = [
        "J3"
    ]
);
```

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/openscad_plate1.png"  width=600 />

and for a bottom plate:

```
plate(
    edge_cuts_data = edge_cuts_data,
    modules_data = modules_data,
    include_footprints = [
        "ProjectLocal:H_M2_Spacer_Hole",
    ]
);
```

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/docs/images/openscad_plate2.png"  width=600 />

These would require implementing the generated boilerplate
of `footprint_modules.scad`, which would look like:

```
// ....

// Footprint used by: H10, H6, H7, H8, H9
module Footprint_ProjectLocal_H_M2_Spacer_Hole() {
    circle(d = 2.3);
}

// Footprint used by: SW_11, SW_12, SW_13, SW_14, SW_15, SW_21, SW_22,
//  SW_23, SW_24, SW_25, SW_31, SW_32, SW_33, SW_34, SW_35, SW_41,
//  SW_42, SW_43
module Footprint_ProjectLocal_SW_MX_PG1350_reversible() {
    square(14, center = true);
}

// ....

// Constructs the geometry for a given module_data structure.
//
// The module_data has the structure:
//   [
//     footprint_name,
//     ["at", x, y, rotation],
//     ["reference", module_reference],
//     ["side", side]
//   ]
module module_for_footprint(
    module_data,
    allow_unhandled_footprints = true,
    allow_unimplemented_footprints = true
) {
    module_footprint = module_data[0];

    if (module_footprint == "Connector_PinSocket_2.54mm:PinSocket_1x04_P2.54mm_Vertical") {
        Footprint_Connector_PinSocket_2_54mm_PinSocket_1x04_P2_54mm_Vertical();
    } else if (module_footprint == "Keebio-Parts:TRRS-PJ-320A") {
        Footprint_Keebio_Parts_TRRS_PJ_320A();
    } else if (module_footprint == "ProjectLocal:H_M2_Spacer_Hole") {
        Footprint_ProjectLocal_H_M2_Spacer_Hole();
    } else if (module_footprint == "ProjectLocal:SW_MX_PG1350_reversible") {
        Footprint_ProjectLocal_SW_MX_PG1350_reversible();
    } else if (module_footprint == "ProjectLocal:WeAct_MiniF4_ZigZag") {
        Footprint_ProjectLocal_WeAct_MiniF4_ZigZag();
    } else if (module_footprint == "Rotary_Encoder:RotaryEncoder_Alps_EC11E-Switch_Vertical_H20mm") {
        Footprint_Rotary_Encoder_RotaryEncoder_Alps_EC11E_Switch_Vertical_H20mm();
    } else {
        assert(allow_unhandled_footprints, "fall-through; unhandled footprint: '" + module_footprint + "'");
    }
}
```

### Motivation

Coming up with the files for plates for a keyboard PCB designed
in Kicad is a bit tedious. The top switch plate needs to have holes for
key switches aligned in the same positions as in the PCB. Both the top plate
and the bottom plate need holes for M2 screws, which are aligned in the position
of the M2 spacer holes in the PCB.

One solution to this is to make use of
the User layers in the Kicad footprints. This forces use of non-standard
libraries, or use of libraries which use the User layer like that.

Another solution is to export or plot an SVG or other format, and come up
with the top/bottom plates from that.

I wanted a solution which let me interact with the Kicad PCB's modules (each
placed footprint in the PCB) in OpenSCAD.

### Requirements

This script requires Python 3, as well as the `jinja2` and `sexpdata` Python
packages.

A `shell.nix` file is provided in this directory. If nixpkgs is installed,
this will provide a shell with these requirements by invoking:

```
nix-shell
```

### Running

The `transform_kicadpcb_to_scad.py` requires the path to a `.kicadpcb` file
in order to generate OpenSCAD code.

By default, this outputs to the `cad/keyboard_plates/<project name>` directory
in this repository, where `<project name>` defaults to the name of the
`.kicad_pcb` file without the extension.

This can be invoked by e.g.:

```
python transform_kicadpcb_to_scad.py \
    --kicad_pcb_path <path/to/keyboard.kicad_pcb>
```

### Testing

The Python unit tests can be invoked with:

```
python -m unittest
```

### Implementation Overview

The essense of the script is to output OpenSCAD files around the idea
of encoding each Kicad module as an array that OpenSCAD can manipulate.
e.g.:

```
[
  footprint_name,
  ["at", x, y, rotation],
  ["reference", module_reference],
  ["side", side]
]
```

this can be used (with some supporting common and user-supplied OpenSCAD
modules) to make a plate definition like:

```
plate(
    edge_cuts_data = edge_cuts_data,
    modules_data = modules_data,
    include_footprints = [
        "Keebio-Parts:TRRS-PJ-320A",
        "ProjectLocal:SW_MX_PG1350_reversible",
        "ProjectLocal:WeAct_MiniF4_ZigZag",
        "Rotary_Encoder:RotaryEncoder_Alps_EC11E-Switch_Vertical_H20mm",
        "ProjectLocal:H_M2_Spacer_Hole",
    ],
    force_include_references = [
        "J3"
    ]
);
```

The `include_footprints`, `force_include_references` are used by the
`plate` module to determine which Kicad modules to `difference()` away from
the board outline. The geometry of each Kicad module is determined by a
user-implemented `module_for_footprint` OpenSCAD module.

The OpenSCAD implementiation uses the idea that Kicad `line`, `arc` graphics
(used by the edge-cuts to define the PCB outline) can be used to construct an
OpenSCAD shape. The s-expressions in the `.kicad_pcb` can be transliterated to
arrays that OpenSCAD can make use of. An OpenSCAD structure of the Kicad modules
can then be interpreted as OpenSCAD geometry with an OpenSCAD module
`module_for_footprint`.

Thus, the important OpenSCAD files for a `plates.scad` are:

- `cad/kicad_pcb_geometry`: implements OpenSCAD modules for dealing
  with Kicad geometry, and other common modules.
- `<project dir>/generated/pcb_data.scad`: the OpenSCAD arrays
  generated from the board outline and Kicad modules in the `.kicad_pcb`.
- `<project dir>/footprint_modules.scad`: implements a `module_for_footprint`
  OpenSCAD module constructs the geometry for a given OpenSCAD representation of
  the Kicad module. This must be implemented by the user; but a substantial
  boilerplate implementation is generated by the program.
