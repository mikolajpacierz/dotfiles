#!/bin/bash

MIC="alsa_input.usb-MV-SILICON_fifine_Microphone_20190808-00.mono-fallback"

pactl subscribe --monitor | \
grep --line-buffered -E "source #" | \
while read -r ; do
    if pactl list short sources | grep -q "$MIC"; then
        pactl set-source-volume "$MIC" 200%
    fi
done

