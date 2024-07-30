#!/usr/bin/fish
cd /home/zed/.wallpapers/
start swaybg -i /home/zed/.wallpapers/wall
while not curl -o wall (random choice (curl 'https://www.reddit.com/r/wallpaper.json?show=all&limit=25' | jq -r '.data.children[].data.url' | egrep "jpeg|jpg")) 
end
if pgrep swaybg > /dev/null
      killall swaybg
end
start swaybg -i wall
