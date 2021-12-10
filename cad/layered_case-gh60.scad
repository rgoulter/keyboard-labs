// Layered Acrylic Case for GH60-compatible PCB.
//
// The OpenSCAD Preview additionally shows the assembled case,
//  as well as slices of the case to assist in debugging.

include <layered_case.scad>;

number_of_layers_above_pcb = 4;
number_of_layers_below_pcb = 4;
layer_thickness_mm = 3;
screw_diameter_mm = 2;
case_margin_mm = 2;
case_border_thickness_mm = 10;

pcb_dimension = [285, 94.6];
module gh60_pcb_approx() {
    square(pcb_dimension);
}

if ($preview) {
    $fn = 16;
} else {
    $fn = 60;
}

mirror([0, 1, 0]) {
    layered_projections(
        layers_above_origin = number_of_layers_above_pcb,
        layers_below_origin = number_of_layers_below_pcb
    ) {
        layered_pseudo_tray_mount_case(
            margin = case_margin_mm,
            case_border_thickness = case_border_thickness_mm,
            layer_thickness = layer_thickness_mm,
            layers_above_origin = number_of_layers_above_pcb,
            layers_below_origin = number_of_layers_below_pcb,
            case_margin = case_margin_mm,
            case_border_thickness = case_border_thickness_mm
        ) {
            gh60_pcb_approx();
            
            // Difference (volume removed from case) for: 

            // Window for USB connector
            translate([18, -5, -3]) {
                cube([12, 20, 6], center = true);
            }

            // Case Screw Holes
            screwsLeft = -1 - (case_border_thickness_mm / 2);
            screwsTop = -1 - (case_border_thickness_mm / 2);
            screwsRight = gh60_pcb_dimension[0] + 1 + (case_border_thickness_mm / 2);
            screwsBottom = gh60_pcb_dimension[1] + 1 + (case_border_thickness_mm / 2);
            screw_holes_along_segment(
                start_point = [screwsLeft,  screwsTop],
                end_point   = [screwsRight, screwsTop],
                num_screws_between = 3,
                screw_diameter = screw_diameter_mm
            );
            screw_holes_along_segment(
                start_point = [screwsRight,  screwsBottom],
                end_point   = [screwsLeft, screwsBottom],
                num_screws_between = 3,
                screw_diameter = screw_diameter_mm
            );
            screw_holes_along_segment(
                start_point = [screwsRight, screwsTop],
                end_point   = [screwsRight, screwsBottom],
                num_screws_between = 1,
                screw_diameter = screw_diameter_mm
            );
            screw_holes_along_segment(
                start_point = [screwsLeft, screwsBottom],
                end_point   = [screwsLeft, screwsTop],
                num_screws_between = 1,
                screw_diameter = screw_diameter_mm
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