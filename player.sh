#!/bin/fish
if test (playerctl status 2>&1) = Playing
    set p $(playerctl metadata --format "Now Playing: {{ title }} - {{ artist }}")
    if test (string length $p) -gt 60
        set p $(playerctl metadata --format "Now Playing: {{ title }}")
        if test (string length $p) -gt 60
            echo "$(string sub --length 60 $p)..."
        else
            echo $p
        end
    else
        echo $p
    end
end
