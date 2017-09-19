#!/bin/bash
# TODO Make script accept percentage instead of raw values
INT_RE='^[0-9]+$'
TARGET_DISPLAY=${TARGET_DISPLAY:-intel_backlight}

if ! [[ -d "/sys/class/backlight/$TARGET_DISPLAY" ]]; then
  echo "The display '$TARGET_DISPLAY' does not exists!"
  exit 1
fi

CUR_BRIGHTNESS=$(cat "/sys/class/backlight/$TARGET_DISPLAY/brightness")
MAX_BRIGHTNESS=$(cat "/sys/class/backlight/$TARGET_DISPLAY/max_brightness")
PERCENTAGE=$(echo "scale=20; $CUR_BRIGHTNESS / $MAX_BRIGHTNESS * 100" | bc)

# Only run the following when the script is executed
if [[ "$(basename -- "$0")" == "backlight.sh" ]]; then
  if [[ $# == 0 ]]; then
    echo "Current brightness: $CUR_BRIGHTNESS"
    echo "Max brightness: $MAX_BRIGHTNESS"
    echo "Percentage: $PERCENTAGE"
  else
    NEW_BRIGHTNESS=$1
    if [[ $NEW_BRIGHTNESS =~ $INT_RE ]]; then
      if (( NEW_BRIGHTNESS > MAX_BRIGHTNESS )); then
        NEW_BRIGHTNESS=$MAX_BRIGHTNESS
      fi
      echo "echo $NEW_BRIGHTNESS > /sys/class/backlight/$TARGET_DISPLAY/brightness" | sudo bash
      echo "Updated to $NEW_BRIGHTNESS"
    else
      echo "Invalid argument. Failed to set brightness."
      exit 1
    fi
  fi
fi
exit 0
