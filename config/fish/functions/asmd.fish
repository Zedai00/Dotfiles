function asmd
nasm -f elf64 $argv
ld (path change-extension o $argv) -o (path change-extension '' $argv)
rm (path change-extension o $argv)
end
