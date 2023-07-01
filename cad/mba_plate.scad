// A plate to put on top of the MBA keyboard with bump-ons.
//
// This allows small keyboards (e.g. 60% and smaller) to be used on top of the
// MBA keyboard, without touching the keyboard (or having to disable the laptop
// keyboard).

kbd_width = 274;
kbd_height = 113;

module mba_plate() {
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
}

mba_plate();

// Transparency of the MBA keyboard
%square([kbd_width, kbd_height], center = true);
// Transparency of the MBA touchpad
translate([0, -kbd_height / 2 - 20]) {
    %square([120, 40], center = true);
}
