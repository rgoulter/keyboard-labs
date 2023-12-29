$fn = 32;

switch_unit = 19.05;

highlight_switch_cutout = true;
highlight_switch_outline = true;

function grid_coord(r, c) = [switch_unit, 0] * c + [0, switch_unit] * r;

module switch(
) {
    square(size = 19.05, center = true);
    if (highlight_switch_cutout) {
        %square(size = 14, center = true);
    }
    if (highlight_switch_outline) {
        %square(size = 19.05, center = true);
    }
}

// origin = unstaggered sw_1_1's middle
module column_staggered_switch_grid(
    num_rows = 3,
    num_cols = 5,
    stagger = [0, 0, 0, 0, 0],
) {
    for (row = [0:num_rows - 1]) {
        for (col = [0:num_cols - 1]) {
            translate(grid_coord(r = row, c = col) + [0, stagger[col]]) {
                switch();
            }
        }
    }
}

module fanned_thumb_cluster(
    fanned_angle = 10,
) {
    rotate([0, 0, fanned_angle]) {
        switch();

        half_u = switch_unit / 2;

        // Could recurse here for more than 1 thumb key to the right
        translate([half_u, half_u]) {
            rotate([0, 0, fanned_angle]) {
                translate([half_u, -half_u]) {
                    switch();
                }
            }
        }
        // Could recurse here for more than 1 thumb key to the left.
        translate([-half_u, half_u]) {
            rotate([0, 0, -fanned_angle]) {
                translate([-half_u, -half_u]) {
                    switch();
                }
            }
        }
    }
}

// Come up with a rounded base hull
// for split keyboards
module pcb_outline_hull(
    num_rows = 3,
    num_cols = 5,
    stagger = [12, 6, 0, 5.5, 8],
) {
    intersection() {
        square([100, 100], center = false);

        offset(r = 1.5)
        offset(r = -1.5)
        difference() {
            hull() {
                intersection() {
                    square([100, 100], center = false);

                    union() {
                        // Switches
                        translate([6.574, 9.6628]) {
                            column_staggered_switch_grid(
                                num_rows = num_rows,
                                num_cols = num_cols,
                                stagger = stagger
                            );

                            // thumb cluster
                            translate(grid_coord(r = 1 + 2, c = 3) + [0, stagger[3]] + [9, 7.5]) {
                                fanned_thumb_cluster();
                            }
                        }

                        // The PCB board shape extends to the USB connector
                        mock_usb_w = 10;
                        translate([100 - mock_usb_w, 0]) {
                            square([mock_usb_w, 8], center = false);
                            %square([mock_usb_w, 8], center = false);
                        }

                        // Add a curve to the outline's top-left
                        w = 36;
                        translate([w, 13]) {
                            rotate([0, 0, 0]) {
                                scale([2 * w, 26]) {
                                    circle(d = 1);
                                }
                            }
                        }
                    } // union
                } // intersection
            } // hull

            // Take out a curve from the bottom left
            translate([21, 79]) {
                rotate([0, 0, 23]) {
                    scale([48, 10]) {
                        circle(d = 1);
                    }
                }
            }
            // Take out a curve from the bottom right
            translate([71, 93]) {
                rotate([0, 0, 10]) {
                    scale([55, 8]) {
                        circle(d = 1);
                    }
                }
            }
        } // difference
    } // intersection
}

scale([1, -1]) {
    pcb_outline_hull();
}