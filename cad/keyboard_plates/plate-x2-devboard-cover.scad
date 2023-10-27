// Plate cover for the X-2, covering the middle MCU area.

pcb_left   = 50;
pcb_top    = 50;
pcb_bottom = 144.2;

h1_x = 168.68748;
h1_y =  54.23755;
h4_x = 216.31252;
h4_y = 139.367309;

holes_distance_width  = h4_x - h1_x;
holes_distance_height = h4_y - h1_y;
margin = 4;

screw_hole_dia = 2.2;

u1_pad1_position = [184.88, 55.18365] - [h1_x, h1_y];

minif4_reset_buttons_offset = u1_pad1_position + [7.5, 14.4];
bluepill_reset_buttons_offset = u1_pad1_position + [4.5, 10];

cutout_button_hole = false;

module x2_devboard_cover_plate(
  outer_margin = margin,
  holes_distance_width,
  holes_distance_height,
  screw_hole_dia = screw_hole_dia,
  cutout_button_hole = cutout_button_hole,
  u1_pad1_position = u1_pad1_position,
  // relative to u1's pad position
  buttons_offset = [0, 0],
  cutout_square_length = 13.5
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
                    square(13.5, center = true);
                }
            }
        }
    }
}

module x2_devboard_cover_plate_for_minif4() {
    x2_devboard_cover_plate(
        outer_margin = margin,
        holes_distance_width = holes_distance_width,
        holes_distance_height = holes_distance_height,
        cutout_button_hole = true,
        buttons_offset = minif4_reset_buttons_offset
    );
}

module x2_devboard_cover_plate_for_bluepill() {    
    x2_devboard_cover_plate(
        outer_margin = margin,
        holes_distance_width = holes_distance_width,
        holes_distance_height = holes_distance_height,
        cutout_button_hole = true,
        buttons_offset = bluepill_reset_buttons_offset
    );
}

*x2_devboard_cover_plate(
    outer_margin = margin,
    holes_distance_width = holes_distance_width,
    holes_distance_height = holes_distance_height
);

// With cutout for accessing button of MiniF4
*x2_devboard_cover_plate_for_minif4();

// With cutout for accessing button of BluePill
*x2_devboard_cover_plate_for_bluepill();
