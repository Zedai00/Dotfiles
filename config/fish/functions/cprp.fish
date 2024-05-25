function cprp
rsync --archive -hh --partial --info=stats3,progress2 --modify-window=1  $argv
end
