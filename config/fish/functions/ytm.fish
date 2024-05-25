function ytm
    if [ $playing = false ]
        set -U link $argv
        set -U track 1
        set -U playing true
        set -U play true
        yt-dlp -f bestaudio $link -o - 2>/dev/null | ffplay -nodisp -autoexit -i - &>/dev/null
    else
        switch $argv
            case next
                killall yt-dlp
                set -U track (math $track + 1)
                yt-dlp -f bestaudio $link --playlist-items (math $track + 1) -o - 2>/dev/null | ffplay -nodisp -autoexit -i - &>/dev/null
            case previous
                if test $track -gt 1
                    killall yt-dlp
                    set t $track
                    set -U track (math $track - 1)
                    yt-dlp -f bestaudio $link --playlist-items (math $t - 1) -o - 2>/dev/null | ffplay -nodisp -autoexit -i - &>/dev/null
                end
            case play-pause
                if $play
                    set -U play false
                    killall yt-dlp
                else
                    yt-dlp -f bestaudio $link --playlist-items $track -o - 2>/dev/null | ffplay -nodisp -autoexit -i - &>/dev/null
                end
        end
    end
end
