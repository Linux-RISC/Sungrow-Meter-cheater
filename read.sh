#!/bin/bash

stty -F /dev/ttyUSB0 9600 cs8 -cstopb -parenb; xxd /dev/ttyUSB0
