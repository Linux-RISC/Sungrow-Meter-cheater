# Sungrow-Meter-cheater
Sungrow S100 power meter emulation using a Raspberry Pi

#### Project objectives
This is a research project that aims to emulate a Sungrow Meter S100

#### Requeriments
1. A Sungrow inverter, I'm using a SG5.0RS
2. A Raspberry Pi, I'm using a Raspberry Pi 3B+ and a 2 GB SD card
3. Raspberry Pi OS Lite, I'm using 32-bit: https://www.raspberrypi.com/software/operating-systems/#raspberry-pi-os-32-bit
4. A 485 dongle, I'm using a ARCELI USB to 485 adapter: https://amzn.eu/d/59K0N9B
5. Install and start picocom (picocom /dev/sttyUSB0) on Raspberry Pi on a separate ssh session. I still don't know why, but some stty option is missing and picocom enables it.

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
...
```
Translation:
- these frames are received every 20 seconds
- use the Modicon Modbus Protocol Reference Guide https://www.modbus.org/docs/PI_MBUS_300.pdf

fe03 003f 0001 a009<br>
0xFE: station=254<br>
0x03: message "Read Holding Registers"<br>
0x003F: starting address=63<br>
0x0001: number of registers=1<br>
0x0a009: CRC-16<br>

2073 0000 0001 c370<br>
0x20: station=32<br>
0x73: message ??? --> message 0x73 doesn't exist in the Modicon Modbus Protocol Reference Guide<br>
0x0000: starting address=0<br>
0x0001: number of registers=1<br>
0xc370: CRC-16<br>

Does anyone know how to answer properly ?

----------
#### 2022-10-09 Update
Just use the script cheater.sh to read the requests from the the inverter and answer using false data. I need to know what data is every MODBUS holding register:

```
pi@raspberrypi:~ $ ./cheater.sh 
answering to fe03003f0001a009
answering to fe03016400081020
answering to fe03000a000c71c2
answering to fe03016400081020
answering to fe0300610003401a
answering to fe03016400081020
answering to fe0300770001201f
answering to fe03016400081020
answering to fe03016400081020
answering to fe03016400081020
answering to fe03016400081020
answering to fe03016400081020
answering to fe03016400081020
answering to fe03016400081020
answering to fe03016400081020
answering to fe03016400081020
answering to fe03016400081020
answering to fe03016400081020
...
```

Check "Issues" section to watch pictures showing false data.
