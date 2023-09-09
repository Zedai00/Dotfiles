function asm
nasm -f elf64 $argv
ld (path change-extension o $argv) -o (path change-extension '' $argv)
end
