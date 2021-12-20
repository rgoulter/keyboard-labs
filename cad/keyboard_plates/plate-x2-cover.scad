// Plate cover for the X-2, covering the middle MCU area.

// BUG: 2021-12-20: Although the plate is fine, there are some usability issues:
//                    - Unreasonably difficult to disassemble the keyboard:
//                      This switch plate blocks access to screws at HOLES A, F.
//                      Which means if the plates are used with the X-2 PCB
//                      screwed into a GH-60 case: then to unscrew the PCB requires
//                      removing the switch plate. Which requires removing all the switches
//                      from the plate.
//                    - Floating plates don't work well with hot-swappable switches,
//                      especially not with the PCB rivets.
//                      (It's easier to accidentally bend the legs of the switch
//                       & not insert properly with the floating plate,
//                       compared to if it's stood-off from the PCB / bottom of the case).

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

screw_hole_size = 2.2;

u1_pad1_position = [184.88, 55.18365] - [h1_x, h1_y];

minif4_reset_buttons_offset = u1_pad1_position + [7.5, 14.4];
bluepill_reset_buttons_offset = u1_pad1_position + [4.5, 10];

module simple_cover_plate(
  outer_margin,
  holes_distance_width,
  holes_distance_height,
  screw_hole_size = 2.2,
) {
    margin = outer_margin - (screw_hole_size / 2);
    translate([margin, margin]) {
        difference() {
            // Add a margin, so it has rounded corners.
            offset(r = margin) {
                // A rectangle just the size of the grid of switches.
                square(
                  [
                    holes_distance_width  + screw_hole_size,
                    holes_distance_height + screw_hole_size
                  ]
                );
            }

            translate([screw_hole_size / 2, screw_hole_size / 2]) {
                circle(d = screw_hole_size);
                translate([holes_distance_width, 0]) {
                    circle(d = screw_hole_size);
                }
                translate([0, holes_distance_height]) {
                    circle(d = screw_hole_size);
                }
                translate([holes_distance_width, holes_distance_height]) {
                    circle(d = screw_hole_size);
                }
                
                children();
            }
        }
    }
}

$fn = 60;

*simple_cover_plate(
    outer_margin = margin,
    holes_distance_width = holes_distance_width,
    holes_distance_height = holes_distance_height
);

// With cutout for accessing button of MiniF4
*difference() {
    simple_cover_plate(
        outer_margin = margin,
        holes_distance_width = holes_distance_width,
        holes_distance_height = holes_distance_height
    ) {
        translate(minif4_reset_buttons_offset) {
            square(13.5, center = true);
        }
    }
}

// With cutout for accessing button of BluePill
*difference() {
    simple_cover_plate(
        outer_margin = margin,
        holes_distance_width = holes_distance_width,
        holes_distance_height = holes_distance_height
    ) {
        translate(bluepill_reset_buttons_offset) {
            square(13.5, center = true);
        }
    }
}