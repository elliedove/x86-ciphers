;;; ; Ellie Dove (edove1@umbc.edu)
;;; ; CMSC 313 PROJ4 
;;; ; jump.asm
;;; ; Assembly code for traditional "jump" cipher
;;; ;

        extern printf
        extern scanf
        extern squareRoot

        section .data
msg1:       db      "Enter string location: ", 0
len1:       equ     $-msg1
msg2:       db      "Current Message: ", 0
len2:       equ     $-msg2
invalid:    db      "Invalid jump value", 0
msg5:       db      "Encrypted Message: ", 0
len5:       equ     $-msg5
fmt1:       db      "%s", 10, 0
fmt2:       db      "Enter jump interval between 2-%d: ", 10,0
fmt3:       db      "Length: %d", 10, 0
newline:    db      10, 0
newlen:     equ     $-newline
length:     db      0
counter:    db      0
jumpSize:   db      0


        section .bss
stringBuff  resb    256
indexBuff   resb    64
jumpBuff    resb    64
jumpDist    resb    64


        section .text
        global  jump
jump:
        mov         [stringBuff], rdi

        ; Ask for index value
    	mov	        rax, 1
	    mov	        rdi, 1
	    mov	        rsi, msg1
	    mov	        rdx, len1
	    syscall

        ; Look for indexBuff input
        mov         rax, 0 
        mov         rdi, 0
        mov         rsi, indexBuff
        mov         rdx, 64 ; Num of chars expected to read
        syscall

        call        sanitizeIndex

        ; Get maximum jump values
        mov         rdi, [r14]
        mov         rsi, length ; Pass length by 'reference'
        call        squareRoot

        mov         r9, rax ; Get sqrt(len) from rax
        
        ; Print out maximum jump calue
        mov         rdi, fmt2
        mov         rsi, r9
        mov         rax, 0
        call        printf

        ; Store user's jump choice in jumpBuff
        mov         rax, 0 
        mov         rdi, 0
        mov         rsi, jumpBuff
        mov         rdx, 64 ; num of chars expected to read
        syscall

        call        sanitizeJump
        call        validJump

        ; Print "encrypted message"
    	mov	        rax, 1
	    mov	        rdi, 1
	    mov	        rsi, msg5
	    mov	        rdx, len5
	    syscall

        ; Setup for encoding
        xor         r13, r13
        xor         r9, r9
        xor         r10, r10
        xor         r8, r8
        mov         r9b, byte[length] ; move only the bits needed from length
        mov         r8b, byte[jumpSize]
        mov         r12, [r14]

encode:
        ; loops through the message in stringBuff, encoding and printing each char
        ; r8 -> desired jump (int)
        ; r9-> length of string
        ; r14 -> message we want
        ; r13 -> counter for while loop
        ; r10 -> next index
        mov         [r14], r12

        cmp         r9, r13
        jbe         finish

        ; Get message[next index], print it
        add         [r14], r10

        ; print the character
    	mov	        rax, 1
	    mov	        rdi, 1
	    mov	        rsi, [r14]
	    mov	        rdx, 1
	    syscall

        ; next += jump
        add         r10, r8

        xor         rdx, rdx
        ; r8 = next index % len(string)
        mov         rax, r10
        mov         rbx, r9
        div         rbx

        ; Compare remainder to 0
        cmp         rdx, 0
        je          reset_next

        ; Modulo the next index (basically)
        cmp         r10, r9
        jae         sub_len

        add         r13, 1

        jmp         encode

reset_next:
        ; resets next to 0 and moves one character forwards
        mov         r10, 0
        add         r12, 1

        add         r13, 1
        jmp         encode

sub_len:
        ; Subtracts length of string from next index
        sub         r10, r9
        add         r13, 1

        jmp         encode

sanitizeIndex:
        ; Sanitize index digit first
        xor         r13, r13
        mov         r14, indexBuff
        movzx       r13, byte [r14]
        sub         r13, 48 ; convert to int

        shl         r13, 3
        ; Move appropriate array index into stringBuff
        mov         r14, [stringBuff]
        add         r14, r13 ; r14 now holds the address we want to access

        ret

sanitizeJump:
        ; Turn jump value into int
        mov         r11, jumpBuff
        movzx       r8, byte [r11]
        sub         r8, 48 ; r8 now stores int version of jump

        mov         [jumpSize], r8

        ret

invalidFinish:
        ; Prints "invalid" and exits
        mov         rdi, fmt1
        mov         rsi, invalid
        mov         rax, 0
        call        printf

        ; Print newline
        mov	        rax, 1      
	    mov	        rdi, 1
	    mov	        rsi, newline
	    mov	        rdx, newlen
	    syscall

        ret

validJump:
        ; Verifies whether jump value is valid
        cmp         r8, 2
        jb          invalidFinish

        cmp         r8, r10
        ja          invalidFinish

        ; Print current message if valid    
        ; Print "current message"
        mov	        rax, 1
	    mov	        rdi, 1
	    mov	        rsi, msg2
	    mov	        rdx, len2
	    syscall

        ; Print original message
        mov         rdi, fmt1
        mov         rsi, [r14]
        mov         rax, 0
        call        printf

        ret

finish:
        ; Finishes execution of jump.asm
        ; print newline
        mov	        rax, 1      
	    mov	        rdi, 1
	    mov	        rsi, newline
	    mov	        rdx, newlen
	    syscall

        ret ; Return back to main