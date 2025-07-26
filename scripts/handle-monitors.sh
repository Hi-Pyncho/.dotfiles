#!/bin/sh

if xrandr --query | grep -q "DisplayPort-0 connected"; then
  xrandr --output DisplayPort-0 --primary --left-of eDP
fi
