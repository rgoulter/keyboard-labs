EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A3 16535 11693
encoding utf-8
Sheet 1 1
Title "Reversible Split Keyboard Half"
Date "2021-05-21"
Rev "2021.5"
Comp "Richard Goulter"
Comment1 "SK6812mini-e used for per-key RGBs. SK6812 for underglow."
Comment2 "TRRS Jacks connected to UART or I2C."
Comment3 "Switch \"matrix\" is a collection of switches, each directly connected to the controller."
Comment4 "Split keyboard half for the WeAct Studio MiniF4 dev board."
$EndDescr
$Comp
L LED:WS2812B D_21
U 1 1 5FE09A18
P 4100 5850
F 0 "D_21" H 4444 5896 50  0000 R BNN
F 1 "SK6812mini-e" H 4444 5805 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 4150 5550 50  0001 L TNN
F 3 "" H 4200 5475 50  0001 L TNN
F 4 "" H 4100 5850 50  0001 C CNN "fit_variant"
F 5 "-basic" H 4100 5850 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 4100 5850 50  0001 C CNN "Comment"
F 7 "RGB LED" H 4100 5850 50  0001 C CNN "Description"
	1    4100 5850
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_22
U 1 1 5FE0A54D
P 4700 5850
F 0 "D_22" H 5044 5896 50  0000 R BNN
F 1 "SK6812mini-e" H 5044 5805 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 4750 5550 50  0001 L TNN
F 3 "" H 4800 5475 50  0001 L TNN
F 4 "" H 4700 5850 50  0001 C CNN "fit_variant"
F 5 "-basic" H 4700 5850 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 4700 5850 50  0001 C CNN "Comment"
F 7 "RGB LED" H 4700 5850 50  0001 C CNN "Description"
	1    4700 5850
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_23
U 1 1 5FE0AEAE
P 5300 5850
F 0 "D_23" H 5644 5896 50  0000 R BNN
F 1 "SK6812mini-e" H 5644 5805 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 5350 5550 50  0001 L TNN
F 3 "" H 5400 5475 50  0001 L TNN
F 4 "" H 5300 5850 50  0001 C CNN "fit_variant"
F 5 "-basic" H 5300 5850 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 5300 5850 50  0001 C CNN "Comment"
F 7 "RGB LED" H 5300 5850 50  0001 C CNN "Description"
	1    5300 5850
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_24
U 1 1 5FE0B5ED
P 5900 5850
F 0 "D_24" H 6244 5896 50  0000 R BNN
F 1 "SK6812mini-e" H 6244 5805 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 5950 5550 50  0001 L TNN
F 3 "" H 6000 5475 50  0001 L TNN
F 4 "" H 5900 5850 50  0001 C CNN "fit_variant"
F 5 "-basic" H 5900 5850 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 5900 5850 50  0001 C CNN "Comment"
F 7 "RGB LED" H 5900 5850 50  0001 C CNN "Description"
	1    5900 5850
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_31
U 1 1 5FE12EFC
P 4100 6550
F 0 "D_31" H 4444 6596 50  0000 R BNN
F 1 "SK6812mini-e" H 4444 6505 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 4150 6250 50  0001 L TNN
F 3 "" H 4200 6175 50  0001 L TNN
F 4 "" H 4100 6550 50  0001 C CNN "fit_variant"
F 5 "-basic" H 4100 6550 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 4100 6550 50  0001 C CNN "Comment"
F 7 "RGB LED" H 4100 6550 50  0001 C CNN "Description"
	1    4100 6550
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_32
U 1 1 5FE13A31
P 4700 6550
F 0 "D_32" H 5044 6596 50  0000 R BNN
F 1 "SK6812mini-e" H 5044 6505 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 4750 6250 50  0001 L TNN
F 3 "" H 4800 6175 50  0001 L TNN
F 4 "" H 4700 6550 50  0001 C CNN "fit_variant"
F 5 "-basic" H 4700 6550 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 4700 6550 50  0001 C CNN "Comment"
F 7 "RGB LED" H 4700 6550 50  0001 C CNN "Description"
	1    4700 6550
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_33
U 1 1 5FE1469E
P 5300 6550
F 0 "D_33" H 5644 6596 50  0000 R BNN
F 1 "SK6812mini-e" H 5644 6505 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 5350 6250 50  0001 L TNN
F 3 "" H 5400 6175 50  0001 L TNN
F 4 "" H 5300 6550 50  0001 C CNN "fit_variant"
F 5 "-basic" H 5300 6550 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 5300 6550 50  0001 C CNN "Comment"
F 7 "RGB LED" H 5300 6550 50  0001 C CNN "Description"
	1    5300 6550
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_34
U 1 1 5FE15110
P 5900 6550
F 0 "D_34" H 6244 6596 50  0000 R BNN
F 1 "SK6812mini-e" H 6244 6505 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 5950 6250 50  0001 L TNN
F 3 "" H 6000 6175 50  0001 L TNN
F 4 "" H 5900 6550 50  0001 C CNN "fit_variant"
F 5 "-basic" H 5900 6550 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 5900 6550 50  0001 C CNN "Comment"
F 7 "RGB LED" H 5900 6550 50  0001 C CNN "Description"
	1    5900 6550
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_35
U 1 1 5FE15BD0
P 6500 6550
F 0 "D_35" H 6844 6596 50  0000 R BNN
F 1 "SK6812mini-e" H 6844 6505 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 6550 6250 50  0001 L TNN
F 3 "" H 6600 6175 50  0001 L TNN
F 4 "" H 6500 6550 50  0001 C CNN "fit_variant"
F 5 "-basic" H 6500 6550 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 6500 6550 50  0001 C CNN "Comment"
F 7 "RGB LED" H 6500 6550 50  0001 C CNN "Description"
	1    6500 6550
	1    0    0    -1  
$EndComp
Text Label 8800 2250 2    50   ~ 0
SCL_TX
Text Label 8800 2350 2    50   ~ 0
SDA_RX
Text Label 6800 5150 3    50   ~ 0
DOUT_1
Text Label 3800 5850 1    50   ~ 0
DOUT_1
Text Label 6800 5850 3    50   ~ 0
DOUT_2
Text Label 3800 6550 1    50   ~ 0
DOUT_2
Text Label 6800 6550 3    50   ~ 0
DOUT_3
$Comp
L Device:C_Small C_21
U 1 1 604CF796
P 8850 5300
F 0 "C_21" V 8713 5300 50  0000 C BNN
F 1 "100nF" V 8712 5300 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 8850 5300 50  0001 C CNN
F 3 "~" H 8850 5300 50  0001 C CNN
F 4 "" V 8850 5300 50  0001 C CNN "fit_variant"
F 5 "-basic" H 8850 5300 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 8850 5300 50  0001 C CNN "Comment"
F 7 "Capacitor (Through-hole or 0805)" H 8850 5300 50  0001 C CNN "Description"
	1    8850 5300
	0    1    1    0   
$EndComp
Wire Wire Line
	6500 5550 5900 5550
Wire Wire Line
	5900 5550 5300 5550
Connection ~ 5900 5550
Wire Wire Line
	5300 5550 4700 5550
Connection ~ 5300 5550
Wire Wire Line
	4700 5550 4100 5550
Connection ~ 4700 5550
$Comp
L LED:WS2812B D_25
U 1 1 5FE0C1BE
P 6500 5850
F 0 "D_25" H 6844 5896 50  0000 R BNN
F 1 "SK6812mini-e" H 6844 5805 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 6550 5550 50  0001 L TNN
F 3 "" H 6600 5475 50  0001 L TNN
F 4 "" H 6500 5850 50  0001 C CNN "fit_variant"
F 5 "-basic" H 6500 5850 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 6500 5850 50  0001 C CNN "Comment"
F 7 "RGB LED" H 6500 5850 50  0001 C CNN "Description"
	1    6500 5850
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C_22
U 1 1 60572158
P 8850 5600
F 0 "C_22" V 8713 5600 50  0000 C BNN
F 1 "100nF" V 8712 5600 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 8850 5600 50  0001 C CNN
F 3 "~" H 8850 5600 50  0001 C CNN
F 4 "" V 8850 5600 50  0001 C CNN "fit_variant"
F 5 "-basic" H 8850 5600 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 8850 5600 50  0001 C CNN "Comment"
F 7 "Capacitor (Through-hole or 0805)" H 8850 5600 50  0001 C CNN "Description"
	1    8850 5600
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_23
U 1 1 6057250D
P 8850 5900
F 0 "C_23" V 8713 5900 50  0000 C BNN
F 1 "100nF" V 8712 5900 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 8850 5900 50  0001 C CNN
F 3 "~" H 8850 5900 50  0001 C CNN
F 4 "" V 8850 5900 50  0001 C CNN "fit_variant"
F 5 "-basic" H 8850 5900 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 8850 5900 50  0001 C CNN "Comment"
F 7 "Capacitor (Through-hole or 0805)" H 8850 5900 50  0001 C CNN "Description"
	1    8850 5900
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_24
U 1 1 605729BF
P 8850 6200
F 0 "C_24" V 8713 6200 50  0000 C BNN
F 1 "100nF" V 8712 6200 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 8850 6200 50  0001 C CNN
F 3 "~" H 8850 6200 50  0001 C CNN
F 4 "" V 8850 6200 50  0001 C CNN "fit_variant"
F 5 "-basic" H 8850 6200 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 8850 6200 50  0001 C CNN "Comment"
F 7 "Capacitor (Through-hole or 0805)" H 8850 6200 50  0001 C CNN "Description"
	1    8850 6200
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_25
U 1 1 60572EE4
P 8850 6500
F 0 "C_25" V 8713 6500 50  0000 C BNN
F 1 "100nF" V 8712 6500 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 8850 6500 50  0001 C CNN
F 3 "~" H 8850 6500 50  0001 C CNN
F 4 "" V 8850 6500 50  0001 C CNN "fit_variant"
F 5 "-basic" H 8850 6500 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 8850 6500 50  0001 C CNN "Comment"
F 7 "Capacitor (Through-hole or 0805)" H 8850 6500 50  0001 C CNN "Description"
	1    8850 6500
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_41
U 1 1 605C286C
P 9500 5300
F 0 "C_41" V 9363 5300 50  0000 C BNN
F 1 "100nF" V 9362 5300 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 9500 5300 50  0001 C CNN
F 3 "~" H 9500 5300 50  0001 C CNN
F 4 "" V 9500 5300 50  0001 C CNN "fit_variant"
F 5 "-basic" H 9500 5300 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 9500 5300 50  0001 C CNN "Comment"
F 7 "Capacitor (Through-hole or 0805)" H 9500 5300 50  0001 C CNN "Description"
	1    9500 5300
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_32
U 1 1 605C3368
P 9200 5600
F 0 "C_32" V 9063 5600 50  0000 C BNN
F 1 "100nF" V 9062 5600 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 9200 5600 50  0001 C CNN
F 3 "~" H 9200 5600 50  0001 C CNN
F 4 "" V 9200 5600 50  0001 C CNN "fit_variant"
F 5 "-basic" H 9200 5600 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 9200 5600 50  0001 C CNN "Comment"
F 7 "Capacitor (Through-hole or 0805)" H 9200 5600 50  0001 C CNN "Description"
	1    9200 5600
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_33
U 1 1 605C388D
P 9200 5900
F 0 "C_33" V 9063 5900 50  0000 C BNN
F 1 "100nF" V 9062 5900 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 9200 5900 50  0001 C CNN
F 3 "~" H 9200 5900 50  0001 C CNN
F 4 "" V 9200 5900 50  0001 C CNN "fit_variant"
F 5 "-basic" H 9200 5900 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 9200 5900 50  0001 C CNN "Comment"
F 7 "Capacitor (Through-hole or 0805)" H 9200 5900 50  0001 C CNN "Description"
	1    9200 5900
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_34
U 1 1 605C3C2B
P 9200 6200
F 0 "C_34" V 9063 6200 50  0000 C BNN
F 1 "100nF" V 9062 6200 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 9200 6200 50  0001 C CNN
F 3 "~" H 9200 6200 50  0001 C CNN
F 4 "" V 9200 6200 50  0001 C CNN "fit_variant"
F 5 "-basic" H 9200 6200 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 9200 6200 50  0001 C CNN "Comment"
F 7 "Capacitor (Through-hole or 0805)" H 9200 6200 50  0001 C CNN "Description"
	1    9200 6200
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_35
U 1 1 605C4025
P 9200 6500
F 0 "C_35" V 9063 6500 50  0000 C BNN
F 1 "100nF" V 9062 6500 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 9200 6500 50  0001 C CNN
F 3 "~" H 9200 6500 50  0001 C CNN
F 4 "" V 9200 6500 50  0001 C CNN "fit_variant"
F 5 "-basic" H 9200 6500 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 9200 6500 50  0001 C CNN "Comment"
F 7 "Capacitor (Through-hole or 0805)" H 9200 6500 50  0001 C CNN "Description"
	1    9200 6500
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_42
U 1 1 605CBDEC
P 9500 5600
F 0 "C_42" V 9363 5600 50  0000 C BNN
F 1 "100nF" V 9362 5600 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 9500 5600 50  0001 C CNN
F 3 "~" H 9500 5600 50  0001 C CNN
F 4 "" V 9500 5600 50  0001 C CNN "fit_variant"
F 5 "-basic" H 9500 5600 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 9500 5600 50  0001 C CNN "Comment"
F 7 "Capacitor (Through-hole or 0805)" H 9500 5600 50  0001 C CNN "Description"
	1    9500 5600
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_43
U 1 1 605CC18A
P 9500 5900
F 0 "C_43" V 9363 5900 50  0000 C BNN
F 1 "100nF" V 9362 5900 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 9500 5900 50  0001 C CNN
F 3 "~" H 9500 5900 50  0001 C CNN
F 4 "" V 9500 5900 50  0001 C CNN "fit_variant"
F 5 "-basic" H 9500 5900 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 9500 5900 50  0001 C CNN "Comment"
F 7 "Capacitor (Through-hole or 0805)" H 9500 5900 50  0001 C CNN "Description"
	1    9500 5900
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_31
U 1 1 60618AAF
P 9200 5300
F 0 "C_31" V 9063 5300 50  0000 C BNN
F 1 "100nF" V 9062 5300 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 9200 5300 50  0001 C CNN
F 3 "~" H 9200 5300 50  0001 C CNN
F 4 "" V 9200 5300 50  0001 C CNN "fit_variant"
F 5 "-basic" H 9200 5300 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 9200 5300 50  0001 C CNN "Comment"
F 7 "Capacitor (Through-hole or 0805)" H 9200 5300 50  0001 C CNN "Description"
	1    9200 5300
	0    1    1    0   
$EndComp
Wire Wire Line
	3700 5550 4100 5550
Connection ~ 4100 5550
Wire Wire Line
	6500 6250 5900 6250
Wire Wire Line
	5300 6250 5900 6250
Connection ~ 5900 6250
Wire Wire Line
	5300 6250 4700 6250
Connection ~ 5300 6250
Wire Wire Line
	4700 6250 4100 6250
Connection ~ 4700 6250
Wire Wire Line
	4100 6250 3700 6250
Connection ~ 4100 6250
$Comp
L Device:R R4
U 1 1 60D9AF80
P 3500 5000
F 0 "R4" H 3430 5046 50  0000 R CNN
F 1 "300 - 500R" V 3400 5000 50  0000 R CNN
F 2 "ProjectLocal:Resistor-Hybrid_Reversible" V 3430 5000 50  0001 C CNN
F 3 "~" H 3500 5000 50  0001 C CNN
F 4 "" H 3500 5000 50  0001 C CNN "fit_variant"
F 5 "-basic" H 3500 5000 50  0001 C CNN "fit_field"
F 6 "For RGB LEDs" H 3500 5000 50  0001 C CNN "Comment"
F 7 "Resistor (1/4W through-hole, or 0805)" H 3500 5000 50  0001 C CNN "Description"
	1    3500 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	3500 5150 3800 5150
$Comp
L Jumper:SolderJumper_3_Open JP4
U 1 1 60FF4E5E
P 11950 1950
F 0 "JP4" V 11950 2018 50  0000 L CNN
F 1 "SolderJumper_3_Open" V 11995 2018 50  0001 L CNN
F 2 "Jumper:SolderJumper-3_P1.3mm_Open_Pad1.0x1.5mm_NumberLabels" H 11950 1950 50  0001 C CNN
F 3 "~" H 11950 1950 50  0001 C CNN
F 4 "Solder depending on firmware's split transportation" H 11950 1950 50  0001 C CNN "Comment"
F 5 "Solder Jumper" H 11950 1950 50  0001 C CNN "Description"
	1    11950 1950
	0    1    1    0   
$EndComp
$Comp
L Jumper:SolderJumper_3_Open JP5
U 1 1 60FF5D91
P 11950 2550
F 0 "JP5" V 11950 2618 50  0000 L CNN
F 1 "SolderJumper_3_Open" V 11995 2618 50  0001 L CNN
F 2 "Jumper:SolderJumper-3_P1.3mm_Open_Pad1.0x1.5mm_NumberLabels" H 11950 2550 50  0001 C CNN
F 3 "~" H 11950 2550 50  0001 C CNN
F 4 "Solder depending on firmware's split transportation" H 11950 2550 50  0001 C CNN "Comment"
F 5 "Solder Jumper" H 11950 2550 50  0001 C CNN "Description"
	1    11950 2550
	0    1    1    0   
$EndComp
Text Label 12100 2350 0    50   ~ 0
SDA_RX_r
Text Label 12100 2750 0    50   ~ 0
SCL_TX_r
Text Label 3700 4750 0    50   ~ 0
5V
Text Label 6850 7750 2    50   ~ 0
GND
Wire Wire Line
	8800 2350 9050 2350
Wire Wire Line
	8800 2250 9200 2250
Wire Wire Line
	9050 2350 9050 2050
Connection ~ 9050 2350
Wire Wire Line
	9050 2350 9350 2350
Wire Wire Line
	9200 2250 9200 2050
Connection ~ 9200 2250
Wire Wire Line
	9200 2250 9350 2250
$Comp
L keebio:TRRS J1
U 1 1 5FDF9ACF
P 9700 2550
F 0 "J1" H 9928 2853 60  0000 L CNN
F 1 "PJ-320A" H 9928 2747 60  0000 L CNN
F 2 "Keebio-Parts:TRRS-PJ-320A" H 9850 2550 60  0001 C CNN
F 3 "" H 9850 2550 60  0001 C CNN
F 4 "" H 9700 2550 50  0001 C CNN "Comment"
F 5 "TRRS (4-pole) Jack" H 9700 2550 50  0001 C CNN "Description"
	1    9700 2550
	1    0    0    -1  
$EndComp
$Comp
L keebio:TRRS J2
U 1 1 5FDFA2E7
P 10550 2550
F 0 "J2" H 10467 3237 60  0000 C CNN
F 1 "PJ-320A" H 10467 3131 60  0000 C CNN
F 2 "Keebio-Parts:TRRS-PJ-320A" H 10700 2550 60  0001 C CNN
F 3 "" H 10700 2550 60  0001 C CNN
F 4 "" H 10550 2550 50  0001 C CNN "Comment"
F 5 "TRRS (4-pole) Jack" H 10550 2550 50  0001 C CNN "Description"
	1    10550 2550
	-1   0    0    -1  
$EndComp
NoConn ~ 2600 2750
NoConn ~ 2600 2850
Text Label 2600 2950 0    50   ~ 0
SW43
Text Label 2600 2550 0    50   ~ 0
SW42
Text Label 2600 2350 0    50   ~ 0
SW41
Text Label 1000 2350 2    50   ~ 0
SW35
Text Label 2600 2150 0    50   ~ 0
SW34
Text Label 2600 1950 0    50   ~ 0
SW33
Text Label 2600 1650 0    50   ~ 0
SW32
Text Label 1000 1350 2    50   ~ 0
SW31
Text Label 1000 2050 2    50   ~ 0
SW24
Text Label 1000 1550 2    50   ~ 0
SW22
Text Label 1000 1250 2    50   ~ 0
SW21
Text Label 1000 2150 2    50   ~ 0
SW15
Text Label 2600 2050 0    50   ~ 0
SW14
Text Label 1000 1650 2    50   ~ 0
SW13
Text Label 1000 1150 2    50   ~ 0
SW11
NoConn ~ 2600 3050
Text Label 1000 2550 2    50   ~ 0
SDA_RX
Text Label 1000 2450 2    50   ~ 0
SCL_TX
Wire Wire Line
	3700 4750 3700 4850
Text Label 10900 2450 0    50   ~ 0
GND
Text Label 10900 2150 0    50   ~ 0
5V
Text Label 9350 2150 2    50   ~ 0
5V
Text Label 9350 2450 2    50   ~ 0
GND
Text Label 2600 1350 0    50   ~ 0
3V3
Text Label 2600 1250 0    50   ~ 0
GND
Text Label 5750 2400 3    50   ~ 0
GND
Text Label 6350 2400 3    50   ~ 0
GND
Text Label 6950 2900 3    50   ~ 0
GND
Text Label 7550 2900 3    50   ~ 0
GND
Text Label 8150 2900 3    50   ~ 0
GND
Connection ~ 6950 1900
Connection ~ 6950 2400
Wire Wire Line
	6950 2400 6950 1900
Connection ~ 8150 2400
Wire Wire Line
	8150 2400 8150 2900
Connection ~ 8150 1900
Wire Wire Line
	8150 1900 8150 2400
Wire Wire Line
	8150 1400 8150 1900
Connection ~ 7550 1900
Wire Wire Line
	7550 1900 7550 1400
Connection ~ 7550 2400
Wire Wire Line
	7550 2400 7550 1900
Wire Wire Line
	7550 2900 7550 2400
Wire Wire Line
	6950 2400 6950 2900
Wire Wire Line
	6950 1400 6950 1900
Connection ~ 6350 1900
Wire Wire Line
	6350 1900 6350 1400
Wire Wire Line
	6350 2400 6350 1900
Connection ~ 5750 1900
Wire Wire Line
	5750 2400 5750 1900
Wire Wire Line
	5750 1400 5750 1900
Text Label 7750 2900 1    50   ~ 0
SW43
Text Label 7750 2400 1    50   ~ 0
SW35
Text Label 7750 1900 1    50   ~ 0
SW25
Text Label 7750 1400 1    50   ~ 0
SW15
Text Label 7150 1400 1    50   ~ 0
SW14
Text Label 7150 1900 1    50   ~ 0
SW24
Text Label 7150 2400 1    50   ~ 0
SW34
Text Label 7150 2900 1    50   ~ 0
SW42
Text Label 6550 2900 1    50   ~ 0
SW41
Text Label 6550 2400 1    50   ~ 0
SW33
Text Label 6550 1900 1    50   ~ 0
SW23
Text Label 6550 1400 1    50   ~ 0
SW13
Text Label 5950 2400 1    50   ~ 0
SW32
Text Label 5950 1900 1    50   ~ 0
SW22
Text Label 5950 1400 1    50   ~ 0
SW12
Text Label 5350 2400 1    50   ~ 0
SW31
Text Label 5350 1900 1    50   ~ 0
SW21
Text Label 5350 1400 1    50   ~ 0
SW11
$Comp
L Switch:SW_Push SW_31
U 1 1 5FDE5173
P 5550 2400
F 0 "SW_31" H 5550 2685 50  0000 C CNN
F 1 "MX-compatible or Kailh Choc v1" H 5550 2594 50  0000 C CNN
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 5550 2600 50  0001 C CNN
F 3 "~" H 5550 2600 50  0001 C CNN
F 4 "Mechanical Keyboard switches" H 5550 2400 50  0001 C CNN "Description"
	1    5550 2400
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_34
U 1 1 5FDF323B
P 7350 2400
F 0 "SW_34" H 7350 2685 50  0000 C CNN
F 1 "MX-compatible or Kailh Choc v1" H 7350 2594 50  0000 C CNN
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 7350 2600 50  0001 C CNN
F 3 "~" H 7350 2600 50  0001 C CNN
F 4 "Mechanical Keyboard switches" H 7350 2400 50  0001 C CNN "Description"
	1    7350 2400
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_33
U 1 1 5FDF2DC3
P 6750 2400
F 0 "SW_33" H 6750 2685 50  0000 C CNN
F 1 "MX-compatible or Kailh Choc v1" H 6750 2594 50  0000 C CNN
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 6750 2600 50  0001 C CNN
F 3 "~" H 6750 2600 50  0001 C CNN
F 4 "Mechanical Keyboard switches" H 6750 2400 50  0001 C CNN "Description"
	1    6750 2400
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_32
U 1 1 5FDF2621
P 6150 2400
F 0 "SW_32" H 6150 2685 50  0000 C CNN
F 1 "MX-compatible or Kailh Choc v1" H 6150 2594 50  0000 C CNN
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 6150 2600 50  0001 C CNN
F 3 "~" H 6150 2600 50  0001 C CNN
F 4 "Mechanical Keyboard switches" H 6150 2400 50  0001 C CNN "Description"
	1    6150 2400
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_22
U 1 1 5FDF1BC1
P 6150 1900
F 0 "SW_22" H 6150 2185 50  0000 C CNN
F 1 "MX-compatible or Kailh Choc v1" H 6150 2094 50  0000 C CNN
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 6150 2100 50  0001 C CNN
F 3 "~" H 6150 2100 50  0001 C CNN
F 4 "Mechanical Keyboard switches" H 6150 1900 50  0001 C CNN "Description"
	1    6150 1900
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_23
U 1 1 5FDF1620
P 6750 1900
F 0 "SW_23" H 6750 2185 50  0000 C CNN
F 1 "MX-compatible or Kailh Choc v1" H 6750 2094 50  0000 C CNN
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 6750 2100 50  0001 C CNN
F 3 "~" H 6750 2100 50  0001 C CNN
F 4 "Mechanical Keyboard switches" H 6750 1900 50  0001 C CNN "Description"
	1    6750 1900
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_24
U 1 1 5FDF0DF7
P 7350 1900
F 0 "SW_24" H 7350 2185 50  0000 C CNN
F 1 "MX-compatible or Kailh Choc v1" H 7350 2094 50  0000 C CNN
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 7350 2100 50  0001 C CNN
F 3 "~" H 7350 2100 50  0001 C CNN
F 4 "Mechanical Keyboard switches" H 7350 1900 50  0001 C CNN "Description"
	1    7350 1900
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_41
U 1 1 5FDF0949
P 6750 2900
F 0 "SW_41" H 6750 3185 50  0000 C CNN
F 1 "MX-compatible or Kailh Choc v1" H 6750 3094 50  0000 C CNN
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 6750 3100 50  0001 C CNN
F 3 "~" H 6750 3100 50  0001 C CNN
F 4 "Mechanical Keyboard switches" H 6750 2900 50  0001 C CNN "Description"
	1    6750 2900
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_42
U 1 1 5FDF0012
P 7350 2900
F 0 "SW_42" H 7350 3185 50  0000 C CNN
F 1 "MX-compatible or Kailh Choc v1" H 7350 3094 50  0000 C CNN
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 7350 3100 50  0001 C CNN
F 3 "~" H 7350 3100 50  0001 C CNN
F 4 "Mechanical Keyboard switches" H 7350 2900 50  0001 C CNN "Description"
	1    7350 2900
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_43
U 1 1 5FDEF97E
P 7950 2900
F 0 "SW_43" H 7950 3185 50  0000 C CNN
F 1 "MX-compatible or Kailh Choc v1" H 7950 3094 50  0000 C CNN
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 7950 3100 50  0001 C CNN
F 3 "~" H 7950 3100 50  0001 C CNN
F 4 "Mechanical Keyboard switches" H 7950 2900 50  0001 C CNN "Description"
	1    7950 2900
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_35
U 1 1 5FDEF11F
P 7950 2400
F 0 "SW_35" H 7950 2685 50  0000 C CNN
F 1 "MX-compatible or Kailh Choc v1" H 7950 2594 50  0000 C CNN
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 7950 2600 50  0001 C CNN
F 3 "~" H 7950 2600 50  0001 C CNN
F 4 "Mechanical Keyboard switches" H 7950 2400 50  0001 C CNN "Description"
	1    7950 2400
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_25
U 1 1 5FDEE777
P 7950 1900
F 0 "SW_25" H 7950 2185 50  0000 C CNN
F 1 "MX-compatible or Kailh Choc v1" H 7950 2094 50  0000 C CNN
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 7950 2100 50  0001 C CNN
F 3 "~" H 7950 2100 50  0001 C CNN
F 4 "Mechanical Keyboard switches" H 7950 1900 50  0001 C CNN "Description"
	1    7950 1900
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_15
U 1 1 5FDED702
P 7950 1400
F 0 "SW_15" H 7950 1685 50  0000 C CNN
F 1 "MX-compatible or Kailh Choc v1" H 7950 1594 50  0000 C CNN
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 7950 1600 50  0001 C CNN
F 3 "~" H 7950 1600 50  0001 C CNN
F 4 "Mechanical Keyboard switches" H 7950 1400 50  0001 C CNN "Description"
	1    7950 1400
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_14
U 1 1 5FDECF29
P 7350 1400
F 0 "SW_14" H 7350 1685 50  0000 C CNN
F 1 "MX-compatible or Kailh Choc v1" H 7350 1594 50  0000 C CNN
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 7350 1600 50  0001 C CNN
F 3 "~" H 7350 1600 50  0001 C CNN
F 4 "Mechanical Keyboard switches" H 7350 1400 50  0001 C CNN "Description"
	1    7350 1400
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_13
U 1 1 5FDEC2EC
P 6750 1400
F 0 "SW_13" H 6750 1685 50  0000 C CNN
F 1 "MX-compatible or Kailh Choc v1" H 6750 1594 50  0000 C CNN
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 6750 1600 50  0001 C CNN
F 3 "~" H 6750 1600 50  0001 C CNN
F 4 "Mechanical Keyboard switches" H 6750 1400 50  0001 C CNN "Description"
	1    6750 1400
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_12
U 1 1 5FDEB649
P 6150 1400
F 0 "SW_12" H 6150 1685 50  0000 C CNN
F 1 "MX-compatible or Kailh Choc v1" H 6150 1594 50  0000 C CNN
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 6150 1600 50  0001 C CNN
F 3 "~" H 6150 1600 50  0001 C CNN
F 4 "Mechanical Keyboard switches" H 6150 1400 50  0001 C CNN "Description"
	1    6150 1400
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_21
U 1 1 5FDE48F6
P 5550 1900
F 0 "SW_21" H 5550 2185 50  0000 C CNN
F 1 "MX-compatible or Kailh Choc v1" H 5550 2094 50  0000 C CNN
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 5550 2100 50  0001 C CNN
F 3 "~" H 5550 2100 50  0001 C CNN
F 4 "Mechanical Keyboard switches" H 5550 1900 50  0001 C CNN "Description"
	1    5550 1900
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_11
U 1 1 5FD3A369
P 5550 1400
F 0 "SW_11" H 5550 1685 50  0000 C CNN
F 1 "MX-compatible or Kailh Choc v1" H 5550 1594 50  0000 C CNN
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 5550 1600 50  0001 C CNN
F 3 "~" H 5550 1600 50  0001 C CNN
F 4 "" H 5550 1400 50  0001 C CNN "fit_variant"
F 5 "Mechanical Keyboard switches" H 5550 1400 50  0001 C CNN "Description"
	1    5550 1400
	1    0    0    -1  
$EndComp
Text Notes 5300 850  0    50   ~ 0
Grid of switches for the PCB half.\n\nEach switch is connected directly to\na pad of the microcontroller development board, and to GND.
Text Notes 4050 4700 0    50   ~ 0
Grid of WS2812-compatible RGB LEDs,\narranged in the same order as the key switches.\n\nEach DOUT connects to the DIN of the next LED.
Text Notes 1200 800  0    50   ~ 0
Development Board,\nSTM32F103 "Blue Pill" or\nWeAct Studio MiniF4 "Black Pill"
$Comp
L Mechanical:MountingHole H1
U 1 1 602E59E6
P 13550 3050
F 0 "H1" H 13650 3096 50  0000 L CNN
F 1 "3M F0502" H 13650 3005 50  0000 L CNN
F 2 "ProjectLocal:Bumpon_3M_F0502" H 13550 3050 50  0001 C CNN
F 3 "~" H 13550 3050 50  0001 C CNN
F 4 "Can be larger if using bottom plate" H 13550 3050 50  0001 C CNN "Comment"
F 5 "Bumpons" H 13550 3050 50  0001 C CNN "Description"
	1    13550 3050
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 602EA31E
P 13550 3250
F 0 "H2" H 13650 3296 50  0000 L CNN
F 1 "3M F0502" H 13650 3205 50  0000 L CNN
F 2 "ProjectLocal:Bumpon_3M_F0502" H 13550 3250 50  0001 C CNN
F 3 "~" H 13550 3250 50  0001 C CNN
F 4 "Can be larger if using bottom plate" H 13550 3250 50  0001 C CNN "Comment"
F 5 "Bumpons" H 13550 3250 50  0001 C CNN "Description"
	1    13550 3250
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 602EA63D
P 13550 3450
F 0 "H3" H 13650 3496 50  0000 L CNN
F 1 "3M F0502" H 13650 3405 50  0000 L CNN
F 2 "ProjectLocal:Bumpon_3M_F0502" H 13550 3450 50  0001 C CNN
F 3 "~" H 13550 3450 50  0001 C CNN
F 4 "Can be larger if using bottom plate" H 13550 3450 50  0001 C CNN "Comment"
F 5 "Bumpons" H 13550 3450 50  0001 C CNN "Description"
	1    13550 3450
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H4
U 1 1 602EA8E5
P 13550 3650
F 0 "H4" H 13650 3696 50  0000 L CNN
F 1 "3M F0502" H 13650 3605 50  0000 L CNN
F 2 "ProjectLocal:Bumpon_3M_F0502" H 13550 3650 50  0001 C CNN
F 3 "~" H 13550 3650 50  0001 C CNN
F 4 "Can be larger if using bottom plate" H 13550 3650 50  0001 C CNN "Comment"
F 5 "Bumpons" H 13550 3650 50  0001 C CNN "Description"
	1    13550 3650
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H5
U 1 1 602EEB15
P 13550 3850
F 0 "H5" H 13650 3896 50  0000 L CNN
F 1 "3M F0502" H 13650 3805 50  0000 L CNN
F 2 "ProjectLocal:Bumpon_3M_F0502" H 13550 3850 50  0001 C CNN
F 3 "~" H 13550 3850 50  0001 C CNN
F 4 "Can be larger if using bottom plate" H 13550 3850 50  0001 C CNN "Comment"
F 5 "Bumpons" H 13550 3850 50  0001 C CNN "Description"
	1    13550 3850
	1    0    0    -1  
$EndComp
Text Label 11750 2450 2    50   ~ 0
TRRS_R1
Text Label 9200 2050 1    50   ~ 0
TRRS_R2
Text Label 9050 2050 1    50   ~ 0
TRRS_R1
Text Label 12100 1750 0    50   ~ 0
SCL_TX_r
Text Label 10900 2250 0    50   ~ 0
SCL_TX_r
Text Label 10900 2350 0    50   ~ 0
SDA_RX_r
Text Label 11650 1950 2    50   ~ 0
SCL_TX
Text Label 11650 2550 2    50   ~ 0
SDA_RX
Wire Wire Line
	11800 1950 11750 1950
Wire Wire Line
	11800 2550 11750 2550
Text Label 11750 1850 2    50   ~ 0
TRRS_R2
Text Notes 8400 1600 0    50   ~ 0
The TRRS jacks for connecting the two PCB halves.\n\nOnly one-of J1 or J2 assembled depending on\nwhether PCB is left or right half.\n\nResistors pull the data inputs up so that the PCB half\ncan be used without the other half being connected.\n\nJumpers JP4, JP5 used to allow either PB6, PB7 of the left half\nto connect to PB6, PB7 or to PB7, PB6 of the right half.\ni.e. jumping:\n closed 12: I2C with SCL<->SCL, SDA<->SDA; or\n closed 23: UART with TX->RX, RX<-TX.
Wire Wire Line
	11750 1850 11750 1950
Connection ~ 11750 1950
Wire Wire Line
	11750 1950 11650 1950
Wire Wire Line
	11750 2450 11750 2550
Connection ~ 11750 2550
Wire Wire Line
	11750 2550 11650 2550
$Comp
L Mechanical:MountingHole H6
U 1 1 603C44C9
P 14300 3050
F 0 "H6" H 14400 3096 50  0000 L CNN
F 1 "M2 Spacer" H 14400 3005 50  0000 L CNN
F 2 "ProjectLocal:H_M2_Spacer_Hole" H 14300 3050 50  0001 C CNN
F 3 "~" H 14300 3050 50  0001 C CNN
F 4 "Spacers" H 14300 3050 50  0001 C CNN "Description"
	1    14300 3050
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H7
U 1 1 603C4D5A
P 14300 3250
F 0 "H7" H 14400 3296 50  0000 L CNN
F 1 "M2 Spacer" H 14400 3205 50  0000 L CNN
F 2 "ProjectLocal:H_M2_Spacer_Hole" H 14300 3250 50  0001 C CNN
F 3 "~" H 14300 3250 50  0001 C CNN
F 4 "Spacers" H 14300 3250 50  0001 C CNN "Description"
	1    14300 3250
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H8
U 1 1 603C5079
P 14300 3450
F 0 "H8" H 14400 3496 50  0000 L CNN
F 1 "M2 Spacer" H 14400 3405 50  0000 L CNN
F 2 "ProjectLocal:H_M2_Spacer_Hole" H 14300 3450 50  0001 C CNN
F 3 "~" H 14300 3450 50  0001 C CNN
F 4 "Spacers" H 14300 3450 50  0001 C CNN "Description"
	1    14300 3450
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H9
U 1 1 603C53A9
P 14300 3650
F 0 "H9" H 14400 3696 50  0000 L CNN
F 1 "M2 Spacer" H 14400 3605 50  0000 L CNN
F 2 "ProjectLocal:H_M2_Spacer_Hole" H 14300 3650 50  0001 C CNN
F 3 "~" H 14300 3650 50  0001 C CNN
F 4 "Spacers" H 14300 3650 50  0001 C CNN "Description"
	1    14300 3650
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H10
U 1 1 603C55A7
P 14300 3850
F 0 "H10" H 14400 3896 50  0000 L CNN
F 1 "M2 Spacer" H 14400 3805 50  0000 L CNN
F 2 "ProjectLocal:H_M2_Spacer_Hole" H 14300 3850 50  0001 C CNN
F 3 "~" H 14300 3850 50  0001 C CNN
F 4 "Spacers" H 14300 3850 50  0001 C CNN "Description"
	1    14300 3850
	1    0    0    -1  
$EndComp
$Comp
L LED:SK6812 D_BL_1
U 1 1 603FF78B
P 7400 5700
F 0 "D_BL_1" V 7354 6044 50  0000 L CNN
F 1 "SK6812" V 7445 6044 50  0000 L CNN
F 2 "ProjectLocal:LED_SK6812_PLCC4_5.0x5.0mm_P3.2mm_Reversible" H 7450 5400 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/product-files/1138/SK6812+LED+datasheet+.pdf" H 7500 5325 50  0001 L TNN
F 4 "" V 7400 5700 50  0001 C CNN "fit_variant"
F 5 "-basic" H 7400 5700 50  0001 C CNN "fit_field"
F 6 "RGB LED" H 7400 5700 50  0001 C CNN "Description"
F 7 "For underglow RGB LEDs" H 7400 5700 50  0001 C CNN "Comment"
	1    7400 5700
	0    1    1    0   
$EndComp
$Comp
L LED:SK6812 D_BL_2
U 1 1 60401C03
P 7400 6300
F 0 "D_BL_2" V 7354 6644 50  0000 L CNN
F 1 "SK6812" V 7445 6644 50  0000 L CNN
F 2 "ProjectLocal:LED_SK6812_PLCC4_5.0x5.0mm_P3.2mm_Reversible" H 7450 6000 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/product-files/1138/SK6812+LED+datasheet+.pdf" H 7500 5925 50  0001 L TNN
F 4 "" V 7400 6300 50  0001 C CNN "fit_variant"
F 5 "-basic" H 7400 6300 50  0001 C CNN "fit_field"
F 6 "RGB LED" H 7400 6300 50  0001 C CNN "Description"
F 7 "For underglow RGB LEDs" H 7400 6300 50  0001 C CNN "Comment"
	1    7400 6300
	0    1    1    0   
$EndComp
$Comp
L LED:SK6812 D_BL_3
U 1 1 60409922
P 7400 6900
F 0 "D_BL_3" V 7354 7244 50  0000 L CNN
F 1 "SK6812" V 7445 7244 50  0000 L CNN
F 2 "ProjectLocal:LED_SK6812_PLCC4_5.0x5.0mm_P3.2mm_Reversible" H 7450 6600 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/product-files/1138/SK6812+LED+datasheet+.pdf" H 7500 6525 50  0001 L TNN
F 4 "" V 7400 6900 50  0001 C CNN "fit_variant"
F 5 "-basic" H 7400 6900 50  0001 C CNN "fit_field"
F 6 "RGB LED" H 7400 6900 50  0001 C CNN "Description"
F 7 "For underglow RGB LEDs" H 7400 6900 50  0001 C CNN "Comment"
	1    7400 6900
	0    1    1    0   
$EndComp
$Comp
L LED:SK6812 D_BL_4
U 1 1 6040B9B5
P 7400 7500
F 0 "D_BL_4" V 7354 7844 50  0000 L CNN
F 1 "SK6812" V 7445 7844 50  0000 L CNN
F 2 "ProjectLocal:LED_SK6812_PLCC4_5.0x5.0mm_P3.2mm_Reversible" H 7450 7200 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/product-files/1138/SK6812+LED+datasheet+.pdf" H 7500 7125 50  0001 L TNN
F 4 "" V 7400 7500 50  0001 C CNN "fit_variant"
F 5 "-basic" H 7400 7500 50  0001 C CNN "fit_field"
F 6 "RGB LED" H 7400 7500 50  0001 C CNN "Description"
F 7 "For underglow RGB LEDs" H 7400 7500 50  0001 C CNN "Comment"
	1    7400 7500
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_BL_1
U 1 1 6040C40C
P 9800 5300
F 0 "C_BL_1" V 9663 5300 50  0000 C BNN
F 1 "100nF" V 9662 5300 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 9800 5300 50  0001 C CNN
F 3 "~" H 9800 5300 50  0001 C CNN
F 4 "" V 9800 5300 50  0001 C CNN "fit_variant"
F 5 "-basic" H 9800 5300 50  0001 C CNN "fit_field"
F 6 "For underglow RGB LEDs" H 9800 5300 50  0001 C CNN "Comment"
F 7 "Capacitor (Through-hole or 0805)" H 9800 5300 50  0001 C CNN "Description"
	1    9800 5300
	0    -1   -1   0   
$EndComp
$Comp
L Device:C_Small C_BL_2
U 1 1 6040D1BF
P 9800 5600
F 0 "C_BL_2" V 9663 5600 50  0000 C BNN
F 1 "100nF" V 9662 5600 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 9800 5600 50  0001 C CNN
F 3 "~" H 9800 5600 50  0001 C CNN
F 4 "" V 9800 5600 50  0001 C CNN "fit_variant"
F 5 "-basic" H 9800 5600 50  0001 C CNN "fit_field"
F 6 "For underglow RGB LEDs" H 9800 5600 50  0001 C CNN "Comment"
F 7 "Capacitor (Through-hole or 0805)" H 9800 5600 50  0001 C CNN "Description"
	1    9800 5600
	0    -1   -1   0   
$EndComp
$Comp
L Device:C_Small C_BL_3
U 1 1 6040D6FB
P 9800 5900
F 0 "C_BL_3" V 9663 5900 50  0000 C BNN
F 1 "100nF" V 9662 5900 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 9800 5900 50  0001 C CNN
F 3 "~" H 9800 5900 50  0001 C CNN
F 4 "" V 9800 5900 50  0001 C CNN "fit_variant"
F 5 "-basic" H 9800 5900 50  0001 C CNN "fit_field"
F 6 "For underglow RGB LEDs" H 9800 5900 50  0001 C CNN "Comment"
F 7 "Capacitor (Through-hole or 0805)" H 9800 5900 50  0001 C CNN "Description"
	1    9800 5900
	0    -1   -1   0   
$EndComp
$Comp
L Device:C_Small C_BL_4
U 1 1 6040D957
P 9800 6200
F 0 "C_BL_4" V 9663 6200 50  0000 C BNN
F 1 "100nF" V 9662 6200 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 9800 6200 50  0001 C CNN
F 3 "~" H 9800 6200 50  0001 C CNN
F 4 "" V 9800 6200 50  0001 C CNN "fit_variant"
F 5 "-basic" H 9800 6200 50  0001 C CNN "fit_field"
F 6 "For underglow RGB LEDs" H 9800 6200 50  0001 C CNN "Comment"
F 7 "Capacitor (Through-hole or 0805)" H 9800 6200 50  0001 C CNN "Description"
	1    9800 6200
	0    -1   -1   0   
$EndComp
Text Label 7000 7700 0    50   ~ 0
GND
Text Label 7400 5400 0    50   ~ 0
DOUT_4
Text Label 7700 5500 0    50   ~ 0
5V
Wire Wire Line
	7100 7500 7000 7500
Wire Wire Line
	7700 5500 7700 5700
Wire Wire Line
	7700 5700 7700 6300
Connection ~ 7700 5700
Wire Wire Line
	7700 6300 7700 6900
Connection ~ 7700 6300
Wire Wire Line
	7700 6900 7700 7500
Connection ~ 7700 6900
Text Label 2600 1750 0    50   ~ 0
RGB_DIN_3V3
$Comp
L Connector:Conn_01x04_Female TP2
U 1 1 6044DBF5
P 11000 5900
F 0 "TP2" H 11028 5876 50  0000 L CNN
F 1 "Conn_01x04_Female" H 11028 5785 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 11000 5900 50  0001 C CNN
F 3 "~" H 11000 5900 50  0001 C CNN
F 4 "Testing Point" H 11000 5900 50  0001 C CNN "Description"
	1    11000 5900
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x04_Female TP1
U 1 1 6044A893
P 11000 5300
F 0 "TP1" H 11028 5276 50  0000 L CNN
F 1 "Conn_01x04_Female" H 11028 5185 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 11000 5300 50  0001 C CNN
F 3 "~" H 11000 5300 50  0001 C CNN
F 4 "Testing Point" H 11000 5300 50  0001 C CNN "Description"
	1    11000 5300
	1    0    0    -1  
$EndComp
Text Label 10800 5200 2    50   ~ 0
GND
Text Label 10800 5500 2    50   ~ 0
GND
Text Label 10800 5300 2    50   ~ 0
5V
Text Label 10800 5400 2    50   ~ 0
RGB_DIN_5V
Text Label 10800 5800 2    50   ~ 0
GND
Text Label 10800 6100 2    50   ~ 0
GND
Text Label 10800 5900 2    50   ~ 0
5V
Text Label 7400 7800 0    50   ~ 0
DOUT_BL
Text Label 10800 6000 2    50   ~ 0
DOUT_BL
Text Notes 550  4650 0    50   ~ 0
Convert the voltage of the RGB_DIN_3V3\nsignal to 5V so that the SK6812mini-e\nand SK6812 receive the RGB data reliably.
Text Label 12100 2150 0    50   ~ 0
SDA_RX_r
Wire Wire Line
	11950 1750 12100 1750
Wire Wire Line
	11950 2150 12100 2150
Wire Wire Line
	11950 2350 12100 2350
Wire Wire Line
	11950 2750 12100 2750
Text Label 850  8950 2    50   ~ 0
RE_A
Text Label 850  9150 2    50   ~ 0
RE_B
Text Label 850  9050 2    50   ~ 0
GND
Text Label 1450 8950 0    50   ~ 0
SW_RE
Text Label 1450 9150 0    50   ~ 0
GND
Text Label 2600 1850 0    50   ~ 0
SW_RE
Text Notes 13250 2800 0    50   ~ 0
Mechanical:\nH1-H5 for dwgs hints for bumpons  to aid PCB layout,\nH6-H10 for holes for M2 spacers (to allow for sandwich-style\ntop and bottom plates),\nH11-H13 M2 screws for an acrylic cover over the devboard/OLED.
Text Notes 600  8500 0    50   ~ 0
Rotary encoder + switch.
$Comp
L Device:Rotary_Encoder_Switch SW_RE1
U 1 1 604C2BC3
P 1150 9050
F 0 "SW_RE1" H 1150 9417 50  0000 C CNN
F 1 "Rotary_Encoder_Switch" H 1150 9326 50  0000 C CNN
F 2 "ProjectLocal:RotaryEncoder_Alps_EC11E-Switch_Vertical_H20mm_Reversible" H 1000 9210 50  0001 C CNN
F 3 "~" H 1150 9310 50  0001 C CNN
F 4 "-basic" H 1150 9050 50  0001 C CNN "fit_field"
F 5 "For Rotary Encoder" H 1150 9050 50  0001 C CNN "Comment"
F 6 "Rotary Encoder" H 1150 9050 50  0001 C CNN "Description"
	1    1150 9050
	1    0    0    -1  
$EndComp
Text Label 1000 2750 2    50   ~ 0
OLED_SDA
Text Label 1000 2650 2    50   ~ 0
OLED_SCL
$Comp
L Mechanical:MountingHole H11
U 1 1 6099ECA3
P 15050 3050
F 0 "H11" H 15150 3096 50  0000 L CNN
F 1 "M2 Spacer" H 15150 3005 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.2mm_M2_ISO7380_Pad" H 15050 3050 50  0001 C CNN
F 3 "~" H 15050 3050 50  0001 C CNN
F 4 "For cover plate" H 15050 3050 50  0001 C CNN "Comment"
F 5 "Spacers" H 15050 3050 50  0001 C CNN "Description"
	1    15050 3050
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H12
U 1 1 609A6D3B
P 15050 3250
F 0 "H12" H 15150 3296 50  0000 L CNN
F 1 "M2 Spacer" H 15150 3205 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.2mm_M2_ISO7380_Pad" H 15050 3250 50  0001 C CNN
F 3 "~" H 15050 3250 50  0001 C CNN
F 4 "For cover plate" H 15050 3250 50  0001 C CNN "Comment"
F 5 "Spacers" H 15050 3250 50  0001 C CNN "Description"
	1    15050 3250
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H13
U 1 1 609A70F3
P 15050 3450
F 0 "H13" H 15150 3496 50  0000 L CNN
F 1 "M2 Spacer" H 15150 3405 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.2mm_M2_ISO7380_Pad" H 15050 3450 50  0001 C CNN
F 3 "~" H 15050 3450 50  0001 C CNN
F 4 "For cover plate" H 15050 3450 50  0001 C CNN "Comment"
F 5 "Spacers" H 15050 3450 50  0001 C CNN "Description"
	1    15050 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	3700 4850 4100 4850
Connection ~ 5900 4850
Connection ~ 4700 4850
Connection ~ 5300 4850
Connection ~ 4100 4850
Wire Wire Line
	6500 4850 5900 4850
Wire Wire Line
	5300 4850 5900 4850
Wire Wire Line
	5300 4850 4700 4850
Wire Wire Line
	4700 4850 4100 4850
$Comp
L LED:WS2812B D_11
U 1 1 5FD534E8
P 4100 5150
F 0 "D_11" H 4444 5196 50  0000 R BNN
F 1 "SK6812mini-e" H 4444 5105 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 4150 4850 50  0001 L TNN
F 3 "" H 4200 4775 50  0001 L TNN
F 4 "" H 4100 5150 50  0001 C CNN "fit_variant"
F 5 "-basic" H 4100 5150 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 4100 5150 50  0001 C CNN "Comment"
F 7 "RGB LED" H 4100 5150 50  0001 C CNN "Description"
	1    4100 5150
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C_11
U 1 1 603D2DAA
P 8500 5300
F 0 "C_11" V 8363 5300 50  0000 C BNN
F 1 "100nF" V 8362 5300 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 8500 5300 50  0001 C CNN
F 3 "~" H 8500 5300 50  0001 C CNN
F 4 "" V 8500 5300 50  0001 C CNN "fit_variant"
F 5 "-basic" H 8500 5300 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 8500 5300 50  0001 C CNN "Comment"
F 7 "Capacitor (Through-hole or 0805)" H 8500 5300 50  0001 C CNN "Description"
	1    8500 5300
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_12
U 1 1 60412CB4
P 8500 5600
F 0 "C_12" V 8363 5600 50  0000 C BNN
F 1 "100nF" V 8362 5600 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 8500 5600 50  0001 C CNN
F 3 "~" H 8500 5600 50  0001 C CNN
F 4 "" V 8500 5600 50  0001 C CNN "fit_variant"
F 5 "-basic" H 8500 5600 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 8500 5600 50  0001 C CNN "Comment"
F 7 "Capacitor (Through-hole or 0805)" H 8500 5600 50  0001 C CNN "Description"
	1    8500 5600
	0    1    1    0   
$EndComp
$Comp
L LED:WS2812B D_14
U 1 1 5FE08387
P 5900 5150
F 0 "D_14" H 6244 5196 50  0000 R BNN
F 1 "SK6812mini-e" H 6244 5105 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 5950 4850 50  0001 L TNN
F 3 "" H 6000 4775 50  0001 L TNN
F 4 "" H 5900 5150 50  0001 C CNN "fit_variant"
F 5 "-basic" H 5900 5150 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 5900 5150 50  0001 C CNN "Comment"
F 7 "RGB LED" H 5900 5150 50  0001 C CNN "Description"
	1    5900 5150
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_15
U 1 1 5FE0912C
P 6500 5150
F 0 "D_15" H 6844 5196 50  0000 R BNN
F 1 "SK6812mini-e" H 6844 5105 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 6550 4850 50  0001 L TNN
F 3 "" H 6600 4775 50  0001 L TNN
F 4 "" H 6500 5150 50  0001 C CNN "fit_variant"
F 5 "-basic" H 6500 5150 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 6500 5150 50  0001 C CNN "Comment"
F 7 "RGB LED" H 6500 5150 50  0001 C CNN "Description"
	1    6500 5150
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C_15
U 1 1 60413B35
P 8500 6500
F 0 "C_15" V 8363 6500 50  0000 C BNN
F 1 "100nF" V 8362 6500 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 8500 6500 50  0001 C CNN
F 3 "~" H 8500 6500 50  0001 C CNN
F 4 "" V 8500 6500 50  0001 C CNN "fit_variant"
F 5 "-basic" H 8500 6500 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 8500 6500 50  0001 C CNN "Comment"
F 7 "Capacitor (Through-hole or 0805)" H 8500 6500 50  0001 C CNN "Description"
	1    8500 6500
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_14
U 1 1 60413695
P 8500 6200
F 0 "C_14" V 8363 6200 50  0000 C BNN
F 1 "100nF" V 8362 6200 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 8500 6200 50  0001 C CNN
F 3 "~" H 8500 6200 50  0001 C CNN
F 4 "" V 8500 6200 50  0001 C CNN "fit_variant"
F 5 "-basic" H 8500 6200 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 8500 6200 50  0001 C CNN "Comment"
F 7 "Capacitor (Through-hole or 0805)" H 8500 6200 50  0001 C CNN "Description"
	1    8500 6200
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_13
U 1 1 60413182
P 8500 5900
F 0 "C_13" V 8363 5900 50  0000 C BNN
F 1 "100nF" V 8362 5900 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 8500 5900 50  0001 C CNN
F 3 "~" H 8500 5900 50  0001 C CNN
F 4 "" V 8500 5900 50  0001 C CNN "fit_variant"
F 5 "-basic" H 8500 5900 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 8500 5900 50  0001 C CNN "Comment"
F 7 "Capacitor (Through-hole or 0805)" H 8500 5900 50  0001 C CNN "Description"
	1    8500 5900
	0    1    1    0   
$EndComp
$Comp
L LED:WS2812B D_12
U 1 1 5FDFCDFD
P 4700 5150
F 0 "D_12" H 5044 5196 50  0000 R BNN
F 1 "SK6812mini-e" H 5044 5105 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 4750 4850 50  0001 L TNN
F 3 "" H 4800 4775 50  0001 L TNN
F 4 "" H 4700 5150 50  0001 C CNN "fit_variant"
F 5 "-basic" H 4700 5150 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 4700 5150 50  0001 C CNN "Comment"
F 7 "RGB LED" H 4700 5150 50  0001 C CNN "Description"
	1    4700 5150
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_13
U 1 1 5FE0782B
P 5300 5150
F 0 "D_13" H 5644 5196 50  0000 R BNN
F 1 "SK6812mini-e" H 5644 5105 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 5350 4850 50  0001 L TNN
F 3 "" H 5400 4775 50  0001 L TNN
F 4 "" H 5300 5150 50  0001 C CNN "fit_variant"
F 5 "-basic" H 5300 5150 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 5300 5150 50  0001 C CNN "Comment"
F 7 "RGB LED" H 5300 5150 50  0001 C CNN "Description"
	1    5300 5150
	1    0    0    -1  
$EndComp
Text Label 6800 7250 3    50   ~ 0
DOUT_4
$Comp
L LED:WS2812B D_43
U 1 1 5FE16705
P 6500 7250
F 0 "D_43" H 6844 7296 50  0000 R BNN
F 1 "SK6812mini-e" H 6844 7205 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 6550 6950 50  0001 L TNN
F 3 "" H 6600 6875 50  0001 L TNN
F 4 "" H 6500 7250 50  0001 C CNN "fit_variant"
F 5 "-basic" H 6500 7250 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 6500 7250 50  0001 C CNN "Comment"
F 7 "RGB LED" H 6500 7250 50  0001 C CNN "Description"
	1    6500 7250
	1    0    0    -1  
$EndComp
Text Label 5000 7250 1    50   ~ 0
DOUT_3
$Comp
L LED:WS2812B D_41
U 1 1 5FE18995
P 5300 7250
F 0 "D_41" H 5644 7296 50  0000 R BNN
F 1 "SK6812mini-e" H 5644 7205 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 5350 6950 50  0001 L TNN
F 3 "" H 5400 6875 50  0001 L TNN
F 4 "" H 5300 7250 50  0001 C CNN "fit_variant"
F 5 "-basic" H 5300 7250 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 5300 7250 50  0001 C CNN "Comment"
F 7 "RGB LED" H 5300 7250 50  0001 C CNN "Description"
	1    5300 7250
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_42
U 1 1 5FE1838E
P 5900 7250
F 0 "D_42" H 6244 7296 50  0000 R BNN
F 1 "SK6812mini-e" H 6244 7205 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 5950 6950 50  0001 L TNN
F 3 "" H 6000 6875 50  0001 L TNN
F 4 "" H 5900 7250 50  0001 C CNN "fit_variant"
F 5 "-basic" H 5900 7250 50  0001 C CNN "fit_field"
F 6 "For Per-key RGB LEDs" H 5900 7250 50  0001 C CNN "Comment"
F 7 "RGB LED" H 5900 7250 50  0001 C CNN "Description"
	1    5900 7250
	1    0    0    -1  
$EndComp
Wire Wire Line
	3700 5550 3700 4850
Connection ~ 3700 4850
Wire Wire Line
	3700 5550 3700 6250
Connection ~ 3700 5550
Wire Wire Line
	6500 6950 5900 6950
Wire Wire Line
	5900 6950 5300 6950
Connection ~ 5900 6950
Wire Wire Line
	5300 6950 3700 6950
Wire Wire Line
	3700 6950 3700 6250
Connection ~ 5300 6950
Connection ~ 3700 6250
Wire Wire Line
	4100 5450 4700 5450
Wire Wire Line
	4700 5450 5300 5450
Connection ~ 4700 5450
Wire Wire Line
	5300 5450 5900 5450
Connection ~ 5300 5450
Wire Wire Line
	5900 5450 6500 5450
Connection ~ 5900 5450
Wire Wire Line
	6500 5450 6900 5450
Wire Wire Line
	6900 5450 6900 6150
Wire Wire Line
	6900 7750 6850 7750
Connection ~ 6500 5450
Wire Wire Line
	4100 6150 4700 6150
Wire Wire Line
	4700 6150 5300 6150
Connection ~ 4700 6150
Wire Wire Line
	5300 6150 5900 6150
Connection ~ 5300 6150
Wire Wire Line
	5900 6150 6500 6150
Connection ~ 5900 6150
Wire Wire Line
	6500 6150 6900 6150
Connection ~ 6500 6150
Connection ~ 6900 6150
Wire Wire Line
	6900 6150 6900 6850
Wire Wire Line
	4100 6850 4700 6850
Wire Wire Line
	5300 6850 4700 6850
Connection ~ 4700 6850
Wire Wire Line
	5300 6850 5900 6850
Connection ~ 5300 6850
Wire Wire Line
	5900 6850 6500 6850
Connection ~ 5900 6850
Wire Wire Line
	6900 6850 6500 6850
Connection ~ 6900 6850
Wire Wire Line
	6900 6850 6900 7550
Connection ~ 6500 6850
Wire Wire Line
	5300 7550 5900 7550
Wire Wire Line
	5900 7550 6500 7550
Connection ~ 5900 7550
Wire Wire Line
	6500 7550 6900 7550
Connection ~ 6500 7550
Connection ~ 6900 7550
Wire Wire Line
	6900 7550 6900 7750
Wire Wire Line
	7100 5700 7100 6300
Wire Wire Line
	7100 6300 7100 6900
Connection ~ 7100 6300
Wire Wire Line
	7100 6900 7100 7500
Connection ~ 7100 6900
Connection ~ 7100 7500
Wire Wire Line
	7000 7500 7000 7700
Text Label 8400 4950 0    50   ~ 0
5V
Text Label 9900 6750 2    50   ~ 0
GND
Wire Wire Line
	8400 4950 8400 5050
Wire Wire Line
	8400 5600 8400 5300
Connection ~ 8400 5300
Wire Wire Line
	8400 5900 8400 5600
Connection ~ 8400 5600
Wire Wire Line
	8400 6200 8400 5900
Connection ~ 8400 5900
Wire Wire Line
	8400 6500 8400 6200
Connection ~ 8400 6200
Wire Wire Line
	8750 6500 8750 6200
Wire Wire Line
	8750 6200 8750 5900
Connection ~ 8750 6200
Wire Wire Line
	8750 5900 8750 5600
Connection ~ 8750 5900
Wire Wire Line
	8750 5600 8750 5300
Connection ~ 8750 5600
Wire Wire Line
	8750 5300 8750 5050
Wire Wire Line
	8750 5050 8400 5050
Connection ~ 8750 5300
Connection ~ 8400 5050
Wire Wire Line
	8400 5050 8400 5300
Wire Wire Line
	9100 6500 9100 6200
Wire Wire Line
	9100 6200 9100 5900
Connection ~ 9100 6200
Wire Wire Line
	9100 5900 9100 5600
Connection ~ 9100 5900
Wire Wire Line
	9100 5600 9100 5300
Connection ~ 9100 5600
Wire Wire Line
	9100 5300 9100 5050
Wire Wire Line
	9100 5050 8750 5050
Connection ~ 9100 5300
Connection ~ 8750 5050
Wire Wire Line
	9400 5900 9400 5600
Wire Wire Line
	9400 5600 9400 5300
Connection ~ 9400 5600
Wire Wire Line
	9400 5300 9400 5050
Wire Wire Line
	9400 5050 9100 5050
Connection ~ 9400 5300
Connection ~ 9100 5050
Wire Wire Line
	9700 6200 9700 5900
Wire Wire Line
	9700 5900 9700 5600
Connection ~ 9700 5900
Wire Wire Line
	9700 5600 9700 5300
Connection ~ 9700 5600
Wire Wire Line
	9700 5300 9700 5050
Wire Wire Line
	9700 5050 9400 5050
Connection ~ 9700 5300
Connection ~ 9400 5050
Wire Wire Line
	8600 5300 8600 5600
Wire Wire Line
	8600 5600 8600 5900
Connection ~ 8600 5600
Wire Wire Line
	8600 5900 8600 6200
Connection ~ 8600 5900
Wire Wire Line
	8600 6200 8600 6500
Connection ~ 8600 6200
Wire Wire Line
	8600 6500 8600 6600
Wire Wire Line
	8600 6600 8950 6600
Wire Wire Line
	9900 6600 9900 6750
Connection ~ 8600 6500
Wire Wire Line
	8950 5300 8950 5600
Wire Wire Line
	8950 5600 8950 5900
Connection ~ 8950 5600
Wire Wire Line
	8950 5900 8950 6200
Connection ~ 8950 5900
Wire Wire Line
	8950 6200 8950 6500
Connection ~ 8950 6200
Wire Wire Line
	8950 6500 8950 6600
Connection ~ 8950 6500
Connection ~ 8950 6600
Wire Wire Line
	8950 6600 9300 6600
Wire Wire Line
	9300 5300 9300 5600
Wire Wire Line
	9300 5600 9300 5900
Connection ~ 9300 5600
Wire Wire Line
	9300 5900 9300 6200
Connection ~ 9300 5900
Wire Wire Line
	9300 6200 9300 6500
Connection ~ 9300 6200
Wire Wire Line
	9600 5300 9600 5600
Wire Wire Line
	9600 5600 9600 5900
Connection ~ 9600 5600
Wire Wire Line
	9600 5900 9600 6600
Connection ~ 9600 5900
Connection ~ 9600 6600
Wire Wire Line
	9600 6600 9900 6600
Wire Wire Line
	9900 5300 9900 5600
Wire Wire Line
	9900 5600 9900 5900
Connection ~ 9900 5600
Wire Wire Line
	9900 5900 9900 6200
Connection ~ 9900 5900
Wire Wire Line
	9900 6600 9900 6200
Connection ~ 9900 6600
Connection ~ 9900 6200
Wire Wire Line
	9300 6500 9300 6600
Connection ~ 9300 6500
Connection ~ 9300 6600
Wire Wire Line
	9300 6600 9600 6600
Text Notes 8400 4600 0    50   ~ 0
Decoupling capacitors\nfor the RGB LEDs
Text Label 1000 2850 2    50   ~ 0
5V
Text Label 1000 2950 2    50   ~ 0
GND
Text Label 1000 3050 2    50   ~ 0
3V3
NoConn ~ 1000 1850
NoConn ~ 1000 1950
Text Label 2600 1150 0    50   ~ 0
GND_or_5V
Text Label 4000 3350 2    50   ~ 0
SW25_or_RESET
Text Label 4150 3550 0    50   ~ 0
SW25
Text Label 4350 4100 0    50   ~ 0
BOOT0
$Comp
L Logic_LevelTranslator:SN74LVC1T45DBV U2
U 1 1 603EC747
P 1400 5300
F 0 "U2" H 1750 5550 50  0000 L CNN
F 1 "SN74LVC1T45DBV" H 1750 5450 50  0000 L CNN
F 2 "ProjectLocal:SOT-23-6_Handsoldering_Reversible" H 1400 4850 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/sn74lvc1t45.pdf" H 500 4650 50  0001 C CNN
F 4 "-basic" H 1400 5300 50  0001 C CNN "fit_field"
F 5 "For RGB LEDs" H 1400 5300 50  0001 C CNN "Comment"
F 6 "SOT-23-6 Logic Level Shifter" H 1400 5300 50  0001 C CNN "Description"
	1    1400 5300
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 603F5BAE
P 850 5500
F 0 "R3" H 920 5500 50  0000 L CNN
F 1 "2.2k - 10k" H 920 5455 50  0000 L TNN
F 2 "ProjectLocal:Resistor-Hybrid_Reversible" V 780 5500 50  0001 C CNN
F 3 "~" H 850 5500 50  0001 C CNN
F 4 "-basic" H 850 5500 50  0001 C CNN "fit_field"
F 5 "R3, for RGB LEDs. R5, R6 for OLED screen" H 850 5500 50  0001 C CNN "Comment"
F 6 "Resistor (1/4W through-hole, or 0805)" H 850 5500 50  0001 C CNN "Description"
	1    850  5500
	0    1    1    0   
$EndComp
Text Label 1800 5300 0    50   ~ 0
RGB_DIN_5V
Text Label 1500 4900 1    50   ~ 0
5V
Text Label 1300 4900 1    50   ~ 0
3V3
Text Label 1400 5700 3    50   ~ 0
GND
Text Label 1000 5300 1    50   ~ 0
RGB_DIN_3V3
Text Label 700  5500 2    50   ~ 0
5V
Text Label 3500 4850 1    50   ~ 0
RGB_DIN_5V
$Comp
L Switch:SW_Push SW_RESET1
U 1 1 60AD9170
P 13950 1350
F 0 "SW_RESET1" H 13950 1635 50  0000 C CNN
F 1 "3x6mm" H 13950 1544 50  0000 C CNN
F 2 "ProjectLocal:SW_Push_SPST_3x6mm_Reversible" H 13950 1550 50  0001 C CNN
F 3 "~" H 13950 1550 50  0001 C CNN
F 4 "Tactile Switch" H 13950 1350 50  0001 C CNN "Description"
	1    13950 1350
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW_BOOT0
U 1 1 60ADC79E
P 14850 1350
F 0 "SW_BOOT0" H 14850 1635 50  0000 C CNN
F 1 "3x6mm" H 14850 1544 50  0000 C CNN
F 2 "ProjectLocal:SW_Push_SPST_3x6mm_Reversible" H 14850 1550 50  0001 C CNN
F 3 "~" H 14850 1550 50  0001 C CNN
F 4 "Tactile Switch" H 14850 1350 50  0001 C CNN "Description"
	1    14850 1350
	1    0    0    -1  
$EndComp
Text Label 15050 1350 0    50   ~ 0
GND
Text Label 14150 1350 0    50   ~ 0
GND
Text Label 13750 1350 2    50   ~ 0
RESET
Text Label 14650 1350 2    50   ~ 0
BOOT0
$Comp
L Device:C_Small C1
U 1 1 60A83BEB
P 2200 8900
F 0 "C1" V 2063 8900 50  0000 C BNN
F 1 "100nF" V 2062 8900 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 2200 8900 50  0001 C CNN
F 3 "~" H 2200 8900 50  0001 C CNN
F 4 "-basic" V 2200 8900 50  0001 C CNN "fit_field"
F 5 "For Rotary Encoder" H 2200 8900 50  0001 C CNN "Comment"
F 6 "Capacitor (Through-hole or 0805)" H 2200 8900 50  0001 C CNN "Description"
	1    2200 8900
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C2
U 1 1 60A86C12
P 2200 9200
F 0 "C2" V 2063 9200 50  0000 C BNN
F 1 "100nF" V 2062 9200 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual_Reversible" H 2200 9200 50  0001 C CNN
F 3 "~" H 2200 9200 50  0001 C CNN
F 4 "-basic" V 2200 9200 50  0001 C CNN "fit_field"
F 5 "For Rotary Encoder" H 2200 9200 50  0001 C CNN "Comment"
F 6 "Capacitor (Through-hole or 0805)" H 2200 9200 50  0001 C CNN "Description"
	1    2200 9200
	0    1    1    0   
$EndComp
Text Label 2100 8900 2    50   ~ 0
RE_A
Text Label 2100 9200 2    50   ~ 0
RE_B
$Comp
L Jumper:SolderJumper_2_Bridged JP3
U 1 1 60B67A99
P 4200 4100
F 0 "JP3" H 4200 4213 50  0000 C CNN
F 1 "SolderJumper_2_Bridged" H 4200 4214 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged2Bar_RoundedPad1.0x1.5mm" H 4200 4100 50  0001 C CNN
F 3 "~" H 4200 4100 50  0001 C CNN
F 4 "Jumped 12 by default. Cut trace for Bluepill" H 4200 4100 50  0001 C CNN "Comment"
F 5 "Solder Jumper" H 4200 4100 50  0001 C CNN "Description"
	1    4200 4100
	1    0    0    -1  
$EndComp
Text Label 2600 2450 0    50   ~ 0
MOTOR_PWM
Text Notes 3250 1900 0    50   ~ 0
Jumpers to allow the PCB design\nto be easily configured for\neither the "Blue Pill" or the "Black Pill"\ndevelopement board.\n\nFor "Blue Pill":\n- JP1 closed 13,\n- JP2 closed 13.\n\nFor "Black Pill":\n- JP1 closed 12,\n- JP2 closed 12,\n- JP3 closed.\n\nIn the default configuration,\nthe jumpers are configured for\nthe MiniF4 "Black Pill".
Text Label 2600 1550 0    50   ~ 0
NC_or_BOOT0
Text Label 2600 2650 0    50   ~ 0
SW25_or_RESET
Text Label 2600 1450 0    50   ~ 0
RESET_or_SW25
Text Label 2600 2250 0    50   ~ 0
RE_A
Text Label 1000 1450 2    50   ~ 0
SW12
Text Label 1000 2250 2    50   ~ 0
RE_B
Text Label 1000 1750 2    50   ~ 0
SW23
Text Notes 10350 8650 0    50   ~ 0
Transistor to allow PWM\ncontrol of a simple\nDC vibration motor.
$Comp
L Device:Q_NPN_BCE Q1
U 1 1 60B4654A
P 11700 9450
F 0 "Q1" H 11891 9496 50  0000 L CNN
F 1 "MMSS8050-H-TP" H 11891 9405 50  0001 L CNN
F 2 "ProjectLocal:SOT-23_Handsoldering_Reversible" H 11900 9550 50  0001 C CNN
F 3 "~" H 11700 9450 50  0001 C CNN
F 4 "-basic" H 11700 9450 50  0001 C CNN "fit_field"
F 5 "For vibration motor" H 11700 9450 50  0001 C CNN "Comment"
F 6 "NPN BJT transistor" H 11700 9450 50  0001 C CNN "Description"
	1    11700 9450
	1    0    0    -1  
$EndComp
$Comp
L Motor:Motor_DC M1
U 1 1 60B49FEF
P 11800 8700
F 0 "M1" H 11958 8696 50  0000 L CNN
F 1 "1030 or 0834" H 11958 8605 50  0000 L CNN
F 2 "ProjectLocal:Mini_DC_Motor" H 11800 8610 50  0001 C CNN
F 3 "~" H 11800 8610 50  0001 C CNN
F 4 "-basic" H 11800 8700 50  0001 C CNN "fit_field"
F 5 "For vibration motor" H 11800 8700 50  0001 C CNN "Comment"
F 6 "Small DC vibration motor" H 11800 8700 50  0001 C CNN "Description"
	1    11800 8700
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 60B4BAE0
P 11650 8500
F 0 "R8" V 11550 8450 50  0000 L CNN
F 1 "500R" H 11720 8455 50  0001 L TNN
F 2 "ProjectLocal:Resistor-Hybrid_Reversible" V 11580 8500 50  0001 C CNN
F 3 "~" H 11650 8500 50  0001 C CNN
F 4 "-basic" V 11650 8500 50  0001 C CNN "fit_field"
F 5 "For vibration motor" H 11650 8500 50  0001 C CNN "Comment"
F 6 "Resistor (1/4W through-hole, or 0805)" H 11650 8500 50  0001 C CNN "Description"
	1    11650 8500
	0    1    1    0   
$EndComp
$Comp
L Device:R R7
U 1 1 60B47E99
P 11350 9450
F 0 "R7" V 11450 9400 50  0000 L CNN
F 1 "500R" H 11420 9405 50  0001 L TNN
F 2 "ProjectLocal:Resistor-Hybrid_Reversible" V 11280 9450 50  0001 C CNN
F 3 "~" H 11350 9450 50  0001 C CNN
F 4 "-basic" V 11350 9450 50  0001 C CNN "fit_field"
F 5 "For vibration motor" H 11350 9450 50  0001 C CNN "Comment"
F 6 "Resistor (1/4W through-hole, or 0805)" H 11350 9450 50  0001 C CNN "Description"
	1    11350 9450
	0    -1   -1   0   
$EndComp
Text Label 11500 8500 2    50   ~ 0
5V
Text Label 11800 9050 0    50   ~ 0
MOTOR_GND
Text Label 11800 9250 0    50   ~ 0
MOTOR_GND
Wire Wire Line
	11800 9000 11800 9050
Text Label 11800 9750 0    50   ~ 0
GND
Wire Wire Line
	11800 9650 11800 9750
Text Label 2300 9200 0    50   ~ 0
GND
Text Label 2300 8900 0    50   ~ 0
GND
Text Notes 4450 9750 0    50   ~ 0
Pull OLED I2C up.
Text Label 4950 10400 0    50   ~ 0
OLED_SDA
Text Label 4950 10050 0    50   ~ 0
OLED_SCL
Text Label 4650 10400 2    50   ~ 0
5V
Text Label 4650 10050 2    50   ~ 0
5V
$Comp
L Device:R R6
U 1 1 6061DE45
P 4800 10400
F 0 "R6" V 5000 10350 50  0000 L CNN
F 1 "2.2k - 10k" V 4900 10200 50  0000 L TNN
F 2 "ProjectLocal:Resistor-Hybrid_Reversible" V 4730 10400 50  0001 C CNN
F 3 "~" H 4800 10400 50  0001 C CNN
F 4 "-basic" V 4800 10400 50  0001 C CNN "fit_field"
F 5 "R3, for RGB LEDs. R5, R6 for OLED screen" H 4800 10400 50  0001 C CNN "Comment"
F 6 "Resistor (1/4W through-hole, or 0805)" H 4800 10400 50  0001 C CNN "Description"
	1    4800 10400
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R5
U 1 1 605F4492
P 4800 10050
F 0 "R5" V 5000 10000 50  0000 L CNN
F 1 "2.2k - 10k" V 4900 9850 50  0000 L TNN
F 2 "ProjectLocal:Resistor-Hybrid_Reversible" V 4730 10050 50  0001 C CNN
F 3 "~" H 4800 10050 50  0001 C CNN
F 4 "-basic" V 4800 10050 50  0001 C CNN "fit_field"
F 5 "R3, for RGB LEDs. R5, R6 for OLED screen" H 4800 10050 50  0001 C CNN "Comment"
F 6 "Resistor (1/4W through-hole, or 0805)" H 4800 10050 50  0001 C CNN "Description"
	1    4800 10050
	0    -1   -1   0   
$EndComp
Text Label 7600 10350 2    50   ~ 0
OLED_SDA
Text Label 7600 10100 2    50   ~ 0
OLED_SCL
Text Label 7600 9850 2    50   ~ 0
5V
Text Label 7600 9600 2    50   ~ 0
GND
Text Label 6250 10350 2    50   ~ 0
OLED_SDA
Text Label 6250 10100 2    50   ~ 0
OLED_SCL
Text Label 6250 9850 2    50   ~ 0
5V
Text Label 6250 9600 2    50   ~ 0
GND
Wire Wire Line
	8600 9350 8600 9600
Connection ~ 8600 9350
Wire Wire Line
	6850 10350 6550 10350
Wire Wire Line
	6850 9350 6850 10350
Wire Wire Line
	8600 9350 6850 9350
Wire Wire Line
	8300 9050 8300 10350
Wire Wire Line
	8400 9150 8400 10100
Wire Wire Line
	8500 9250 8500 9850
Wire Wire Line
	8600 9050 8600 9350
Wire Wire Line
	6750 9250 6750 10100
Wire Wire Line
	6650 9150 6650 9850
Wire Wire Line
	6550 9050 6550 9600
Wire Wire Line
	8600 9600 7900 9600
Connection ~ 8500 9250
Wire Wire Line
	8500 9850 7900 9850
Wire Wire Line
	6750 10100 6550 10100
Wire Wire Line
	8500 9250 6750 9250
Wire Wire Line
	8500 9050 8500 9250
Connection ~ 8400 9150
Wire Wire Line
	8400 10100 7900 10100
Wire Wire Line
	6650 9850 6550 9850
Wire Wire Line
	8400 9150 6650 9150
Wire Wire Line
	8400 9050 8400 9150
Connection ~ 8300 9050
Wire Wire Line
	8300 10350 7900 10350
Wire Wire Line
	8300 9050 6550 9050
$Comp
L Jumper:SolderJumper_2_Open JP13
U 1 1 605571DE
P 7750 10350
F 0 "JP13" H 7750 10463 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 7750 10464 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm" H 7750 10350 50  0001 C CNN
F 3 "~" H 7750 10350 50  0001 C CNN
F 4 "Jump appropriate side for OLED screen" H 7750 10350 50  0001 C CNN "Comment"
F 5 "Solder Jumper" H 7750 10350 50  0001 C CNN "Description"
	1    7750 10350
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Open JP12
U 1 1 60553C5A
P 7750 10100
F 0 "JP12" H 7750 10213 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 7750 10214 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm" H 7750 10100 50  0001 C CNN
F 3 "~" H 7750 10100 50  0001 C CNN
F 4 "Jump appropriate side for OLED screen" H 7750 10100 50  0001 C CNN "Comment"
F 5 "Solder Jumper" H 7750 10100 50  0001 C CNN "Description"
	1    7750 10100
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Open JP11
U 1 1 60553356
P 7750 9850
F 0 "JP11" H 7750 9963 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 7750 9964 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm" H 7750 9850 50  0001 C CNN
F 3 "~" H 7750 9850 50  0001 C CNN
F 4 "Jump appropriate side for OLED screen" H 7750 9850 50  0001 C CNN "Comment"
F 5 "Solder Jumper" H 7750 9850 50  0001 C CNN "Description"
	1    7750 9850
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Open JP10
U 1 1 60552AED
P 7750 9600
F 0 "JP10" H 7750 9713 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 7750 9714 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm" H 7750 9600 50  0001 C CNN
F 3 "~" H 7750 9600 50  0001 C CNN
F 4 "Jump appropriate side for OLED screen" H 7750 9600 50  0001 C CNN "Comment"
F 5 "Solder Jumper" H 7750 9600 50  0001 C CNN "Description"
	1    7750 9600
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Open JP9
U 1 1 60530B58
P 6400 10350
F 0 "JP9" H 6400 10463 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 6400 10464 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm" H 6400 10350 50  0001 C CNN
F 3 "~" H 6400 10350 50  0001 C CNN
F 4 "Jump appropriate side for OLED screen" H 6400 10350 50  0001 C CNN "Comment"
F 5 "Solder Jumper" H 6400 10350 50  0001 C CNN "Description"
	1    6400 10350
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Open JP8
U 1 1 6053034C
P 6400 10100
F 0 "JP8" H 6400 10213 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 6400 10214 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm" H 6400 10100 50  0001 C CNN
F 3 "~" H 6400 10100 50  0001 C CNN
F 4 "Jump appropriate side for OLED screen" H 6400 10100 50  0001 C CNN "Comment"
F 5 "Solder Jumper" H 6400 10100 50  0001 C CNN "Description"
	1    6400 10100
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Open JP7
U 1 1 6052FAA5
P 6400 9850
F 0 "JP7" H 6400 9963 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 6400 9964 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm" H 6400 9850 50  0001 C CNN
F 3 "~" H 6400 9850 50  0001 C CNN
F 4 "Jump appropriate side for OLED screen" H 6400 9850 50  0001 C CNN "Comment"
F 5 "Solder Jumper" H 6400 9850 50  0001 C CNN "Description"
	1    6400 9850
	1    0    0    -1  
$EndComp
Text Notes 4350 8900 0    50   ~ 0
OLED module with I2C.\nPins are GND, VCC, SCL, SDA.\n\nHowever, since the board is reversible,\nand it’s easier to use the same 01x04 through-hole pads\nfor the OLED for use on either side of the PCB,\nthe connections each have to be jumped.
$Comp
L Jumper:SolderJumper_2_Open JP6
U 1 1 60528B37
P 6400 9600
F 0 "JP6" H 6400 9713 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 6400 9714 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm" H 6400 9600 50  0001 C CNN
F 3 "~" H 6400 9600 50  0001 C CNN
F 4 "Jump appropriate side for OLED screen" H 6400 9600 50  0001 C CNN "Comment"
F 5 "Solder Jumper" H 6400 9600 50  0001 C CNN "Description"
	1    6400 9600
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x04_Female J3
U 1 1 60521A32
P 8400 8850
F 0 "J3" V 8600 8850 50  0000 R CNN
F 1 "01x04 Female Header" V 8500 9300 50  0001 R CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x04_P2.54mm_Vertical" H 8400 8850 50  0001 C CNN
F 3 "~" H 8400 8850 50  0001 C CNN
F 4 "-basic" V 8400 8850 50  0001 C CNN "fit_field"
F 5 "For OLED screen" H 8400 8850 50  0001 C CNN "Comment"
F 6 "Female Header" H 8400 8850 50  0001 C CNN "Description"
	1    8400 8850
	0    -1   -1   0   
$EndComp
Wire Notes Line
	5150 4300 5150 500 
Wire Notes Line
	13200 4300 13200 500 
Wire Notes Line
	4300 11200 4300 8300
Wire Notes Line
	16050 2350 13200 2350
Wire Notes Line
	3200 500  3200 8300
Wire Notes Line
	8250 500  8250 8300
Wire Notes Line
	500  8300 16050 8300
Text Label 11200 9450 2    50   ~ 0
MOTOR_PWM
$Comp
L Jumper:SolderJumper_3_Bridged12 JP2
U 1 1 60B93FDF
P 4150 3350
F 0 "JP2" V 4104 3418 50  0000 L CNN
F 1 "SolderJumper_3_Bridged12" V 4195 3418 50  0001 L CNN
F 2 "Jumper:SolderJumper-3_P1.3mm_Bridged2Bar12_RoundedPad1.0x1.5mm_NumberLabels" H 4150 3350 50  0001 C CNN
F 3 "~" H 4150 3350 50  0001 C CNN
F 4 "Jumped 12 by default. Cut trace & solder 23 for Bluepill" H 4150 3350 50  0001 C CNN "Comment"
F 5 "Solder Jumper" H 4150 3350 50  0001 C CNN "Description"
	1    4150 3350
	0    1    1    0   
$EndComp
$Comp
L Jumper:SolderJumper_3_Bridged12 JP1
U 1 1 60B92FC1
P 4150 2550
F 0 "JP1" V 4104 2618 50  0000 L CNN
F 1 "SolderJumper_3_Bridged12" V 4195 2618 50  0001 L CNN
F 2 "Jumper:SolderJumper-3_P1.3mm_Bridged2Bar12_RoundedPad1.0x1.5mm_NumberLabels" H 4150 2550 50  0001 C CNN
F 3 "~" H 4150 2550 50  0001 C CNN
F 4 "Jumped 12 by default. Cut trace & solder 23 for Bluepill" H 4150 2550 50  0001 C CNN "Comment"
F 5 "Solder Jumper" H 4150 2550 50  0001 C CNN "Description"
	1    4150 2550
	0    1    1    0   
$EndComp
Text Label 4150 3150 0    50   ~ 0
RESET
Text Label 4150 2350 0    50   ~ 0
SW25
Text Label 4150 2750 0    50   ~ 0
RESET
Text Label 4000 2550 2    50   ~ 0
RESET_or_SW25
Text Label 4050 4100 2    50   ~ 0
NC_or_BOOT0
Wire Notes Line
	10250 4300 10250 11200
Wire Notes Line
	500  4300 16050 4300
Text Notes 10350 5050 0    50   ~ 0
01x04 test point connectors for interfacing\nwith the WS2812-compatible RGBs.\n\nThis facilitates testing.\nIt allows the RGB LEDs to be driven\nwithout the U1 dev board being soldered in.\nIt also provides a way to use U1 to drive\nother WS2812-compatible RGB strips.
$Comp
L Device:R R2
U 1 1 5FDD4F32
P 11750 1000
F 0 "R2" H 11820 1000 50  0000 L CNN
F 1 "2.2k - 10k" H 11820 955 50  0000 L TNN
F 2 "ProjectLocal:Resistor-Hybrid_Reversible" V 11680 1000 50  0001 C CNN
F 3 "~" H 11750 1000 50  0001 C CNN
F 4 "R3, for RGB LEDs. R5, R6 for OLED screen" H 11750 1000 50  0001 C CNN "Comment"
F 5 "Resistor (1/4W through-hole, or 0805)" H 11750 1000 50  0001 C CNN "Description"
	1    11750 1000
	1    0    0    -1  
$EndComp
Text Label 11100 1150 3    50   ~ 0
TRRS_R1
Text Label 11750 1150 3    50   ~ 0
TRRS_R2
Text Label 11750 850  1    50   ~ 0
5V
Text Label 11100 850  1    50   ~ 0
5V
$Comp
L Device:R R1
U 1 1 5FDD65E1
P 11100 1000
F 0 "R1" H 11170 1000 50  0000 L CNN
F 1 "2.2k - 10k" H 11170 955 50  0000 L TNN
F 2 "ProjectLocal:Resistor-Hybrid_Reversible" V 11030 1000 50  0001 C CNN
F 3 "~" H 11100 1000 50  0001 C CNN
F 4 "R3, for RGB LEDs. R5, R6 for OLED screen" H 11100 1000 50  0001 C CNN "Comment"
F 5 "Resistor (1/4W through-hole, or 0805)" H 11100 1000 50  0001 C CNN "Description"
	1    11100 1000
	1    0    0    -1  
$EndComp
Text Notes 13250 950  0    50   ~ 0
External reset switches.\n\nThis makes it easier to reset the development board\nif the board is mounted with its top facing towards\nthe PCB.
$Comp
L ProjectLocal:BluePill_or_MiniF4_DIP40 U1
U 1 1 6222795C
P 1800 2050
F 0 "U1" H 1800 3215 50  0000 C CNN
F 1 "STM32F103 Bluepill, or MiniF4 STM32F4x1 \"Blackpill\"" H 1800 3124 50  0000 C CNN
F 2 "ProjectLocal:DIP40_Reversible_ZigZag" H 2300 3200 50  0001 C CNN
F 3 "" V 2450 1200 50  0001 C CNN
F 4 "" H 1800 2050 50  0001 C CNN "fit_variant"
F 5 "DIP-40 STM32 Development Board" H 1800 2050 50  0001 C CNN "Description"
F 6 "Ideally, use a DIP-40 socket with round pins, or cut down a SIP header with round pins" H 1800 2050 50  0001 C CNN "Comment"
	1    1800 2050
	1    0    0    -1  
$EndComp
$EndSCHEMATC
