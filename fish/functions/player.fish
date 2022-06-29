function player
    if [ (playerctl status 2>&1) = Playing ]
        switch $argv
            case next
                playerctl next
            case previous
                playerctl previous
            case play-pause
                playerctl play-pause
        end
    else if test $playing = true
        switch $argv
            case next
                ytm next
            case previous
                ytm previous
            case play-pause
                ytm play-pause
        end
    end
end
