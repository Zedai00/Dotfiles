#!/bin/fish
set wall ~/.dotfiles/wallpapers/wall.jpg
set urlpath ( \
curl "https://www.bing.com/HPImageArchive.aspx?format=rss&idx=0&n=1&mkt=en-US" \
| xmllint --xpath "/rss/channel/item/link/text()" - \
| sed 's/1366x768/1920x1080/g' \
)
curl "https://www.bing.com$urlpath" -o $wall
swaymsg output "*" bg ~/.dotfiles/wallpapers/wall.jpg fill
