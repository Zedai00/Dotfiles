function play
	nohup vlc $argv &>/dev/null & disown 
end
