EESchema Schematic File Version 2
LIBS:jac
LIBS:Propeddle-cache
LIBS:ttl_ieee
LIBS:power
LIBS:propeller
LIBS:crystal
LIBS:conn
LIBS:Propeddle-cache
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 7
Title "Propeddle"
Date "23 apr 2014"
Rev "11"
Comp "(C) 2014 Jac Goudsmit"
Comment1 "Software-Defined 6502 Computer"
Comment2 "http://www.propeddle.com"
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L GND #PWR015
U 1 1 533850AF
P 5900 3700
F 0 "#PWR015" H 5900 3700 30  0001 C CNN
F 1 "GND" H 5900 3630 30  0001 C CNN
F 2 "" H 5900 3700 60  0000 C CNN
F 3 "" H 5900 3700 60  0000 C CNN
	1    5900 3700
	1    0    0    -1  
$EndComp
$Comp
L C C201
U 1 1 533850B5
P 4700 1950
F 0 "C201" H 4700 2050 40  0000 L CNN
F 1 "100n" H 4706 1865 40  0000 L CNN
F 2 "~" H 4738 1800 30  0000 C CNN
F 3 "~" H 4700 1950 60  0000 C CNN
	1    4700 1950
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR016
U 1 1 533850C2
P 5900 5900
F 0 "#PWR016" H 5900 5900 30  0001 C CNN
F 1 "GND" H 5900 5830 30  0001 C CNN
F 2 "" H 5900 5900 60  0000 C CNN
F 3 "" H 5900 5900 60  0000 C CNN
	1    5900 5900
	1    0    0    -1  
$EndComp
$Comp
L R R201
U 1 1 533850CA
P 6250 4650
F 0 "R201" V 6330 4650 40  0000 C CNN
F 1 "10K" V 6257 4651 40  0000 C CNN
F 2 "~" V 6180 4650 30  0000 C CNN
F 3 "~" H 6250 4650 30  0000 C CNN
	1    6250 4650
	0    -1   -1   0   
$EndComp
$Comp
L C C202
U 1 1 533850D0
P 4900 1950
F 0 "C202" H 4900 2050 40  0000 L CNN
F 1 "100n" H 4906 1865 40  0000 L CNN
F 2 "~" H 4938 1800 30  0000 C CNN
F 3 "~" H 4900 1950 60  0000 C CNN
	1    4900 1950
	1    0    0    -1  
$EndComp
$Comp
L C C203
U 1 1 533850D6
P 5350 4900
F 0 "C203" H 5350 5000 40  0000 L CNN
F 1 "100n" H 5356 4815 40  0000 L CNN
F 2 "~" H 5388 4750 30  0000 C CNN
F 3 "~" H 5350 4900 60  0000 C CNN
	1    5350 4900
	1    0    0    -1  
$EndComp
$Comp
L P8X32A-DIP IC201
U 1 1 533850DC
P 5900 2550
F 0 "IC201" H 5600 3650 50  0000 L BNN
F 1 "P8X32A" H 6000 1400 50  0000 L BNN
F 2 "" H 5900 2550 50  0001 C CNN
F 3 "~" H 6050 2300 60  0000 C CNN
	1    5900 2550
	1    0    0    -1  
$EndComp
$Comp
L XTAL X201
U 1 1 533850E2
P 6850 2550
F 0 "X201" H 6850 2750 60  0000 C CNN
F 1 "5MHz" H 6850 2350 60  0000 C CNN
F 2 "~" H 6850 2550 60  0000 C CNN
F 3 "~" H 6850 2550 60  0000 C CNN
	1    6850 2550
	0    -1   -1   0   
$EndComp
$Comp
L 24LC IC202
U 1 1 533850EE
P 5900 5350
F 0 "IC202" H 5700 5700 60  0000 C CNN
F 1 "24LC512" H 6100 5000 60  0000 C CNN
F 2 "" H 5900 5350 60  0000 C CNN
F 3 "" H 5900 5350 60  0000 C CNN
	1    5900 5350
	1    0    0    -1  
$EndComp
Wire Wire Line
	4700 2500 5400 2500
Wire Wire Line
	5900 4550 5900 5050
Wire Wire Line
	5900 5650 5900 5900
Wire Wire Line
	5350 5100 5350 5800
Connection ~ 5350 5250
Connection ~ 5900 5800
Connection ~ 5350 5350
Wire Wire Line
	6550 5250 6450 5250
Wire Wire Line
	6550 5800 6550 5250
Wire Wire Line
	5350 4650 6000 4650
Connection ~ 5900 4650
Wire Wire Line
	6450 5450 6600 5450
Wire Wire Line
	6450 5550 6600 5550
Wire Wire Line
	6500 4650 6500 5550
Connection ~ 6500 5550
Wire Wire Line
	5850 1450 5850 1500
Connection ~ 5900 1450
Wire Wire Line
	5850 3600 5850 3650
Wire Wire Line
	4900 1750 4900 1450
Wire Wire Line
	4700 1450 5950 1450
Connection ~ 5850 1450
Wire Wire Line
	5950 1450 5950 1500
Wire Wire Line
	6850 2350 6700 2350
Wire Wire Line
	6700 2350 6700 2500
Wire Wire Line
	6700 2500 6400 2500
Wire Wire Line
	6400 2600 6700 2600
Wire Wire Line
	4700 1450 4700 1750
Connection ~ 4900 1450
Wire Wire Line
	4700 2150 4700 3650
Wire Wire Line
	4900 2150 4900 2500
Connection ~ 4900 2500
Connection ~ 4700 2500
Wire Wire Line
	4700 3650 5950 3650
Wire Wire Line
	5350 4650 5350 4700
Wire Wire Line
	5350 5800 6550 5800
Connection ~ 5350 5150
Wire Wire Line
	5950 3650 5950 3600
Connection ~ 5850 3650
Wire Wire Line
	5900 3700 5900 3650
Connection ~ 5900 3650
Wire Wire Line
	6700 2600 6700 2800
Wire Wire Line
	6700 2800 7150 2800
Text HLabel 5400 1600 0    50   BiDi ~ 0
P0
Text HLabel 5400 1700 0    50   BiDi ~ 0
P1
Text HLabel 5400 1800 0    50   BiDi ~ 0
P2
Text HLabel 5400 1900 0    50   BiDi ~ 0
P3
Text HLabel 5400 2000 0    50   BiDi ~ 0
P4
Text HLabel 5400 2100 0    50   BiDi ~ 0
P5
Text HLabel 5400 2200 0    50   BiDi ~ 0
P6
Text HLabel 5400 2300 0    50   BiDi ~ 0
P7
Text HLabel 5400 2800 0    50   BiDi ~ 0
P8
Text HLabel 5400 2900 0    50   BiDi ~ 0
P9
Text HLabel 5400 3000 0    50   BiDi ~ 0
P10
Text HLabel 5400 3100 0    50   BiDi ~ 0
P11
Text HLabel 5400 3200 0    50   BiDi ~ 0
P12
Text HLabel 5400 3300 0    50   BiDi ~ 0
P13
Text HLabel 5400 3400 0    50   BiDi ~ 0
P14
Text HLabel 5400 3500 0    50   BiDi ~ 0
P15
Text HLabel 6400 3500 2    50   BiDi ~ 0
P16
Text HLabel 6400 3400 2    50   BiDi ~ 0
P17
Text HLabel 6400 3300 2    50   BiDi ~ 0
P18
Text HLabel 6400 3200 2    50   BiDi ~ 0
P19
Text HLabel 6400 3100 2    50   BiDi ~ 0
P20
Text HLabel 6400 3000 2    50   BiDi ~ 0
P21
Text HLabel 6400 2900 2    50   BiDi ~ 0
P22
Text HLabel 6400 2800 2    50   BiDi ~ 0
P23
Text HLabel 6400 2300 2    50   BiDi ~ 0
P24
Text HLabel 6400 2200 2    50   BiDi ~ 0
P25
Text HLabel 6400 2100 2    50   BiDi ~ 0
P26
Text HLabel 6400 2000 2    50   BiDi ~ 0
P27
Text HLabel 5400 2600 0    50   Input ~ 0
~RES
Text HLabel 8250 1900 2    50   Input ~ 0
RXD
Text HLabel 8250 2000 2    50   Output ~ 0
TXD
Text HLabel 8250 2200 2    50   BiDi ~ 0
SCL
Text HLabel 8250 2100 2    50   BiDi ~ 0
SDA
Wire Wire Line
	7800 1900 8250 1900
Wire Wire Line
	7800 2000 8250 2000
Wire Wire Line
	7800 2100 8250 2100
Wire Wire Line
	7800 2200 8250 2200
Text HLabel 6600 5450 2    50   BiDi ~ 0
SCL
Text HLabel 6600 5550 2    50   BiDi ~ 0
SDA
Text Label 6400 1900 0    50   ~ 0
P28
Text Label 6400 1800 0    50   ~ 0
P29
Text Label 6400 1700 0    50   ~ 0
P30
Text Label 6400 1600 0    50   ~ 0
P31
Text Label 7800 1900 2    50   ~ 0
P31
Text Label 7800 2000 2    50   ~ 0
P30
Text Label 7800 2100 2    50   ~ 0
P29
Text Label 7800 2200 2    50   ~ 0
P28
$Comp
L +3.3V #PWR017
U 1 1 53456764
P 5900 1450
F 0 "#PWR017" H 5900 1410 30  0001 C CNN
F 1 "+3.3V" H 5900 1560 30  0000 C CNN
F 2 "" H 5900 1450 60  0000 C CNN
F 3 "" H 5900 1450 60  0000 C CNN
	1    5900 1450
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR018
U 1 1 53456773
P 5900 4550
F 0 "#PWR018" H 5900 4510 30  0001 C CNN
F 1 "+3.3V" H 5900 4660 30  0000 C CNN
F 2 "" H 5900 4550 60  0000 C CNN
F 3 "" H 5900 4550 60  0000 C CNN
	1    5900 4550
	1    0    0    -1  
$EndComp
Connection ~ 6850 2800
Text Label 7150 2800 0    50   ~ 0
XI
$EndSCHEMATC
