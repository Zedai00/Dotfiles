function runc
set info (string split '.' $argv)
set ext $info[2]
set file $info[1]
if test -d $file
rm $file
end
switch $ext
case "cpp"
make CXXFLAGS="-g" $file >> /dev/null
case "c"
make CFLAGS="-g" $file >> /dev/null
end
./$file
end
