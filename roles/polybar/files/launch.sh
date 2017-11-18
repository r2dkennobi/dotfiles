#!/bin/bash
killall -q polybar

while pgrep -x polybar >/dev/null; do sleep 1; done

if [ "$(xrandr | grep "DP-1 connected")" != "" ]; then
  MONITOR=DP-1 polybar example &
fi
if [ "$(xrandr | grep "DP-1-1 connected")" != "" ]; then
  MONITOR=DP-1-1 polybar example &
fi
if [ "$(xrandr | grep "DP-1-2 connected")" != "" ]; then
  MONITOR=DP-1-2 polybar example &
fi
if [ "$(xrandr | grep "DP-2 connected")" != "" ]; then
  MONITOR=DP-2 polybar example &
fi
MONITOR=eDP-1 polybar example &
#polybar top &
#polybar bottom &
