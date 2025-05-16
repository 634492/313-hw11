# 313-hw11
Code written by: Lance Leckner 
Class: UMBC CMSC 313 2:30-3:45
How to compile and execute my code.
Enter your terminal.
To assemble: nasm -f elf32 -g -F dwarf -o convertToAscii.o convertToAscii.asm
To link and load: ld -m elf_i386 -o convertToAscii convertToAscii.o
Then run the program convertToAscii

