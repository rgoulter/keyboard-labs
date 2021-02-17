EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Soldering Practice, SK6812mini-e, Reversible"
Date "2021-02-24"
Rev "2021.1"
Comp "Richard Goulter"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	2550 2100 2550 2200
Wire Wire Line
	2750 2200 2750 2300
$Comp
L Device:C_Small C_1
U 1 1 603D2DAA
P 2650 2200
F 0 "C_1" V 2513 2200 50  0000 C BNN
F 1 "100nF" V 2512 2200 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 2650 2200 50  0001 C CNN
F 3 "~" H 2650 2200 50  0001 C CNN
	1    2650 2200
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP_3V3
U 1 1 604BDA94
P 950 900
F 0 "TP_3V3" H 1008 1018 50  0000 L CNN
F 1 "TestPoint" H 1008 927 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_1.5x1.5mm_Drill0.7mm" H 1150 900 50  0001 C CNN
F 3 "~" H 1150 900 50  0001 C CNN
	1    950  900 
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_1
U 1 1 5FD534E8
P 2550 1800
F 0 "D_1" H 2894 1846 50  0000 R BNN
F 1 "WS2812B" H 2894 1755 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 2600 1500 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 2650 1425 50  0001 L TNN
	1    2550 1800
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP_GND_1
U 1 1 604C23E2
P 1500 900
F 0 "TP_GND_1" H 1558 1018 50  0000 L CNN
F 1 "TestPoint" H 1558 927 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.5mm_Drill0.7mm" H 1700 900 50  0001 C CNN
F 3 "~" H 1700 900 50  0001 C CNN
	1    1500 900 
	1    0    0    -1  
$EndComp
Text Label 2750 2300 0    50   ~ 0
GND
Text Label 2550 1500 0    50   ~ 0
3V3
$Comp
L Connector:TestPoint TP_DIN_1
U 1 1 604C3D7C
P 2250 1300
F 0 "TP_DIN_1" H 2308 1418 50  0000 L CNN
F 1 "TestPoint" H 2308 1327 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_1.5x1.5mm_Drill0.7mm" H 2450 1300 50  0001 C CNN
F 3 "~" H 2450 1300 50  0001 C CNN
	1    2250 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1600 1800 2250 1800
Wire Wire Line
	2250 1800 2250 1300
Connection ~ 2250 1800
$Comp
L Connector:TestPoint TP_DOUT_1
U 1 1 604C7874
P 2850 1300
F 0 "TP_DOUT_1" H 2908 1418 50  0000 L CNN
F 1 "TestPoint" H 2908 1327 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.5mm_Drill0.7mm" H 3050 1300 50  0001 C CNN
F 3 "~" H 3050 1300 50  0001 C CNN
	1    2850 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	2850 1800 2850 1300
Text Label 950  900  0    50   ~ 0
3V3
Text Label 1500 900  0    50   ~ 0
GND
Wire Wire Line
	3800 2100 3800 2200
Wire Wire Line
	4000 2200 4000 2300
$Comp
L Device:C_Small C_2
U 1 1 604EA1AB
P 3900 2200
F 0 "C_2" V 3763 2200 50  0000 C BNN
F 1 "100nF" V 3762 2200 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 3900 2200 50  0001 C CNN
F 3 "~" H 3900 2200 50  0001 C CNN
	1    3900 2200
	0    1    1    0   
$EndComp
$Comp
L LED:WS2812B D_2
U 1 1 604EA1B1
P 3800 1800
F 0 "D_2" H 4144 1846 50  0000 R BNN
F 1 "WS2812B" H 4144 1755 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 3850 1500 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 3900 1425 50  0001 L TNN
	1    3800 1800
	1    0    0    -1  
$EndComp
Text Label 4000 2300 0    50   ~ 0
GND
Text Label 3800 1500 0    50   ~ 0
3V3
$Comp
L Connector:TestPoint TP_DIN_2
U 1 1 604EA1B9
P 3500 1300
F 0 "TP_DIN_2" H 3558 1418 50  0000 L CNN
F 1 "TestPoint" H 3558 1327 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_1.5x1.5mm_Drill0.7mm" H 3700 1300 50  0001 C CNN
F 3 "~" H 3700 1300 50  0001 C CNN
	1    3500 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	2850 1800 3500 1800
Wire Wire Line
	3500 1800 3500 1300
Connection ~ 3500 1800
$Comp
L Connector:TestPoint TP_DOUT_2
U 1 1 604EA1C2
P 4100 1300
F 0 "TP_DOUT_2" H 4158 1418 50  0000 L CNN
F 1 "TestPoint" H 4158 1327 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.5mm_Drill0.7mm" H 4300 1300 50  0001 C CNN
F 3 "~" H 4300 1300 50  0001 C CNN
	1    4100 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	4100 1800 4100 1300
Wire Wire Line
	5050 2100 5050 2200
Wire Wire Line
	5250 2200 5250 2300
$Comp
L Device:C_Small C_3
U 1 1 604EC43A
P 5150 2200
F 0 "C_3" V 5013 2200 50  0000 C BNN
F 1 "100nF" V 5012 2200 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 5150 2200 50  0001 C CNN
F 3 "~" H 5150 2200 50  0001 C CNN
	1    5150 2200
	0    1    1    0   
$EndComp
$Comp
L LED:WS2812B D_3
U 1 1 604EC440
P 5050 1800
F 0 "D_3" H 5394 1846 50  0000 R BNN
F 1 "WS2812B" H 5394 1755 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 5100 1500 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 5150 1425 50  0001 L TNN
	1    5050 1800
	1    0    0    -1  
$EndComp
Text Label 5250 2300 0    50   ~ 0
GND
Text Label 5050 1500 0    50   ~ 0
3V3
$Comp
L Connector:TestPoint TP_DIN_3
U 1 1 604EC448
P 4750 1300
F 0 "TP_DIN_3" H 4808 1418 50  0000 L CNN
F 1 "TestPoint" H 4808 1327 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_1.5x1.5mm_Drill0.7mm" H 4950 1300 50  0001 C CNN
F 3 "~" H 4950 1300 50  0001 C CNN
	1    4750 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	4100 1800 4750 1800
Wire Wire Line
	4750 1800 4750 1300
Connection ~ 4750 1800
$Comp
L Connector:TestPoint TP_DOUT_3
U 1 1 604EC451
P 5350 1300
F 0 "TP_DOUT_3" H 5408 1418 50  0000 L CNN
F 1 "TestPoint" H 5408 1327 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.5mm_Drill0.7mm" H 5550 1300 50  0001 C CNN
F 3 "~" H 5550 1300 50  0001 C CNN
	1    5350 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 1800 5350 1300
Wire Wire Line
	6300 2100 6300 2200
Wire Wire Line
	6500 2200 6500 2300
$Comp
L Device:C_Small C_4
U 1 1 604EE48B
P 6400 2200
F 0 "C_4" V 6263 2200 50  0000 C BNN
F 1 "100nF" V 6262 2200 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 6400 2200 50  0001 C CNN
F 3 "~" H 6400 2200 50  0001 C CNN
	1    6400 2200
	0    1    1    0   
$EndComp
$Comp
L LED:WS2812B D_4
U 1 1 604EE491
P 6300 1800
F 0 "D_4" H 6644 1846 50  0000 R BNN
F 1 "WS2812B" H 6644 1755 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 6350 1500 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 6400 1425 50  0001 L TNN
	1    6300 1800
	1    0    0    -1  
$EndComp
Text Label 6500 2300 0    50   ~ 0
GND
Text Label 6300 1500 0    50   ~ 0
3V3
$Comp
L Connector:TestPoint TP_DIN_4
U 1 1 604EE499
P 6000 1300
F 0 "TP_DIN_4" H 6058 1418 50  0000 L CNN
F 1 "TestPoint" H 6058 1327 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_1.5x1.5mm_Drill0.7mm" H 6200 1300 50  0001 C CNN
F 3 "~" H 6200 1300 50  0001 C CNN
	1    6000 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 1800 6000 1800
Wire Wire Line
	6000 1800 6000 1300
Connection ~ 6000 1800
$Comp
L Connector:TestPoint TP_DOUT_4
U 1 1 604EE4A2
P 6600 1300
F 0 "TP_DOUT_4" H 6658 1418 50  0000 L CNN
F 1 "TestPoint" H 6658 1327 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.5mm_Drill0.7mm" H 6800 1300 50  0001 C CNN
F 3 "~" H 6800 1300 50  0001 C CNN
	1    6600 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	6600 1800 6600 1300
Wire Wire Line
	2550 3750 2550 3850
Wire Wire Line
	2750 3850 2750 3950
$Comp
L Device:C_Small C_5
U 1 1 604F1C83
P 2650 3850
F 0 "C_5" V 2513 3850 50  0000 C BNN
F 1 "100nF" V 2512 3850 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 2650 3850 50  0001 C CNN
F 3 "~" H 2650 3850 50  0001 C CNN
	1    2650 3850
	0    1    1    0   
$EndComp
$Comp
L LED:WS2812B D_5
U 1 1 604F1C89
P 2550 3450
F 0 "D_5" H 2894 3496 50  0000 R BNN
F 1 "WS2812B" H 2894 3405 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 2600 3150 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 2650 3075 50  0001 L TNN
	1    2550 3450
	1    0    0    -1  
$EndComp
Text Label 2750 3950 0    50   ~ 0
GND
Text Label 2550 3150 0    50   ~ 0
3V3
$Comp
L Connector:TestPoint TP_DIN_5
U 1 1 604F1C91
P 2250 2950
F 0 "TP_DIN_5" H 2308 3068 50  0000 L CNN
F 1 "TestPoint" H 2308 2977 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_1.5x1.5mm_Drill0.7mm" H 2450 2950 50  0001 C CNN
F 3 "~" H 2450 2950 50  0001 C CNN
	1    2250 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	1600 3450 2250 3450
Wire Wire Line
	2250 3450 2250 2950
Connection ~ 2250 3450
$Comp
L Connector:TestPoint TP_DOUT_5
U 1 1 604F1C9A
P 2850 2950
F 0 "TP_DOUT_5" H 2908 3068 50  0000 L CNN
F 1 "TestPoint" H 2908 2977 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.5mm_Drill0.7mm" H 3050 2950 50  0001 C CNN
F 3 "~" H 3050 2950 50  0001 C CNN
	1    2850 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	2850 3450 2850 2950
Wire Wire Line
	3800 3750 3800 3850
Wire Wire Line
	4000 3850 4000 3950
$Comp
L Device:C_Small C_6
U 1 1 604F433C
P 3900 3850
F 0 "C_6" V 3763 3850 50  0000 C BNN
F 1 "100nF" V 3762 3850 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 3900 3850 50  0001 C CNN
F 3 "~" H 3900 3850 50  0001 C CNN
	1    3900 3850
	0    1    1    0   
$EndComp
$Comp
L LED:WS2812B D_6
U 1 1 604F4342
P 3800 3450
F 0 "D_6" H 4144 3496 50  0000 R BNN
F 1 "WS2812B" H 4144 3405 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 3850 3150 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 3900 3075 50  0001 L TNN
	1    3800 3450
	1    0    0    -1  
$EndComp
Text Label 4000 3950 0    50   ~ 0
GND
Text Label 3800 3150 0    50   ~ 0
3V3
$Comp
L Connector:TestPoint TP_DIN_6
U 1 1 604F434A
P 3500 2950
F 0 "TP_DIN_6" H 3558 3068 50  0000 L CNN
F 1 "TestPoint" H 3558 2977 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_1.5x1.5mm_Drill0.7mm" H 3700 2950 50  0001 C CNN
F 3 "~" H 3700 2950 50  0001 C CNN
	1    3500 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	2850 3450 3500 3450
Wire Wire Line
	3500 3450 3500 2950
Connection ~ 3500 3450
$Comp
L Connector:TestPoint TP_DOUT_6
U 1 1 604F4353
P 4100 2950
F 0 "TP_DOUT_6" H 4158 3068 50  0000 L CNN
F 1 "TestPoint" H 4158 2977 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.5mm_Drill0.7mm" H 4300 2950 50  0001 C CNN
F 3 "~" H 4300 2950 50  0001 C CNN
	1    4100 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4100 3450 4100 2950
Wire Wire Line
	5050 3750 5050 3850
Wire Wire Line
	5250 3850 5250 3950
$Comp
L Device:C_Small C_7
U 1 1 604F6F2C
P 5150 3850
F 0 "C_7" V 5013 3850 50  0000 C BNN
F 1 "100nF" V 5012 3850 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 5150 3850 50  0001 C CNN
F 3 "~" H 5150 3850 50  0001 C CNN
	1    5150 3850
	0    1    1    0   
$EndComp
$Comp
L LED:WS2812B D_7
U 1 1 604F6F32
P 5050 3450
F 0 "D_7" H 5394 3496 50  0000 R BNN
F 1 "WS2812B" H 5394 3405 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 5100 3150 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 5150 3075 50  0001 L TNN
	1    5050 3450
	1    0    0    -1  
$EndComp
Text Label 5250 3950 0    50   ~ 0
GND
Text Label 5050 3150 0    50   ~ 0
3V3
$Comp
L Connector:TestPoint TP_DIN_7
U 1 1 604F6F3A
P 4750 2950
F 0 "TP_DIN_7" H 4808 3068 50  0000 L CNN
F 1 "TestPoint" H 4808 2977 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_1.5x1.5mm_Drill0.7mm" H 4950 2950 50  0001 C CNN
F 3 "~" H 4950 2950 50  0001 C CNN
	1    4750 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4100 3450 4750 3450
Wire Wire Line
	4750 3450 4750 2950
Connection ~ 4750 3450
$Comp
L Connector:TestPoint TP_DOUT_7
U 1 1 604F6F43
P 5350 2950
F 0 "TP_DOUT_7" H 5408 3068 50  0000 L CNN
F 1 "TestPoint" H 5408 2977 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.5mm_Drill0.7mm" H 5550 2950 50  0001 C CNN
F 3 "~" H 5550 2950 50  0001 C CNN
	1    5350 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 3450 5350 2950
Wire Wire Line
	6300 3750 6300 3850
Wire Wire Line
	6500 3850 6500 3950
$Comp
L Device:C_Small C_8
U 1 1 604F953F
P 6400 3850
F 0 "C_8" V 6263 3850 50  0000 C BNN
F 1 "100nF" V 6262 3850 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 6400 3850 50  0001 C CNN
F 3 "~" H 6400 3850 50  0001 C CNN
	1    6400 3850
	0    1    1    0   
$EndComp
$Comp
L LED:WS2812B D_8
U 1 1 604F9545
P 6300 3450
F 0 "D_8" H 6644 3496 50  0000 R BNN
F 1 "WS2812B" H 6644 3405 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 6350 3150 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 6400 3075 50  0001 L TNN
	1    6300 3450
	1    0    0    -1  
$EndComp
Text Label 6500 3950 0    50   ~ 0
GND
Text Label 6300 3150 0    50   ~ 0
3V3
$Comp
L Connector:TestPoint TP_DIN_8
U 1 1 604F954D
P 6000 2950
F 0 "TP_DIN_8" H 6058 3068 50  0000 L CNN
F 1 "TestPoint" H 6058 2977 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_1.5x1.5mm_Drill0.7mm" H 6200 2950 50  0001 C CNN
F 3 "~" H 6200 2950 50  0001 C CNN
	1    6000 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 3450 6000 3450
Wire Wire Line
	6000 3450 6000 2950
Connection ~ 6000 3450
$Comp
L Connector:TestPoint TP_DOUT_8
U 1 1 604F9556
P 6600 2950
F 0 "TP_DOUT_8" H 6658 3068 50  0000 L CNN
F 1 "TestPoint" H 6658 2977 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.5mm_Drill0.7mm" H 6800 2950 50  0001 C CNN
F 3 "~" H 6800 2950 50  0001 C CNN
	1    6600 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	6600 3450 6600 2950
Wire Wire Line
	6600 1800 7300 1800
Wire Wire Line
	7300 1800 7300 2450
Wire Wire Line
	7300 2450 1600 2450
Wire Wire Line
	1600 2450 1600 3450
Connection ~ 6600 1800
$Comp
L Device:R R_RGB_1
U 1 1 60D9AF80
P 1600 1650
F 0 "R_RGB_1" H 1530 1696 50  0000 R CNN
F 1 "300 - 500R" H 1530 1605 50  0000 R CNN
F 2 "Keebio-Parts:Resistor-Hybrid" V 1530 1650 50  0001 C CNN
F 3 "~" H 1600 1650 50  0001 C CNN
	1    1600 1650
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP_DIN_RGB_1
U 1 1 604C3051
P 1600 1500
F 0 "TP_DIN_RGB_1" H 1658 1618 50  0000 L CNN
F 1 "TestPoint" H 1658 1527 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.5mm_Drill0.7mm" H 1800 1500 50  0001 C CNN
F 3 "~" H 1800 1500 50  0001 C CNN
	1    1600 1500
	1    0    0    -1  
$EndComp
Text Label 800  1100 0    50   ~ 0
3V3
$Comp
L Connector:Conn_01x04_Male J1
U 1 1 60525E02
P 600 1200
F 0 "J1" H 708 1481 50  0000 C CNN
F 1 "Conn_01x04_Male" H 708 1390 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 600 1200 50  0001 C CNN
F 3 "~" H 600 1200 50  0001 C CNN
	1    600  1200
	1    0    0    -1  
$EndComp
Text Label 800  1200 0    50   ~ 0
GND
Text Label 800  1300 0    50   ~ 0
RGB_IN
Text Label 1600 1500 0    50   ~ 0
RGB_IN
Text Label 800  1400 0    50   ~ 0
RGB_OUT
Text Label 6600 2950 0    50   ~ 0
RGB_OUT
$EndSCHEMATC
