function subs
ffmpeg -i $argv[1] -f srt -i $argv[2] \
-map 0:0 -map 0:1 -map 1:0 -c:v copy -c:a copy \
-c:s mov_text $argv[3]
end
