# Sungrow-Meter
Sungrow S100 power meter emulation using a Raspberry Pi

#### Project objectives
This is a research project that aims to emulate a Sungrow Meter S100

#### Requeriments
1. A Sungrow inverter, I'im using a SG5.0RS
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
