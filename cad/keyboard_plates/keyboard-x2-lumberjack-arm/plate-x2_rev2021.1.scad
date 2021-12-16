include <generated/pcb_data.scad>;
include <footprint_modules.scad>;
include <../../kicad_pcb_geometry.scad>;

include <../../layered_case.scad>;

*edge_cuts_shape(edge_cuts_data);

*board_outline(edge_cuts_data);

// Use same properties as layered_case-gh60.scad in cad/
number_of_layers_above_pcb = 4;
number_of_layers_below_pcb = 4;
layer_thickness_mm = 3;
screw_diameter_mm = 2;
case_margin_mm = 2;
case_border_thickness_mm = 10;

gh60_pcb_dimensions = [285, 94.6];


// A plate compatible with the GH-60 layered acrylic case,
// with cutouts for each of the through-hole pads.
module gh60_underpcb_support_plate() {
    difference() {
        union() {
            scale([1, -1]) {
                difference() {
                    offset(r = case_margin_mm + case_border_thickness_mm) {
                        square(gh60_pcb_dimensions);
                    }

                    board_outline(edge_cuts_data = edge_cuts_data);
                }
            }

            plate(
                edge_cuts_data = edge_cuts_data,
                modules_data = modules_data,
                include_footprints = [
                    "Connector_USB:USB_C_Receptacle_XKB_U262-16XN-4BVC11",
                    "Package_DIP:DIP-40_W15.24mm_Socket",
                    "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual",
                    "ProjectLocal:Diode-dual",
                    "ProjectLocal:Resistor-Hybrid",
                    "ProjectLocal:SW_MX_PG1350_NoLed",
                    "lumberjack:MountingHole_M2",
                    "lumberjack:MountingSlot_M2",
                ]
            );
        }

        // Small Touch-ups
        scale([1, -1]) {
            // Case holes for the GH-60-ish plate
            case_screw_holes(
                case_border_thickness_mm = case_border_thickness_mm,
                pcb_dimensions = gh60_pcb_dimensions,
                num_screws_along_long_edge = 3,
                num_screws_along_short_edge = 1,
                screw_diameter_mm = screw_diameter_mm,
                use_3D = false
            );

            // GH-60 HOLES A, F
            // With wide enough diameter for M2 spacer.
            // (spacer D <= 3.3).
            translate([2, 56.5]) {
                offset(r = 1.7) {
                    square([1.1, 0.1], center = true);
                }
            }
            translate([285 - 2, 56.5]) {
                offset(r = 1.7) {
                    square([1.1, 0.1], center = true);
                }
            }

            // Cut out area for USB-C connector
            translate(J1_at) {
                extra = 20;
                translate([-5, -4.2 - extra]) {
                    square([10, 8 + extra]);
                }
            }

            // Tidy up various cutouts for adjacent components:
            translate(R1_at + [-0.8, -3.9 - 0.8]) {
                offset(r = 0.4){
                    square([3.9, 1.6]);
                }
            }
            translate(R1_at + [-0.8, 3.9 - 0.8]) {
                offset(r = 0.4){
                    square([3.9, 1.6]);
                }
            }
            translate(C2_at + [-0.8, -2.54 - 0.8]) {
                offset(r = 0.4){
                    square([3.75, 1.6 + 2.54 * 2 + 0.1]);
                }
            }
            translate(C4_at + [-0.8, -2.54 - 0.8]) {
                offset(r = 0.4){
                    square([3.75, 1.6 + 2.54 * 2 + 0.1]);
                }
            }
        }
    }
}

$fn = 60;
gh60_underpcb_support_plate();