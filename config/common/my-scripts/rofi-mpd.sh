#!/usr/bin/env bash

# Control MPD from rofi. Copy/pasted and adapted from
# https://gitlab.com/vahnrr/rofi-menus.

rofi_command="rofi"

### Options ###

# Gets the current status of mpd (for us to parse it later on)
status="$(mpc status)"

# Defines the Play / Pause option content
if [[ $status == *"[playing]"* ]]; then
    play_pause=""
else
    play_pause=""
fi

active=""
urgent=""

stop=""
next=""
previous=""

# Variable passed to rofi
options="$previous\n$play_pause\n$stop\n$next"

# Get the current playing song
current=$(mpc current)

# If mpd isn't running it will return an empty string, we don't want
# to display that
if [[ -z "$current" ]]; then
    current="-"
fi

# Spawn the mpd menu with the "Play / Pause" entry selected by default
chosen=$(echo -e "$options" | $rofi_command -p "$current" -dmenu -selected-row 1)

case $chosen in
    $previous)
        mpc -q prev
        ;;
    $play_pause)
        mpc -q toggle
        ;;
    $stop)
        mpc -q stop
        ;;
    $next)
        mpc -q next
        ;;
esac
