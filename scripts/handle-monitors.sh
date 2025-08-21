#!/bin/sh

# export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
export DISPLAY=:0
export XAUTHORITY=/home/pyncho/.Xauthority

NOTEBOOK_MONITOR="eDP"
EXTERNAL_MONITOR="DisplayPort-0"

if xrandr --query | grep -q "$EXTERNAL_MONITOR connected"; then
  # Внешний монитор подключен - делаем его основным
  xrandr --output "$EXTERNAL_MONITOR" --auto --primary \
    --output "$NOTEBOOK_MONITOR" --auto --right-of "$EXTERNAL_MONITOR"
else
  # Только ноутбук - делаем его основным и отключаем внешний
  xrandr --output "$NOTEBOOK_MONITOR" --auto --primary \
    --output "$EXTERNAL_MONITOR" --off
fi
