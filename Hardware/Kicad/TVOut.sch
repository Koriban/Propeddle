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
Sheet 6 7
Title "Propeddle"
Date "8 apr 2014"
Rev "10"
Comp "(C) 2014 Jac Goudsmit"
Comment1 "Software-Defined 6502 Computer"
Comment2 "http://www.propeddle.com"
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L CONN_2 P601
U 1 1 53432796
P 6250 3900
F 0 "P601" V 6200 3900 40  0000 C CNN
F 1 "TV OUT" V 6300 3900 40  0000 C CNN
F 2 "~" H 6250 3900 60  0000 C CNN
F 3 "~" H 6250 3900 60  0000 C CNN
	1    6250 3900
	1    0    0    1   
$EndComp
$Comp
L GND #PWR030
U 1 1 534327AA
P 5900 4150
F 0 "#PWR030" H 5900 4150 30  0001 C CNN
F 1 "GND" H 5900 4080 30  0001 C CNN
F 2 "" H 5900 4150 60  0000 C CNN
F 3 "" H 5900 4150 60  0000 C CNN
	1    5900 4150
	1    0    0    -1  
$EndComp
Wire Wire Line
	5900 4150 5900 4000
$Comp
L R R602
U 1 1 534327BA
P 5550 3300
F 0 "R602" V 5630 3300 40  0000 C CNN
F 1 "270" V 5557 3301 40  0000 C CNN
F 2 "~" V 5480 3300 30  0000 C CNN
F 3 "~" H 5550 3300 30  0000 C CNN
	1    5550 3300
	0    1    1    0   
$EndComp
$Comp
L R R603
U 1 1 534327C7
P 5550 3450
F 0 "R603" V 5630 3450 40  0000 C CNN
F 1 "560" V 5557 3451 40  0000 C CNN
F 2 "~" V 5480 3450 30  0000 C CNN
F 3 "~" H 5550 3450 30  0000 C CNN
	1    5550 3450
	0    1    1    0   
$EndComp
$Comp
L R R604
U 1 1 534327CD
P 5550 3600
F 0 "R604" V 5630 3600 40  0000 C CNN
F 1 "1K" V 5557 3601 40  0000 C CNN
F 2 "~" V 5480 3600 30  0000 C CNN
F 3 "~" H 5550 3600 30  0000 C CNN
	1    5550 3600
	0    1    1    0   
$EndComp
Wire Wire Line
	5900 3150 5900 3800
Wire Wire Line
	5900 3600 5800 3600
Wire Wire Line
	5800 3450 5900 3450
Connection ~ 5900 3600
Wire Wire Line
	5800 3300 5900 3300
Connection ~ 5900 3450
Text HLabel 5300 3300 0    50   Input ~ 0
TV2
Text HLabel 5300 3450 0    50   Input ~ 0
TV1
Text HLabel 5300 3600 0    50   Input ~ 0
TV0
$Comp
L R R601
U 1 1 534327F6
P 5550 3150
F 0 "R601" V 5630 3150 40  0000 C CNN
F 1 "560" V 5557 3151 40  0000 C CNN
F 2 "~" V 5480 3150 30  0000 C CNN
F 3 "~" H 5550 3150 30  0000 C CNN
	1    5550 3150
	0    1    1    0   
$EndComp
Text HLabel 5300 3150 0    50   Input ~ 0
TVAUDIO
Wire Wire Line
	5800 3150 5900 3150
Connection ~ 5900 3300
$EndSCHEMATC