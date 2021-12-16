// Footprint used by: J1
module Footprint_Connector_USB_USB_C_Receptacle_XKB_U262_16XN_4BVC11() {
    extra = 20;
    translate([-5, -4.2 - extra]) {
        square([10, 8 + extra]);
    }
}

// Footprint used by: D1, D2, D3, D4
module Footprint_LED_SMD_LED_WS2812B_PLCC4_5_0x5_0mm_P3_2mm() {
    square(1, center = true);
}

// Footprint used by: U1
module Footprint_Package_DIP_DIP_40_W15_24mm_Socket() {
    translate([-0.9, -0.9]) {
        square([1.8, 1.8 + 2.54 * (20 - 1)]);

        translate([15.24, 0]) {
            square([1.8, 1.8 + 2.54 * (20 - 1)]);
        }
    }
}

// Footprint used by: U2
module Footprint_Package_TO_SOT_SMD_SOT_23_6_Handsoldering() {
    square(1, center = true);
}

// Footprint used by: C1, C2, C3, C4
module Footprint_ProjectLocal_C_0805_2012Metric_Pad1_18x1_45mm_HandSolder_Dual() {
    translate([-2.54, 0]) {
        circle(d = 2.4);
    }
    translate([2.54, 0]) {
        circle(d = 2.4);
    }
}

// Footprint used by: D5, D_1_1, D_1_10, D_1_11, D_1_12, D_1_2, D_1_3,
//  D_1_4, D_1_5, D_1_6, D_1_7, D_1_8, D_1_9, D_2_1, D_2_10, D_2_11,
//  D_2_12, D_2_2, D_2_3, D_2_4, D_2_5, D_2_6, D_2_7, D_2_8, D_2_9,
//  D_3_1, D_3_10, D_3_11, D_3_12, D_3_2, D_3_3, D_3_4, D_3_5, D_3_6,
//  D_3_7, D_3_8, D_3_9, D_4_1, D_4_10, D_4_11, D_4_12, D_4_2, D_4_3,
//  D_4_4, D_4_5, D_4_6, D_4_7, D_4_8, D_4_9, D_5_1, D_5_10, D_5_11,
//  D_5_12, D_5_2, D_5_3, D_5_4, D_5_5, D_5_6, D_5_7, D_5_8, D_5_9
module Footprint_ProjectLocal_Diode_dual() {
    translate([-3.9, 0]) {
        circle(d = 2.4);
    }
    translate([3.9, 0]) {
        circle(d = 2.4);
    }
}

// Footprint used by: R1, R2, R3, R4
module Footprint_ProjectLocal_Resistor_Hybrid() {
    translate([-3.9, 0]) {
        circle(d = 2.4);
    }
    translate([3.9, 0]) {
        circle(d = 2.4);
    }
}

// Footprint used by: SW_1_1, SW_1_10, SW_1_11, SW_1_12, SW_1_2,
//  SW_1_3, SW_1_4, SW_1_5, SW_1_6, SW_1_7, SW_1_8, SW_1_9, SW_2_1,
//  SW_2_10, SW_2_11, SW_2_12, SW_2_2, SW_2_3, SW_2_4, SW_2_5, SW_2_6,
//  SW_2_7, SW_2_8, SW_2_9, SW_3_1, SW_3_10, SW_3_11, SW_3_12, SW_3_2,
//  SW_3_3, SW_3_4, SW_3_5, SW_3_6, SW_3_7, SW_3_8, SW_3_9, SW_4_1,
//  SW_4_10, SW_4_11, SW_4_12, SW_4_2, SW_4_3, SW_4_4, SW_4_5, SW_4_6,
//  SW_4_7, SW_4_8, SW_4_9, SW_5_1, SW_5_10, SW_5_11, SW_5_12, SW_5_2,
//  SW_5_3, SW_5_4, SW_5_5, SW_5_6, SW_5_7, SW_5_8, SW_5_9
module Footprint_ProjectLocal_SW_MX_PG1350_NoLed() {
    translate([-6.5, -2]) {
        square([13, 9]);
    }
}

// Footprint used by: H1, H2, H3, H4
module Footprint_lumberjack_MountingHole_M2() {
    // Hole wide enough to allow M2 screw head.
    // (Dk <= 3.6).
    circle(d = 4);
}

// Footprint used by: H7
module Footprint_lumberjack_MountingSlot_M2() {
    // With wide enough diameter for M2 spacer.
    // (spacer D <= 3.3).
    circle(d = 3.5);
}

// Footprint used by: REF**
module Footprint_lumberjack_OSHW() {
    square(1, center = true);
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

    if (module_footprint == "Connector_USB:USB_C_Receptacle_XKB_U262-16XN-4BVC11") {
        Footprint_Connector_USB_USB_C_Receptacle_XKB_U262_16XN_4BVC11();
    } else if (module_footprint == "LED_SMD:LED_WS2812B_PLCC4_5.0x5.0mm_P3.2mm") {
        Footprint_LED_SMD_LED_WS2812B_PLCC4_5_0x5_0mm_P3_2mm();
    } else if (module_footprint == "Package_DIP:DIP-40_W15.24mm_Socket") {
        Footprint_Package_DIP_DIP_40_W15_24mm_Socket();
    } else if (module_footprint == "Package_TO_SOT_SMD:SOT-23-6_Handsoldering") {
        Footprint_Package_TO_SOT_SMD_SOT_23_6_Handsoldering();
    } else if (module_footprint == "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual") {
        Footprint_ProjectLocal_C_0805_2012Metric_Pad1_18x1_45mm_HandSolder_Dual();
    } else if (module_footprint == "ProjectLocal:Diode-dual") {
        Footprint_ProjectLocal_Diode_dual();
    } else if (module_footprint == "ProjectLocal:Resistor-Hybrid") {
        Footprint_ProjectLocal_Resistor_Hybrid();
    } else if (module_footprint == "ProjectLocal:SW_MX_PG1350_NoLed") {
        Footprint_ProjectLocal_SW_MX_PG1350_NoLed();
    } else if (module_footprint == "lumberjack:MountingHole_M2") {
        Footprint_lumberjack_MountingHole_M2();
    } else if (module_footprint == "lumberjack:MountingSlot_M2") {
        Footprint_lumberjack_MountingSlot_M2();
    } else if (module_footprint == "lumberjack:OSHW") {
        Footprint_lumberjack_OSHW();
    } else {
        assert(allow_unhandled_footprints, "fall-through; unhandled footprint: '" + module_footprint + "'");
    }
}