EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Reversible Split Keyboard Half"
Date "2021-02-24"
Rev "2021.1"
Comp "Richard Goulter"
Comment1 ""
Comment2 "TRRS Jacks connected to UART or I2C."
Comment3 "Switch \"matrix\" is a collection of switches, each directly connected to the controller."
Comment4 "Split keyboard half for the WeAct Studio MiniF4 dev board."
$EndDescr
Text Label 900  7200 2    50   ~ 0
SCL_TX
Text Label 900  7300 2    50   ~ 0
SDA_RX
$Comp
L Jumper:SolderJumper_3_Open JP_TRRS_1
U 1 1 60FF4E5E
P 4250 6900
F 0 "JP_TRRS_1" V 4250 6968 50  0000 L CNN
F 1 "SolderJumper_3_Open" V 4295 6968 50  0001 L CNN
F 2 "Jumper:SolderJumper-3_P1.3mm_Open_Pad1.0x1.5mm_NumberLabels" H 4250 6900 50  0001 C CNN
F 3 "~" H 4250 6900 50  0001 C CNN
	1    4250 6900
	0    1    1    0   
$EndComp
$Comp
L Jumper:SolderJumper_3_Open JP_TRRS_2
U 1 1 60FF5D91
P 4250 7450
F 0 "JP_TRRS_2" V 4250 7518 50  0000 L CNN
F 1 "SolderJumper_3_Open" V 4295 7518 50  0001 L CNN
F 2 "Jumper:SolderJumper-3_P1.3mm_Open_Pad1.0x1.5mm_NumberLabels" H 4250 7450 50  0001 C CNN
F 3 "~" H 4250 7450 50  0001 C CNN
	1    4250 7450
	0    1    1    0   
$EndComp
Text Label 4250 7250 0    50   ~ 0
SDA_RX_r
Text Label 4250 7650 0    50   ~ 0
SCL_TX_r
Wire Wire Line
	900  7300 1150 7300
Wire Wire Line
	900  7200 1300 7200
Wire Wire Line
	1150 7300 1150 7000
Connection ~ 1150 7300
Wire Wire Line
	1150 7300 1450 7300
Wire Wire Line
	1300 7200 1300 7000
Connection ~ 1300 7200
Wire Wire Line
	1300 7200 1450 7200
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
NoConn ~ 1150 850 
NoConn ~ 1150 2450
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
Text Label 1150 1950 2    50   ~ 0
SW24
Text Label 1150 1850 2    50   ~ 0
SW23
Text Label 1150 1750 2    50   ~ 0
SW22
Text Label 1150 2050 2    50   ~ 0
SW21
Text Label 2750 2450 0    50   ~ 0
SW15
Text Label 1150 1450 2    50   ~ 0
SW14
Text Label 1150 1350 2    50   ~ 0
SW13
Text Label 1150 1250 2    50   ~ 0
SW12
Text Label 1150 1150 2    50   ~ 0
SW11
NoConn ~ 2750 2750
NoConn ~ 1150 2750
NoConn ~ 1150 2650
NoConn ~ 1150 2550
NoConn ~ 2750 850 
Text Label 1150 2250 2    50   ~ 0
SDA_RX
Text Label 1150 2150 2    50   ~ 0
SCL_TX
Text Label 3000 7400 0    50   ~ 0
GND
Text Label 3000 7100 0    50   ~ 0
3V3
Text Label 1450 7100 2    50   ~ 0
3V3
Text Label 1450 7400 2    50   ~ 0
GND
Text Label 2750 1050 0    50   ~ 0
3V3
Text Label 2750 950  0    50   ~ 0
GND
$Comp
L Device:R R1
U 1 1 5FDD65E1
P 850 5900
F 0 "R1" H 920 5900 50  0000 L CNN
F 1 "2.2k - 10k" H 920 5855 50  0000 L TNN
F 2 "ProjectLocal:Resistor-Hybrid" V 780 5900 50  0001 C CNN
F 3 "~" H 850 5900 50  0001 C CNN
	1    850  5900
	1    0    0    -1  
$EndComp
Text Label 850  5750 1    50   ~ 0
3V3
Text Label 1500 5750 1    50   ~ 0
3V3
Text Label 1500 6050 3    50   ~ 0
TRRS_R2
Text Label 850  6050 3    50   ~ 0
TRRS_R1
$Comp
L Device:R R2
U 1 1 5FDD4F32
P 1500 5900
F 0 "R2" H 1570 5900 50  0000 L CNN
F 1 "2.2k - 10k" H 1570 5855 50  0000 L TNN
F 2 "ProjectLocal:Resistor-Hybrid" V 1430 5900 50  0001 C CNN
F 3 "~" H 1500 5900 50  0001 C CNN
	1    1500 5900
	1    0    0    -1  
$EndComp
Wire Notes Line
	4800 500  4800 7750
Wire Notes Line
	4800 2650 11200 2650
Wire Notes Line
	500  3350 4800 3350
Wire Notes Line
	500  5350 4800 5350
Text Label 6400 1950 3    50   ~ 0
GND
Text Label 7000 1950 3    50   ~ 0
GND
Text Label 7600 2450 3    50   ~ 0
GND
Text Label 8200 2450 3    50   ~ 0
GND
Text Label 8800 2450 3    50   ~ 0
GND
Connection ~ 7600 1450
Connection ~ 7600 1950
Wire Wire Line
	7600 1950 7600 1450
Connection ~ 8800 1950
Wire Wire Line
	8800 1950 8800 2450
Connection ~ 8800 1450
Wire Wire Line
	8800 1450 8800 1950
Wire Wire Line
	8800 950  8800 1450
Connection ~ 8200 1450
Wire Wire Line
	8200 1450 8200 950 
Connection ~ 8200 1950
Wire Wire Line
	8200 1950 8200 1450
Wire Wire Line
	8200 2450 8200 1950
Wire Wire Line
	7600 1950 7600 2450
Wire Wire Line
	7600 950  7600 1450
Connection ~ 7000 1450
Wire Wire Line
	7000 1450 7000 950 
Wire Wire Line
	7000 1950 7000 1450
Connection ~ 6400 1450
Wire Wire Line
	6400 1950 6400 1450
Wire Wire Line
	6400 950  6400 1450
Text Label 8400 2450 1    50   ~ 0
SW43
Text Label 8400 1950 1    50   ~ 0
SW35
Text Label 8400 1450 1    50   ~ 0
SW25
Text Label 8400 950  1    50   ~ 0
SW15
Text Label 7800 950  1    50   ~ 0
SW14
Text Label 7800 1450 1    50   ~ 0
SW24
Text Label 7800 1950 1    50   ~ 0
SW34
Text Label 7800 2450 1    50   ~ 0
SW42
Text Label 7200 2450 1    50   ~ 0
SW41
Text Label 7200 1950 1    50   ~ 0
SW33
Text Label 7200 1450 1    50   ~ 0
SW23
Text Label 7200 950  1    50   ~ 0
SW13
Text Label 6600 1950 1    50   ~ 0
SW32
Text Label 6600 1450 1    50   ~ 0
SW22
Text Label 6600 950  1    50   ~ 0
SW12
Text Label 6000 1950 1    50   ~ 0
SW31
Text Label 6000 1450 1    50   ~ 0
SW21
Text Label 6000 950  1    50   ~ 0
SW11
$Comp
L Switch:SW_Push SW_31
U 1 1 5FDE5173
P 6200 1950
F 0 "SW_31" H 6200 2235 50  0000 C CNN
F 1 "SW_Push" H 6200 2144 50  0000 C CNN
F 2 "keyswitches:SW_MX_reversible" H 6200 2150 50  0001 C CNN
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
F 2 "keyswitches:SW_MX_reversible" H 8000 2150 50  0001 C CNN
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
F 2 "keyswitches:SW_MX_reversible" H 7400 2150 50  0001 C CNN
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
F 2 "keyswitches:SW_MX_reversible" H 6800 2150 50  0001 C CNN
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
F 2 "keyswitches:SW_MX_reversible" H 6800 1650 50  0001 C CNN
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
F 2 "keyswitches:SW_MX_reversible" H 7400 1650 50  0001 C CNN
F 3 "~" H 7400 1650 50  0001 C CNN
	1    7400 1450
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_24
U 1 1 5FDF0DF7
P 8000 1450
F 0 "SW_24" H 8000 1735 50  0000 C CNN
F 1 "SW_Push" H 8000 1644 50  0000 C CNN
F 2 "keyswitches:SW_MX_reversible" H 8000 1650 50  0001 C CNN
F 3 "~" H 8000 1650 50  0001 C CNN
	1    8000 1450
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_41
U 1 1 5FDF0949
P 7400 2450
F 0 "SW_41" H 7400 2735 50  0000 C CNN
F 1 "SW_Push" H 7400 2644 50  0000 C CNN
F 2 "keyswitches:SW_MX_reversible" H 7400 2650 50  0001 C CNN
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
F 2 "keyswitches:SW_MX_reversible" H 8000 2650 50  0001 C CNN
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
F 2 "keyswitches:SW_MX_reversible" H 8600 2650 50  0001 C CNN
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
F 2 "keyswitches:SW_MX_reversible" H 8600 2150 50  0001 C CNN
F 3 "~" H 8600 2150 50  0001 C CNN
	1    8600 1950
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_25
U 1 1 5FDEE777
P 8600 1450
F 0 "SW_25" H 8600 1735 50  0000 C CNN
F 1 "SW_Push" H 8600 1644 50  0000 C CNN
F 2 "keyswitches:SW_MX_reversible" H 8600 1650 50  0001 C CNN
F 3 "~" H 8600 1650 50  0001 C CNN
	1    8600 1450
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_15
U 1 1 5FDED702
P 8600 950
F 0 "SW_15" H 8600 1235 50  0000 C CNN
F 1 "SW_Push" H 8600 1144 50  0000 C CNN
F 2 "keyswitches:SW_MX_reversible" H 8600 1150 50  0001 C CNN
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
F 2 "keyswitches:SW_MX_reversible" H 8000 1150 50  0001 C CNN
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
F 2 "keyswitches:SW_MX_reversible" H 7400 1150 50  0001 C CNN
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
F 2 "keyswitches:SW_MX_reversible" H 6800 1150 50  0001 C CNN
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
F 2 "keyswitches:SW_MX_reversible" H 6200 1650 50  0001 C CNN
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
F 2 "keyswitches:SW_MX_reversible" H 6200 1150 50  0001 C CNN
F 3 "~" H 6200 1150 50  0001 C CNN
	1    6200 950 
	1    0    0    -1  
$EndComp
Text Notes 9100 950  0    50   ~ 0
Grid of switches for the PCB half.\n\nEach switch is connected directly to\na pin of the microcontroller, and to GND.
Text Notes 3150 1400 0    50   ~ 0
The WeAct Studo MiniF4 dev board.
NoConn ~ 2750 1250
NoConn ~ 1150 1550
NoConn ~ 1150 1650
NoConn ~ 1150 2350
NoConn ~ 2750 2150
NoConn ~ 1150 950 
NoConn ~ 1150 1050
$Comp
L Mechanical:MountingHole H1
U 1 1 602E59E6
P 1050 3800
F 0 "H1" H 1150 3846 50  0000 L CNN
F 1 "MountingHole" H 1150 3755 50  0000 L CNN
F 2 "ProjectLocal:Bumpon_3M_F0502" H 1050 3800 50  0001 C CNN
F 3 "~" H 1050 3800 50  0001 C CNN
	1    1050 3800
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 602EA31E
P 1050 4000
F 0 "H2" H 1150 4046 50  0000 L CNN
F 1 "MountingHole" H 1150 3955 50  0000 L CNN
F 2 "ProjectLocal:Bumpon_3M_F0502" H 1050 4000 50  0001 C CNN
F 3 "~" H 1050 4000 50  0001 C CNN
	1    1050 4000
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 602EA63D
P 1050 4200
F 0 "H3" H 1150 4246 50  0000 L CNN
F 1 "MountingHole" H 1150 4155 50  0000 L CNN
F 2 "ProjectLocal:Bumpon_3M_F0502" H 1050 4200 50  0001 C CNN
F 3 "~" H 1050 4200 50  0001 C CNN
	1    1050 4200
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H4
U 1 1 602EA8E5
P 1050 4400
F 0 "H4" H 1150 4446 50  0000 L CNN
F 1 "MountingHole" H 1150 4355 50  0000 L CNN
F 2 "ProjectLocal:Bumpon_3M_F0502" H 1050 4400 50  0001 C CNN
F 3 "~" H 1050 4400 50  0001 C CNN
	1    1050 4400
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H5
U 1 1 602EEB15
P 1050 4600
F 0 "H5" H 1150 4646 50  0000 L CNN
F 1 "MountingHole" H 1150 4555 50  0000 L CNN
F 2 "ProjectLocal:Bumpon_3M_F0502" H 1050 4600 50  0001 C CNN
F 3 "~" H 1050 4600 50  0001 C CNN
	1    1050 4600
	1    0    0    -1  
$EndComp
Text Label 4250 7100 0    50   ~ 0
SDA_RX_r
Text Label 4050 7350 1    50   ~ 0
TRRS_R1
Text Label 1300 7000 1    50   ~ 0
TRRS_R2
Text Label 1150 7000 1    50   ~ 0
TRRS_R1
Text Label 4250 6700 0    50   ~ 0
SCL_TX_r
Text Label 3000 7200 0    50   ~ 0
SCL_TX_r
Text Label 3000 7300 0    50   ~ 0
SDA_RX_r
Text Label 3950 6900 2    50   ~ 0
SCL_TX
Text Label 3950 7450 2    50   ~ 0
SDA_RX
Wire Wire Line
	4100 6900 4050 6900
Wire Wire Line
	4100 7450 4050 7450
Text Label 4050 6800 1    50   ~ 0
TRRS_R2
Text Notes 2400 6350 0    50   ~ 0
The TRRS jacks for connecting the two PCB halves.\n\nOnly one-of J1 or J_1_r assembled depending on\nwhether PCB is left or right half.\n\nResistors pull the data inputs up so that the PCB half\ncan be used without the other half being connected.\n\nJumpers used to allow either PB6, PB7 of the left half\nto connect to PB6, PB7 or to PB7, PB6 of the right half.
Wire Wire Line
	4050 6800 4050 6900
Connection ~ 4050 6900
Wire Wire Line
	4050 6900 3950 6900
Wire Wire Line
	4050 7350 4050 7450
Connection ~ 4050 7450
Wire Wire Line
	4050 7450 3950 7450
NoConn ~ 2750 2350
$Comp
L Mechanical:MountingHole H6
U 1 1 603C44C9
P 1900 3800
F 0 "H6" H 2000 3846 50  0000 L CNN
F 1 "MountingHole" H 2000 3755 50  0000 L CNN
F 2 "ProjectLocal:H_M2_Spacer_Hole" H 1900 3800 50  0001 C CNN
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
F 2 "ProjectLocal:H_M2_Spacer_Hole" H 1900 4000 50  0001 C CNN
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
F 2 "ProjectLocal:H_M2_Spacer_Hole" H 1900 4200 50  0001 C CNN
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
F 2 "ProjectLocal:H_M2_Spacer_Hole" H 1900 4400 50  0001 C CNN
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
F 2 "ProjectLocal:H_M2_Spacer_Hole" H 1900 4600 50  0001 C CNN
F 3 "~" H 1900 4600 50  0001 C CNN
	1    1900 4600
	1    0    0    -1  
$EndComp
NoConn ~ 2750 2250
$EndSCHEMATC
