import unittest

import textwrap

import sexpdata

from transform_kicadpcb_to_scad import (
    SimplifiedModule,
    SimplifiedModuleCoordinates,
    alist_lookup,
    find_reference,
    geometry_min_coords,
    is_edge_cut_graphic,
    is_module,
    is_reference,
    layer_of,
    render_edge_cuts_data,
    render_modules_data,
    render_sexpdata_symbol_to_string,
    render_pcb_data_scad,
    render_footprint_modules_scad,
    simplify_geometry,
    simplify_module,
    scad_of_kicad_pcb
)

class TestRenderSexpdataSymbolToString(unittest.TestCase):
    def test_trivial(self):
        c = 5
        expected = 5
        actual = render_sexpdata_symbol_to_string(c)
        self.assertEqual(expected, actual)

    def test_symbol(self):
        c = sexpdata.Symbol('a')
        expected = 'a'
        actual = render_sexpdata_symbol_to_string(c)
        self.assertEqual(expected, actual)

    def test_list(self):
        c = [1, 2, 3]
        expected = [1, 2, 3]
        actual = render_sexpdata_symbol_to_string(c)
        self.assertEqual(expected, actual)

    def test_nested_list_with_symbol(self):
        c = [sexpdata.Symbol('a'), 2, [sexpdata.Symbol('b')]]
        expected = ['a', 2, ['b']]
        actual = render_sexpdata_symbol_to_string(c)
        self.assertEqual(expected, actual)

class TestAlistLookup(unittest.TestCase):
    def test_happy(self):
        xs = ["foo", ["x", 5], ["y", 9]]
        k = "x"
        expected = [5]
        actual = alist_lookup(xs, k)
        self.assertEqual(expected, actual)

class TestLayerOf(unittest.TestCase):
    def test_happy(self):
        geometry = ["line", ["start", 200, 105], ["end", 200, 145], ["layer", "Edge.Cuts"], ["width", 0.05]]
        expected = "Edge.Cuts"
        actual = layer_of(geometry)
        self.assertEqual(expected, actual)

class TestIsEdgeCutGraphic(unittest.TestCase):
    def test_happy_true_positive(self):
        geometry = ["gr_line", ["start", 200, 105], ["end", 200, 145], ["layer", "Edge.Cuts"], ["width", 0.05]]
        expected = True
        actual = is_edge_cut_graphic(geometry)
        self.assertEqual(expected, actual)

    def test_arc_true_positive(self):
        geometry = ["gr_arc", ["start", 200, 105], ["end", 200, 145], ["layer", "Edge.Cuts"], ["angle", 90], ["width", 0.05]]
        expected = True
        actual = is_edge_cut_graphic(geometry)
        self.assertEqual(expected, actual)

    def test_happy_true_negative_fp(self):
        geometry = ["fp_line", ["start", 200, 105], ["end", 200, 145], ["layer", "Edge.Cuts"], ["width", 0.05]]
        expected = False
        actual = is_edge_cut_graphic(geometry)
        self.assertEqual(expected, actual)

    def test_happy_true_negative_wrong_layer(self):
        geometry = ["gr_line", ["start", 200, 105], ["end", 200, 145], ["layer", "SilkScreen"], ["width", 0.05]]
        expected = False
        actual = is_edge_cut_graphic(geometry)
        self.assertEqual(expected, actual)

class TestIsReference(unittest.TestCase):
    def test_happy(self):
        module = ["fp_text", "reference", "A1"]
        expected = True
        actual = is_reference(module)
        self.assertEqual(expected, actual)

class TestFindReference(unittest.TestCase):
    def test_happy(self):
        module = ["module", ["fp_text", "reference", "A1"]]
        expected = "A1"
        actual = find_reference(module)
        self.assertEqual(expected, actual)

class TestGeometryMinCoords(unittest.TestCase):
    def test_simple(self):
        geometry = ["gr_line", ["start", 200, 105], ["end", 200, 145], ["layer", "Edge.Cuts"], ["width", 0.05]]
        expected = [200, 105]
        actual = geometry_min_coords(geometry)
        self.assertEqual(expected, actual)

    def test_sloped_line(self):
        geometry = ["gr_line", ["start", 100, 105], ["end", 200, 145], ["layer", "Edge.Cuts"], ["width", 0.05]]
        expected = [100, 105]
        actual = geometry_min_coords(geometry)
        self.assertEqual(expected, actual)

class TestSimplifyGeometry(unittest.TestCase):
    def test_simple(self):
        geometry = ["gr_line", ["start", 200, 105], ["end", 200, 145], ["layer", "Edge.Cuts"], ["width", 0.05]]
        expected = ["line", ["start", 200, 105], ["end", 200, 145], ["width", 0.05]]
        actual = simplify_geometry(geometry)
        self.assertEqual(expected, actual)

    def test_arc(self):
        geometry = ["gr_arc", ["start", 200, 105], ["end", 200, 145], ["layer", "Edge.Cuts"], ["angle", 90], ["width", 0.05]]
        expected = ["arc", ["start", 200, 105], ["end", 200, 145], ["angle", 90], ["width", 0.05]]
        actual = simplify_geometry(geometry)
        self.assertEqual(expected, actual)

sample_module = [
    "module",
    "ProjectLocal:SW_MX_PG1350_reversible",
    ["layer", "F.Cu"],
    ["at", 110, 70],
    ["descr" "Kailh \"Choc\" PG1350 keyswitch, able to be mounted on front or back of PCB"],
    ["tags" "kailh,choc"],
    ["fp_text", "reference", "SW_11"],
]

sample_module_rotated = [
    "module",
    "ProjectLocal:SW_MX_PG1350_reversible",
    ["layer", "F.Cu"],
    ["at", 110, 70, 90],
    ["descr" "Kailh \"Choc\" PG1350 keyswitch, able to be mounted on front or back of PCB"],
    ["tags" "kailh,choc"],
    ["fp_text", "reference", "SW_11"],
]

sample_module_flipped = [
    "module",
    "ProjectLocal:SW_MX_PG1350_reversible",
    ["layer", "B.Cu"],
    ["at", 110, 70, 90],
    ["descr" "Kailh \"Choc\" PG1350 keyswitch, able to be mounted on front or back of PCB"],
    ["tags" "kailh,choc"],
    ["fp_text", "reference", "SW_11"],
]

class TestSimplifyModule(unittest.TestCase):
    def test_happy_reference(self):
        expected = "SW_11"
        actual = simplify_module(sample_module).reference
        self.assertEqual(expected, actual)

    def test_happy_footprint(self):
        expected = "ProjectLocal:SW_MX_PG1350_reversible"
        actual = simplify_module(sample_module).footprint
        self.assertEqual(expected, actual)

    def test_happy_module_data(self):
        expected = [
            "ProjectLocal:SW_MX_PG1350_reversible",
            ["at", 110, 70],
            ["reference", "SW_11"],
            ["side", "front"],
        ]
        actual = simplify_module(sample_module).module_data
        self.assertEqual(expected, actual)

    def test_happy_coordinates(self):
        expected = SimplifiedModuleCoordinates(at_x = 110, at_y = 70)
        actual = simplify_module(sample_module).coordinates
        self.assertEqual(expected, actual)

    def test_happy_module_data_translated(self):
        expected = [
            "ProjectLocal:SW_MX_PG1350_reversible",
            ["at", 60, 40],
            ["reference", "SW_11"],
            ["side", "front"],
        ]
        actual = simplify_module(sample_module, translate_geometry_by = [-50, -30]).module_data
        self.assertEqual(expected, actual)

    def test_rotated_module_data(self):
        expected = [
            "ProjectLocal:SW_MX_PG1350_reversible",
            ["at", 110, 70, 90],
            ["reference", "SW_11"],
            ["side", "front"],
        ]
        actual = simplify_module(sample_module_rotated).module_data
        self.assertEqual(expected, actual)

    def test_flipped_module_data(self):
        expected = [
            "ProjectLocal:SW_MX_PG1350_reversible",
            ["at", 110, 70, 90],
            ["reference", "SW_11"],
            ["side", "back"],
        ]
        actual = simplify_module(sample_module_flipped).module_data
        self.assertEqual(expected, actual)

class TestRenderEdgeCutsData(unittest.TestCase):
    def test_happy(self):
        edge_cuts = [
            ["line", ["start", 0, 0], ["end", 100, 0], ["width", 0.05]],
            ["line", ["start", 0, 0], ["end", 0, 100],  ["width", 0.05]],
            ["line", ["start", 100, 0], ["end", 100, 100], ["width", 0.05]],
            ["line", ["start", 0, 100], ["end", 100, 100], ["width", 0.05]],
        ]
        expected = textwrap.dedent("""\
          edge_cuts_data = [
            ["line", ["start", 0, 0], ["end", 100, 0], ["width", 0.05]],
            ["line", ["start", 0, 0], ["end", 0, 100], ["width", 0.05]],
            ["line", ["start", 100, 0], ["end", 100, 100], ["width", 0.05]],
            ["line", ["start", 0, 100], ["end", 100, 100], ["width", 0.05]],
          ];""")
        actual = render_edge_cuts_data(edge_cuts)
        self.assertEqual(expected, actual)

    def test_arc(self):
        edge_cuts = [
            ["line", ["start", 0, 0], ["end", 100, 0], ["width", 0.05]],
            ["line", ["start", 0, 0], ["end", 0, 100],  ["width", 0.05]],
            ["line", ["start", 0, 0], ["end", 100, 0],  ["angle", 90], ["width", 0.05]],
        ]
        expected = textwrap.dedent("""\
          edge_cuts_data = [
            ["line", ["start", 0, 0], ["end", 100, 0], ["width", 0.05]],
            ["line", ["start", 0, 0], ["end", 0, 100], ["width", 0.05]],
            ["line", ["start", 0, 0], ["end", 100, 0], ["angle", 90], ["width", 0.05]],
          ];""")
        actual = render_edge_cuts_data(edge_cuts)
        self.assertEqual(expected, actual)

class TestRenderModulesData(unittest.TestCase):
    def test_happy(self):
        simplified_modules = [
            SimplifiedModule(
                reference = "SW_11",
                footprint = "ProjectLocal:SW_MX_PG1350_reversible",
                module_data = [
                    "ProjectLocal:SW_MX_PG1350_reversible",
                    ["at", 30, 70],
                    ["reference", "SW_11"],
                    ["side", "front"],
                ],
                coordinates = SimplifiedModuleCoordinates(at_x = 30, at_y = 70),
                fp_geometry_by_layer = {}
            ),
            SimplifiedModule(
                reference = "SW_12",
                footprint = "ProjectLocal:SW_MX_PG1350_reversible",
                module_data = [
                    "ProjectLocal:SW_MX_PG1350_reversible",
                    ["at", 49, 70],
                    ["reference", "SW_12"],
                    ["side", "front"],
                ],
                coordinates = SimplifiedModuleCoordinates(at_x = 49, at_y = 70),
                fp_geometry_by_layer = {}
            )
        ]
        expected = textwrap.dedent("""\
          SW_11_at = [30, 70];
          SW_12_at = [49, 70];

          modules_data = [
            [
              "ProjectLocal:SW_MX_PG1350_reversible",
              ["at", 30, 70],
              ["reference", "SW_11"],
              ["side", "front"]
            ],
            [
              "ProjectLocal:SW_MX_PG1350_reversible",
              ["at", 49, 70],
              ["reference", "SW_12"],
              ["side", "front"]
            ],
          ];""")
        actual = render_modules_data(simplified_modules)
        self.assertEqual(expected, actual)

    def test_happy_rotated(self):
        simplified_modules = [
            SimplifiedModule(
                reference = "SW_11",
                footprint = "ProjectLocal:SW_MX_PG1350_reversible",
                module_data = [
                    "ProjectLocal:SW_MX_PG1350_reversible",
                    ["at", 30, 70, 45],
                    ["reference", "SW_11"],
                    ["side", "front"],
                ],
                coordinates = SimplifiedModuleCoordinates(at_x = 30, at_y = 70),
                fp_geometry_by_layer = {}
            ),
            SimplifiedModule(
                reference = "SW_12",
                footprint = "ProjectLocal:SW_MX_PG1350_reversible",
                module_data = [
                    "ProjectLocal:SW_MX_PG1350_reversible",
                    ["at", 49, 70],
                    ["reference", "SW_12"],
                    ["side", "front"],
                ],
                coordinates = SimplifiedModuleCoordinates(at_x = 49, at_y = 70),
                fp_geometry_by_layer = {}
            )
        ]
        expected = textwrap.dedent("""\
          SW_11_at = [30, 70];
          SW_12_at = [49, 70];

          modules_data = [
            [
              "ProjectLocal:SW_MX_PG1350_reversible",
              ["at", 30, 70, 45],
              ["reference", "SW_11"],
              ["side", "front"]
            ],
            [
              "ProjectLocal:SW_MX_PG1350_reversible",
              ["at", 49, 70],
              ["reference", "SW_12"],
              ["side", "front"]
            ],
          ];""")
        actual = render_modules_data(simplified_modules)
        self.assertEqual(expected, actual)

# want e.g. U1_at_x = ..., U1_left = ..., U1_top = ..., U1_width = ...; etc.
class TestRenderModulesCoordinates(unittest.TestCase):
    pass


# concat of edge_cuts_data and modules_data from the kicad_pcb sexpr
class TestRenderPcbDataScad(unittest.TestCase):
    def test_happy(self):
        edge_cuts = [
            ["line", ["start", 0, 0], ["end", 100, 0], ["width", 0.05]],
            ["line", ["start", 0, 0], ["end", 0, 100],  ["width", 0.05]],
            ["line", ["start", 100, 0], ["end", 100, 100], ["width", 0.05]],
            ["line", ["start", 0, 100], ["end", 100, 100], ["width", 0.05]],
        ]
        simplified_modules = [
            SimplifiedModule(
                reference = "SW_11",
                footprint = "ProjectLocal:SW_MX_PG1350_reversible",
                module_data = [
                    "ProjectLocal:SW_MX_PG1350_reversible",
                    ["at", 30, 70, 45],
                    ["reference", "SW_11"],
                    ["side", "front"],
                ],
                coordinates = SimplifiedModuleCoordinates(at_x = 30, at_y = 70),
                fp_geometry_by_layer = {}
            ),
            SimplifiedModule(
                reference = "SW_12",
                footprint = "ProjectLocal:SW_MX_PG1350_reversible",
                module_data = [
                    "ProjectLocal:SW_MX_PG1350_reversible",
                    ["at", 49, 70],
                    ["reference", "SW_12"],
                    ["side", "front"],
                ],
                coordinates = SimplifiedModuleCoordinates(at_x = 49, at_y = 70),
                fp_geometry_by_layer = {}
            )
        ]
        expected = textwrap.dedent("""\
          edge_cuts_data = [
            ["line", ["start", 0, 0], ["end", 100, 0], ["width", 0.05]],
            ["line", ["start", 0, 0], ["end", 0, 100], ["width", 0.05]],
            ["line", ["start", 100, 0], ["end", 100, 100], ["width", 0.05]],
            ["line", ["start", 0, 100], ["end", 100, 100], ["width", 0.05]],
          ];

          SW_11_at = [30, 70];
          SW_12_at = [49, 70];

          modules_data = [
            [
              "ProjectLocal:SW_MX_PG1350_reversible",
              ["at", 30, 70, 45],
              ["reference", "SW_11"],
              ["side", "front"]
            ],
            [
              "ProjectLocal:SW_MX_PG1350_reversible",
              ["at", 49, 70],
              ["reference", "SW_12"],
              ["side", "front"]
            ],
          ];""")
        actual = render_pcb_data_scad(edge_cuts, simplified_modules)
        self.assertEqual(expected, actual)

# generated template with module_for_footprint, and other supporting code
class TestRenderFootprintModulesScad(unittest.TestCase):
    def test_happy(self):
        simplified_modules = [
            SimplifiedModule(
                reference = "U1",
                footprint = "ProjectLocal:WeAct_MiniF4",
                module_data = [
                    "ProjectLocal:SW_MX_PG1350_reversible",
                    ["at", 30, 70, 45],
                    ["reference", "SW_11"],
                    ["side", "front"],
                ],
                coordinates = SimplifiedModuleCoordinates(at_x = 30, at_y = 70),
                fp_geometry_by_layer = {}
            ),
            SimplifiedModule(
                reference = "SW_11",
                footprint = "ProjectLocal:SW_MX_PG1350_reversible",
                module_data = [
                    "ProjectLocal:SW_MX_PG1350_reversible",
                    ["at", 49, 70],
                    ["reference", "SW_11"],
                    ["side", "front"],
                ],
                coordinates = SimplifiedModuleCoordinates(at_x = 49, at_y = 70),
                fp_geometry_by_layer = {}
            )
        ]
        expected = textwrap.dedent("""\
            // Footprint used by: SW_11
            module Footprint_ProjectLocal_SW_MX_PG1350_reversible() {
                square(1, center = true);
            }

            // Footprint used by: U1
            module Footprint_ProjectLocal_WeAct_MiniF4() {
                square(1, center = true);
            }

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

                if (module_footprint == "ProjectLocal:SW_MX_PG1350_reversible") {
                    Footprint_ProjectLocal_SW_MX_PG1350_reversible();
                } else if (module_footprint == "ProjectLocal:WeAct_MiniF4") {
                    Footprint_ProjectLocal_WeAct_MiniF4();
                } else {
                    assert(allow_unhandled_footprints, "fall-through; unhandled footprint: '" + module_footprint + "'");
                }
            }""")
        actual = render_footprint_modules_scad(simplified_modules)
        self.maxDiff = None
        self.assertEqual(expected, actual)

sample_pcb = textwrap.dedent("""\
(
    kicad_pcb

    (gr_line (start   0   0) (end 100   0) (layer Edge.Cuts) (width 0.05))
    (gr_line (start   0   0) (end   0 100) (layer Edge.Cuts) (width 0.05))
    (gr_line (start 100   0) (end 100 100) (layer Edge.Cuts) (width 0.05))
    (gr_line (start   0 100) (end 100 100) (layer Edge.Cuts) (width 0.05))

    (
        module
        ProjectLocal:WeAct_MiniF4
        (at 2.5 45 90)
        (fp_text reference U1)
    )
    (
        module
        ProjectLocal:SW_MX_PG1350_reversible
        (at 10 70)
        (fp_text reference SW_11)
    )
    (
        module
        ProjectLocal:SW_MX_PG1350_reversible
        (at 29 81)
        (fp_text reference SW_12)
    )
)""")

class TestRenderScadFromPcb(unittest.TestCase):
    def test_pcb_data_happy(self):
        expected = textwrap.dedent("""\
          edge_cuts_data = [
            ["line", ["start", 0, 0], ["end", 100, 0], ["width", 0.05]],
            ["line", ["start", 0, 0], ["end", 0, 100], ["width", 0.05]],
            ["line", ["start", 100, 0], ["end", 100, 100], ["width", 0.05]],
            ["line", ["start", 0, 100], ["end", 100, 100], ["width", 0.05]],
          ];

          SW_11_at = [10, 70];
          SW_12_at = [29, 81];
          U1_at = [2.5, 45];

          modules_data = [
            [
              "ProjectLocal:SW_MX_PG1350_reversible",
              ["at", 10, 70],
              ["reference", "SW_11"],
              ["side", "front"]
            ],
            [
              "ProjectLocal:SW_MX_PG1350_reversible",
              ["at", 29, 81],
              ["reference", "SW_12"],
              ["side", "front"]
            ],
            [
              "ProjectLocal:WeAct_MiniF4",
              ["at", 2.5, 45, 90],
              ["reference", "U1"],
              ["side", "front"]
            ],
          ];""")
        actual = scad_of_kicad_pcb(sample_pcb).pcb_data_scad
        self.maxDiff = None
        self.assertEqual(expected, actual)

    def test_footprint_modules_happy(self):
        expected = textwrap.dedent("""\
            // Footprint used by: SW_11, SW_12
            module Footprint_ProjectLocal_SW_MX_PG1350_reversible() {
                square(1, center = true);
            }

            // Footprint used by: U1
            module Footprint_ProjectLocal_WeAct_MiniF4() {
                square(1, center = true);
            }

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

                if (module_footprint == "ProjectLocal:SW_MX_PG1350_reversible") {
                    Footprint_ProjectLocal_SW_MX_PG1350_reversible();
                } else if (module_footprint == "ProjectLocal:WeAct_MiniF4") {
                    Footprint_ProjectLocal_WeAct_MiniF4();
                } else {
                    assert(allow_unhandled_footprints, "fall-through; unhandled footprint: '" + module_footprint + "'");
                }
            }""")
        actual = scad_of_kicad_pcb(sample_pcb).footprint_modules_scad
        self.maxDiff = None
        self.assertEqual(expected, actual)


if __name__ == '__main__':
    unittest.main()
