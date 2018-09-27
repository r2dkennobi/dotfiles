#!/bin/bash
# For DisplayLink X Display setup
#$(xrandr --listproviders | grep -q "modesetting") && xrandr --setprovideroutputsource 1 0
OS=$(grep '^ID=' /etc/os-release | awk -F= '{ print $NF }')
if [[ $OS = *"antergos"* ]]; then
  exec i3 -V > "$HOME/.config/i3/logfile" 2>&1
fi
