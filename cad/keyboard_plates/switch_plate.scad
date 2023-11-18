// Common functions and modules for keyboard switch plates.

module switch_cutout(w = 1, width = 14, switch_grid_unit = 19.05) {
    halfwidth = width / 2;
    translate([-halfwidth, -halfwidth]) {
        square([
            width + (w - 1) * switch_grid_unit,
            width
        ]);
    }
}

module cutout_ortho_4x12(switch_grid_unit = 19.05) {
    for (row = [0:3], column = [0:11]) {
        translate([column, row] * switch_grid_unit) {
            switch_cutout(switch_grid_unit = switch_grid_unit);
        }
    }
}

module mounting_hole_cutouts(
    pcb_mounting_hole_offsets,
    // D=4, so screwdriver can be used to mount PCB to case
    pcb_mounting_hole_dia = 4,
) {
    for (pt = pcb_mounting_hole_offsets) {
        translate(pt) {
            circle(d = pcb_mounting_hole_dia);
        }
    }
}
