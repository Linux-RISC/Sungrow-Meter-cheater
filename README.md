# Sungrow-Meter
Sungrow S100 power meter emulation using a Raspberry Pi

#### Project objectives
This is a research project that aims to emulate a Sungrow Meter S100

#### Requeriments
1. A Sungrow inverter, I'm using a SG5.0RS
2. A Raspberry Pi, I'm using a Raspberry Pi 3B+ and a 2 GB SD card.
3. Raspberry Pi OS Lite, I'm using 32-bit: https://www.raspberrypi.com/software/operating-systems/#raspberry-pi-os-32-bit
4. A 485 dongle, I'im using a ARCELI USB to 485 adapter: https://amzn.eu/d/59K0N9B

#### Installation
Connect two wires from COM2 terminals (A2,B2) to 485 adapter terminals (D+,D-). Read the documentation of you inverter, I have used the page 20 of this manual:  https://aus.sungrowpower.com/upload/file/20210707/SG2.0-6.0RS-UEN-Ver11-202106.pdf

#### Listening to the inverter
1. Connect to the Raspberry using ssh (for example Putty on Windows or ssh on Linux) 
2. Use the script read.sh to read the requests from the inverter:
```
pi@raspberrypi:~ $ ./read.sh 
00000000: fe03 003f 0001 a009 2073 0000 0001 c370  ...?.... s.....p
00000010: fe03 003f 0001 a009 2073 0000 0001 c370  ...?.... s.....p
00000020: fe03 003f 0001 a009 2073 0000 0001 c370  ...?.... s.....p
00000030: fe03 003f 0001 a009 2073 0000 0001 c370  ...?.... s.....p
00000040: fe03 003f 0001 a009 2073 0000 0001 c370  ...?.... s.....p
00000050: fe03 003f 0001 a009 2073 0000 0001 c370  ...?.... s.....p
00000060: fe03 003f 0001 a009 2073 0000 0001 c370  ...?.... s.....p
00000070: fe03 003f 0001 a009 2073 0000 0001 c370  ...?.... s.....p
00000080: fe03 003f 0001 a009 2073 0000 0001 c370  ...?.... s.....p
00000090: fe03 003f 0001 a009 2073 0000 0001 c370  ...?.... s.....p
000000a0: fe03 003f 0001 a009 2073 0000 0001 c370  ...?.... s.....p
000000b0: fe03 003f 0001 a009 2073 0000 0001 c370  ...?.... s.....p
```
Translation:
- these frames are received every 20 seconds
- use the Modicon Modbus Protocol Reference Guide https://www.modbus.org/docs/PI_MBUS_300.pdf

fe03 003f 0001 a009
0xFE: station=254
0x03: message "Read Holding Registers"
0x003F: starting address=63
0x0001: number of registers=1
0x0a009: CRC-16

2073 0000 0001 c370
0x20: station=32
0x73: message ??? --> message 0x73 doesn't exist in the Modicon Modbus Protocol Reference Guide
0x0000: starting address=0
0x0001: number of registers=1
0xc370: CRC-16
