// Describes the outline for a GH60-compatible PCB.
// For use on the edge-cuts layer.

height = 94.2;
width = 285;

corner_r = 2.25;

hole_x = 3.7089;
hole_y = 56.5; // 55.25 + 57.75;
hole_r = 1.25;

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

module hole(x, r) {
    translate([0, -r]) {
        square([x, 2 * r], center = false);
    }
    translate([x, 0]) {
        circle(r);
    }
}

module gh60_pcb_outline() {
    difference() {
        square([width, height], center = false);

        translate([0, 0]) {
            rotate([0, 0, 0]) {
                corner(corner_r);
            }
        }
        translate([width, 0]) {
            rotate([0, 0, 90]) {
                corner(corner_r);
            }
        }
        translate([width, height]) {
            rotate([0, 0, 180]) {
                corner(corner_r);
            }
        }
        translate([0, height]) {
            rotate([0, 0, 270]) {
                corner(corner_r);
            }
        }

        translate([0, hole_y]) {
            hole(hole_x, hole_r);
        }
        translate([width, hole_y]) {
            scale([-1, 1, 1]) {
                hole(hole_x, hole_r);
            }
        }
    }
}

$fn = 60;

scale([1, -1, 1]) {
    gh60_pcb_outline();
}
