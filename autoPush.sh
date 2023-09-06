#!/bin/fish
while inotifywait -e modify,create,delete -r /home/zed/.dotfiles/
    cd /home/zed/.dotfiles/
    git add -A && git commit -m "Auto Commit" && git push  
end
