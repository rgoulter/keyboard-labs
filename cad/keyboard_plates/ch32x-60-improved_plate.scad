// CH32X-60-improved switch plate - FR4 1.6mm, tray-mount GH60
// Generates SVG/DXF via openscad -o plate.svg/dxf
// Cutouts: 14×14 MX + 2× stab 7×15 (6 north / 9 south, big hole south) for ≥2U, Ø4.5 H1-H4.
// Positions via SW_1_1 + U offsets (see ch32x_60_positions.scad / ch32x_60_improved.py)

include <../kicad_pcb_geometry.scad>;
include <../gh60_dimensions.scad>;
include <../ch32x_60_positions.scad>;

module corner(r) {
    difference() {
        square(r, center = false);
        translate([r, r]) {
            circle(r = r);
        }
    }
}

board_w = BOARD_W;
board_h = BOARD_H;
corner_r = 2.25;
mount_d = 4.5; // M2 Dk ≤ 4.0
mount_r = mount_d / 2;

stab_w = 7;
stab_h = 15; // 6 north / 9 south (stab's big hole south)
stab_cy = 1.5; // 1.5 south of switch centre
stab_dx = 11.938; // 2U

module switch_rect() {
    square([14, 14], center = true);
}
module stab_rect() {
    square([stab_w, stab_h], center = true);
}
function row_x_offsets(ws, i = 0, x = 0) = i >= len(ws) ? [] : concat([x], row_x_offsets(ws, i + 1, x + ws[i] * U));

module plate_natural() {
    difference() {
        // Board outline (with rounded corners)
        difference() {
            square([board_w, board_h]);
            translate([0, 0]) {
                rotate(0) {
                    corner(corner_r);
                }
            }
            translate([board_w, 0]) {
                rotate(90) {
                    corner(corner_r);
                }
            }
            translate([board_w, board_h]) {
                rotate(180) {
                    corner(corner_r);
                }
            }
            translate([0, board_h]) {
                rotate(270) {
                    corner(corner_r);
                }
            }
        }

        // Mounting holes
        for (pt = H) {
            translate(pt) {
                circle(r = mount_r);
            }
        }

        // Half-hole edge slots (c.f. GH60 dim 2.2244 and edge_cuts scad)
        translate([HALF_HOLE_X, HALF_HOLE_Y]) {
            translate([-HALF_HOLE_X/2, 0]) {
                square([HALF_HOLE_X, 2*HALF_HOLE_R], center = true);
            }
            circle(r = HALF_HOLE_R);
        }
        translate([BOARD_W - HALF_HOLE_X, HALF_HOLE_Y]) {
            translate([HALF_HOLE_X/2, 0]) {
                square([HALF_HOLE_X, 2*HALF_HOLE_R], center = true);
            }
            circle(r = HALF_HOLE_R);
        }

        // Switch + Stabilizer cutouts
        for (r = [0 : len(ROW_WIDTHS) - 1]) {
            widths = ROW_WIDTHS[r];
            xoffs = row_x_offsets(widths);
            y = SW_1_1[1] + r * U;

            for (c = [0 : len(widths) - 1]) {
                w = widths[c];
                x = SW_1_1[0] + xoffs[c] + w * U / 2 - 9.525;

                translate([x, y]) {
                    // Switch cutout
                    switch_rect();

                    // CH32X-60-Improved only has 2U stabilizers,
                    //  for every switch at least 2U.
                    if (w >= 2) {
                        translate([stab_dx, stab_cy]) {
                            stab_rect();
                        }
                        translate([-stab_dx, stab_cy]) {
                            stab_rect();
                        }
                    }
                }
            }
        }
    }
}

// OpenSCAD Y north, so flip natural (Y south) for preview
translate([0, board_h]) {
    scale([1, -1, 1]) {
        plate_natural();
    }
}
