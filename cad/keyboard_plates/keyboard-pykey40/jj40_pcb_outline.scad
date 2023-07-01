// definition for the PCB outline for the edge cuts layer for the PCB.

pcb_height = 75;
pcb_width = 227;

corner_r = 2.25;

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

module jj40_pcb_outline() {
    union() {
        square_with_rounded_corners(dim = [pcb_width, pcb_height], r = corner_r);

        // USB Connector
        extraW = 2;
        translate([31.5 - (extraW / 2), -2]) {
            w = 9 + extraW;
            difference() {
                square([w, 4], center = false);

                corner(r = 0.5);
                translate([w, 0]) {
                    mirror([1, 0]) corner(r = 0.5);
                }
            }

            translate([-1, 1]) {
              difference() {
                square([1, 1], center = false);
                circle(r = 1);
              }
            }
            translate([w, 1]) {
              difference() {
                square([1, 1], center = false);
                translate([1, 0]) {
                    circle(r = 1);
                }
              }
            }
        }
    }
}

$fn = 60;

scale([1, -1, 1]) {
    jj40_pcb_outline();
}
