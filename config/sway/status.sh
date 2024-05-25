#!/bin/fish
while true
    set pl (player)
    set wifi (
    if nmcli device show wlp1s0 | grep -q "\bconnected\b"
      set icon 
    else
      set icon 睊
    end 
    echo -n "<span font='FiraCode Nerd Font 12'>$icon </span>"
    )
    set br (bright)
    set vol (pamixer --get-volume-human)
    set bat (string trim (battery))
    set date (date '+%a %d/%m/%y %r')
    printf '
,[
    {
      "name":"id_music",
      "full_text":"%s",
      "min_width":600,
      "align":"center",
      "markup":"pango"
    },
    {
      "name":"id_wifi",
      "full_text":"%s",
      "markup":"pango"
    },
    {
      "name":"id_br",
      "full_text":"<span font=\'FiraCode Nerd Font 12\'></span>  %s",
      "markup":"pango"
    },
    {
      "name":"id_vol",
      "full_text":"<span font=\'FiraCode Nerd Font 12\'></span>  %s",
      "markup":"pango"
    },
    {
      "name":"id_bat",
      "full_text":"<span font=\'FiraCode Nerd Font 12\'></span>     %s",
      "markup":"pango"
    },
    {
      "name":"id_date",
      "full_text":"<span font=\'FiraCode Nerd Font 12\'></span>   %s",
      "markup":"pango"
    }
]' $pl $wifi $br $vol $bat $date
end
