function op
argparse --ignore-unknown "m" -- $argv
or return 
if set -q _flag_m 
for i in $argv
        $i &> /dev/null & disown &> /dev/null
end
else 
 $argv &> /dev/null & disown &> /dev/null
end
end
