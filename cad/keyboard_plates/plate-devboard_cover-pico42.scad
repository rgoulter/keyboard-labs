// Plate cover for the Pico42, covering the middle devboard area.

use <plate-devboard_cover.scad>;

pcb_left   = 50;
pcb_top    = 50;

h1_x = 146.225;
h1_y =  53.5;
h4_x = 178.325;
h4_y = 102.125;

u1_mid_position = [162.275, 76.13];
u1_height = 51;

devboard_height = u1_height;
devboard_mid_y_rel_to_h1 = u1_mid_position[1] - h1_y;
cutout_mid_y_from_top = 13.5;

rpi_pico_btn_y = 12; // from top of Raspberry Pi Pico devboard
weact_rp2040_btn_y = 15; // from top of WeAct Studio RP2040 devboard

holes_distance_width  = h4_x - h1_x;
holes_distance_height = h4_y - h1_y;
margin = 2.5;

screw_hole_dia = 2.2;

switch_unit = 19.05;

cutout_button_hole = true;

module pico42_devboard_cover_plate() {
    devboard_cover_plate(
        outer_margin = margin,
        holes_distance_width = holes_distance_width,
        holes_distance_height = holes_distance_height,
        screw_hole_dia = screw_hole_dia,
        cutout_button_hole = cutout_button_hole,
        // relative to H1's pad position
        buttons_offset = [
            holes_distance_width / 2,
            holes_distance_height - devboard_mid_y_rel_to_h1 + (devboard_height / 2) - cutout_mid_y_from_top
        ],
        cutout_square_length = 13.5
    );
}

$fn = 32;

pico42_devboard_cover_plate();
