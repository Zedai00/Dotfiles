#!/bin/fish
while inotifywait -e modify,create,delete -r /home/zed/.dotfiles/
    cd ~/.dotfiles/
    git add -A && git commit -m "Auto Commit" && git push origin main
end
