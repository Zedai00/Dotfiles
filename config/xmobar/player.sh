#!/bin/fish
while true
    if test (playerctl status 2>&1) = Playing
        set p $(playerctl metadata --format "{{ title }} - {{ artist }}")
        if test (string length $p) -gt 38
            set p $(playerctl metadata --format "{{ title }}")
            if test (string length $p) -gt 38
                echo "$(string sub --length 38 $p)" | xmonadpropwrite _XM &> /dev/null
            else
                echo $p | xmonadpropwrite _XM &> /dev/null
            end
        else
            echo $p | xmonadpropwrite _XM &> /dev/null
        end
    else
        if [ -n $p ]
            echo "" | xmonadpropwrite _XM &> /dev/null
        end
    end
end
