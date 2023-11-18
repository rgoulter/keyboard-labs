// Definition for the switch plate.

include <jj40_constants.scad>;
include <common.scad>;

use <../switch_plate.scad>;

$fn = 60;

block_pinky_columns = 0;
block_central_rows = 0;

// uses PCB's origin as the origin
module jj40_switch_plate_ortho_4x12(
    switch_plate_dim = SWITCH_PLATE_DIM,
    pcb_switch_plate_position = PCB_SWITCH_PLATE_POSITION,
    corner_r = CORNER_R,
    pcb_sw_1_1_position = PCB_SW_1_1_POSITION,
    pcb_mounting_hole_offsets = PCB_MOUNTING_HOLE_OFFSETS,
    pcb_mounting_hole_dia = 4,
    pcb_sw_1_1_position = PCB_SW_1_1_POSITION,
    switch_grid_unit = SWITCH_GRID_UNIT,
    block_pinky_columns = block_pinky_columns,
    block_central_rows = block_central_rows,
) {
    difference() {
        translate(pcb_switch_plate_position) {
            square_with_rounded_corners(switch_plate_dim, r = corner_r);
        }

        translate(pcb_sw_1_1_position) {
            mounting_hole_cutouts(pcb_mounting_hole_offsets = pcb_mounting_hole_offsets);
            cutout_ortho_4x12(
                switch_grid_unit = switch_grid_unit,
                block_pinky_columns = block_pinky_columns,
                block_central_rows = block_central_rows
            );
        }
    }
}

scale([1, -1, 1]) {
    jj40_switch_plate_ortho_4x12();
}
