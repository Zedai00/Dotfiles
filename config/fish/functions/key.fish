function key
    if test (playerctl status) = Playing
        switch $argv
            case next
            
            case '*'
            
        end
    else
        echo Start
    end
end
