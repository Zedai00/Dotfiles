#!/bin/fish
while inotifywait -e modify,create,delete -r /home/zed/.dotfiles/
    cd /home/zed/.dotfiles/
    git add -A &> ~/log 
    git commit -m "Auto Commit" &> ~/log
    git push >> ~/log  
end
