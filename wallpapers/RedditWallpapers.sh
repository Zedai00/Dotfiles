#!/usr/bin/fish
cd /home/zed/.wallpapers/
if pgrep swaybg > /dev/null
      killall swaybg
end
rm wall
while not wget (random choice (curl 'https://www.reddit.com/r/wallpaper.json?show=all&limit=25' | jq -r '.data.children[].data.url' | egrep "jpeg|jpg")) -O wall
end
swaybg -i wall
