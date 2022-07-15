#!/bin/fish
# Change Sound and Update In Xmobar


function get_bar
    set br (amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }'
    if [ $br -gt 99 ]
        set -gx sound "$br"
    else if [ $br -gt 9 ]
        set -gx sound " $br"
    else
        set -gx sound " $br "
    end
end

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
        if string match "*yes*" (pactl get-sink-mute 0)
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
