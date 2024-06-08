function debug
set info (string split '.' $argv)
set ext $info[2]
set file $info[1]
rm $file
switch $ext
case "cpp"
make CXXFLAGS="-g" $file
case "c"
make CFLAGS="-g" $file
end
end
