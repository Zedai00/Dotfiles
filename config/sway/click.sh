#!/bin/fish
argparse "a=+" "c=+" -- $argv
for i in (seq (count $_flag_a))
    if string match -q -- "*$_flag_a[$i]*" $line
        echo $_flag_c[$i] | read --local --list --tokenize c
        set p ($c &; echo "$last_pid")
        while read line
            kill $p
            break
        end
    end
end
