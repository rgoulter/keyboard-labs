EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Connector USB-C 16-pin Soldering Practice"
Date "2021-12-01"
Rev ""
Comp ""
Comment1 "Small PCB for soldering practice for a 16-pin USB-C Connector."
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector:USB_C_Receptacle_USB2.0 J1
U 1 1 61A9403E
P 1200 1900
F 0 "J1" H 1307 2767 50  0000 C CNN
F 1 "USB_C_Receptacle_USB2.0" H 1307 2676 50  0000 C CNN
F 2 "Connector_USB:USB_C_Receptacle_Palconn_UTC16-G" H 1350 1900 50  0001 C CNN
F 3 "https://www.usb.org/sites/default/files/documents/usb_type-c.zip" H 1350 1900 50  0001 C CNN
	1    1200 1900
	1    0    0    -1  
$EndComp
Text Label 1800 1800 0    50   ~ 0
A7
$Comp
L Device:R R1
U 1 1 61A96095
P 2650 2450
F 0 "R1" H 2720 2496 50  0000 L CNN
F 1 "5.1K" H 2720 2405 50  0000 L CNN
F 2 "Keebio-Parts:Resistor-Hybrid" V 2580 2450 50  0001 C CNN
F 3 "~" H 2650 2450 50  0001 C CNN
	1    2650 2450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 61A9916A
P 3050 2450
F 0 "R2" H 3120 2496 50  0000 L CNN
F 1 "5.1K" H 3120 2405 50  0000 L CNN
F 2 "Keebio-Parts:Resistor-Hybrid" V 2980 2450 50  0001 C CNN
F 3 "~" H 3050 2450 50  0001 C CNN
	1    3050 2450
	1    0    0    -1  
$EndComp
Text Label 1800 1300 0    50   ~ 0
VBUS
$Comp
L Device:D D1
U 1 1 61A9BC3A
P 2950 1400
F 0 "D1" H 2950 1183 50  0000 C CNN
F 1 "D" H 2950 1274 50  0000 C CNN
F 2 "Keebio-Parts:Diode-dual" H 2950 1400 50  0001 C CNN
F 3 "~" H 2950 1400 50  0001 C CNN
	1    2950 1400
	-1   0    0    1   
$EndComp
Text Label 2800 1400 2    50   ~ 0
VBUS
Text Label 3100 1400 0    50   ~ 0
5V
$Comp
L power:GND #PWR0101
U 1 1 61A9DFC8
P 1200 2800
F 0 "#PWR0101" H 1200 2550 50  0001 C CNN
F 1 "GND" H 1205 2627 50  0000 C CNN
F 2 "" H 1200 2800 50  0001 C CNN
F 3 "" H 1200 2800 50  0001 C CNN
	1    1200 2800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 61A9F2F3
P 2650 2600
F 0 "#PWR0102" H 2650 2350 50  0001 C CNN
F 1 "GND" H 2655 2427 50  0000 C CNN
F 2 "" H 2650 2600 50  0001 C CNN
F 3 "" H 2650 2600 50  0001 C CNN
	1    2650 2600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0103
U 1 1 61A9F70C
P 3050 2600
F 0 "#PWR0103" H 3050 2350 50  0001 C CNN
F 1 "GND" H 3055 2427 50  0000 C CNN
F 2 "" H 3050 2600 50  0001 C CNN
F 3 "" H 3050 2600 50  0001 C CNN
	1    3050 2600
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x04_Female J2
U 1 1 61AA7374
P 5000 1200
F 0 "J2" H 5028 1176 50  0000 L CNN
F 1 "Conn_01x04_Female" H 5028 1085 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 5000 1200 50  0001 C CNN
F 3 "~" H 5000 1200 50  0001 C CNN
	1    5000 1200
	1    0    0    -1  
$EndComp
Text Label 1800 1500 0    50   ~ 0
CC1
Text Label 1800 1600 0    50   ~ 0
CC2
Text Label 2650 2300 0    50   ~ 0
CC1
Text Label 3050 2300 0    50   ~ 0
CC2
Text Label 4800 1100 2    50   ~ 0
5V
Text Label 4800 1400 2    50   ~ 0
GND
Text Label 4800 2350 2    50   ~ 0
VBUS
Text Label 1800 2400 0    50   ~ 0
SBU1
Text Label 1800 2500 0    50   ~ 0
SBU2
Text Label 4800 2550 2    50   ~ 0
CC1
Text Label 4800 3150 2    50   ~ 0
CC2
Text Label 4800 1300 2    50   ~ 0
A7
Text Label 4800 1900 2    50   ~ 0
B7
Text Label 1800 1900 0    50   ~ 0
B7
Text Label 1800 2000 0    50   ~ 0
A6
Text Label 1800 2100 0    50   ~ 0
B6
Text Label 4800 1200 2    50   ~ 0
A6
Text Label 4800 1800 2    50   ~ 0
B6
$Comp
L Connector:Conn_01x04_Female J3
U 1 1 61AC9EDD
P 5000 1800
F 0 "J3" H 5028 1776 50  0000 L CNN
F 1 "Conn_01x04_Female" H 5028 1685 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 5000 1800 50  0001 C CNN
F 3 "~" H 5000 1800 50  0001 C CNN
	1    5000 1800
	1    0    0    -1  
$EndComp
Text Label 4800 1700 2    50   ~ 0
5V
Text Label 4800 2000 2    50   ~ 0
GND
Text Label 4800 2750 2    50   ~ 0
A6
Text Label 4800 2850 2    50   ~ 0
A7
Text Label 4800 2950 2    50   ~ 0
B6
Text Label 4800 2650 2    50   ~ 0
B7
Text Label 4800 3050 2    50   ~ 0
SBU1
Text Label 4800 2450 2    50   ~ 0
SBU2
$Comp
L power:GND #PWR0104
U 1 1 61ADB71C
P 4800 2250
F 0 "#PWR0104" H 4800 2000 50  0001 C CNN
F 1 "GND" H 4805 2077 50  0000 C CNN
F 2 "" H 4800 2250 50  0001 C CNN
F 3 "" H 4800 2250 50  0001 C CNN
	1    4800 2250
	0    1    1    0   
$EndComp
$Comp
L Connector:Conn_01x10_Female J4
U 1 1 61ADC476
P 5000 2650
F 0 "J4" H 5028 2626 50  0000 L CNN
F 1 "Conn_01x10_Female" H 5028 2535 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x10_P2.54mm_Vertical" H 5000 2650 50  0001 C CNN
F 3 "~" H 5000 2650 50  0001 C CNN
	1    5000 2650
	1    0    0    -1  
$EndComp
Text Notes 4950 700  2    50   ~ 0
Schematic adapted from the USB-C connection part of the WeAct Studio STM32F4x1Cx v3.1 development board.
$EndSCHEMATC
