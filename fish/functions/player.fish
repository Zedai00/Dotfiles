function player
if test (playerctl status) = "Playing"
echo $(playerctl metadata --format "Now playing: {{ title }} - {{ artist }}")
else 
echo ""
end
end
