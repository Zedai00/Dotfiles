function setw
wget (random choice (curl 'https://www.reddit.com/r/wallpapers.json?show=all&limit=25' | jq -r '.data.children[].data.url' | egrep "jpeg|png|jpg")) -O wall
swaybg -i wall
end
