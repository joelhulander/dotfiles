#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.drawing=on icon.color=0xffeba0ac
else
  sketchybar --set $NAME background.drawing=off icon.color=0xffcdd6f4
fi
