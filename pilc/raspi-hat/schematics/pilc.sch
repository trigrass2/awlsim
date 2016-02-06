EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:max485
LIBS:rv3029c2
LIBS:pilc-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 4
Title "PiLC HAT"
Date ""
Rev "0.1"
Comp "Michael Buesch <m@bues.ch>"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L CONN_02X20 P2
U 1 1 56AC9385
P 5750 2250
F 0 "P2" H 5750 3300 50  0000 C CNN
F 1 "RaspberryPi_2x20" V 5750 2250 50  0000 C CNN
F 2 "" H 5750 1300 60  0000 C CNN
F 3 "" H 5750 1300 60  0000 C CNN
	1    5750 2250
	1    0    0    -1  
$EndComp
Text Label 6400 2600 0    39   ~ 0
ID_SC
Text Label 4950 2600 0    39   ~ 0
ID_SD
$Comp
L +5V #PWR15
U 1 1 56ACAB28
P 6100 1300
F 0 "#PWR15" H 6100 1150 50  0001 C CNN
F 1 "+5V" H 6100 1440 50  0000 C CNN
F 2 "" H 6100 1300 60  0000 C CNN
F 3 "" H 6100 1300 60  0000 C CNN
	1    6100 1300
	0    1    1    0   
$EndComp
$Comp
L +5V #PWR22
U 1 1 56ACAB55
P 6300 1400
F 0 "#PWR22" H 6300 1250 50  0001 C CNN
F 1 "+5V" H 6300 1540 50  0000 C CNN
F 2 "" H 6300 1400 60  0000 C CNN
F 3 "" H 6300 1400 60  0000 C CNN
	1    6300 1400
	0    1    1    0   
$EndComp
$Comp
L GND #PWR16
U 1 1 56ACAC8B
P 6100 1500
F 0 "#PWR16" H 6100 1250 50  0001 C CNN
F 1 "GND" H 6100 1350 50  0000 C CNN
F 2 "" H 6100 1500 60  0000 C CNN
F 3 "" H 6100 1500 60  0000 C CNN
	1    6100 1500
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR17
U 1 1 56ACACF8
P 6100 1900
F 0 "#PWR17" H 6100 1650 50  0001 C CNN
F 1 "GND" H 6100 1750 50  0000 C CNN
F 2 "" H 6100 1900 60  0000 C CNN
F 3 "" H 6100 1900 60  0000 C CNN
	1    6100 1900
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR18
U 1 1 56ACAD1B
P 6100 2200
F 0 "#PWR18" H 6100 1950 50  0001 C CNN
F 1 "GND" H 6100 2050 50  0000 C CNN
F 2 "" H 6100 2200 60  0000 C CNN
F 3 "" H 6100 2200 60  0000 C CNN
	1    6100 2200
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR19
U 1 1 56ACAD3E
P 6100 2700
F 0 "#PWR19" H 6100 2450 50  0001 C CNN
F 1 "GND" H 6100 2550 50  0000 C CNN
F 2 "" H 6100 2700 60  0000 C CNN
F 3 "" H 6100 2700 60  0000 C CNN
	1    6100 2700
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR20
U 1 1 56ACAD5C
P 6100 2900
F 0 "#PWR20" H 6100 2650 50  0001 C CNN
F 1 "GND" H 6100 2750 50  0000 C CNN
F 2 "" H 6100 2900 60  0000 C CNN
F 3 "" H 6100 2900 60  0000 C CNN
	1    6100 2900
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR13
U 1 1 56ACAEE2
P 5400 3200
F 0 "#PWR13" H 5400 2950 50  0001 C CNN
F 1 "GND" H 5400 3050 50  0000 C CNN
F 2 "" H 5400 3200 60  0000 C CNN
F 3 "" H 5400 3200 60  0000 C CNN
	1    5400 3200
	0    1    1    0   
$EndComp
$Comp
L GND #PWR12
U 1 1 56ACAF05
P 5400 2500
F 0 "#PWR12" H 5400 2250 50  0001 C CNN
F 1 "GND" H 5400 2350 50  0000 C CNN
F 2 "" H 5400 2500 60  0000 C CNN
F 3 "" H 5400 2500 60  0000 C CNN
	1    5400 2500
	0    1    1    0   
$EndComp
$Comp
L GND #PWR10
U 1 1 56ACB0B3
P 5400 1700
F 0 "#PWR10" H 5400 1450 50  0001 C CNN
F 1 "GND" H 5400 1550 50  0000 C CNN
F 2 "" H 5400 1700 60  0000 C CNN
F 3 "" H 5400 1700 60  0000 C CNN
	1    5400 1700
	0    1    1    0   
$EndComp
$Comp
L +3V3 #PWR9
U 1 1 56ACB42D
P 5400 1300
F 0 "#PWR9" H 5400 1150 50  0001 C CNN
F 1 "+3V3" H 5400 1440 50  0000 C CNN
F 2 "" H 5400 1300 60  0000 C CNN
F 3 "" H 5400 1300 60  0000 C CNN
	1    5400 1300
	0    -1   -1   0   
$EndComp
$Comp
L +3V3 #PWR11
U 1 1 56ACB470
P 5400 2100
F 0 "#PWR11" H 5400 1950 50  0001 C CNN
F 1 "+3V3" H 5400 2240 50  0000 C CNN
F 2 "" H 5400 2100 60  0000 C CNN
F 3 "" H 5400 2100 60  0000 C CNN
	1    5400 2100
	0    -1   -1   0   
$EndComp
$Comp
L R R5
U 1 1 56ACB5AF
P 6250 6350
F 0 "R5" V 6330 6350 50  0000 C CNN
F 1 "3.9k" V 6250 6350 50  0000 C CNN
F 2 "" V 6180 6350 30  0000 C CNN
F 3 "" H 6250 6350 30  0000 C CNN
	1    6250 6350
	-1   0    0    1   
$EndComp
$Comp
L R R4
U 1 1 56ACB620
P 6000 6350
F 0 "R4" V 6080 6350 50  0000 C CNN
F 1 "3.9k" V 6000 6350 50  0000 C CNN
F 2 "" V 5930 6350 30  0000 C CNN
F 3 "" H 6000 6350 30  0000 C CNN
	1    6000 6350
	-1   0    0    1   
$EndComp
$Comp
L +3V3 #PWR21
U 1 1 56ACB6DB
P 6250 6600
F 0 "#PWR21" H 6250 6450 50  0001 C CNN
F 1 "+3V3" H 6250 6740 50  0000 C CNN
F 2 "" H 6250 6600 60  0000 C CNN
F 3 "" H 6250 6600 60  0000 C CNN
	1    6250 6600
	-1   0    0    1   
$EndComp
$Comp
L +3V3 #PWR14
U 1 1 56ACB6FD
P 6000 6600
F 0 "#PWR14" H 6000 6450 50  0001 C CNN
F 1 "+3V3" H 6000 6740 50  0000 C CNN
F 2 "" H 6000 6600 60  0000 C CNN
F 3 "" H 6000 6600 60  0000 C CNN
	1    6000 6600
	-1   0    0    1   
$EndComp
$Comp
L C_Small C1
U 1 1 56AD0688
P 1750 6250
F 0 "C1" H 1760 6320 50  0000 L CNN
F 1 "100n" H 1760 6170 50  0000 L CNN
F 2 "" H 1750 6250 60  0000 C CNN
F 3 "" H 1750 6250 60  0000 C CNN
	1    1750 6250
	-1   0    0    1   
$EndComp
$Comp
L +3V3 #PWR2
U 1 1 56AD06DB
P 1500 6050
F 0 "#PWR2" H 1500 5900 50  0001 C CNN
F 1 "+3V3" H 1500 6190 50  0000 C CNN
F 2 "" H 1500 6050 60  0000 C CNN
F 3 "" H 1500 6050 60  0000 C CNN
	1    1500 6050
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR1
U 1 1 56AD0707
P 1500 5550
F 0 "#PWR1" H 1500 5300 50  0001 C CNN
F 1 "GND" H 1500 5400 50  0000 C CNN
F 2 "" H 1500 5550 60  0000 C CNN
F 3 "" H 1500 5550 60  0000 C CNN
	1    1500 5550
	0    1    1    0   
$EndComp
$Comp
L GND #PWR3
U 1 1 56AD084E
P 1750 6450
F 0 "#PWR3" H 1750 6200 50  0001 C CNN
F 1 "GND" H 1750 6300 50  0000 C CNN
F 2 "" H 1750 6450 60  0000 C CNN
F 3 "" H 1750 6450 60  0000 C CNN
	1    1750 6450
	1    0    0    -1  
$EndComp
$Comp
L ATTINY85-P IC1
U 1 1 56AD1486
P 3200 5800
F 0 "IC1" H 2050 6200 40  0000 C CNN
F 1 "ATTINY85-P" H 4200 5400 40  0000 C CNN
F 2 "DIP8" H 4200 5800 35  0000 C CIN
F 3 "" H 3200 5800 60  0000 C CNN
	1    3200 5800
	-1   0    0    1   
$EndComp
$Comp
L R R3
U 1 1 56AD34FB
P 5000 5550
F 0 "R3" V 5080 5550 50  0000 C CNN
F 1 "10k" V 5000 5550 50  0000 C CNN
F 2 "" V 4930 5550 30  0000 C CNN
F 3 "" H 5000 5550 30  0000 C CNN
	1    5000 5550
	0    -1   -1   0   
$EndComp
$Comp
L +3V3 #PWR8
U 1 1 56AD3540
P 5250 5550
F 0 "#PWR8" H 5250 5400 50  0001 C CNN
F 1 "+3V3" H 5250 5690 50  0000 C CNN
F 2 "" H 5250 5550 60  0000 C CNN
F 3 "" H 5250 5550 60  0000 C CNN
	1    5250 5550
	0    1    1    0   
$EndComp
$Comp
L CONN_02X03 P1
U 1 1 56AD385D
P 3200 6600
F 0 "P1" H 3200 6800 50  0000 C CNN
F 1 "ISP" H 3200 6400 50  0000 C CNN
F 2 "" H 3200 5400 60  0000 C CNN
F 3 "" H 3200 5400 60  0000 C CNN
	1    3200 6600
	1    0    0    -1  
$EndComp
$Comp
L +3V3 #PWR4
U 1 1 56AD421A
P 3550 6500
F 0 "#PWR4" H 3550 6350 50  0001 C CNN
F 1 "+3V3" H 3550 6640 50  0000 C CNN
F 2 "" H 3550 6500 60  0000 C CNN
F 3 "" H 3550 6500 60  0000 C CNN
	1    3550 6500
	0    1    1    0   
$EndComp
$Comp
L GND #PWR5
U 1 1 56AD424E
P 3550 6700
F 0 "#PWR5" H 3550 6450 50  0001 C CNN
F 1 "GND" H 3550 6550 50  0000 C CNN
F 2 "" H 3550 6700 60  0000 C CNN
F 3 "" H 3550 6700 60  0000 C CNN
	1    3550 6700
	0    -1   -1   0   
$EndComp
Text Label 6400 1600 0    39   ~ 0
TXD
Text Label 6400 1700 0    39   ~ 0
RXD
$Comp
L CP C3
U 1 1 56AD760C
P 10350 1950
F 0 "C3" H 10375 2050 50  0000 L CNN
F 1 "330µF 35V" H 10375 1850 50  0000 L CNN
F 2 "" H 10388 1800 30  0000 C CNN
F 3 "" H 10350 1950 60  0000 C CNN
	1    10350 1950
	1    0    0    -1  
$EndComp
$Comp
L CP C2
U 1 1 56AD7663
P 9750 1950
F 0 "C2" H 9775 2050 50  0000 L CNN
F 1 "47µF 25V" H 9775 1850 50  0000 L CNN
F 2 "" H 9788 1800 30  0000 C CNN
F 3 "" H 9750 1950 60  0000 C CNN
	1    9750 1950
	1    0    0    -1  
$EndComp
$Comp
L +3V3 #PWR24
U 1 1 56AD76EF
P 9750 1700
F 0 "#PWR24" H 9750 1550 50  0001 C CNN
F 1 "+3V3" H 9750 1840 50  0000 C CNN
F 2 "" H 9750 1700 60  0000 C CNN
F 3 "" H 9750 1700 60  0000 C CNN
	1    9750 1700
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR26
U 1 1 56AD7721
P 10350 1700
F 0 "#PWR26" H 10350 1550 50  0001 C CNN
F 1 "+5V" H 10350 1840 50  0000 C CNN
F 2 "" H 10350 1700 60  0000 C CNN
F 3 "" H 10350 1700 60  0000 C CNN
	1    10350 1700
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR25
U 1 1 56AD7768
P 9750 2200
F 0 "#PWR25" H 9750 1950 50  0001 C CNN
F 1 "GND" H 9750 2050 50  0000 C CNN
F 2 "" H 9750 2200 60  0000 C CNN
F 3 "" H 9750 2200 60  0000 C CNN
	1    9750 2200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR27
U 1 1 56AD779A
P 10350 2200
F 0 "#PWR27" H 10350 1950 50  0001 C CNN
F 1 "GND" H 10350 2050 50  0000 C CNN
F 2 "" H 10350 2200 60  0000 C CNN
F 3 "" H 10350 2200 60  0000 C CNN
	1    10350 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	6000 2600 6750 2600
Wire Wire Line
	6100 1300 6000 1300
Wire Wire Line
	6000 1400 6300 1400
Wire Wire Line
	6100 1500 6000 1500
Wire Wire Line
	6000 1900 6100 1900
Wire Wire Line
	6000 2200 6100 2200
Wire Wire Line
	6000 2700 6100 2700
Wire Wire Line
	6000 2900 6100 2900
Wire Wire Line
	5400 3200 5500 3200
Wire Wire Line
	5400 2500 5500 2500
Wire Wire Line
	5400 1700 5500 1700
Wire Wire Line
	5400 1300 5500 1300
Wire Wire Line
	5400 2100 5500 2100
Wire Wire Line
	6250 6500 6250 6600
Wire Wire Line
	6000 6500 6000 6600
Wire Wire Line
	1850 5550 1500 5550
Wire Wire Line
	1500 6050 1850 6050
Wire Wire Line
	1750 6150 1750 6050
Connection ~ 1750 6050
Wire Wire Line
	1750 6450 1750 6350
Wire Wire Line
	4550 5750 9250 5750
Wire Wire Line
	6350 5850 4550 5850
Wire Wire Line
	4550 6050 6450 6050
Wire Wire Line
	4750 2600 5500 2600
Wire Wire Line
	6000 6200 6000 5850
Wire Wire Line
	5150 5550 5250 5550
Wire Wire Line
	4550 5550 4850 5550
Wire Wire Line
	3450 6500 3550 6500
Wire Wire Line
	3450 6700 3550 6700
Wire Wire Line
	4650 6600 3450 6600
Wire Wire Line
	4650 6050 4650 6600
Connection ~ 4650 6050
Connection ~ 6250 6050
Connection ~ 6000 5850
Wire Wire Line
	2950 6700 2850 6700
Wire Wire Line
	2850 6700 2850 6850
Wire Wire Line
	2850 6850 4750 6850
Wire Wire Line
	4750 6850 4750 5550
Connection ~ 4750 5550
Wire Wire Line
	2950 6600 2750 6600
Wire Wire Line
	2750 6600 2750 6950
Wire Wire Line
	2750 6950 4850 6950
Wire Wire Line
	4850 6950 4850 5850
Connection ~ 4850 5850
Wire Wire Line
	2950 6500 2650 6500
Wire Wire Line
	2650 6500 2650 7050
Wire Wire Line
	2650 7050 4950 7050
Wire Wire Line
	9750 2100 9750 2200
Wire Wire Line
	9750 1700 9750 1800
Wire Wire Line
	10350 1700 10350 1800
Wire Wire Line
	10350 2100 10350 2200
Wire Wire Line
	4550 5650 9250 5650
$Sheet
S 1400 1300 1250 300 
U 56AD309F
F0 "rtc" 60
F1 "rtc.sch" 60
F2 "SCL" I R 2650 1500 60 
F3 "SDA" I R 2650 1400 60 
$EndSheet
Text Label 4950 1400 0    39   ~ 0
SDA
Text Label 4950 1500 0    39   ~ 0
SCL
$Comp
L R R1
U 1 1 56AD6620
P 3700 1750
F 0 "R1" V 3780 1750 50  0000 C CNN
F 1 "3.9k" V 3700 1750 50  0000 C CNN
F 2 "" V 3630 1750 30  0000 C CNN
F 3 "" H 3700 1750 30  0000 C CNN
	1    3700 1750
	0    1    1    0   
$EndComp
$Comp
L R R2
U 1 1 56AD6626
P 3700 2000
F 0 "R2" V 3780 2000 50  0000 C CNN
F 1 "3.9k" V 3700 2000 50  0000 C CNN
F 2 "" V 3630 2000 30  0000 C CNN
F 3 "" H 3700 2000 30  0000 C CNN
	1    3700 2000
	0    1    1    0   
$EndComp
$Comp
L +3V3 #PWR6
U 1 1 56AD662C
P 3950 1750
F 0 "#PWR6" H 3950 1600 50  0001 C CNN
F 1 "+3V3" H 3950 1890 50  0000 C CNN
F 2 "" H 3950 1750 60  0000 C CNN
F 3 "" H 3950 1750 60  0000 C CNN
	1    3950 1750
	0    1    1    0   
$EndComp
$Comp
L +3V3 #PWR7
U 1 1 56AD6632
P 3950 2000
F 0 "#PWR7" H 3950 1850 50  0001 C CNN
F 1 "+3V3" H 3950 2140 50  0000 C CNN
F 2 "" H 3950 2000 60  0000 C CNN
F 3 "" H 3950 2000 60  0000 C CNN
	1    3950 2000
	0    1    1    0   
$EndComp
Wire Wire Line
	3850 1750 3950 1750
Wire Wire Line
	3850 2000 3950 2000
Wire Wire Line
	3250 2000 3550 2000
Wire Wire Line
	3250 1750 3550 1750
$Sheet
S 9250 5400 1250 450 
U 56AD6E49
F0 "profibus" 60
F1 "profibus.sch" 60
F2 "TxD" I L 9250 5750 60 
F3 "RxD" I L 9250 5500 60 
F4 "TxForceEn" I L 9250 5650 60 
$EndSheet
Wire Wire Line
	7450 5500 9250 5500
$Sheet
S 1400 2600 1250 1750
U 56AE5291
F0 "relays" 60
F1 "relays.sch" 60
$EndSheet
Wire Wire Line
	4550 5950 4950 5950
Wire Wire Line
	4950 5950 4950 7050
$Comp
L LED D1
U 1 1 56B661B9
P 8150 1800
F 0 "D1" H 8150 1900 50  0000 C CNN
F 1 "LED" H 8150 1700 50  0000 C CNN
F 2 "" H 8150 1800 50  0000 C CNN
F 3 "" H 8150 1800 50  0000 C CNN
	1    8150 1800
	-1   0    0    1   
$EndComp
$Comp
L R R6
U 1 1 56B662D5
P 7700 1800
F 0 "R6" V 7780 1800 50  0000 C CNN
F 1 "330" V 7700 1800 50  0000 C CNN
F 2 "" V 7630 1800 50  0000 C CNN
F 3 "" H 7700 1800 50  0000 C CNN
	1    7700 1800
	0    1    1    0   
$EndComp
Wire Wire Line
	7850 1800 7950 1800
$Comp
L GND #PWR23
U 1 1 56B666A1
P 8450 1800
F 0 "#PWR23" H 8450 1550 50  0001 C CNN
F 1 "GND" H 8450 1650 50  0000 C CNN
F 2 "" H 8450 1800 50  0000 C CNN
F 3 "" H 8450 1800 50  0000 C CNN
	1    8450 1800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8350 1800 8450 1800
Text Label 6400 1800 0    39   ~ 0
BCM18
Wire Bus Line
	6850 1700 6850 3550
Wire Bus Line
	6850 3550 4650 3550
Wire Bus Line
	4650 3550 4650 1000
Entry Wire Line
	4650 1500 4750 1400
Entry Wire Line
	4650 1600 4750 1500
Wire Wire Line
	4750 1400 5500 1400
Wire Wire Line
	4750 1500 5500 1500
Entry Wire Line
	3050 1400 3150 1300
Entry Wire Line
	3050 1500 3150 1400
Wire Wire Line
	3050 1400 2650 1400
Wire Wire Line
	3050 1500 2650 1500
Text Label 2850 1400 0    39   ~ 0
SDA
Text Label 2850 1500 0    39   ~ 0
SCL
Entry Wire Line
	3150 1650 3250 1750
Entry Wire Line
	3150 1900 3250 2000
Text Label 3300 1750 0    39   ~ 0
SDA
Text Label 3300 2000 0    39   ~ 0
SCL
Wire Bus Line
	4650 1000 3150 1000
Entry Wire Line
	4650 1700 4750 1600
Entry Wire Line
	4650 1900 4750 1800
Entry Wire Line
	4650 2000 4750 1900
Entry Wire Line
	4650 2100 4750 2000
Entry Wire Line
	4650 2300 4750 2200
Entry Wire Line
	4650 2400 4750 2300
Entry Wire Line
	4650 2500 4750 2400
Entry Wire Line
	4650 2700 4750 2600
Entry Wire Line
	4650 2800 4750 2700
Entry Wire Line
	4650 2900 4750 2800
Entry Wire Line
	4650 3000 4750 2900
Entry Wire Line
	4650 3100 4750 3000
Entry Wire Line
	4650 3200 4750 3100
Entry Wire Line
	6750 2000 6850 2100
Entry Wire Line
	6750 2100 6850 2200
Entry Wire Line
	6750 2300 6850 2400
Entry Wire Line
	6750 2400 6850 2500
Entry Wire Line
	6750 2500 6850 2600
Entry Wire Line
	6750 2800 6850 2900
Entry Wire Line
	6750 3000 6850 3100
Entry Wire Line
	6750 3100 6850 3200
Entry Wire Line
	6750 3200 6850 3300
Wire Wire Line
	4750 1600 5500 1600
Text Label 4950 1600 0    39   ~ 0
BCM4
Wire Wire Line
	4750 1800 5500 1800
Wire Wire Line
	4750 1900 5500 1900
Wire Wire Line
	4750 2000 5500 2000
Wire Wire Line
	4750 2200 5500 2200
Wire Wire Line
	4750 2300 5500 2300
Wire Wire Line
	4750 2400 5500 2400
Wire Wire Line
	4750 2700 5500 2700
Wire Wire Line
	4750 2800 5500 2800
Wire Wire Line
	4750 2900 5500 2900
Wire Wire Line
	4750 3000 5500 3000
Wire Wire Line
	4750 3100 5500 3100
Text Label 4950 1800 0    39   ~ 0
BCM17
Text Label 4950 1900 0    39   ~ 0
BCM27
Text Label 4950 2000 0    39   ~ 0
BCM22
Text Label 4950 2200 0    39   ~ 0
BCM10
Text Label 4950 2300 0    39   ~ 0
BCM9
Text Label 4950 2400 0    39   ~ 0
BCM11
Text Label 4950 2700 0    39   ~ 0
BCM5
Text Label 4950 2800 0    39   ~ 0
BCM6
Text Label 4950 2900 0    39   ~ 0
BCM13
Text Label 4950 3000 0    39   ~ 0
BCM19
Text Label 4950 3100 0    39   ~ 0
BCM26
Wire Wire Line
	6750 3200 6000 3200
Wire Wire Line
	6750 3100 6000 3100
Wire Wire Line
	6750 3000 6000 3000
Wire Wire Line
	6750 2800 6000 2800
Entry Wire Line
	6750 2600 6850 2700
Wire Wire Line
	6750 2500 6000 2500
Wire Wire Line
	6750 2400 6000 2400
Wire Wire Line
	6750 2300 6000 2300
Wire Wire Line
	6750 2100 6000 2100
Wire Wire Line
	6750 2000 6000 2000
Text Label 7350 5300 1    39   ~ 0
TXD
Text Label 7450 5300 1    39   ~ 0
RXD
Entry Wire Line
	6750 1600 6850 1700
Entry Wire Line
	6750 1700 6850 1800
Entry Wire Line
	6750 1800 6850 1900
Wire Wire Line
	6750 1800 6000 1800
Wire Wire Line
	6750 1700 6000 1700
Wire Wire Line
	6750 1600 6000 1600
Entry Wire Line
	6850 1900 6950 1800
Wire Wire Line
	6950 1800 7550 1800
Text Label 7100 1800 0    39   ~ 0
BCM18
Text Label 6400 3200 0    39   ~ 0
BCM21
Text Label 6400 3100 0    39   ~ 0
BCM20
Text Label 6400 3000 0    39   ~ 0
BCM16
Text Label 6400 2800 0    39   ~ 0
BCM12
Text Label 6400 2500 0    39   ~ 0
BCM7
Text Label 6400 2400 0    39   ~ 0
BCM8
Text Label 6400 2300 0    39   ~ 0
BCM25
Text Label 6400 2100 0    39   ~ 0
BCM24
Text Label 6400 2000 0    39   ~ 0
BCM23
Wire Bus Line
	3150 5000 7350 5000
Entry Wire Line
	7350 5000 7450 5100
Entry Wire Line
	7250 5000 7350 5100
Wire Wire Line
	7450 5100 7450 5500
Wire Wire Line
	7350 5100 7350 5750
Connection ~ 7350 5750
Wire Bus Line
	3150 1000 3150 5000
Wire Wire Line
	6350 5850 6350 5100
Entry Wire Line
	6250 5000 6350 5100
Entry Wire Line
	6350 5000 6450 5100
Wire Wire Line
	6450 6050 6450 5100
Wire Wire Line
	6250 6050 6250 6200
Text Label 6350 5300 1    39   ~ 0
ID_SC
Text Label 6450 5300 1    39   ~ 0
ID_SD
$EndSCHEMATC
