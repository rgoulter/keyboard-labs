// Layered Acrylic Case for GH60-compatible PCB.
//
// The OpenSCAD Preview additionally shows the assembled case,
//  as well as slices of the case to assist in debugging.

// BUG: 2021-12-20: The HOLES A, F don't align with the X-2 PCB(!!),
//                   which uses the same position as GH-60.
//                  - (And other notes as listed in plate-x2_rev2021.1.scad apply here)

include <layered_case.scad>;

number_of_layers_above_pcb = 4;
number_of_layers_below_pcb = 4;
layer_thickness_mm = 3;
screw_diameter_mm = 2;
case_margin_mm = 2;
case_border_thickness_mm = 10;

gh60_pcb_dimensions = [285, 94.6];
module gh60_pcb_approx() {
    square(gh60_pcb_dimensions);
}

$fn = 16;

module gh60_layered_case(
    show_3D = false
){
    mirror([0, 1, 0]) {
        layered_projections(
            layers_above_origin = number_of_layers_above_pcb,
            layers_below_origin = number_of_layers_below_pcb,
            show_3D = show_3D,
            projection_dy = gh60_pcb_dimensions[1] + 2 * case_border_thickness_mm + 2 * case_margin_mm + 2
        ) {
            layered_pseudo_tray_mount_case(
                margin = case_margin_mm,
                case_border_thickness = case_border_thickness_mm,
                layer_thickness = layer_thickness_mm,
                layers_above_origin = number_of_layers_above_pcb,
                layers_below_origin = number_of_layers_below_pcb
            ) {
                gh60_pcb_approx();

                // Difference (volume removed from case) for:

                // Window for USB connector
                translate([18, -5, -3]) {
                    cube([12, 20, 6], center = true);
                }

                // Case Screw Holes
                case_screw_holes(
                    case_border_thickness_mm = case_border_thickness_mm,
                    pcb_dimensions = gh60_pcb_dimensions,
                    num_screws_along_long_edge = 3,
                    num_screws_along_short_edge = 1,
                    screw_diameter_mm = screw_diameter_mm
                );

                // GH60 PCB M2 mounting holes
                screws_at(
                    points = [
                        [5, 56.5],      // Hole A
                        [25.2, 27.9],   // Hole B
                        [128.2, 47],    // Hole C
                        [190.5, 85.2],  // Hole D
                        [260.05, 27.9], // Hole E
                        [279, 56.5],    // Hole F
                    ],
                    screw_diameter = 2
                );
            }
        }
    }
}
