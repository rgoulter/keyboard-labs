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
L Device:R R_RGB_1
U 1 1 60D9AF80
P 5600 3150
F 0 "R_RGB_1" H 5530 3196 50  0000 R CNN
F 1 "300 - 500R" H 5530 3105 50  0000 R CNN
F 2 "ProjectLocal:Resistor-Hybrid" V 5530 3150 50  0001 C CNN
F 3 "~" H 5600 3150 50  0001 C CNN
	1    5600 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 3300 5900 3300
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
Text Label 1150 2250 2    50   ~ 0
SDA_RX
Text Label 1150 2150 2    50   ~ 0
SCL_TX
Text Label 2750 2250 0    50   ~ 0
RGB_DIN_3V3
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
L Device:C_Small C_1
U 1 1 6040C40C
P 9650 3950
F 0 "C_1" V 9513 3950 50  0000 C BNN
F 1 "100nF" V 9512 3950 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 9650 3950 50  0001 C CNN
F 3 "~" H 9650 3950 50  0001 C CNN
	1    9650 3950
	-1   0    0    1   
$EndComp
$Comp
L Device:C_Small C_2
U 1 1 6040D1BF
P 9650 4550
F 0 "C_2" V 9513 4550 50  0000 C BNN
F 1 "100nF" V 9512 4550 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 9650 4550 50  0001 C CNN
F 3 "~" H 9650 4550 50  0001 C CNN
	1    9650 4550
	-1   0    0    1   
$EndComp
$Comp
L Device:C_Small C_3
U 1 1 6040D6FB
P 9650 5150
F 0 "C_3" V 9513 5150 50  0000 C BNN
F 1 "100nF" V 9512 5150 50  0000 C TNN
F 2 "ProjectLocal:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder_Dual" H 9650 5150 50  0001 C CNN
F 3 "~" H 9650 5150 50  0001 C CNN
	1    9650 5150
	-1   0    0    1   
$EndComp
$Comp
L Device:C_Small C_4
U 1 1 6040D957
P 9700 5750
F 0 "C_4" V 9563 5750 50  0000 C BNN
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
$Comp
L Logic_LevelTranslator:SN74LVC1T45DBV U2
U 1 1 603EC747
P 3950 2850
F 0 "U2" H 4394 2896 50  0000 L CNN
F 1 "SN74LVC1T45DBV" H 4394 2805 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23-6" H 3950 2400 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/sn74lvc1t45.pdf" H 3050 2200 50  0001 C CNN
	1    3950 2850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 603F5BAE
P 3400 3050
F 0 "R3" H 3470 3050 50  0000 L CNN
F 1 "2.2k - 10k" H 3470 3005 50  0000 L TNN
F 2 "ProjectLocal:Resistor-Hybrid" V 3330 3050 50  0001 C CNN
F 3 "~" H 3400 3050 50  0001 C CNN
	1    3400 3050
	0    1    1    0   
$EndComp
Text Label 3250 3050 2    50   ~ 0
5V
Text Label 4350 2850 0    50   ~ 0
RGB_DIN_5V
Text Label 3550 2850 2    50   ~ 0
RGB_DIN_3V3
Text Label 4050 2450 1    50   ~ 0
5V
Text Label 3850 2450 1    50   ~ 0
3V3
Text Label 2750 850  0    50   ~ 0
5V
Text Label 3950 3250 3    50   ~ 0
GND
$EndSCHEMATC
