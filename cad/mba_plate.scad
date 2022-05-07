kbd_width = 274;
kbd_height = 113;

r = 10;
translate([0, kbd_height / 2]) {
    offset(r = r) {
        square([kbd_width + (2 * (15 - r)), 1], center = true);
    }
}
square([kbd_width + (2 * 15), kbd_height], center = true);
translate([0, -kbd_height / 2]) {
    offset(r = r) {
        translate([-(kbd_width / 2) - 5, 0]) {
            square([60, 1]);
        }
    }
}
translate([0, -kbd_height / 2]) {
    offset(r = r) {
        translate([(kbd_width / 2) + 5 - 60, 0]) {
            square([60, 1]);
        }
    }
}

%square([kbd_width, kbd_height], center = true);
translate([0, -kbd_height / 2 - 20]) {
    %square([120, 40], center = true);
}