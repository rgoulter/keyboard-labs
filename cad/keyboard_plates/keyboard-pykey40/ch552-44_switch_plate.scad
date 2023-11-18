// Definition for the switch plate.

include <jj40_constants.scad>;
include <common.scad>;

use <../switch_plate.scad>;

$fn = 60;

// ch552-44 switch plate has same dimensions and mounting holes as jj40,
// but there's a cutout for the top 2 rows in the central 2 columns,
// for the weact studio ch552 dev board.
//
// uses PCB's origin as the origin
module ch552_44_switch_plate(
    switch_plate_dim = SWITCH_PLATE_DIM,
    pcb_switch_plate_position = PCB_SWITCH_PLATE_POSITION,
    corner_r = CORNER_R,
    pcb_sw_1_1_position = PCB_SW_1_1_POSITION,
    pcb_mounting_hole_offsets = PCB_MOUNTING_HOLE_OFFSETS,
    pcb_mounting_hole_dia = 4,
    switch_grid_unit = SWITCH_GRID_UNIT
) {
    difference() {
        translate(pcb_switch_plate_position) {
            square_with_rounded_corners(switch_plate_dim, r = corner_r);
        }

        translate(pcb_sw_1_1_position) {
            mounting_hole_cutouts(pcb_mounting_hole_offsets = pcb_mounting_hole_offsets);
            // Pico42 is a subset of ortho 4x12
            cutout_ortho_4x12(switch_grid_unit = switch_grid_unit);
        }

        translate([
            pcb_sw_1_1_position[0] + switch_grid_unit * (5 - 0.5),
            pcb_switch_plate_position[1]
        ]) {
            cutout_width = switch_grid_unit * 2;
            cutout_height = switch_grid_unit * 1.5 - pcb_switch_plate_position.y + pcb_sw_1_1_position.y;
            rounded_square_cutout(
                dim = [cutout_width, cutout_height],
                corner_r = corner_r
            );
        }
    }
}

scale([1, -1, 1]) {
    ch552_44_switch_plate();
}
