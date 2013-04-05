#!/bin/bash

# adapte from http://ubuntuforums.org/showthread.php?t=1877865
# For Ubuntu Unity 2d, create custom shortcuts to snap left and right by giving the followng commands:
# /path/to/snapwindow.sh left
# /path/to/snapwindow.sh right

WIDTH=`xdpyinfo | grep 'dimensions:' | cut -f 2 -d ':' | cut -f 1 -d 'x' `
HALF=$(($WIDTH/2))
wmctrl -r :ACTIVE: -b remove,maximized_horz,fullscreen
wmctrl -r :ACTIVE: -b add,maximized_vert
if [ "$1" == "left" ]; then
    wmctrl -r :ACTIVE: -e 0,0,0,$HALF,-1
fi
if [ "$1" == "right" ]; then
    wmctrl -r :ACTIVE: -e 0,$HALF,0,$HALF,-1
fi
