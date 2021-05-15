include <generated/pcb_data.scad>;
include <footprint_modules.scad>;
include <../../kicad_pcb_geometry.scad>;

*edge_cuts_shape(edge_cuts_data);

*board_outline(edge_cuts_data);

// cover screws
screw1_at = [U1_length + 2.5, 2.5];
screw2_at = [U1_length + 2.5, 2.5 + 18];
screw3_at = [5, U1_width + 2.5];

module cover_screws() {
    translate(screw1_at) {
        circle(d = 2.3);
    }
    translate(screw2_at) {
        circle(d = 2.3);
    }
    translate(screw3_at) {
        circle(d = 2.3);
    }
}

$fn = 36;

// (Metal) top plate
!difference() {
    plate(
        edge_cuts_data = edge_cuts_data,
        modules_data = modules_data,
        include_footprints = [
            "Keebio-Parts:TRRS-PJ-320A",
            "ProjectLocal:SW_MX_PG1350_reversible",
            "ProjectLocal:WeAct_MiniF4_ZigZag",
            "Rotary_Encoder:RotaryEncoder_Alps_EC11E-Switch_Vertical_H20mm",
            "ProjectLocal:H_M2_Spacer_Hole",
        ],
        force_include_references = [
            "J3"
        ]
    );

    translate([0, -100]) {
        cover_screws();
    }

    // Round corners
    translate([0, -100 + 23.2]) {
        corner_rounder(r = 2.5);
    }
    translate([55.71, -100.1]) {
        corner_rounder(r = 2.5);
    }
    translate([J3_at[0], -J3_at[1]] + [-1.55, 2.3]) {
        rotate([0, 0, 0]) {
            corner_rounder(r = 1);
        }
    }
    translate([J3_at[0], -J3_at[1]] + [-1.55, -2.3 -2.54*3]) {
        rotate([0, 0, 270]) {
            corner_rounder(r = 1);
        }
    }
    translate([J1_at[0], -J1_at[1]] + [2.5, 6.3]) {
        rotate([0, 0, 90]) {
            corner_rounder(r = 2.5);
        }
    }
    translate([J1_at[0], -J1_at[1]] + [2.5, -4]) {
        rotate([0, 0, 180]) {
            corner_rounder(r = 2.5);
        }
    }
    translate([SW_RE1_at[0], -SW_RE1_at[1]] + [-4, -1.8]) {
        rotate([0, 0, 90]) {
            corner_rounder(r = 2.5);
        }
    }
    translate([SW_RE1_at[0], -SW_RE1_at[1]] + [8.8, -1.8]) {
        rotate([0, 0, 0]) {
            corner_rounder(r = 2.5);
        }
    }
}

// Acrylic bottom plate
!plate(
    edge_cuts_data = edge_cuts_data,
    modules_data = modules_data,
    include_footprints = [
        "ProjectLocal:H_M2_Spacer_Hole",
    ]
);

// Acrylic plate cover
difference() {
    offset(2) {
        offset(-2) {
            square([U1_length + 6, U1_width], center = false);
            square([10, U1_width + 6], center = false);
        }
    }

    cover_screws();
    translate([14.5, 11]) {
        offset(1) {
            square(13.5, center = true);
        }
    }
}