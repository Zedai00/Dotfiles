#!/usr/bin/fish
while not wget (random choice (curl 'https://www.reddit.com/r/wallpapers.json?show=all&limit=25' | jq -r '.data.children[].data.url' | egrep "jpeg|jpg")) -O wall
end
swaybg -i wall
