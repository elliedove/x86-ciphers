;;; ; Ellie Dove (edove1@umbc.edu)
;;; ; CMSC 313 PROJ4 
;;; ; shift.asm
;;; ; Uses caesar cipher-style ASCII rotation to shift chars
;;; ;

        extern printf
        extern scanf

        section .data
msg1:       db      "Enter shift value: ", 0
len1:       equ     $-msg1
msg2:       db      "Enter string location: ", 0
len2:       equ     $-msg2
msg3:       db      "Current message: "
len3:       equ     $-msg3
msg4:       db      "Encrypted message: ", 0
len4:       equ     $-msg4
fmt:        db      "%s", 10, 0
invalid:    db      "Invalid choice.", 0
newline:    db      10, 0
newlen:     equ     $-newline

        section .bss
indexBuff   resb    64 ; reserve space for string buffer
shiftBuff   resb    64 ; way too much space for two digits
stringBuff  resb    256
newString   resb    256

        section .text
        global  shift
shift:
        ; immediately move 'array' param into stringBuff
        mov         [stringBuff], rdi

        ; Ask for index value
    	mov	        rax, 1
        mov	        rdi, 1
    	mov	        rsi, msg2
    	mov	        rdx, len2
    	syscall

        ; Look for indexBuff input
        mov         rax, 0 
        mov         rdi, 0
        mov         rsi, indexBuff
        mov         rdx, 64 ; num of chars expected to read
        syscall
        
        call        sanitizeIndex

        ; Ask for shift value
    	mov	        rax, 1      
	mov	        rdi, 1
	mov	        rsi, msg1
	mov	        rdx, len1
	syscall

        ; Store in shiftBuff
        mov         rax, 0 
        mov         rdi, 0
        mov         rsi, shiftBuff
        mov         rdx, 64 ; num of chars expected to read
        syscall

        jmp         sanitize

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

invalidFinish:
        ; Prints invalid and returns to main
        mov         rdi, fmt
        mov         rsi, invalid
        mov         rax, 0
        call        printf

        ; print newline
        mov	        rax, 1      
	mov	        rdi, 1
	mov	        rsi, newline
	mov	        rdx, newlen
	syscall

        ret

increment:
        ; increments r10 then goes sequentially downwards
        add         r10, 1

looper:
        ; loop to shift every char in the string
        mov         r9, [r14]
        add         r9, r10 ; moves r9 along

        cmp         [r9], byte 0 ; see if '\0' char (end of string)
        je          finish

        cmp         [r9], byte 97 ; if it's below 97, it'll likely be uppercase
        jb          uppercase

        cmp         [r9], byte 122 ; >122 -> increment, do nothing
        ja          increment
        
        add         [r9], r12 ; shift current char

        cmp         [r9], byte 122 ; if it goes over, loop it back 
        ja          getInRangeLower 

        add         r10, 1 ; increment counter
        jmp         looper

uppercase:
        ; handles anything to do with uppercase letters
        cmp         [r9], byte 65 ; bounds check for <65 
        jb          increment

        cmp         [r9], byte 90 ; bounds check for >90 
        ja          increment
        add         [r9], r12 ; shift current char

        cmp         [r9], byte 90 ; if out of A-Z, bring back in
        ja          getInRangeUpper

        add         r10, 1
        jmp         looper

getInRangeUpper:
        ; gets uppercase letters back in range A-Z
        sub         [r9], byte "Z"
        add         [r9], byte "A"
        sub         [r9], byte 1

        add         r10, 1
        jmp         looper

getInRangeLower:
        ; gets lowercase letters back in range a-z
        sub         [r9], byte "z"
        add         [r9], byte "a"
        sub         [r9], byte 1

        add         r10, 1
        jmp         looper

finish:
        ; print "encrypted message"
    	mov	        rax, 1      
	mov	        rdi, 1
        mov	        rsi, msg4
        mov	        rdx, len4
        syscall

        ; print the finished product
        mov         rdi, fmt
        mov         rsi, [r14]
        mov         rax, 0
        call        printf

        ; print newline
        mov	        rax, 1      
	mov	        rdi, 1
	mov	        rsi, newline
	mov	        rdx, newlen
	syscall

        ret ; return back to main.asm

sanitize:
        ; sanitizes index and shift amount

        ; Sanitize shift amount
        xor         r11, r11 ; using as a counter
        xor         r12, r12 ; total shift amount

        mov         r11, shiftBuff 
        movzx       r8, byte [r11] ; grab the first byte of shiftBuff
        sub         r8, 48 ; convert to int

        add         r11, 1 ; move to the next character
        cmp         [r11], byte 10
        je          singleDigit ; jump to label to handle single digit

        ; otherwise - handle as if there's two digits
        mov         rax, r8 
        mov         r8, 10
        mul         r8 ; multiply the first digit by 10
        add         r12, rax ; add to total

        movzx       r8, byte [r11]
        sub         r8, 48 ; convert to int

        add         r12, r8 ; add 2nd digit to total
        jmp         validShift

singleDigit:
        ; label for if there's only a single digit
        add         r12, r8
        jmp         validShift

validShift:
        ; Verifies the inputted shift is in our valid range
        cmp         r12, 25
        ja          invalidFinish

        cmp         r12, 0
        jb          invalidFinish

        ; print "current message"
    	mov	        rax, 1      
	mov	        rdi, 1
	mov	        rsi, msg3
	mov	        rdx, len3
	syscall

        ; print out original message
        mov         rdi, fmt
        mov         rsi, [r14]
        mov         rax, 0
        call        printf

        xor         r10, r10

        jmp         looper
