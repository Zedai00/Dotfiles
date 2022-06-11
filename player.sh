#!/bin/fish
       if test (playerctl status) = "Playing"
           echo $(playerctl metadata --format "Now Playing: {{ title }} - {{ artist }}")
       else 
           echo ""
		end
