include <layered_case.scad>;

gh60_pcb_dimension = [285, 94.6];
module gh60_pcb_approx() {
    square(gh60_pcb_dimension);
}

module gh60_layered_case(
    layers_above_origin = 4,
    layers_below_origin = 4,
) {
    margin = 2;
    case_border_thickness = 10;
    layer_thickness = 3;

    layered_pseudo_tray_mount_case(
        margin = margin,
        case_border_thickness = case_border_thickness,
        layer_thickness = layer_thickness,
        layers_above_origin = layers_above_origin,
        layers_below_origin = layers_below_origin
    ) {
        gh60_pcb_approx();

        // e.g. usb connector
        translate([18, -5, -3]) {
            cube([12, 20, 6], center = true);
        }

        // screw holes along top
        screwsLeft = -1 - (case_border_thickness / 2);
        screwsTop = -1 - (case_border_thickness / 2);
        screwsRight = gh60_pcb_dimension[0] + 1 + (case_border_thickness / 2);
        screwsBottom = gh60_pcb_dimension[1] + 1 + (case_border_thickness / 2);
        screw_holes_along_segment(
            start_point = [screwsLeft,  screwsTop],
            end_point   = [screwsRight, screwsTop],
            num_screws_between = 3
        );
        screw_holes_along_segment(
            start_point = [screwsRight,  screwsBottom],
            end_point   = [screwsLeft, screwsBottom],
            num_screws_between = 3
        );
        screw_holes_along_segment(
            start_point = [screwsRight, screwsTop],
            end_point   = [screwsRight, screwsBottom],
            num_screws_between = 1
        );
        screw_holes_along_segment(
            start_point = [screwsLeft, screwsBottom],
            end_point   = [screwsLeft, screwsTop],
            num_screws_between = 1
        );

        screws_at(
            points = [
                [5, 56.5],      // Hole A
                [25.2, 27.9],   // Hole B
                [128.2, 47],    // Hole C
                [190.5, 85.2],  // Hole D
                [260.05, 27.9], // Hole E
                [279, 56.5],    // Hole F
            ]
        );
    }
}

if ($preview) {
    $fn = 16;
} else {
    $fn = 60;
}

mirror([0, 1, 0]) {
    layers_above_origin = 1;
    layers_below_origin = 3;
    layered_projections(
        layers_above_origin = layers_above_origin,
        layers_below_origin = layers_below_origin
    ) {
        gh60_layered_case(
            layers_above_origin = layers_above_origin,
            layers_below_origin = layers_below_origin
        );
    }
}