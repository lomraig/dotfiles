#!/bin/bash
state_file=/tmp/rgb_is_off

if [ -f "$state_file" ]; then
    openrgb --profile on
    rm "$state_file"
else
    openrgb --profile off
    touch "$state_file"
fi
