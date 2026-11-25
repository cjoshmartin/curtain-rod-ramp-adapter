#!/bin/sh
# Renders the README images from views.scad. Run from anywhere: sh images/render.sh
set -e
cd "$(dirname "$0")"

render() {
    out=$1; view=$2; size=$3; camera=$4; projection=$5
    openscad -o "$out" --imgsize="$size" --colorscheme=Tomorrow \
        --projection="$projection" --camera="$camera" -D "view=\"$view\"" views.scad
}

# Installed on the rod, seen from the room side (clip opening facing you)
render front.png   installed 1600,900  -40,0,0,45,0,-25,200   p
# Installed on the rod, seen from the wall side
render back.png    installed 1600,900  -40,0,0,55,0,200,180   o
# Adapter cut in half lengthwise, showing the ramp, the stop and the sleeve
render section.png section   1600,700  -35,0,0,90,0,0,98      o
# Looking along the rod: the C-shaped clip
render end.png     end       1000,1000 0,0,0,90,0,90,90       o
# Standing on the print bed, as exported
render print.png   print     900,1200  0,0,33,62,0,30,210     p
