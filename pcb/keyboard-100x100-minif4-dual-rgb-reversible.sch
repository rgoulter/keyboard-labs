EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Reversible Split Keyboard Half"
Date "2021-03-07"
Rev "2021.2"
Comp "Richard Goulter"
Comment1 "SK6812mini-e used for per-key RGBs. SK6812 for underglow."
Comment2 "TRRS Jacks connected to UART or I2C."
Comment3 "Switch \"matrix\" is a collection of switches, each directly connected to the controller."
Comment4 "Split keyboard half for the WeAct Studio MiniF4 dev board."
$EndDescr
$Comp
L LED:WS2812B D_21
U 1 1 5FE09A18
P 6200 4150
F 0 "D_21" H 6544 4196 50  0000 R BNN
F 1 "WS2812B" H 6544 4105 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 6250 3850 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 6300 3775 50  0001 L TNN
	1    6200 4150
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_22
U 1 1 5FE0A54D
P 6800 4150
F 0 "D_22" H 7144 4196 50  0000 R BNN
F 1 "WS2812B" H 7144 4105 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 6850 3850 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 6900 3775 50  0001 L TNN
	1    6800 4150
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_23
U 1 1 5FE0AEAE
P 7400 4150
F 0 "D_23" H 7744 4196 50  0000 R BNN
F 1 "WS2812B" H 7744 4105 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 7450 3850 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 7500 3775 50  0001 L TNN
	1    7400 4150
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_24
U 1 1 5FE0B5ED
P 8000 4150
F 0 "D_24" H 8344 4196 50  0000 R BNN
F 1 "WS2812B" H 8344 4105 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 8050 3850 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 8100 3775 50  0001 L TNN
	1    8000 4150
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_31
U 1 1 5FE12EFC
P 6200 5000
F 0 "D_31" H 6544 5046 50  0000 R BNN
F 1 "WS2812B" H 6544 4955 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 6250 4700 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 6300 4625 50  0001 L TNN
	1    6200 5000
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_32
U 1 1 5FE13A31
P 6800 5000
F 0 "D_32" H 7144 5046 50  0000 R BNN
F 1 "WS2812B" H 7144 4955 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 6850 4700 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 6900 4625 50  0001 L TNN
	1    6800 5000
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_33
U 1 1 5FE1469E
P 7400 5000
F 0 "D_33" H 7744 5046 50  0000 R BNN
F 1 "WS2812B" H 7744 4955 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 7450 4700 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 7500 4625 50  0001 L TNN
	1    7400 5000
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_34
U 1 1 5FE15110
P 8000 5000
F 0 "D_34" H 8344 5046 50  0000 R BNN
F 1 "WS2812B" H 8344 4955 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 8050 4700 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 8100 4625 50  0001 L TNN
	1    8000 5000
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_35
U 1 1 5FE15BD0
P 8600 5000
F 0 "D_35" H 8944 5046 50  0000 R BNN
F 1 "WS2812B" H 8944 4955 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 8650 4700 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 8700 4625 50  0001 L TNN
	1    8600 5000
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_42
U 1 1 5FE1838E
P 8000 5850
F 0 "D_42" H 8344 5896 50  0000 R BNN
F 1 "WS2812B" H 8344 5805 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 8050 5550 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 8100 5475 50  0001 L TNN
	1    8000 5850
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_41
U 1 1 5FE18995
P 7400 5850
F 0 "D_41" H 7744 5896 50  0000 R BNN
F 1 "WS2812B" H 7744 5805 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 7450 5550 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 7500 5475 50  0001 L TNN
	1    7400 5850
	1    0    0    -1  
$EndComp
Text Label 900  7200 2    50   ~ 0
SCL_TX
Text Label 900  7300 2    50   ~ 0
SDA_RX
$Comp
L LED:WS2812B D_13
U 1 1 5FE0782B
P 7400 3300
F 0 "D_13" H 7744 3346 50  0000 R BNN
F 1 "WS2812B" H 7744 3255 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 7450 3000 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 7500 2925 50  0001 L TNN
	1    7400 3300
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_12
U 1 1 5FDFCDFD
P 6800 3300
F 0 "D_12" H 7144 3346 50  0000 R BNN
F 1 "WS2812B" H 7144 3255 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 6850 3000 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 6900 2925 50  0001 L TNN
	1    6800 3300
	1    0    0    -1  
$EndComp
Text Label 8900 3300 3    50   ~ 0
DOUT_1
Text Label 5900 4150 1    50   ~ 0
DOUT_1
Text Label 8900 4150 3    50   ~ 0
DOUT_2
Text Label 5900 5000 1    50   ~ 0
DOUT_2
Text Label 8900 5000 3    50   ~ 0
DOUT_3
Text Label 7100 5850 1    50   ~ 0
DOUT_3
$Comp
L Device:C_Small C_13
U 1 1 60413182
P 7500 3700
F 0 "C_13" V 7363 3700 50  0000 C BNN
F 1 "100nF" V 7362 3700 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 7500 3700 50  0001 C CNN
F 3 "~" H 7500 3700 50  0001 C CNN
	1    7500 3700
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_14
U 1 1 60413695
P 8100 3700
F 0 "C_14" V 7963 3700 50  0000 C BNN
F 1 "100nF" V 7962 3700 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 8100 3700 50  0001 C CNN
F 3 "~" H 8100 3700 50  0001 C CNN
	1    8100 3700
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_15
U 1 1 60413B35
P 8700 3700
F 0 "C_15" V 8563 3700 50  0000 C BNN
F 1 "100nF" V 8562 3700 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 8700 3700 50  0001 C CNN
F 3 "~" H 8700 3700 50  0001 C CNN
	1    8700 3700
	0    1    1    0   
$EndComp
$Comp
L LED:WS2812B D_43
U 1 1 5FE16705
P 8600 5850
F 0 "D_43" H 8944 5896 50  0000 R BNN
F 1 "WS2812B" H 8944 5805 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 8650 5550 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 8700 5475 50  0001 L TNN
	1    8600 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	6200 3600 6200 3700
Wire Wire Line
	6800 3600 6800 3700
Wire Wire Line
	7400 3600 7400 3700
Wire Wire Line
	8000 3600 8000 3700
Wire Wire Line
	8600 3600 8600 3700
$Comp
L Device:C_Small C_21
U 1 1 604CF796
P 6300 4550
F 0 "C_21" V 6163 4550 50  0000 C BNN
F 1 "100nF" V 6162 4550 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 6300 4550 50  0001 C CNN
F 3 "~" H 6300 4550 50  0001 C CNN
	1    6300 4550
	0    1    1    0   
$EndComp
Wire Wire Line
	6400 3800 7000 3800
Wire Wire Line
	6400 3700 6400 3800
Wire Wire Line
	7000 3700 7000 3800
Connection ~ 7000 3800
Wire Wire Line
	7000 3800 7600 3800
Wire Wire Line
	7600 3700 7600 3800
Connection ~ 7600 3800
Wire Wire Line
	7600 3800 8200 3800
Wire Wire Line
	8200 3700 8200 3800
Connection ~ 8200 3800
Wire Wire Line
	8200 3800 8800 3800
Wire Wire Line
	8800 3700 8800 3800
Connection ~ 8800 3800
Wire Wire Line
	8800 3800 8950 3800
Wire Wire Line
	6800 3000 6200 3000
Connection ~ 6200 3000
Wire Wire Line
	7400 3000 6800 3000
Connection ~ 7400 3000
Wire Wire Line
	7400 3000 8000 3000
Connection ~ 6800 3000
Wire Wire Line
	8600 3000 8000 3000
Connection ~ 8000 3000
Wire Wire Line
	8600 3850 8000 3850
Wire Wire Line
	8000 3850 7400 3850
Connection ~ 8000 3850
Wire Wire Line
	7400 3850 6800 3850
Connection ~ 7400 3850
Wire Wire Line
	6800 3850 6200 3850
Connection ~ 6800 3850
Wire Wire Line
	8950 3800 8950 4650
$Comp
L LED:WS2812B D_25
U 1 1 5FE0C1BE
P 8600 4150
F 0 "D_25" H 8944 4196 50  0000 R BNN
F 1 "WS2812B" H 8944 4105 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 8650 3850 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 8700 3775 50  0001 L TNN
	1    8600 4150
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C_22
U 1 1 60572158
P 6900 4550
F 0 "C_22" V 6763 4550 50  0000 C BNN
F 1 "100nF" V 6762 4550 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 6900 4550 50  0001 C CNN
F 3 "~" H 6900 4550 50  0001 C CNN
	1    6900 4550
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_23
U 1 1 6057250D
P 7500 4550
F 0 "C_23" V 7363 4550 50  0000 C BNN
F 1 "100nF" V 7362 4550 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 7500 4550 50  0001 C CNN
F 3 "~" H 7500 4550 50  0001 C CNN
	1    7500 4550
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_24
U 1 1 605729BF
P 8100 4550
F 0 "C_24" V 7963 4550 50  0000 C BNN
F 1 "100nF" V 7962 4550 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 8100 4550 50  0001 C CNN
F 3 "~" H 8100 4550 50  0001 C CNN
	1    8100 4550
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_25
U 1 1 60572EE4
P 8700 4550
F 0 "C_25" V 8563 4550 50  0000 C BNN
F 1 "100nF" V 8562 4550 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 8700 4550 50  0001 C CNN
F 3 "~" H 8700 4550 50  0001 C CNN
	1    8700 4550
	0    1    1    0   
$EndComp
Wire Wire Line
	6200 4450 6200 4550
Wire Wire Line
	6400 4550 6400 4650
Wire Wire Line
	6400 4650 7000 4650
Wire Wire Line
	6800 4450 6800 4550
Wire Wire Line
	7000 4550 7000 4650
Connection ~ 7000 4650
Wire Wire Line
	7000 4650 7600 4650
Wire Wire Line
	7400 4450 7400 4550
Wire Wire Line
	7600 4550 7600 4650
Connection ~ 7600 4650
Wire Wire Line
	7600 4650 8200 4650
Wire Wire Line
	8000 4450 8000 4550
Wire Wire Line
	8200 4550 8200 4650
Connection ~ 8200 4650
Wire Wire Line
	8200 4650 8800 4650
Wire Wire Line
	8600 4450 8600 4550
Wire Wire Line
	8800 4550 8800 4650
Connection ~ 8800 4650
Wire Wire Line
	8800 4650 8950 4650
$Comp
L Device:C_Small C_41
U 1 1 605C286C
P 7500 6250
F 0 "C_41" V 7363 6250 50  0000 C BNN
F 1 "100nF" V 7362 6250 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 7500 6250 50  0001 C CNN
F 3 "~" H 7500 6250 50  0001 C CNN
	1    7500 6250
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_32
U 1 1 605C3368
P 6900 5400
F 0 "C_32" V 6763 5400 50  0000 C BNN
F 1 "100nF" V 6762 5400 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 6900 5400 50  0001 C CNN
F 3 "~" H 6900 5400 50  0001 C CNN
	1    6900 5400
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_33
U 1 1 605C388D
P 7500 5400
F 0 "C_33" V 7363 5400 50  0000 C BNN
F 1 "100nF" V 7362 5400 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 7500 5400 50  0001 C CNN
F 3 "~" H 7500 5400 50  0001 C CNN
	1    7500 5400
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_34
U 1 1 605C3C2B
P 8100 5400
F 0 "C_34" V 7963 5400 50  0000 C BNN
F 1 "100nF" V 7962 5400 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 8100 5400 50  0001 C CNN
F 3 "~" H 8100 5400 50  0001 C CNN
	1    8100 5400
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_35
U 1 1 605C4025
P 8700 5400
F 0 "C_35" V 8563 5400 50  0000 C BNN
F 1 "100nF" V 8562 5400 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 8700 5400 50  0001 C CNN
F 3 "~" H 8700 5400 50  0001 C CNN
	1    8700 5400
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_42
U 1 1 605CBDEC
P 8100 6250
F 0 "C_42" V 7963 6250 50  0000 C BNN
F 1 "100nF" V 7962 6250 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 8100 6250 50  0001 C CNN
F 3 "~" H 8100 6250 50  0001 C CNN
	1    8100 6250
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_43
U 1 1 605CC18A
P 8700 6250
F 0 "C_43" V 8563 6250 50  0000 C BNN
F 1 "100nF" V 8562 6250 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 8700 6250 50  0001 C CNN
F 3 "~" H 8700 6250 50  0001 C CNN
	1    8700 6250
	0    1    1    0   
$EndComp
Wire Wire Line
	8600 5550 8000 5550
Wire Wire Line
	8000 5550 7400 5550
Connection ~ 8000 5550
Connection ~ 7400 5550
$Comp
L Device:C_Small C_31
U 1 1 60618AAF
P 6300 5400
F 0 "C_31" V 6163 5400 50  0000 C BNN
F 1 "100nF" V 6162 5400 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 6300 5400 50  0001 C CNN
F 3 "~" H 6300 5400 50  0001 C CNN
	1    6300 5400
	0    1    1    0   
$EndComp
Wire Wire Line
	6200 5300 6200 5400
Wire Wire Line
	6800 5300 6800 5400
Wire Wire Line
	7400 5300 7400 5400
Wire Wire Line
	8000 5300 8000 5400
Wire Wire Line
	8600 5300 8600 5400
Wire Wire Line
	6400 5400 6400 5500
Wire Wire Line
	6400 5500 7000 5500
Wire Wire Line
	8950 5500 8950 6350
Wire Wire Line
	7000 5400 7000 5500
Connection ~ 7000 5500
Wire Wire Line
	7000 5500 7600 5500
Wire Wire Line
	7600 5400 7600 5500
Connection ~ 7600 5500
Wire Wire Line
	7600 5500 8200 5500
Wire Wire Line
	8200 5400 8200 5500
Connection ~ 8200 5500
Wire Wire Line
	8200 5500 8800 5500
Wire Wire Line
	8800 5400 8800 5500
Connection ~ 8800 5500
Wire Wire Line
	8800 5500 8950 5500
Wire Wire Line
	7400 6150 7400 6250
Wire Wire Line
	7600 6250 7600 6350
Wire Wire Line
	7600 6350 8200 6350
Wire Wire Line
	8000 6150 8000 6250
Wire Wire Line
	8200 6250 8200 6350
Connection ~ 8200 6350
Wire Wire Line
	8200 6350 8800 6350
Wire Wire Line
	8800 6250 8800 6350
Connection ~ 8800 6350
Wire Wire Line
	8800 6350 8950 6350
Text Label 5600 3000 1    50   ~ 0
RGB_DIN_5V
Wire Wire Line
	5800 3000 6200 3000
Wire Wire Line
	5800 3000 5800 3850
Wire Wire Line
	5800 3850 6200 3850
Connection ~ 6200 3850
Wire Wire Line
	5800 3850 5800 4700
Connection ~ 5800 3850
Wire Wire Line
	5800 5550 7400 5550
Wire Wire Line
	8600 6150 8600 6250
$Comp
L LED:WS2812B D_15
U 1 1 5FE0912C
P 8600 3300
F 0 "D_15" H 8944 3346 50  0000 R BNN
F 1 "WS2812B" H 8944 3255 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 8650 3000 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 8700 2925 50  0001 L TNN
	1    8600 3300
	1    0    0    -1  
$EndComp
$Comp
L LED:WS2812B D_14
U 1 1 5FE08387
P 8000 3300
F 0 "D_14" H 8344 3346 50  0000 R BNN
F 1 "WS2812B" H 8344 3255 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 8050 3000 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 8100 2925 50  0001 L TNN
	1    8000 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	8600 4700 8000 4700
Wire Wire Line
	7400 4700 8000 4700
Connection ~ 8000 4700
Wire Wire Line
	7400 4700 6800 4700
Connection ~ 7400 4700
Wire Wire Line
	6800 4700 6200 4700
Connection ~ 6800 4700
Wire Wire Line
	6200 4700 5800 4700
Connection ~ 6200 4700
Wire Wire Line
	5800 4700 5800 5550
Connection ~ 5800 4700
$Comp
L Device:R R4
U 1 1 60D9AF80
P 5600 3150
F 0 "R4" H 5530 3196 50  0000 R CNN
F 1 "300 - 500R" H 5530 3105 50  0000 R CNN
F 2 "ProjectLocal:Resistor-Hybrid" V 5530 3150 50  0001 C CNN
F 3 "~" H 5600 3150 50  0001 C CNN
	1    5600 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 3300 5900 3300
$Comp
L Jumper:SolderJumper_3_Open JP1
U 1 1 60FF4E5E
P 4050 6900
F 0 "JP1" V 4050 6968 50  0000 L CNN
F 1 "SolderJumper_3_Open" V 4095 6968 50  0001 L CNN
F 2 "Jumper:SolderJumper-3_P1.3mm_Open_Pad1.0x1.5mm_NumberLabels" H 4050 6900 50  0001 C CNN
F 3 "~" H 4050 6900 50  0001 C CNN
	1    4050 6900
	0    1    1    0   
$EndComp
$Comp
L Jumper:SolderJumper_3_Open JP2
U 1 1 60FF5D91
P 4050 7500
F 0 "JP2" V 4050 7568 50  0000 L CNN
F 1 "SolderJumper_3_Open" V 4095 7568 50  0001 L CNN
F 2 "Jumper:SolderJumper-3_P1.3mm_Open_Pad1.0x1.5mm_NumberLabels" H 4050 7500 50  0001 C CNN
F 3 "~" H 4050 7500 50  0001 C CNN
	1    4050 7500
	0    1    1    0   
$EndComp
Text Label 4200 7300 0    50   ~ 0
SDA_RX_r
Text Label 4200 7700 0    50   ~ 0
SCL_TX_r
Text Label 5800 2900 0    50   ~ 0
5V
Text Label 8950 6450 2    50   ~ 0
GND
Connection ~ 8950 6350
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
L Device:C_Small C_12
U 1 1 60412CB4
P 6900 3700
F 0 "C_12" V 6763 3700 50  0000 C BNN
F 1 "100nF" V 6762 3700 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 6900 3700 50  0001 C CNN
F 3 "~" H 6900 3700 50  0001 C CNN
	1    6900 3700
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_11
U 1 1 603D2DAA
P 6300 3700
F 0 "C_11" V 6163 3700 50  0000 C BNN
F 1 "100nF" V 6162 3700 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 6300 3700 50  0001 C CNN
F 3 "~" H 6300 3700 50  0001 C CNN
	1    6300 3700
	0    1    1    0   
$EndComp
$Comp
L LED:WS2812B D_11
U 1 1 5FD534E8
P 6200 3300
F 0 "D_11" H 6544 3346 50  0000 R BNN
F 1 "WS2812B" H 6544 3255 50  0001 L TNN
F 2 "ProjectLocal:SK6812-MINI-E_Reversible" H 6250 3000 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf" H 6300 2925 50  0001 L TNN
	1    6200 3300
	1    0    0    -1  
$EndComp
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
L keebio:TRRS J2
U 1 1 5FDFA2E7
P 2650 7500
F 0 "J2" H 2567 8187 60  0000 C CNN
F 1 "TRRS" H 2567 8081 60  0000 C CNN
F 2 "Keebio-Parts:TRRS-PJ-320A" H 2800 7500 60  0001 C CNN
F 3 "" H 2800 7500 60  0001 C CNN
	1    2650 7500
	-1   0    0    -1  
$EndComp
NoConn ~ 2500 2700
NoConn ~ 2500 2800
NoConn ~ 2500 2900
Text Label 2500 2200 0    50   ~ 0
SW43
Text Label 2500 2100 0    50   ~ 0
SW42
Text Label 2500 2000 0    50   ~ 0
SW41
Text Label 2500 1900 0    50   ~ 0
SW35
Text Label 2500 1800 0    50   ~ 0
SW34
Text Label 2500 1700 0    50   ~ 0
SW33
Text Label 2500 1600 0    50   ~ 0
SW32
Text Label 2500 2400 0    50   ~ 0
SW31
Text Label 2500 1400 0    50   ~ 0
SW25
Text Label 900  2200 2    50   ~ 0
SW24
Text Label 900  2100 2    50   ~ 0
SW23
Text Label 900  2000 2    50   ~ 0
SW22
Text Label 900  2300 2    50   ~ 0
SW21
Text Label 2500 2300 0    50   ~ 0
SW15
Text Label 900  1700 2    50   ~ 0
SW14
Text Label 900  1600 2    50   ~ 0
SW13
Text Label 900  1500 2    50   ~ 0
SW12
Text Label 900  1400 2    50   ~ 0
SW11
NoConn ~ 2500 3000
Text Label 900  2500 2    50   ~ 0
SDA_RX
Text Label 900  2400 2    50   ~ 0
SCL_TX
Wire Wire Line
	5800 2900 5800 3000
Connection ~ 5800 3000
Wire Wire Line
	8950 6350 8950 6450
Text Label 3000 7400 0    50   ~ 0
GND
Text Label 3000 7100 0    50   ~ 0
5V
Text Label 1450 7100 2    50   ~ 0
5V
Text Label 1450 7400 2    50   ~ 0
GND
Wire Wire Line
	8950 5500 8950 4650
Connection ~ 8950 5500
Connection ~ 8950 4650
Text Label 2500 1300 0    50   ~ 0
3V3
Text Label 2500 1200 0    50   ~ 0
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
5V
Text Label 1500 5750 1    50   ~ 0
5V
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
	4800 2650 11200 2650
Wire Notes Line
	500  3350 4800 3350
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
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 6200 2150 50  0001 C CNN
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
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 8000 2150 50  0001 C CNN
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
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 7400 2150 50  0001 C CNN
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
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 6800 2150 50  0001 C CNN
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
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 6800 1650 50  0001 C CNN
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
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 7400 1650 50  0001 C CNN
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
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 8000 1650 50  0001 C CNN
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
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 7400 2650 50  0001 C CNN
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
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 8000 2650 50  0001 C CNN
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
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 8600 2650 50  0001 C CNN
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
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 8600 2150 50  0001 C CNN
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
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 8600 1650 50  0001 C CNN
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
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 8600 1150 50  0001 C CNN
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
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 8000 1150 50  0001 C CNN
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
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 7400 1150 50  0001 C CNN
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
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 6800 1150 50  0001 C CNN
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
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 6200 1650 50  0001 C CNN
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
F 2 "ProjectLocal:SW_MX_PG1350_reversible" H 6200 1150 50  0001 C CNN
F 3 "~" H 6200 1150 50  0001 C CNN
	1    6200 950 
	1    0    0    -1  
$EndComp
Text Notes 9100 950  0    50   ~ 0
Grid of switches for the PCB half.\n\nEach switch is connected directly to\na pin of the microcontroller, and to GND.
Text Notes 9150 3150 0    50   ~ 0
Grid of WS2812-compatible RGB LEDs,\narranged in the same order as the key switches.\n\nEach DOUT connects to the DIN of the next LED.
Text Notes 700  650  0    50   ~ 0
The WeAct Studo MiniF4 dev board.
NoConn ~ 2500 1500
NoConn ~ 900  1800
NoConn ~ 900  1900
$Comp
L Mechanical:MountingHole H1
U 1 1 602E59E6
P 9700 1750
F 0 "H1" H 9800 1796 50  0000 L CNN
F 1 "MountingHole" H 9800 1705 50  0000 L CNN
F 2 "ProjectLocal:Bumpon_3M_F0502" H 9700 1750 50  0001 C CNN
F 3 "~" H 9700 1750 50  0001 C CNN
	1    9700 1750
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 602EA31E
P 9700 1950
F 0 "H2" H 9800 1996 50  0000 L CNN
F 1 "MountingHole" H 9800 1905 50  0000 L CNN
F 2 "ProjectLocal:Bumpon_3M_F0502" H 9700 1950 50  0001 C CNN
F 3 "~" H 9700 1950 50  0001 C CNN
	1    9700 1950
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 602EA63D
P 9700 2150
F 0 "H3" H 9800 2196 50  0000 L CNN
F 1 "MountingHole" H 9800 2105 50  0000 L CNN
F 2 "ProjectLocal:Bumpon_3M_F0502" H 9700 2150 50  0001 C CNN
F 3 "~" H 9700 2150 50  0001 C CNN
	1    9700 2150
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H4
U 1 1 602EA8E5
P 9700 2350
F 0 "H4" H 9800 2396 50  0000 L CNN
F 1 "MountingHole" H 9800 2305 50  0000 L CNN
F 2 "ProjectLocal:Bumpon_3M_F0502" H 9700 2350 50  0001 C CNN
F 3 "~" H 9700 2350 50  0001 C CNN
	1    9700 2350
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H5
U 1 1 602EEB15
P 9700 2550
F 0 "H5" H 9800 2596 50  0000 L CNN
F 1 "MountingHole" H 9800 2505 50  0000 L CNN
F 2 "ProjectLocal:Bumpon_3M_F0502" H 9700 2550 50  0001 C CNN
F 3 "~" H 9700 2550 50  0001 C CNN
	1    9700 2550
	1    0    0    -1  
$EndComp
Text Label 3850 7400 2    50   ~ 0
TRRS_R1
Text Label 1300 7000 1    50   ~ 0
TRRS_R2
Text Label 1150 7000 1    50   ~ 0
TRRS_R1
Text Label 4200 6700 0    50   ~ 0
SCL_TX_r
Text Label 3000 7200 0    50   ~ 0
SCL_TX_r
Text Label 3000 7300 0    50   ~ 0
SDA_RX_r
Text Label 3750 6900 2    50   ~ 0
SCL_TX
Text Label 3750 7500 2    50   ~ 0
SDA_RX
Wire Wire Line
	3900 6900 3850 6900
Wire Wire Line
	3900 7500 3850 7500
Text Label 3850 6800 2    50   ~ 0
TRRS_R2
Text Notes 2400 6500 0    50   ~ 0
The TRRS jacks for connecting the two PCB halves.\n\nOnly one-of J1 or J_2 assembled depending on\nwhether PCB is left or right half.\n\nResistors pull the data inputs up so that the PCB half\ncan be used without the other half being connected.\n\nJumpers used to allow either PB6, PB7 of the left half\nto connect to PB6, PB7 or to PB7, PB6 of the right half.\ni.e. jumping:\n pad 1: I2C with SCL<->SCL, SDA<->SDA; or\n pad 3: UART with TX->RX, RX<-TX.
Wire Wire Line
	3850 6800 3850 6900
Connection ~ 3850 6900
Wire Wire Line
	3850 6900 3750 6900
Wire Wire Line
	3850 7400 3850 7500
Connection ~ 3850 7500
Wire Wire Line
	3850 7500 3750 7500
NoConn ~ 2500 2600
$Comp
L Mechanical:MountingHole H6
U 1 1 603C44C9
P 10550 1750
F 0 "H6" H 10650 1796 50  0000 L CNN
F 1 "MountingHole" H 10650 1705 50  0000 L CNN
F 2 "ProjectLocal:H_M2_Spacer_Hole" H 10550 1750 50  0001 C CNN
F 3 "~" H 10550 1750 50  0001 C CNN
	1    10550 1750
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H7
U 1 1 603C4D5A
P 10550 1950
F 0 "H7" H 10650 1996 50  0000 L CNN
F 1 "MountingHole" H 10650 1905 50  0000 L CNN
F 2 "ProjectLocal:H_M2_Spacer_Hole" H 10550 1950 50  0001 C CNN
F 3 "~" H 10550 1950 50  0001 C CNN
	1    10550 1950
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H8
U 1 1 603C5079
P 10550 2150
F 0 "H8" H 10650 2196 50  0000 L CNN
F 1 "MountingHole" H 10650 2105 50  0000 L CNN
F 2 "ProjectLocal:H_M2_Spacer_Hole" H 10550 2150 50  0001 C CNN
F 3 "~" H 10550 2150 50  0001 C CNN
	1    10550 2150
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H9
U 1 1 603C53A9
P 10550 2350
F 0 "H9" H 10650 2396 50  0000 L CNN
F 1 "MountingHole" H 10650 2305 50  0000 L CNN
F 2 "ProjectLocal:H_M2_Spacer_Hole" H 10550 2350 50  0001 C CNN
F 3 "~" H 10550 2350 50  0001 C CNN
	1    10550 2350
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H10
U 1 1 603C55A7
P 10550 2550
F 0 "H10" H 10650 2596 50  0000 L CNN
F 1 "MountingHole" H 10650 2505 50  0000 L CNN
F 2 "ProjectLocal:H_M2_Spacer_Hole" H 10550 2550 50  0001 C CNN
F 3 "~" H 10550 2550 50  0001 C CNN
	1    10550 2550
	1    0    0    -1  
$EndComp
$Comp
L LED:SK6812 D_BL_1
U 1 1 603FF78B
P 10100 3850
F 0 "D_BL_1" V 10054 4194 50  0000 L CNN
F 1 "SK6812" V 10145 4194 50  0000 L CNN
F 2 "ProjectLocal:LED_SK6812_PLCC4_5.0x5.0mm_P3.2mm_Reversible" H 10150 3550 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/product-files/1138/SK6812+LED+datasheet+.pdf" H 10200 3475 50  0001 L TNN
	1    10100 3850
	0    1    1    0   
$EndComp
$Comp
L LED:SK6812 D_BL_2
U 1 1 60401C03
P 10100 4450
F 0 "D_BL_2" V 10054 4794 50  0000 L CNN
F 1 "SK6812" V 10145 4794 50  0000 L CNN
F 2 "ProjectLocal:LED_SK6812_PLCC4_5.0x5.0mm_P3.2mm_Reversible" H 10150 4150 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/product-files/1138/SK6812+LED+datasheet+.pdf" H 10200 4075 50  0001 L TNN
	1    10100 4450
	0    1    1    0   
$EndComp
$Comp
L LED:SK6812 D_BL_3
U 1 1 60409922
P 10100 5050
F 0 "D_BL_3" V 10054 5394 50  0000 L CNN
F 1 "SK6812" V 10145 5394 50  0000 L CNN
F 2 "ProjectLocal:LED_SK6812_PLCC4_5.0x5.0mm_P3.2mm_Reversible" H 10150 4750 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/product-files/1138/SK6812+LED+datasheet+.pdf" H 10200 4675 50  0001 L TNN
	1    10100 5050
	0    1    1    0   
$EndComp
$Comp
L LED:SK6812 D_BL_4
U 1 1 6040B9B5
P 10100 5650
F 0 "D_BL_4" V 10054 5994 50  0000 L CNN
F 1 "SK6812" V 10145 5994 50  0000 L CNN
F 2 "ProjectLocal:LED_SK6812_PLCC4_5.0x5.0mm_P3.2mm_Reversible" H 10150 5350 50  0001 L TNN
F 3 "https://cdn-shop.adafruit.com/product-files/1138/SK6812+LED+datasheet+.pdf" H 10200 5275 50  0001 L TNN
	1    10100 5650
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C_BL_1
U 1 1 6040C40C
P 9650 3950
F 0 "C_BL_1" V 9513 3950 50  0000 C BNN
F 1 "100nF" V 9512 3950 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 9650 3950 50  0001 C CNN
F 3 "~" H 9650 3950 50  0001 C CNN
	1    9650 3950
	-1   0    0    1   
$EndComp
$Comp
L Device:C_Small C_BL_2
U 1 1 6040D1BF
P 9650 4550
F 0 "C_BL_2" V 9513 4550 50  0000 C BNN
F 1 "100nF" V 9512 4550 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 9650 4550 50  0001 C CNN
F 3 "~" H 9650 4550 50  0001 C CNN
	1    9650 4550
	-1   0    0    1   
$EndComp
$Comp
L Device:C_Small C_BL_3
U 1 1 6040D6FB
P 9650 5150
F 0 "C_BL_3" V 9513 5150 50  0000 C BNN
F 1 "100nF" V 9512 5150 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 9650 5150 50  0001 C CNN
F 3 "~" H 9650 5150 50  0001 C CNN
	1    9650 5150
	-1   0    0    1   
$EndComp
$Comp
L Device:C_Small C_BL_4
U 1 1 6040D957
P 9700 5750
F 0 "C_BL_4" V 9563 5750 50  0000 C BNN
F 1 "100nF" V 9562 5750 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 9700 5750 50  0001 C CNN
F 3 "~" H 9700 5750 50  0001 C CNN
	1    9700 5750
	-1   0    0    1   
$EndComp
Text Label 9550 6000 0    50   ~ 0
GND
Text Label 8900 5850 3    50   ~ 0
DOUT_4
Text Label 10100 3550 0    50   ~ 0
DOUT_4
Text Label 10400 3650 0    50   ~ 0
5V
Wire Wire Line
	9800 3850 9650 3850
Wire Wire Line
	9800 4450 9650 4450
Wire Wire Line
	9800 5050 9650 5050
Wire Wire Line
	9800 5650 9700 5650
Wire Wire Line
	9650 4050 9550 4050
Wire Wire Line
	9550 4050 9550 4650
Wire Wire Line
	9550 4650 9650 4650
Wire Wire Line
	9550 4650 9550 5250
Wire Wire Line
	9550 5250 9650 5250
Connection ~ 9550 4650
Wire Wire Line
	9550 5250 9550 5850
Wire Wire Line
	9550 5850 9700 5850
Connection ~ 9550 5250
Wire Wire Line
	9550 5850 9550 6000
Connection ~ 9550 5850
Wire Wire Line
	10400 3650 10400 3850
Wire Wire Line
	10400 3850 10400 4450
Connection ~ 10400 3850
Wire Wire Line
	10400 4450 10400 5050
Connection ~ 10400 4450
Wire Wire Line
	10400 5050 10400 5650
Connection ~ 10400 5050
Text Label 3650 2000 2    50   ~ 0
5V
Text Label 2500 1100 0    50   ~ 0
5V
Text Label 2500 2500 0    50   ~ 0
RGB_DIN_3V3
$Comp
L Connector:Conn_01x04_Female TP2
U 1 1 6044DBF5
P 5600 7450
F 0 "TP2" H 5628 7426 50  0000 L CNN
F 1 "Conn_01x04_Female" H 5628 7335 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 5600 7450 50  0001 C CNN
F 3 "~" H 5600 7450 50  0001 C CNN
	1    5600 7450
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x04_Female TP1
U 1 1 6044A893
P 5600 6850
F 0 "TP1" H 5628 6826 50  0000 L CNN
F 1 "Conn_01x04_Female" H 5628 6735 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 5600 6850 50  0001 C CNN
F 3 "~" H 5600 6850 50  0001 C CNN
	1    5600 6850
	1    0    0    -1  
$EndComp
Text Label 5400 6750 2    50   ~ 0
GND
Text Label 5400 7050 2    50   ~ 0
GND
Text Label 5400 6850 2    50   ~ 0
5V
Text Label 5400 6950 2    50   ~ 0
RGB_DIN_5V
Text Label 5400 7350 2    50   ~ 0
GND
Text Label 5400 7650 2    50   ~ 0
GND
Text Label 5400 7450 2    50   ~ 0
5V
Text Label 10100 5950 0    50   ~ 0
DOUT_BL
Text Label 5400 7550 2    50   ~ 0
DOUT_BL
Text Notes 4950 6600 0    50   ~ 0
01x04 test point connectors for interfacing\nwith the WS2812-compatible RGBs.\n\nThis facilitates testing.\nIt allows the RGB LEDs to be driven\nwithout the U1 dev board being soldered in.\nIt also provides a way to use U1 to drive\nother WS2812-compatible RGB strips.
Text Label 3950 1800 2    50   ~ 0
RGB_DIN_3V3
Text Label 4350 2200 3    50   ~ 0
GND
Text Label 4250 1400 1    50   ~ 0
3V3
Text Label 4450 1400 1    50   ~ 0
5V
Text Label 4750 1800 0    50   ~ 0
RGB_DIN_5V
$Comp
L Device:R R3
U 1 1 603F5BAE
P 3800 2000
F 0 "R3" H 3870 2000 50  0000 L CNN
F 1 "2.2k - 10k" H 3870 1955 50  0000 L TNN
F 2 "ProjectLocal:Resistor-Hybrid" V 3730 2000 50  0001 C CNN
F 3 "~" H 3800 2000 50  0001 C CNN
	1    3800 2000
	0    1    1    0   
$EndComp
$Comp
L Logic_LevelTranslator:SN74LVC1T45DBV U2
U 1 1 603EC747
P 4350 1800
F 0 "U2" H 4700 2050 50  0000 L CNN
F 1 "SN74LVC1T45DBV" H 4700 1950 50  0000 L CNN
F 2 "ProjectLocal:SOT-23-6_Handsoldering_Reversible" H 4350 1350 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/sn74lvc1t45.pdf" H 3450 1150 50  0001 C CNN
	1    4350 1800
	1    0    0    -1  
$EndComp
Wire Notes Line
	3000 500  3000 3350
Wire Notes Line
	4800 2650 4800 7800
Wire Notes Line
	5800 500  5800 2650
Text Notes 3150 850  0    50   ~ 0
Convert the voltage of the RGB_DIN_3V3 signal to 5V\nso that the SK6812mini-e and SK6812 receive the\nRGB data reliably.
Text Label 4200 7100 0    50   ~ 0
SDA_RX_r
Wire Wire Line
	4050 6700 4200 6700
Wire Wire Line
	4050 7100 4200 7100
Wire Wire Line
	4050 7300 4200 7300
Wire Wire Line
	4050 7700 4200 7700
Text Label 850  4050 2    50   ~ 0
RE_A
Text Label 850  4250 2    50   ~ 0
RE_B
Text Label 850  4150 2    50   ~ 0
GND
Text Label 1450 4050 0    50   ~ 0
SW_RE
Text Label 1450 4250 0    50   ~ 0
GND
$Comp
L ProjectLocal:MiniF4 U1
U 1 1 5FD347E3
P 1700 2000
F 0 "U1" H 1700 3165 50  0000 C CNN
F 1 "MiniF4" H 1700 3074 50  0000 C CNN
F 2 "ProjectLocal:WeAct_MiniF4_ZigZag" H 3950 2450 50  0001 C CNN
F 3 "" V 2350 1150 50  0001 C CNN
	1    1700 2000
	1    0    0    -1  
$EndComp
Text Label 900  1100 2    50   ~ 0
RE_A
Text Label 900  1200 2    50   ~ 0
RE_B
Text Label 900  1300 2    50   ~ 0
SW_RE
Wire Notes Line
	11200 1250 9000 1250
Wire Notes Line
	9000 1250 9000 2650
Text Notes 9050 1600 0    50   ~ 0
Mechanical:\nH1-H5 for silkscreen hints for bumpons\n(and aid PCB layout),\nH6-H8 for holes for M2 spacers.
Text Notes 550  3550 0    50   ~ 0
Rotary encoder + switch.
$Comp
L Device:Rotary_Encoder_Switch SW_RE1
U 1 1 604C2BC3
P 1150 4150
F 0 "SW_RE1" H 1150 4517 50  0000 C CNN
F 1 "Rotary_Encoder_Switch" H 1150 4426 50  0000 C CNN
F 2 "Rotary_Encoder:RotaryEncoder_Alps_EC11E-Switch_Vertical_H20mm" H 1000 4310 50  0001 C CNN
F 3 "~" H 1150 4410 50  0001 C CNN
	1    1150 4150
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x04_Female J3
U 1 1 60521A32
P 4450 3700
F 0 "J3" V 4650 3700 50  0000 R CNN
F 1 "Conn_01x04_Female" V 4550 4150 50  0001 R CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x04_P2.54mm_Vertical" H 4450 3700 50  0001 C CNN
F 3 "~" H 4450 3700 50  0001 C CNN
	1    4450 3700
	0    -1   -1   0   
$EndComp
$Comp
L Jumper:SolderJumper_2_Open JP3
U 1 1 60528B37
P 2450 4450
F 0 "JP3" H 2450 4563 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 2450 4564 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm" H 2450 4450 50  0001 C CNN
F 3 "~" H 2450 4450 50  0001 C CNN
	1    2450 4450
	1    0    0    -1  
$EndComp
Text Notes 1850 3800 0    50   ~ 0
OLED module with I2C.\nPins are GND, VCC, SCL, SDA.\nHowever, since the board is reversible, and it’s easier\nto use the same 01x04 pins on the PCB,\nthe connections each have to be jumped.
$Comp
L Jumper:SolderJumper_2_Open JP4
U 1 1 6052FAA5
P 2450 4700
F 0 "JP4" H 2450 4813 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 2450 4814 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm" H 2450 4700 50  0001 C CNN
F 3 "~" H 2450 4700 50  0001 C CNN
	1    2450 4700
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Open JP5
U 1 1 6053034C
P 2450 4950
F 0 "JP5" H 2450 5063 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 2450 5064 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm" H 2450 4950 50  0001 C CNN
F 3 "~" H 2450 4950 50  0001 C CNN
	1    2450 4950
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Open JP6
U 1 1 60530B58
P 2450 5200
F 0 "JP6" H 2450 5313 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 2450 5314 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm" H 2450 5200 50  0001 C CNN
F 3 "~" H 2450 5200 50  0001 C CNN
	1    2450 5200
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Open JP7
U 1 1 60552AED
P 3800 4450
F 0 "JP7" H 3800 4563 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 3800 4564 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm" H 3800 4450 50  0001 C CNN
F 3 "~" H 3800 4450 50  0001 C CNN
	1    3800 4450
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Open JP8
U 1 1 60553356
P 3800 4700
F 0 "JP8" H 3800 4813 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 3800 4814 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm" H 3800 4700 50  0001 C CNN
F 3 "~" H 3800 4700 50  0001 C CNN
	1    3800 4700
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Open JP9
U 1 1 60553C5A
P 3800 4950
F 0 "JP9" H 3800 5063 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 3800 5064 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm" H 3800 4950 50  0001 C CNN
F 3 "~" H 3800 4950 50  0001 C CNN
	1    3800 4950
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Open JP10
U 1 1 605571DE
P 3800 5200
F 0 "JP10" H 3800 5313 50  0000 C CNN
F 1 "SolderJumper_2_Open" H 3800 5314 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm" H 3800 5200 50  0001 C CNN
F 3 "~" H 3800 5200 50  0001 C CNN
	1    3800 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4350 3900 2600 3900
Wire Wire Line
	4350 5200 3950 5200
Connection ~ 4350 3900
Wire Wire Line
	4450 3900 4450 4000
Wire Wire Line
	4450 4000 2700 4000
Wire Wire Line
	2700 4700 2600 4700
Wire Wire Line
	4450 4950 3950 4950
Connection ~ 4450 4000
Wire Wire Line
	4550 3900 4550 4100
Wire Wire Line
	4550 4100 2800 4100
Wire Wire Line
	2800 4950 2600 4950
Wire Wire Line
	4550 4700 3950 4700
Connection ~ 4550 4100
Wire Wire Line
	4650 4450 3950 4450
Wire Wire Line
	2600 3900 2600 4450
Wire Wire Line
	2700 4000 2700 4700
Wire Wire Line
	2800 4100 2800 4950
Wire Wire Line
	4650 3900 4650 4200
Wire Wire Line
	4550 4100 4550 4700
Wire Wire Line
	4450 4000 4450 4950
Wire Wire Line
	4350 3900 4350 5200
Wire Wire Line
	4650 4200 2900 4200
Wire Wire Line
	2900 4200 2900 5200
Wire Wire Line
	2900 5200 2600 5200
Connection ~ 4650 4200
Wire Wire Line
	4650 4200 4650 4450
Text Label 2300 4450 2    50   ~ 0
GND
Text Label 2300 4700 2    50   ~ 0
5V
Text Label 2300 4950 2    50   ~ 0
OLED_SCL
Text Label 2300 5200 2    50   ~ 0
OLED_SDA
Text Label 3650 4450 2    50   ~ 0
GND
Text Label 3650 4700 2    50   ~ 0
5V
Text Label 3650 4950 2    50   ~ 0
OLED_SCL
Text Label 3650 5200 2    50   ~ 0
OLED_SDA
$Comp
L Device:R R5
U 1 1 605F4492
P 850 4900
F 0 "R5" V 1050 4850 50  0000 L CNN
F 1 "2.2k - 10k" V 950 4700 50  0000 L TNN
F 2 "ProjectLocal:Resistor-Hybrid" V 780 4900 50  0001 C CNN
F 3 "~" H 850 4900 50  0001 C CNN
	1    850  4900
	0    -1   -1   0   
$EndComp
Wire Notes Line
	1800 3350 1800 4500
Wire Notes Line
	1800 4500 500  4500
$Comp
L Device:R R6
U 1 1 6061DE45
P 850 5250
F 0 "R6" V 1050 5200 50  0000 L CNN
F 1 "2.2k - 10k" V 950 5050 50  0000 L TNN
F 2 "ProjectLocal:Resistor-Hybrid" V 780 5250 50  0001 C CNN
F 3 "~" H 850 5250 50  0001 C CNN
	1    850  5250
	0    -1   -1   0   
$EndComp
Text Label 700  4900 2    50   ~ 0
3V3
Text Label 700  5250 2    50   ~ 0
3V3
Text Label 1000 4900 0    50   ~ 0
OLED_SCL
Text Label 1000 5250 0    50   ~ 0
OLED_SDA
Wire Notes Line
	500  5350 4800 5350
Text Notes 500  4600 0    50   ~ 0
Pull OLED I2C up.
Text Label 900  2700 2    50   ~ 0
OLED_SDA
Text Label 900  2600 2    50   ~ 0
OLED_SCL
$EndSCHEMATC
