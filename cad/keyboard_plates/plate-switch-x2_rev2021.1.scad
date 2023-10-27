// Floating switch plate for the X-2.
//
// Simply, a 5x6 grid of 14x14mm cutouts, with a 1.9mm margin.

include <../kicad_pcb_geometry.scad>;

outer_margin = 1.9;
switch_distance = 19.05;
cutout_width = 14;
num_columns = 6;
num_rows = 5;

module simple_switch_plate(
  outer_margin = outer_margin,
  num_columns = num_columns,
  num_rows = num_rows,
  switch_distance = switch_distance,
  cutout_width = cutout_width,
) {
    translate([outer_margin, outer_margin]) {
        difference() {
            // Add a margin, so it has rounded corners.
            offset(r = outer_margin) {
                // A rectangle just the size of the grid of switches.
                square(
                  [
                    (cutout_width / 2) + switch_distance * (num_columns - 1) + (cutout_width / 2),
                    (cutout_width / 2) + switch_distance * (num_rows - 1) + (cutout_width / 2)
                  ]
                );
            }

            // "Cut out" the switch cutouts
            for (col = [1 : num_columns], row = [1 : num_rows]) {
                translate([switch_distance * (col - 1), switch_distance * (row - 1)]) {
                    square(14);
                }
            }
        }
    }
}

module x2_switch_plate(
  outer_margin = outer_margin,
  num_columns = num_columns,
  num_rows = num_rows,
  switch_distance = 19.05,
  cutout_width = 14,
) {
    difference() {
        simple_switch_plate(
            outer_margin = outer_margin,
            switch_distance = switch_distance,
            cutout_width = cutout_width,
            num_columns = num_columns,
            num_rows = num_rows
        );

        // Cut out a d=3mm hole
        // for screwdriver access the screw underneath.
        cy = outer_margin + (cutout_width / 2) + (switch_distance / 2) + (switch_distance);
        translate([3.7, cy]) {
            circle(d = 3);
        }
        translate([0, cy - 1.5]) {
            square([3.7, 3]);
        }
        translate([0, cy + 1.5]) {
            rotate([0, 0]) {
                corner_rounder(r = 1);
            }
        }
        translate([0, cy - 1.5]) {
            rotate([0, 0, 270]) {
                corner_rounder(r = 1);
            }
        }
    }
}

// X-2 switches
x2_switch_plate(
    outer_margin = outer_margin,
    switch_distance = switch_distance,
    cutout_width = cutout_width,
    num_columns = num_columns,
    num_rows = num_rows
);