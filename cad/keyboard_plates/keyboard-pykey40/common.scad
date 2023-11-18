module corner(r) {
    difference() {
        square(r, center = false);
        translate([r, r]) {
            circle(r);
        }
    }
}

// Rect
// Minus corner of R=corner_r
// minus holes from outside
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

module rounded_square_cutout(
    dim,
    corner_r
) {
    difference() {
        square(dim, center = false);
        translate(dim) {
            rotate(180) {
                corner(r = corner_r);
            }
        }
        translate([0, dim[1]]) {
            rotate(270) {
                corner(r = corner_r);
            }
        }
    }

    translate([0, 0]) {
        rotate(90) {
            corner(r = corner_r);
        }
    }
    translate([dim[0], 0]) {
        rotate(0) {
            corner(r = corner_r);
        }
    }
}
