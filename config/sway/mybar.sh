#!/bin/fish
echo '{ "version": 1, "click_events":true }'
echo '['
echo '[]'

# launched in a background process
~/.config/sway/status.sh &

# Listening for STDIN events
while read line
    echo $line > /tmp/tmp.txt
    # on click, we get from STDIN :
    # {"name":"id_time","button":1,"modifiers":["Mod2"],"x":2982,"y":9,"relative_x":67,"relative_y":9,"width":95,"height":22}
    # DATE click
    if string match -q -- "*id_time*" $line
        set p (foot --hold ~/.config/sway/click.sh &; echo "$last_pid")
        while read line
            kill $p
            break
        end
    end
end
