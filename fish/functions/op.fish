function op
argparse "m" -- $argv
or return 
if set -q _flag_m 
for i in $argv
        nohup $i &> /dev/null & disown 
end
else
nohup (string split " " $argv) &> /dev/null & disown
end
end
