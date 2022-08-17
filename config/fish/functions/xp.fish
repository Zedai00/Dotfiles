function xp
if count (wmctrl -l) > 1
killall picom;picom --config ~/.config/picom2.conf 
else
killall picom; picom 
end
end
