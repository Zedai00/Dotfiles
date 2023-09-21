function asm
nasm -f elf64 $argv
ld (path change-extension o $argv) -o (path change-extension '' $argv)
rm (path change-extension o $argv)
set -l cmd (path change-extension '' $argv)
./$cmd 
end
