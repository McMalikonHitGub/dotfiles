#!/bin/bash 
echo "testing hyprlock.sh"

CONFIG="$HOME/.config/hypr/config"
HYPRLOCK="$HOME/.config/hypr/hyprlock.conf"
OUTPUT="/tmp/hyprlock.conf"

radius=$(<"$CONFIG/radius.txt")
bordercolor=$(<"$CONFIG/bordercolor.txt")
gap=$(<"$CONFIG/gap.txt")
borderwidth=$(<"$CONFIG/borderwidth.txt")
widgetcolor=$(<"$CONFIG/widgetcolor.txt")
textcolor=$(<"$CONFIG/textcolor.txt")


sed \
    -e "s/RADIUS/$radius/g" \
    -e "s/BORDERCOLOR/$bordercolor/g" \
    -e "s/BORDERWIDTH/$borderwidth/g" \
    -e "s/WIDGETCOLOR/$widgetcolor/g" \
    -e "s/TEXTCOLOR/$textcolor/g" \
    "$HYPRLOCK" > "$OUTPUT"
cat "$OUTPUT"
hyprlock -c "$OUTPUT"
