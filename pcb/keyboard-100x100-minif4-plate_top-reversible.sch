EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Reversible Split Keyboard Half, Top Plate"
Date "2021-02-24"
Rev "2021.1"
Comp "Richard Goulter"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L keebio:TRRS J1
U 1 1 5FDF9ACF
P 1800 7500
F 0 "J1" H 2028 7803 60  0000 L CNN
F 1 "TRRS" H 2028 7697 60  0000 L CNN
F 2 "Keebio-Parts:TRRS-PJ-320A" H 1950 7500 60  0001 C CNN
F 3 "" H 1950 7500 60  0001 C CNN
	1    1800 7500
	1    0    0    -1  
$EndComp
$Comp
L keebio:TRRS J_r_1
U 1 1 5FDFA2E7
P 2650 7500
F 0 "J_r_1" H 2567 8187 60  0000 C CNN
F 1 "TRRS" H 2567 8081 60  0000 C CNN
F 2 "Keebio-Parts:TRRS-PJ-320A" H 2800 7500 60  0001 C CNN
F 3 "" H 2800 7500 60  0001 C CNN
	1    2650 7500
	-1   0    0    -1  
$EndComp
NoConn ~ 2750 2550
NoConn ~ 2750 2650
Text Label 2750 1950 0    50   ~ 0
SW43
Text Label 2750 1850 0    50   ~ 0
SW42
Text Label 2750 1750 0    50   ~ 0
SW41
Text Label 2750 1650 0    50   ~ 0
SW35
Text Label 2750 1550 0    50   ~ 0
SW34
Text Label 2750 1450 0    50   ~ 0
SW33
Text Label 2750 1350 0    50   ~ 0
SW32
Text Label 2750 2050 0    50   ~ 0
SW31
Text Label 2750 1150 0    50   ~ 0
SW25
Text Label 2750 2450 0    50   ~ 0
SW15
NoConn ~ 2750 2750
NoConn ~ 2750 850 
Text Label 2750 2250 0    50   ~ 0
RGB_DIN
Text Label 2750 1050 0    50   ~ 0
3V3
Text Label 2750 950  0    50   ~ 0
GND
Wire Notes Line
	4800 500  4800 7750
Wire Notes Line
	4800 2650 11200 2650
Wire Notes Line
	500  3350 4800 3350
Wire Notes Line
	500  5350 4800 5350
$Comp
L Switch:SW_Push SW_31
U 1 1 5FDE5173
P 6200 1950
F 0 "SW_31" H 6200 2235 50  0000 C CNN
F 1 "SW_Push" H 6200 2144 50  0000 C CNN
F 2 "ProjectLocal:SW_Cutout" H 6200 2150 50  0001 C CNN
F 3 "~" H 6200 2150 50  0001 C CNN
	1    6200 1950
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_34
U 1 1 5FDF323B
P 8000 1950
F 0 "SW_34" H 8000 2235 50  0000 C CNN
F 1 "SW_Push" H 8000 2144 50  0000 C CNN
F 2 "ProjectLocal:SW_Cutout" H 8000 2150 50  0001 C CNN
F 3 "~" H 8000 2150 50  0001 C CNN
	1    8000 1950
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_33
U 1 1 5FDF2DC3
P 7400 1950
F 0 "SW_33" H 7400 2235 50  0000 C CNN
F 1 "SW_Push" H 7400 2144 50  0000 C CNN
F 2 "ProjectLocal:SW_Cutout" H 7400 2150 50  0001 C CNN
F 3 "~" H 7400 2150 50  0001 C CNN
	1    7400 1950
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_32
U 1 1 5FDF2621
P 6800 1950
F 0 "SW_32" H 6800 2235 50  0000 C CNN
F 1 "SW_Push" H 6800 2144 50  0000 C CNN
F 2 "ProjectLocal:SW_Cutout" H 6800 2150 50  0001 C CNN
F 3 "~" H 6800 2150 50  0001 C CNN
	1    6800 1950
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_22
U 1 1 5FDF1BC1
P 6800 1450
F 0 "SW_22" H 6800 1735 50  0000 C CNN
F 1 "SW_Push" H 6800 1644 50  0000 C CNN
F 2 "ProjectLocal:SW_Cutout" H 6800 1650 50  0001 C CNN
F 3 "~" H 6800 1650 50  0001 C CNN
	1    6800 1450
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_23
U 1 1 5FDF1620
P 7400 1450
F 0 "SW_23" H 7400 1735 50  0000 C CNN
F 1 "SW_Push" H 7400 1644 50  0000 C CNN
F 2 "ProjectLocal:SW_Cutout" H 7400 1650 50  0001 C CNN
F 3 "~" H 7400 1650 50  0001 C CNN
	1    7400 1450
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_41
U 1 1 5FDF0949
P 7400 2450
F 0 "SW_41" H 7400 2735 50  0000 C CNN
F 1 "SW_Push" H 7400 2644 50  0000 C CNN
F 2 "ProjectLocal:SW_Cutout" H 7400 2650 50  0001 C CNN
F 3 "~" H 7400 2650 50  0001 C CNN
	1    7400 2450
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_42
U 1 1 5FDF0012
P 8000 2450
F 0 "SW_42" H 8000 2735 50  0000 C CNN
F 1 "SW_Push" H 8000 2644 50  0000 C CNN
F 2 "ProjectLocal:SW_Cutout" H 8000 2650 50  0001 C CNN
F 3 "~" H 8000 2650 50  0001 C CNN
	1    8000 2450
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_43
U 1 1 5FDEF97E
P 8600 2450
F 0 "SW_43" H 8600 2735 50  0000 C CNN
F 1 "SW_Push" H 8600 2644 50  0000 C CNN
F 2 "ProjectLocal:SW_Cutout" H 8600 2650 50  0001 C CNN
F 3 "~" H 8600 2650 50  0001 C CNN
	1    8600 2450
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_35
U 1 1 5FDEF11F
P 8600 1950
F 0 "SW_35" H 8600 2235 50  0000 C CNN
F 1 "SW_Push" H 8600 2144 50  0000 C CNN
F 2 "ProjectLocal:SW_Cutout" H 8600 2150 50  0001 C CNN
F 3 "~" H 8600 2150 50  0001 C CNN
	1    8600 1950
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_15
U 1 1 5FDED702
P 8600 950
F 0 "SW_15" H 8600 1235 50  0000 C CNN
F 1 "SW_Push" H 8600 1144 50  0000 C CNN
F 2 "ProjectLocal:SW_Cutout" H 8600 1150 50  0001 C CNN
F 3 "~" H 8600 1150 50  0001 C CNN
	1    8600 950 
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_14
U 1 1 5FDECF29
P 8000 950
F 0 "SW_14" H 8000 1235 50  0000 C CNN
F 1 "SW_Push" H 8000 1144 50  0000 C CNN
F 2 "ProjectLocal:SW_Cutout" H 8000 1150 50  0001 C CNN
F 3 "~" H 8000 1150 50  0001 C CNN
	1    8000 950 
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_13
U 1 1 5FDEC2EC
P 7400 950
F 0 "SW_13" H 7400 1235 50  0000 C CNN
F 1 "SW_Push" H 7400 1144 50  0000 C CNN
F 2 "ProjectLocal:SW_Cutout" H 7400 1150 50  0001 C CNN
F 3 "~" H 7400 1150 50  0001 C CNN
	1    7400 950 
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_12
U 1 1 5FDEB649
P 6800 950
F 0 "SW_12" H 6800 1235 50  0000 C CNN
F 1 "SW_Push" H 6800 1144 50  0000 C CNN
F 2 "ProjectLocal:SW_Cutout" H 6800 1150 50  0001 C CNN
F 3 "~" H 6800 1150 50  0001 C CNN
	1    6800 950 
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_21
U 1 1 5FDE48F6
P 6200 1450
F 0 "SW_21" H 6200 1735 50  0000 C CNN
F 1 "SW_Push" H 6200 1644 50  0000 C CNN
F 2 "ProjectLocal:SW_Cutout" H 6200 1650 50  0001 C CNN
F 3 "~" H 6200 1650 50  0001 C CNN
	1    6200 1450
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_11
U 1 1 5FD3A369
P 6200 950
F 0 "SW_11" H 6200 1235 50  0000 C CNN
F 1 "SW_Push" H 6200 1144 50  0000 C CNN
F 2 "ProjectLocal:SW_Cutout" H 6200 1150 50  0001 C CNN
F 3 "~" H 6200 1150 50  0001 C CNN
	1    6200 950 
	1    0    0    -1  
$EndComp
NoConn ~ 2750 1250
NoConn ~ 2750 2150
NoConn ~ 2750 2350
$Comp
L Mechanical:MountingHole H6
U 1 1 603C44C9
P 1900 3800
F 0 "H6" H 2000 3846 50  0000 L CNN
F 1 "MountingHole" H 2000 3755 50  0000 L CNN
F 2 "ProjectLocal:H_M2_Screw_Hole" H 1900 3800 50  0001 C CNN
F 3 "~" H 1900 3800 50  0001 C CNN
	1    1900 3800
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H7
U 1 1 603C4D5A
P 1900 4000
F 0 "H7" H 2000 4046 50  0000 L CNN
F 1 "MountingHole" H 2000 3955 50  0000 L CNN
F 2 "ProjectLocal:H_M2_Screw_Hole" H 1900 4000 50  0001 C CNN
F 3 "~" H 1900 4000 50  0001 C CNN
	1    1900 4000
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H8
U 1 1 603C5079
P 1900 4200
F 0 "H8" H 2000 4246 50  0000 L CNN
F 1 "MountingHole" H 2000 4155 50  0000 L CNN
F 2 "ProjectLocal:H_M2_Screw_Hole" H 1900 4200 50  0001 C CNN
F 3 "~" H 1900 4200 50  0001 C CNN
	1    1900 4200
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H9
U 1 1 603C53A9
P 1900 4400
F 0 "H9" H 2000 4446 50  0000 L CNN
F 1 "MountingHole" H 2000 4355 50  0000 L CNN
F 2 "ProjectLocal:H_M2_Screw_Hole" H 1900 4400 50  0001 C CNN
F 3 "~" H 1900 4400 50  0001 C CNN
	1    1900 4400
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H10
U 1 1 603C55A7
P 1900 4600
F 0 "H10" H 2000 4646 50  0000 L CNN
F 1 "MountingHole" H 2000 4555 50  0000 L CNN
F 2 "ProjectLocal:H_M2_Screw_Hole" H 1900 4600 50  0001 C CNN
F 3 "~" H 1900 4600 50  0001 C CNN
	1    1900 4600
	1    0    0    -1  
$EndComp
NoConn ~ 1150 1050
NoConn ~ 1150 950 
NoConn ~ 1150 2350
NoConn ~ 1150 1650
NoConn ~ 1150 1550
Text Label 1150 2150 2    50   ~ 0
SCL_TX
Text Label 1150 2250 2    50   ~ 0
SDA_RX
NoConn ~ 1150 2550
NoConn ~ 1150 2650
NoConn ~ 1150 2750
Text Label 1150 1150 2    50   ~ 0
SW11
Text Label 1150 1250 2    50   ~ 0
SW12
Text Label 1150 1350 2    50   ~ 0
SW13
Text Label 1150 1450 2    50   ~ 0
SW14
Text Label 1150 2050 2    50   ~ 0
SW21
Text Label 1150 1750 2    50   ~ 0
SW22
Text Label 1150 1850 2    50   ~ 0
SW23
Text Label 1150 1950 2    50   ~ 0
SW24
NoConn ~ 1150 2450
NoConn ~ 1150 850 
$Comp
L ProjectLocal:MiniF4 U1
U 1 1 5FD347E3
P 1950 1750
F 0 "U1" H 1950 2915 50  0000 C CNN
F 1 "MiniF4" H 1950 2824 50  0000 C CNN
F 2 "ProjectLocal:WeAct_MiniF4_ZigZag" H 4200 2200 50  0001 C CNN
F 3 "" V 2600 900 50  0001 C CNN
	1    1950 1750
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_24
U 1 1 5FDF0DF7
P 8000 1450
F 0 "SW_24" H 8000 1735 50  0000 C CNN
F 1 "SW_Push" H 8000 1644 50  0000 C CNN
F 2 "ProjectLocal:SW_Cutout" H 8000 1650 50  0001 C CNN
F 3 "~" H 8000 1650 50  0001 C CNN
	1    8000 1450
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_25
U 1 1 5FDEE777
P 8600 1450
F 0 "SW_25" H 8600 1735 50  0000 C CNN
F 1 "SW_Push" H 8600 1644 50  0000 C CNN
F 2 "ProjectLocal:SW_Cutout" H 8600 1650 50  0001 C CNN
F 3 "~" H 8600 1650 50  0001 C CNN
	1    8600 1450
	1    0    0    -1  
$EndComp
$EndSCHEMATC
