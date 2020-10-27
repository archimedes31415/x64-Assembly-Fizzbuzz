fizzbuzz: fizzbuzz.o
	ld -o fizzbuzz fizzbuzz.o
fizzbuzz.o: fizzbuzz.asm
	nasm -f elf64 -o fizzbuzz.o fizzbuzz.asm
