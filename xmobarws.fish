#!/bin/fish
set str
set -l v $ws
set -l var $ws
set -q argv[1]; and set var $argv[1]
for i in (seq 8)
        if test "$var" -eq $i
            set -U ws $i
            set -a str "<action=fish -c '/home/zed/.dotfiles/xmobarws.fish $i'><fc=white,#3B4252:1><box type=HBoth color=#ECEFF4 width=2> $i </box></fc></action>"
        else
            set -a str "<action=fish -c '/home/zed/.dotfiles/xmobarws.fish $i'><fc=white,#434C5E:1><box type=HBoth color=#ECEFF4 width=2> $i </box></fc></action>"
        end
end
echo -s $str
if test $v -ne $ws
    xdotool key super+$ws
end
