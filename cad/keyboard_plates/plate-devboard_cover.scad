// Helper module for devboard cover,
// for keyboards such as "Lumberjack Arm", Pico42, CH552-44, etc.

module devboard_cover_plate(
  outer_margin,
  holes_distance_width,
  holes_distance_height,
  screw_hole_dia = 2.2,
  cutout_button_hole = false,
  cutout_switch_hole = false,
  // relative to H1's pad position
  buttons_offset = [0, 0],
  cutout_square_length = 13.5,
  switch_offset = [0, 0],
  cutout_switch_dim = [24.5, 13.5],
) {
    screw_hole_r = screw_hole_dia / 2;
    margin = outer_margin - screw_hole_r;
    translate([margin, margin]) {
        difference() {
            // Add a margin, so it has rounded corners.
            translate([-screw_hole_r, -screw_hole_r]) {
                offset(r = margin) {
                    // A rectangle just the size of the grid of switches.
                    square(
                      [
                        holes_distance_width  + screw_hole_dia,
                        holes_distance_height + screw_hole_dia
                      ]
                    );
                }
            }

            screw_hole_points = [[0, 0], [holes_distance_width, 0], [0, holes_distance_height], [holes_distance_width, holes_distance_height]];
            for (screw_hole_point = screw_hole_points) {
                translate(screw_hole_point) {
                    circle(d = screw_hole_dia);
                }
            }

            if (cutout_button_hole) {
                translate(buttons_offset) {
                    square(cutout_square_length, center = true);
                }
            }
            if (cutout_switch_hole) {
                translate(switch_offset) {
                    square(cutout_switch_dim, center = true);
                }
            }
        }
    }
}
