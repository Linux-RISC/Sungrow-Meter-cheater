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
1. Connect two wires from COM2 terminals (A2,B2) to 485 adapter terminals (D+,D-). Read the documentation of you inverter, I have used the page 20 of this manual:  https://aus.sungrowpower.com/upload/file/20210707/SG2.0-6.0RS-UEN-Ver11-202106.pdf

#### Listening to the inverter
