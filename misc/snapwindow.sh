#!/bin/bash

# based on http://ubuntuforums.org/showthread.php?t=1877865

# sudo apt-get install wmctrl
# For Ubuntu Unity 2d, create custom shortcuts to snap left and right by giving the followng commands:
# /path/to/snapwindow.sh left
# /path/to/snapwindow.sh right

WIDTH=`xdpyinfo | grep 'dimensions:' | cut -f 2 -d ':' | cut -f 1 -d 'x' `
HALF=$(($WIDTH/2))
QUARTER=$(($WIDTH/4))
wmctrl -r :ACTIVE: -b remove,maximized_horz,fullscreen
wmctrl -r :ACTIVE: -b add,maximized_vert

# single monitor
if [ "$1" == "left" ]; then
    wmctrl -r :ACTIVE: -e 0,0,0,$HALF,-1
fi
if [ "$1" == "right" ]; then
    wmctrl -r :ACTIVE: -e 0,$HALF,0,$HALF,-1
fi

# dual monitors
if [ "$1" == "1/4" ]; then
    wmctrl -r :ACTIVE: -e 0,0,0,$QUARTER,-1
fi
if [ "$1" == "2/4" ]; then
    wmctrl -r :ACTIVE: -e 0,$QUARTER,0,$QUARTER,-1
fi
if [ "$1" == "3/4" ]; then
    wmctrl -r :ACTIVE: -e 0,$HALF,0,$QUARTER,-1
fi
if [ "$1" == "4/4" ]; then
    let "x = $HALF+$QUARTER"
    echo $WIDTH
    echo $HALF
    echo $QUARTER
    echo $x
    wmctrl -r :ACTIVE: -e 0,$x,0,$QUARTER,-1
fi
