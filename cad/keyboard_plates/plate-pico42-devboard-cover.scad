// Plate cover for the Pico42, covering the middle devboard area.

pcb_left   = 50;
pcb_top    = 50;

h1_x = 146.225;
h1_y =  53.5;
h4_x = 178.325;
h4_y = 102.125;

u1_mid_position = [162.275, 76.13];
u1_height = 51;

rpi_pico_btn_y = 12; // from top of Raspberry Pi Pico devboard
weact_rp2040_btn_y = 15; // from top of WeAct Studio RP2040 devboard

holes_distance_width  = h4_x - h1_x;
holes_distance_height = h4_y - h1_y;
margin = 2.5;

screw_hole_dia = 2.2;

switch_unit = 19.05;

cutout_button_hole = true;

module pico42_devboard_cover_plate(
  outer_margin = margin,
  holes_distance_width = holes_distance_width,
  holes_distance_height = holes_distance_height,
  screw_hole_dia = screw_hole_dia,
  cutout_button_hole = cutout_button_hole,
  devboard_height = u1_height,
  devboard_mid_y_rel_to_h1 = u1_mid_position[1] - h1_y,
  cutout_mid_y_from_top = 13.5,
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

            // Cutout from the top of the devboard.
            if (cutout_button_hole) {
                translate([holes_distance_width / 2, holes_distance_height - devboard_mid_y_rel_to_h1 + (devboard_height / 2) - cutout_mid_y_from_top]) {
                    square(cutout_square_length, center = true);
                }
            }
        }
    }
}

$fn = 32;

pico42_devboard_cover_plate(
    outer_margin = margin,
    holes_distance_width = holes_distance_width,
    holes_distance_height = holes_distance_height,
    screw_hole_dia = screw_hole_dia,
    cutout_button_hole = cutout_button_hole,
    devboard_height = u1_height,
    devboard_mid_y_rel_to_h1 = u1_mid_position[1] - h1_y,
    cutout_mid_y_from_top = 13.5,
    cutout_square_length = 13.5
);