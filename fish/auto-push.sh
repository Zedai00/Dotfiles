#!/bin/bash
while true; do

inotifywait -e modify,create,delete -r /home/zed/.config/fish/ && \
git add . && git commit -m "Auto Commit" && git push origin main 

done
