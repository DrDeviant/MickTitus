#!/usr/bin/env bash
notify-send "Fucked the script"
for run in {1..25}; do pkill crows.sh; done
