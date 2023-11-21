include <../keyboard_plates/keyboard-pykey40/jj40_constants.scad>;

// PCB position, from Switch Plate's top-left.
SWITCH_PLATE_PCB_POSITION = -PCB_SWITCH_PLATE_POSITION;
CASE_SWITCH_PLATE_MARGIN = 0.25;

echo(SWITCH_PLATE_PCB_POSITION = SWITCH_PLATE_PCB_POSITION);

// "Low Profile" case means the walls of the case
// are at the same height as the switch plate.
CASE_LOW_PROFILE_MX_UPPER_CAVITY_HEIGHT = 6;
CASE_LOWER_CAVITY_HEIGHT = 4;

CASE_WALL_THICKNESS = 4;
CASE_BOTTOM_HEIGHT = 2;

// [x, y] positions for the bump-on feet.
// (These get mirrored for the other side of the case).
CASE_BUMPON_GUIDE_POSITIONS = [[35, 15], [10, -10]];
