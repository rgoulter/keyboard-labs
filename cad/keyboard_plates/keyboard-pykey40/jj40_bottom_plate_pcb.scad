// Bottom plate aligned with the PCB.
//
// This only makes sense to use in an assembly
// of the PCB which doesn't use a switch plate,
// and solders 5-pin switches onto the PCB directly.

pcb_height = 75;
pcb_width = 227;

corner_r = 2.25;

foot_dia = 22;
foot_hole_dia = 4.1;

// Rect
// Minus corner of R=corner_r
// minus holes from outside

module corner(r) {
    difference() {
        square(r, center = false);
        translate([r, r]) {
            circle(r);
        }
    }
}

module square_with_rounded_corners(dim, r) {
    difference() {
        square(dim, center = false);

        translate([0, 0]) {
            rotate(0) {
                corner(r);
            }
        }
        translate([dim[0], 0]) {
            rotate(90) {
                corner(r);
            }
        }
        translate(dim) {
            rotate(180) {
                corner(r);
            }
        }
        translate([0, dim[1]]) {
            rotate(270) {
                corner(r);
            }
        }
    }
}

$fn = 60;

module jj40_bottom_plate_pcb() {
    difference() {
        union() {
            square_with_rounded_corners(dim = [pcb_width, pcb_height], r = corner_r)
            square(, center = false);
        }

        // D=2.2
        // 17, 18
        // 208, 18
        // 208, 56
        // 17, 56
        // 112, 37
        for (pt = [[17, 18], [208, 18], [208, 56], [17, 56], [112, 37]]) {
            translate(pt) {
                circle(d = 2.2);
            }
        }

        foot_offset_x = 32;
        foot_offset_y = 12;
        translate([0 + foot_offset_x, foot_offset_y]) {
            %circle(d = foot_dia);
            circle(d = foot_hole_dia);
        }
        translate([pcb_width - foot_offset_x, foot_offset_y]) {
            %circle(d = foot_dia);
            circle(d = foot_hole_dia);
        }
    }
}

scale([1, -1, 1]) {
    jj40_bottom_plate_pcb();
}
