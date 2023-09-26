// This file is used to create a dimensioned drawing of where the
// threads should be machined for the CNC case.
//
// This is a bit of a kludge. OpenScad doesn't seem well suited to
// this task.
//
// The approach here is the dimensions are present in the preview.
//
// e.g. the preview image can be created with:
//
//   openscad
//     ./keyboard_case-threads.scad
//     --o=keyboard_case-threads.png
//     --projection=ortho
//     --camera=114,-44,0,0,0,0,280
//     --imgsize=2048,900
include <../dimlines.scad>;
include <keyboard_case-constants.scad>;

use <keyboard_case.scad>;

DIM_FONTSCALE = 0.4;
$fn = 64;

echo(vpr=$vpr, vpt=$vpt, vpd=$vpd, vpf=$vpf);

rotate(0 * 90) {
    translate([0, 0, -3]) {
        simple_keyboard_case();
    }

    case_cavity_position = [CASE_WALL_THICKNESS, CASE_WALL_THICKNESS];
    cavity_switchplate_position = [CASE_SWITCH_PLATE_MARGIN, CASE_SWITCH_PLATE_MARGIN];
    case_pcb_position = case_cavity_position + cavity_switchplate_position + SWITCH_PLATE_PCB_POSITION;

    scale([1, -1, 1]) {
        translate(case_pcb_position) {
            translate([0, 0, 12]) {
                color("black") {
                    pcb_mounting_hole_positions = [
                        for (offset = PCB_MOUNTING_HOLE_OFFSETS) PCB_SW_1_1_POSITION + offset
                    ];
                    for (pt = pcb_mounting_hole_positions) {
                        translate(pt) {
                            circle_center(radius=3, size=2.5, line_width=0.3);
                        }
                    }
                }
            }
        }
    }

    color("black") {
        // kludge: get sorted x-values of mount points
        mount_point_xs = [
            PCB_SW_1_1_POSITION[0] + SWITCH_GRID_UNIT * 0.5,
            PCB_SW_1_1_POSITION[0] + SWITCH_GRID_UNIT * 5.5,
            PCB_SW_1_1_POSITION[0] + SWITCH_GRID_UNIT * 10.5
        ];
        mount_point_ys = [
            PCB_SW_1_1_POSITION[1] + SWITCH_GRID_UNIT * 0.5,
            PCB_SW_1_1_POSITION[1] + SWITCH_GRID_UNIT * 1.5,
            PCB_SW_1_1_POSITION[1] + SWITCH_GRID_UNIT * 2.5
        ];

        x_dim_base = CASE_WALL_THICKNESS + CASE_SWITCH_PLATE_MARGIN + SWITCH_PLATE_PCB_POSITION[0];
        x_dim1 = x_dim_base + mount_point_xs[0];
        x_dim2 = mount_point_xs[1] - mount_point_xs[0];
        x_dim3 = mount_point_xs[2] - mount_point_xs[1];

        y_dim_base = CASE_WALL_THICKNESS + CASE_SWITCH_PLATE_MARGIN + SWITCH_PLATE_PCB_POSITION[1];
        y_dim3 = mount_point_ys[2] - mount_point_ys[1];
        y_dim2 = mount_point_ys[1] - mount_point_ys[0];
        y_dim1 = y_dim_base + mount_point_ys[0];

        translate([0, 5, 20]) {
            rotate(-90) line(length = CASE_WALL_THICKNESS, width = 0.5);
            dimensions(length=x_dim1, line_width=0.5);
            translate([x_dim1, 0]) {
                rotate(-90) line(length = CASE_WALL_THICKNESS + mount_point_ys[0], width = 0.5);
                dimensions(length=x_dim2, line_width=0.5);
            }
            translate([x_dim1 + x_dim2, 0]) {
                rotate(-90) line(length = CASE_WALL_THICKNESS + mount_point_ys[1], width = 0.5);
                dimensions(length=x_dim3, line_width=0.5);
            }
            translate([x_dim1 + x_dim2 + x_dim3, 0]) {
                rotate(-90) line(length = CASE_WALL_THICKNESS + mount_point_ys[0], width = 0.5);
            }
        }

        translate([-5, -(CASE_WALL_THICKNESS + CASE_SWITCH_PLATE_MARGIN + SWITCH_PLATE_PCB_POSITION[1] + mount_point_ys[2]), 20]) {
            rotate(90) {
                rotate(-90) line(length = CASE_WALL_THICKNESS + mount_point_xs[0], width = 0.5);
                dimensions(length=y_dim3, line_width=0.5);
                translate([y_dim3, 0]) {
                    rotate(-90) line(length = CASE_WALL_THICKNESS + mount_point_xs[1], width = 0.5);
                    dimensions(length=y_dim2, line_width=0.5);
                }
                translate([y_dim3 + y_dim2, 0]) {
                    rotate(-90) line(length = CASE_WALL_THICKNESS + mount_point_xs[0], width = 0.5);
                    dimensions(length=y_dim1, line_width=0.5);
                }
                translate([y_dim3 + y_dim2 + y_dim1, 0]) {
                    rotate(-90) line(length = CASE_WALL_THICKNESS, width = 0.5);
                }
            }
        }
        
        translate([15, -(PCB_DIM[1] + 20), 25]) {
            color("black") scale(0.7) drawtext("5 threaded holes, M2x2.4mm");
        }
    }
}
