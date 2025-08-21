#!/bin/sh
export DISPLAY=:0
export XAUTHORITY=/home/pyncho/.Xauthority  # или путь из `echo $XAUTHORITY`

echo '111' >> /home/pyncho/udev-log
