#!/bin/fish
# Change Sound and Update In Xmobar

function get_sound
    set br (amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }'
)   
    echo $argv
    if test (count $argv) -lt 2 -a "$argv[1]" = "mute"
            echo "<fn=1>ﱝ </fn>$br" | xmonadpropwrite _SOUND &> /dev/null
    else
        echo "<fn=1>墳 </fn>$br" | xmonadpropwrite _SOUND &> /dev/null
    end
end

switch $argv
    case "up"
        pactl set-sink-volume 0 +5%
        get_sound 
    case "down"
        pactl set-sink-volume 0 -5%
        get_sound 
    case "mute"
        if set -q mute
            pactl set-sink-mute 0 toggle
            get_sound "unmute"
            set -e mute
        else
            pactl set-sink-mute 0 toggle
            get_sound "mute"
            set -U mute 0%
        end
    case "*"
        get_sound
end
