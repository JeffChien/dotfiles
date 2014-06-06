#!/usr/bin/env bash

readonly MONITOR1='LVDS'
readonly MONITOR2='VGA-0'

xrandr --output "$MONITOR1" --auto --off
xrandr --output "$MONITOR2" --auto
