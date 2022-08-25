#!/bin/fish
if test (playerctl status 2>&1) = Playing
    set p $(playerctl metadata --format "{{ title }} - {{ artist }}")
    set p $(string replace -a '"' '\\"' $p)
    if test (string length $p) -gt 38
        set p $(playerctl metadata --format "{{ title }}")
        if test (string length $p) -gt 38
            echo "$(string sub --length 38 $p)"
        else
            echo $p
        end
    else
        echo $p
    end
else
    if [ -n $p ]
        echo ""
    end
end
