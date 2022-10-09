#!/bin/bash

# https://github.com/Linux-RISC/Sungrow-Meter-cheater

device="/dev/ttyUSB0"
stty -F $device 9600 cs8 -cstopb -parenb echo

# register 63, 1 registers
R63_1="fe03003f0001a009"
# register 356, 8 registers
R356_8="fe03016400081020"
# register 10, 12 registers
R10_12="fe03000a000c71c2"
# register 97, 3 registers
R97_3="fe0300610003401a"
# register 119, 1 registers
R119_1="fe0300770001201f"

while true
do
  request=$(xxd -l 8 -p $device)
  case $request in
    $R63_1)
      echo "answering to $request"
      answer="FE03021000A190"
      echo "$answer" | xxd -r -p > $device
      ;;
    $R356_8)
      echo "answering to $request"
      answer="FE031010002000300040005000600070008000D97D"
      echo "$answer" | xxd -r -p > $device
      ;;
    $R10_12)
      echo "answering to $request"
      answer="FE0318100020003000400050006000700080009000100011001200C81B"
      echo "$answer" | xxd -r -p > $device
      ;;
    $R97_3)
      echo "answering to $request"
      answer="FE03061111222233336554"
      echo "$answer" | xxd -r -p > $device
      ;;
    $R119_1)
      echo "answering to $request"
      answer="FE03049999E66B"
      echo "$answer" | xxd -r -p > $device
      ;;
    *)
      echo "unknown request $request"
      ;;
  esac
done
