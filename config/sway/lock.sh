#!/bin/fish
set lock 'swaylock --clock --indicator --screenshots --effect-scale 0.4 -
-effect-vignette 0.2:0.5 --effect-blur 4x2 --datestr "%a %e.%m.%Y" --timest
r "%k:%M"'

exec swayidle -w \
    timeout 300 $lock \
    timeout 600 'swaymsg "output * dpms off"' resume 'swaymsg "o
utput * dpms on"' \
    before-sleep $lock
