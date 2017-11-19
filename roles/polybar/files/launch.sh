#!/bin/bash
killall -q polybar

while pgrep -x polybar >/dev/null; do sleep 1; done

MONITORS=$(xrandr | grep " connected" | awk '{ print $1 }' | sort)

for m in $MONITORS; do
  MONITOR=$m polybar example &
done
#polybar top &
#polybar bottom &
