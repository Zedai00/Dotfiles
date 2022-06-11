function op
for i in $argv
nohup $i &> /dev/null & disown
end
end
