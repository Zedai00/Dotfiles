function op
argparse "m" -- $argv
or return 
if set -q _flag_m 
for i in $argv
        $i &> /dev/null & disown &> /dev/null
end
else
for i in  (string split " " $argv)
 $i &> /dev/null & disown &> /dev/null
end
end
end
