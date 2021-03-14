#!/usr/bin/env python

import argparse
import os.path
import pathlib
import re
import sys
import textwrap
from collections import namedtuple

import jinja2
import sexpdata
from jinja2 import Template

# Transform the sexpdata.Symbols to their string values in
# a sexpdata structure.
def render_sexpdata_symbol_to_string(c):
    if type(c) == list:
      return [render_sexpdata_symbol_to_string(cc) for cc in c]
    elif type(c) == sexpdata.Symbol:
      return c.value()
    else:
      return c

# Returns the tail of the child whose first item
# is a symbol with the given string value.
#
# e.g.:
#   alist_lookup(["foo", ["x", 5], ["y", 9]], "x")
#   returns 5.
def alist_lookup(s, needle):
    for i in s:
        if type(i) == list and i[0] == needle:
            return i[1:]
    return None

# Returns string value of the layer.
#
# e.g. [gr_line [start 200 105] [end 200 145] [layer Edge.Cuts] [width 0.05]]
# returns "Edge.Cuts"
def layer_of(c):
    layer = alist_lookup(c, "layer")
    if layer is not None:
        return layer[0]

# Returns true for graphics on the Edge.Cuts layer.
#
# e.g. (gr_line (start 200 105) (end 200 145) (layer Edge.Cuts) (width 0.05))
def is_edge_cut_graphic(c):
    if type(c) == list and c[0].startswith("gr_"):
        layer = alist_lookup(c, "layer")
        if layer_of(c) == "Edge.Cuts":
            return True
        else:
            return False
    else:
        return False

# Returns a copy of the geometry.
# Removes the "gr_" prefix from "gr_line", "gr_arc", etc. geometry.
def simplify_geometry(c):
    if type(c) == list:
        return [
            simplify_geometry(cc)
            for cc
            in c
            if (
                (not type(cc) == list) or
                (cc[0] in ["start", "end", "width", "angle"])
            )
        ]
    if type(c) == str and c[:3] == 'gr_':
        return c[3:]
    else:
        return c

def is_module(c):
    return type(c) == list and c[0] == "module"

def is_reference(c):
    return (
        type(c) == list and
        c[0] == "fp_text" and
        c[1] == "reference"
    )




SimplifiedModuleCoordinates = namedtuple("SimplifiedModuleCoordinates", [
    "at_x",
    "at_y"
])


# Simplified (module...) data
#
# Useful to also put reference, footprint here;
# as well as ... fp_ geometry, grouped by layer?
SimplifiedModule = namedtuple("SimplifiedModule", [
    "reference",
    "footprint",
    "module_data",
    "coordinates",
    "fp_geometry_by_layer"
])

def find_reference(c):
    [ref] = [cc for cc in c if is_reference(cc)]
    return ref[2]

# Return a point which has an x as small as the smallest x
# in the given geometry, and a y as small as the smallest y in the geometry.
def geometry_min_coords(c):
    # assumes "line", not "arc"
    start_point = alist_lookup(c, "start")
    end_point = alist_lookup(c, "end")
    return [
        min(start_point[0], end_point[0]),
        min(start_point[1], end_point[1])
    ]

def geometry_max_coords(c):
    # assumes "line", not "arc"
    start_point = alist_lookup(c, "start")
    end_point = alist_lookup(c, "end")
    return [
        max(start_point[0], end_point[0]),
        max(start_point[1], end_point[1])
    ]

def translation_coords_from_edge_cuts(edge_cuts):
    edge_min_coords = [geometry_min_coords(c) for c in edge_cuts]
    min_coords = [
        min([pt[0] for pt in edge_min_coords]),
        min([pt[1] for pt in edge_min_coords]),
    ]
    return [-min_coords[0], -min_coords[1]]

def module_coordinate_translate_by(c, dp):
    if type(c) == list and c[0] in ["at"]:
        if len(c) == 4:
            return [c[0], c[1] - dp[0], c[2] - dp[1], c[3]]
        else:
            return [c[0], c[1] - dp[0], c[2] - dp[1]]
    else:
        return c

def geometry_coordinate_translate_by(c, dp):
    if type(c) == list and c[0] in ["start", "end"]:
        return [c[0], c[1] + dp[0], c[2] + dp[1]]
    else:
        return c

def geometry_translate_by(c, dp):
    return [geometry_coordinate_translate_by(cc, dp) for cc in c]

# e.g. want:
#   [
#     "ProjectLocal:SW_MX_PG1350_reversible",
#     ["at", 30, 30],
#     ["reference", "SW_11"]
#   ],
def simplify_module(c, translate_geometry_by = [0, 0]):
    if not is_module(c):
        return None

    footprint = c[1]
    reference = find_reference(c)
    module_at = alist_lookup(c, "at") # [x, y] or [x, y, rot]
    layer = (alist_lookup(c, "layer") or ["F.Cu"])[0] # "F.Cu" or "B.Cu"
    coordinates = SimplifiedModuleCoordinates(
        at_x = module_at[0] + translate_geometry_by[0],
        at_y = module_at[1] + translate_geometry_by[1]
    )

    # empty list if no rotation; otherwise,
    # singleton of the angle
    rotation = [module_at[2]] if len(module_at) == 3 else []

    return SimplifiedModule(
        reference = reference,
        footprint = footprint,
        coordinates = coordinates,
        module_data = [
            footprint,
            ["at", coordinates.at_x, coordinates.at_y] + rotation,
            ["reference", reference],
            ["side", "front" if layer == "F.Cu" else "back"],
        ],
        fp_geometry_by_layer = {}
    )

def render_edge_cuts_data(edge_cuts):
    template = Template(textwrap.dedent('''\
      edge_cuts_data = [
        {% for item in edge_cuts_data %}
        {{ item }},
        {% endfor %}
      ];
    '''), trim_blocks = True, lstrip_blocks = True)
    return template.render(edge_cuts_data = edge_cuts).replace("'", "\"")

def render_modules_data(simplified_modules):
    # Awkward, but enough for the unit tests
    simplified_module_coordinates = [
        (m.reference, [m.coordinates.at_x, m.coordinates.at_y])
        for m
        in simplified_modules
    ]
    simplified_module_data = [
        m.module_data
        for m
        in sorted(simplified_modules, key = lambda m: m.reference)
    ]
    template = Template(textwrap.dedent('''\
      {% for reference, position in simplified_module_coordinates %}
      {{ reference }}_at = {{ position }};
      {% endfor %}

      modules_data = [
        {% for item in simplified_module_data %}
        [
          "{{ item[0] }}",
          {{ item[1] }},
          {{ item[2] }},
          {{ item[3] }}
        ],
        {% endfor %}
      ];
    '''), trim_blocks = True, lstrip_blocks = True)
    return template.render(
        simplified_module_data = simplified_module_data,
        simplified_module_coordinates = sorted(simplified_module_coordinates)
    ).replace("'", "\"")

def render_pcb_data_scad(edge_cuts, simplified_modules):
    rendered_edge_cuts = render_edge_cuts_data(edge_cuts)
    rendered_module_data = render_modules_data(simplified_modules)
    return rendered_edge_cuts + "\n\n" + rendered_module_data

def module_name_from_footprint_name(footprint_name):
    return 'Footprint_' + re.sub('[^A-Za-z0-9_]', '_', footprint_name)

def references_used_per_footprint(simplified_modules):
    usages = {}
    for m in sorted(simplified_modules, key = lambda m: m.reference):
        if m.footprint not in usages:
            usages[m.footprint] = []
        usages[m.footprint].append(m.reference)
    return usages

def footprint_module_comment(refs):
    return '\n'.join(textwrap.wrap(
        ', '.join(refs),
        initial_indent = "// Footprint used by: ",
        subsequent_indent = "//  ",
    ))

def render_footprint_modules_scad(simplified_modules):
    usages = references_used_per_footprint(simplified_modules)
    footprint_names = sorted(list(set([m.footprint for m in simplified_modules])))
    footprint_modules = [
        (n, module_name_from_footprint_name(n), footprint_module_comment(usages[n]))
        for n
        in footprint_names
    ]
    template = Template(textwrap.dedent('''\
        {% for _, module_name, cmt in footprint_modules %}
        {{ cmt }}
        module {{module_name}}() {
            square(1, center = true);
        }

        {% endfor %}
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

        #%   for footprint_name, module_name, _ in footprint_modules
        #%     if loop.first
            if (module_footprint == "{{footprint_name}}") {
                {{module_name}}();
        #%     else
            } else if (module_footprint == "{{footprint_name}}") {
                {{module_name}}();
        #%     endif
        #%   endfor
            } else {
                assert(allow_unhandled_footprints, "fall-through; unhandled footprint: '" + module_footprint + "'");
            }
        }'''), trim_blocks = True, lstrip_blocks = True, line_statement_prefix = '#%')
    return template.render(footprint_modules = footprint_modules)

ScadOutput = namedtuple("ScadOutput", [
    "pcb_data_scad",
    "footprint_modules_scad"
])

def scad_of_kicad_pcb(kicad_pcb):
    kicad_pcb_data_sexpr = sexpdata.loads(kicad_pcb)
    kicad_pcb_data = render_sexpdata_symbol_to_string(kicad_pcb_data_sexpr)

    edge_cuts = [
        simplify_geometry(c)
        for c
        in kicad_pcb_data
        if is_edge_cut_graphic(c)
    ]

    translate_geometry_by = translation_coords_from_edge_cuts(edge_cuts)

    edge_cuts = [geometry_translate_by(c, translate_geometry_by) for c in edge_cuts]

    simplified_modules = [
        simplify_module(c, translate_geometry_by = translate_geometry_by)
        for c
        in kicad_pcb_data
        if is_module(c)
    ]

    pcb_data_scad = render_pcb_data_scad(edge_cuts, simplified_modules)
    footprint_modules_scad = render_footprint_modules_scad(simplified_modules)
    return ScadOutput(
        pcb_data_scad = pcb_data_scad,
        footprint_modules_scad = footprint_modules_scad
    )

script_path = os.path.realpath(__file__)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description = 'Outputs a SCAD file with KicadPCB geometry.')
    parser.add_argument('--kicad_pcb_path', metavar='PATH_TO_KICAD_PCB', type=str,
                         help='path to a .kicad_pcb file to transform')
    parser.add_argument('--output_dir', metavar='PATH_TO_OUTPUT_DIR', type=str,
                         help='path to a .kicad_pcb file to transform')
    parser.add_argument('--project_name', metavar='SCAD_PROJECT_NAME', type=str,
                         help='path to a .kicad_pcb file to transform')

    args = parser.parse_args()

    kicad_pcb_path = args.kicad_pcb_path

    if kicad_pcb_path is None:
        print("kicad_pcb_path not given", file = sys.stderr)
        exit(1)

    output_dir = args.output_dir or os.path.join(os.path.dirname(script_path), '..', 'cad', 'keyboard_plates')

    project_name = args.project_name
    if project_name is None:
        project_name, _ = os.path.splitext(os.path.basename(kicad_pcb_path))

    print("project name is '%s'" % project_name)

    with open(kicad_pcb_path) as f:
        kicad_pcb_contents = f.read()

    scad = scad_of_kicad_pcb(kicad_pcb_contents)
    pcb_data_scad = scad.pcb_data_scad
    footprint_modules_scad = scad.footprint_modules_scad

    project_dir = os.path.join(output_dir, project_name)
    generated_dir = os.path.join(project_dir, 'generated')
    pathlib.Path(generated_dir).mkdir(parents = True, exist_ok = True)

    pcb_data_scad_path = os.path.join(generated_dir, 'pcb_data.scad')
    with open(os.path.join(pcb_data_scad_path), 'w') as f:
        f.write(pcb_data_scad)

    footprint_modules_scad_path = os.path.join(project_dir, 'footprint_modules.scad')
    if not os.path.exists(footprint_modules_scad_path):
        with open(os.path.join(footprint_modules_scad_path), 'w') as f:
            f.write(footprint_modules_scad)
