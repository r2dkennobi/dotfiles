#!/bin/bash

declare -a DA_LIST=($(xrandr | grep ".*connected" | cut -d' ' -f1));
declare -a DA_STATE=($(xrandr | grep ".*connected" | cut -d' ' -f2));
echo ${DA_LIST[@]}
echo ${DA_STATE[@]}
