FILE  = main
FILE2 = jump
FILE3 = shift
FILE4 = validate

run: $(FILE).asm $(FILE2).asm $(FILE3).asm $(FILE4).c
	nasm -f elf64 -l $(FILE).lst $(FILE).asm
	nasm -f elf64 -l $(FILE2).lst $(FILE2).asm
	nasm -f elf64 -l $(FILE3).lst $(FILE3).asm
	gcc -c $(FILE4).c -o $(FILE4).o
	gcc -m64 -o $(FILE) $(FILE2).o $(FILE3).o $(FILE4).o $(FILE).o -lm
	$(FILE)

clean: 
	rm *.o  *.lst

