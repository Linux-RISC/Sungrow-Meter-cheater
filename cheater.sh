#!/bin/bash

# https://github.com/Linux-RISC/Sungrow-Meter-cheater

# https://stackoverflow.com/questions/2746553/read-values-into-a-shell-variable-from-a-pipe
shopt -s lastpipe

function Shelly_get_em0 () {

./Shelly_get_em0.sh | read power

# debugging
#echo $power

command='LC_NUMERIC=C printf "%.0f" $power'
power=$(eval $command)

# debugging
#echo "power="$power

if (( $power<0 )); then
   (( C2_power=4294967296+power ))
else
   (( C2_power=power ))
fi

}

sleep 10
device="/dev/ttyUSB0"
stty -F $device 9600 -parenb -parodd -cmspar cs8 -hupcl -cstopb cread clocal -crtscts -ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr -icrnl -ixon -ixoff -iuclc -ixany -imaxbel -iutf8 -opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0 -isig -icanon -iexten -echo echoe echok -echonl -noflsh -xcase -tostop -echoprt echoctl echoke -flusho -extproc

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
      answer="FE03020000AC50"
      echo "$answer" | xxd -r -p > $device
      ;;
    $R356_8)
# https://www.exploringbinary.com/twos-complement-converter/
# two's complement
# 2#00000000000000000000000000000000=16#0000 0000=0
# 2#00000000000000000000000000000001=16#0000 0001=1
# ...
# 2#01111111111111111111111111111111=16#7FFF FFFF=2147483647
# 2#10000000000000000000000000000000=16#8000 0000=2147483648=-2147483648 (C2)
# 2#10000000000000000000000000000001=16#8000 0001=2147483649=-2147483647 (C2)
# 2#10000000000000000000000000000010=16#8000 0002=2147483650=-2147483646 (C2)
# ...
# 2#11111111111111111111111111111111=16#FFFF FFFF=4294967295=-1 (C2)
      # R356 HW+R357 LW=Meter Phase A Active Power W (C2)
      # R358 HW+R359 LW=Meter Phase B Active Power W (C2)
      # R360 HW+R361 LW=Meter Phase C Active Power W (C2)
      # R362 HW+R363 LW=Meter Active Power W (C2)
      echo "answering to $request"
#      answer="FE0310000000640000000000000000000000644E96"
#      echo "$answer" | xxd -r -p > $device
#continue

      Shelly_get_em0

      # debugging
      #echo "power="$power
      #echo "C2_power="$C2_power

      hex=$(printf "%04X" $C2_power)

      # debugging
      #echo "hex="$hex
      if (( power<0 )); then
         answer="FE0310"$hex"0000000000000000"$hex
      else
         answer="FE03100000"$hex"00000000000000000000"$hex
      fi
      #echo "answer="$answer
      ./calc_crc16.sh $answer | read CRC
      answer=$answer$CRC
      echo "answer="$answer" ("$power" W)"

      echo "$answer" | xxd -r -p > $device
      ;;
    $R10_12)
      echo "answering to $request"
      answer="FE03180000000000000000000000000000000000000000000000006F1F"
      echo "$answer" | xxd -r -p > $device
      ;;
    $R97_3)
      echo "answering to $request"
      answer="FE03060000000000006481"
      echo "$answer" | xxd -r -p > $device
      ;;
    $R119_1)
      echo "answering to $request"
      answer="FE03020000AC50"
      echo "$answer" | xxd -r -p > $device
      ;;
    *)
      echo "unknown request $request"
      ;;
  esac
done
