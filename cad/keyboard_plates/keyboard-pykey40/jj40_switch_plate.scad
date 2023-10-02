// Definition for the switch plate.

include <jj40_constants.scad>;
include <common.scad>;

$fn = 60;

// 0: PyKey40 (47 key, 2U space), 1: Ortho 4x12, 2: Pico42
render_plate = 0;

module switch_cutout(w = 1, width = 2 * SW_CUTOUT_HALFWIDTH, sw_offset = SW_OFFSET) {
    halfwidth = width / 2;
    translate([-halfwidth, -halfwidth]) {
        square([
            width + (w - 1) * sw_offset,
            width
        ]);
    }
}

module jj40_switch_plate(
    space_2u = true,
    switch_plate_dim = SWITCH_PLATE_DIM,
    switch_plate_offset = SWITCH_PLATE_OFFSET,
    corner_r = CORNER_R,
    pcb_mounting_hole_positions = PCB_MOUNTING_HOLE_POSITIONS,
    pcb_mounting_hole_dia = 4,
    sw_1_1_offset = SW_1_1_OFFSET,
    sw_offset = SW_OFFSET
) {
    difference() {
        translate(switch_plate_offset) {
            square_with_rounded_corners(switch_plate_dim, r = corner_r);
        }

        // D=4, so screwdriver can be used to mount PCB to case
        for (pt = pcb_mounting_hole_positions) {
            translate(pt) {
                circle(d = pcb_mounting_hole_dia);
            }
        }

        translate(sw_1_1_offset) {
            for (row = [0:3], column = [0:11]) {
                translate([column, row] * sw_offset) {
                    if (space_2u && row == 3 && column == 5) {
                        switch_cutout(w = 2);
                    } else if (space_2u && row == 3 && column == 6) {
                    } else {
                        switch_cutout();
                    }
                }
            }
        }
    }
}

// pico is the same as jj40,
// but there's a cutout for the top 3 rows in the central 2 columns,
// for the pico dev board.
module pico42_switch_plate(
    switch_plate_dim = SWITCH_PLATE_DIM,
    switch_plate_offset = SWITCH_PLATE_OFFSET,
    corner_r = CORNER_R,
    pcb_mounting_hole_positions = PCB_MOUNTING_HOLE_POSITIONS,
    pcb_mounting_hole_dia = 4,
    sw_1_1_offset = SW_1_1_OFFSET,
    sw_offset = SW_OFFSET
) {
    difference() {
        jj40_switch_plate(
            space_2u = false,
            switch_plate_dim = switch_plate_dim,
            switch_plate_offset = switch_plate_offset,
            corner_r = corner_r,
            pcb_mounting_hole_positions = pcb_mounting_hole_positions,
            pcb_mounting_hole_dia = 4,
            sw_1_1_offset = sw_1_1_offset,
            sw_offset = sw_offset
        );

        translate(sw_1_1_offset + sw_offset * [5 - 0.5, -0.5]) {
            cutout_width = sw_offset * 2;
            cutout_height = sw_offset * 3;
            translate([0, -50]) {
                square_with_rounded_corners(dim = [cutout_width, cutout_height + 50], r = 0.5);
            }
            translate([0, (sw_offset / 2) - sw_1_1_offset[1] + switch_plate_offset[1]]) {
                rotate(90) {
                    corner(r = corner_r);
                }
            }
            translate([cutout_width, (sw_offset / 2) - sw_1_1_offset[1] + switch_plate_offset[1]]) {
                rotate(0) {
                    corner(r = corner_r);
                }
            }
        }
    }
}

scale([1, -1, 1]) {
    if (render_plate == 0) {
        jj40_switch_plate(space_2u = true);
    } else if (render_plate == 1) {
        jj40_switch_plate(space_2u = false);
    } else if (render_plate == 2) {
        pico42_switch_plate();
    }
}
