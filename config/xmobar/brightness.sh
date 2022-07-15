#!/bin/fish
# Change Brightness and Update In Xmobar

# Create Pipe
#set -U _bright_pipe /tmp/.bright-pipe
#if [ ! -e /tmp/.bright-pipe ] # If Pipe does not exist create it.
#    mkfifo $_bright_pipe
#end

function get_bright
    set br (math round (xbacklight -get))
    if [ $br -gt 99 ]
        echo "$br%" | xmonadpropwrite _BRIGHT &> /dev/null
    else if [ $br -gt 9 ] 
        echo "$br% " | xmonadpropwrite _BRIGHT &> /dev/null
    else
        echo " $br% " | xmonadpropwrite _BRIGHT &> /dev/null
    end
end

switch $argv
    case "up"
        xbacklight -inc 5%
    case "down"
        xbacklight -dec 5%
    case "*"
        echo "Error Xbacklight Unknown Command"
end

get_bright
