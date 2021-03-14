// Footprint used by: TP1, TP2
module Footprint_Connector_PinHeader_2_54mm_PinHeader_1x04_P2_54mm_Vertical() {
    square(1, center = true);
}

// Footprint used by: J3
module Footprint_Connector_PinSocket_2_54mm_PinSocket_1x04_P2_54mm_Vertical() {
    offset_from_origin_x = 1.33;
    offset_from_origin_y = 1.33;
    width = 2.66;
    height = 10.28;
    offset(1) {
        translate([-offset_from_origin_x, -offset_from_origin_y]) {
          square([width, height], center = false);
        }
    }
}

// Footprint used by: JP10, JP3, JP4, JP5, JP6, JP7, JP8, JP9
module Footprint_Jumper_SolderJumper_2_P1_3mm_Open_Pad1_0x1_5mm() {
    square(1, center = true);
}

// Footprint used by: JP1, JP2
module Footprint_Jumper_SolderJumper_3_P1_3mm_Open_Pad1_0x1_5mm_NumberLabels() {
    square(1, center = true);
}

// Footprint used by: J1, J2
module Footprint_Keebio_Parts_TRRS_PJ_320A() {
    offset(1) {
        translate([-3.1, -3.1]) {
            square([6.2, 14.15]);
        }
    }
}

// Footprint used by: H11, H12, H13, H14, H15
module Footprint_MountingHole_MountingHole_2_2mm_M2_ISO7380_Pad() {
    square(1, center = true);
}

// Footprint used by: H1, H2, H3, H4, H5
module Footprint_ProjectLocal_Bumpon_3M_F0502() {
    square(1, center = true);
}

// Footprint used by: C_11, C_12, C_13, C_14, C_15, C_21, C_22, C_23,
//  C_24, C_25, C_31, C_32, C_33, C_34, C_35, C_41, C_42, C_43,
//  C_BL_1, C_BL_2, C_BL_3, C_BL_4
module Footprint_ProjectLocal_C_0805_2012Metric_Pad1_18x1_45mm_HandSolder_Dual() {
    square(1, center = true);
}

// Footprint used by: H10, H6, H7, H8, H9
module Footprint_ProjectLocal_H_M2_Spacer_Hole() {
    circle(d = 2.3);
}

// Footprint used by: D_BL_1, D_BL_2, D_BL_3, D_BL_4
module Footprint_ProjectLocal_LED_SK6812_PLCC4_5_0x5_0mm_P3_2mm_Reversible() {
    square(1, center = true);
}

// Footprint used by: R1, R2, R3, R4, R5, R6
module Footprint_ProjectLocal_Resistor_Hybrid() {
    square(1, center = true);
}

// Footprint used by: D_11, D_12, D_13, D_14, D_15, D_21, D_22, D_23,
//  D_24, D_25, D_31, D_32, D_33, D_34, D_35, D_41, D_42, D_43
module Footprint_ProjectLocal_SK6812_MINI_E_Reversible() {
    square(1, center = true);
}

// Footprint used by: U2
module Footprint_ProjectLocal_SOT_23_6_Handsoldering_Reversible() {
    square(1, center = true);
}

// Footprint used by: SW_11, SW_12, SW_13, SW_14, SW_15, SW_21, SW_22,
//  SW_23, SW_24, SW_25, SW_31, SW_32, SW_33, SW_34, SW_35, SW_41,
//  SW_42, SW_43
module Footprint_ProjectLocal_SW_MX_PG1350_reversible() {
    square(14, center = true);
}

// Footprint used by: U1
U1_offset = [-5.3, -4]; // -12.5, -2 ???
U1_width = 24;
U1_length = 57;
module Footprint_ProjectLocal_WeAct_MiniF4_ZigZag() {
    translate(U1_offset) { // -12.5, -2
        square([U1_width, U1_length], center = false);
    }
}

// Footprint used by: SW_RE1
module Footprint_Rotary_Encoder_RotaryEncoder_Alps_EC11E_Switch_Vertical_H20mm() {
    px = 1.4;
    py = -3.4;
    cx = 6.1;
    cy = 5.9;
    *circle(d = 1);
    translate([px, py]) {
        *circle(d = 2);
        translate([cx, cy]) {
            *circle(d = 5);
            square([13, 13], center = true);
        }
    }
}

// Constructs the geometry for a given module_data structure.
//
// The module_data has the structure:
//   [
//     footprint_name,
//     ["at", x, y, rotation],
//     ["reference", module_reference],
//     ["side", side]
//   ]
module module_for_footprint(
    module_data,
    allow_unhandled_footprints = true,
    allow_unimplemented_footprints = true
) {
    module_footprint = module_data[0];

    if (module_footprint == "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical") {
        Footprint_Connector_PinHeader_2_54mm_PinHeader_1x04_P2_54mm_Vertical();
    } else if (module_footprint == "Connector_PinSocket_2.54mm:PinSocket_1x04_P2.54mm_Vertical") {
        Footprint_Connector_PinSocket_2_54mm_PinSocket_1x04_P2_54mm_Vertical();
    } else if (module_footprint == "Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm") {
        Footprint_Jumper_SolderJumper_2_P1_3mm_Open_Pad1_0x1_5mm();
    } else if (module_footprint == "Jumper:SolderJumper-3_P1.3mm_Open_Pad1.0x1.5mm_NumberLabels") {
        Footprint_Jumper_SolderJumper_3_P1_3mm_Open_Pad1_0x1_5mm_NumberLabels();
    } else if (module_footprint == "Keebio-Parts:TRRS-PJ-320A") {
        Footprint_Keebio_Parts_TRRS_PJ_320A();
    } else if (module_footprint == "MountingHole:MountingHole_2.2mm_M2_ISO7380_Pad") {
        Footprint_MountingHole_MountingHole_2_2mm_M2_ISO7380_Pad();
    } else if (module_footprint == "ProjectLocal:Bumpon_3M_F0502") {
        Footprint_ProjectLocal_Bumpon_3M_F0502();
    } else if (module_footprint == "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual") {
        Footprint_ProjectLocal_C_0805_2012Metric_Pad1_18x1_45mm_HandSolder_Dual();
    } else if (module_footprint == "ProjectLocal:H_M2_Spacer_Hole") {
        Footprint_ProjectLocal_H_M2_Spacer_Hole();
    } else if (module_footprint == "ProjectLocal:LED_SK6812_PLCC4_5.0x5.0mm_P3.2mm_Reversible") {
        Footprint_ProjectLocal_LED_SK6812_PLCC4_5_0x5_0mm_P3_2mm_Reversible();
    } else if (module_footprint == "ProjectLocal:Resistor-Hybrid") {
        Footprint_ProjectLocal_Resistor_Hybrid();
    } else if (module_footprint == "ProjectLocal:SK6812-MINI-E_Reversible") {
        Footprint_ProjectLocal_SK6812_MINI_E_Reversible();
    } else if (module_footprint == "ProjectLocal:SOT-23-6_Handsoldering_Reversible") {
        Footprint_ProjectLocal_SOT_23_6_Handsoldering_Reversible();
    } else if (module_footprint == "ProjectLocal:SW_MX_PG1350_reversible") {
        Footprint_ProjectLocal_SW_MX_PG1350_reversible();
    } else if (module_footprint == "ProjectLocal:WeAct_MiniF4_ZigZag") {
        Footprint_ProjectLocal_WeAct_MiniF4_ZigZag();
    } else if (module_footprint == "Rotary_Encoder:RotaryEncoder_Alps_EC11E-Switch_Vertical_H20mm") {
        Footprint_Rotary_Encoder_RotaryEncoder_Alps_EC11E_Switch_Vertical_H20mm();
    } else {
        assert(allow_unhandled_footprints, "fall-through; unhandled footprint: '" + module_footprint + "'");
    }
}