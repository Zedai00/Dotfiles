#!/bin/fish
while true
    echo -n ",["
    echo -n "{\"name\":\"id_music\",\"full_text\":\"$(player)\",\"min_width\":600, \"align\":\"center\"},"
    echo -n "{\"name\":\"id_br\",\"full_text\":\"Br:$(bright)\"},"
    echo -n "{\"name\":\"id_volume\",\"full_text\":\"Vol:$(pamixer --get-volume-human)\"},"
    echo -n "{\"name\":\"id_bat\",\"full_text\":\"Bat:$(string trim (battery))\"},"
    echo -n "{\"name\":\"id_time\",\"full_text\":\"$(date "+%a %d/%m/%y %r")\"}"
    echo -n "]"
    sleep 1
end
