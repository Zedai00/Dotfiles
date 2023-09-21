function asm32
nasm -f elf32 $argv
ld -m elf_i386 (path change-extension o $argv) -o (path change-extension '' $argv)
rm (path change-extension o $argv)
set -l cmd (path change-extension '' $argv)
./$cmd
end
