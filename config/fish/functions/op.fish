function op
argparse "m" -- $argv
or return 
if set -q _flag_m 
for i in $argv
        $i &> /dev/null & disown 
end
else
for i in  (string split " " $argv)
 $i &> /dev/null & disown
end
end
end
