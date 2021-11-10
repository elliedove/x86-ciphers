;;; ; Ellie Dove (edove1@umbc.edu)
;;; ; CMSC 313 PROJ4 
;;; ; main.asm
;;; ; Assembly code controlling the menu for various ciphers
;;; ;

        extern printf
        extern scanf
        extern jump
        extern shift
        extern readMessage
        extern display
        extern easterEgg

        section .data
menu1:      db      "Encryption menu options:", 10, "d - display current message", 0
menu2:      db      "r - read new message", 10, "s - shift encrypt", 0
menu3:      db      "j - jump encrypt", 10, "q - quit program", 0
menu4:      db      "Enter chosen option:", 0
foundMsg:   db      "Command not found", 0, 10
bye:        db      "Goodbye!", 10, 0
fmt:        db      "%s", 10, 0

; Saved message slots
msg0:       db      "This is the original message.", 0
msg1:       db      "This is the original message.", 0
msg2:       db      "This is the original message.", 0
msg3:       db      "This is the original message.", 0
msg4:       db      "This is the original message.", 0
msg5:       db      "This is the original message.", 0
msg6:       db      "This is the original message.", 0
msg7:       db      "This is the original message.", 0
msg8:       db      "This is the original message.", 0
msg9:       db      "This is the original message.", 0
array:      dq      msg0, msg1, msg2, msg3, msg4, msg5, msg6, msg7, msg8, msg9

        section .bss
option:     resb    64 ; space for menu option (way too much :> )
option2:    resb    64 ; space for shift index

        section .text
        global main
main:
        push        rbp

        xor         r12, r12 ; counter for easter egg

        ; r15 is going to be our counter
        ; This is sketchy. r10 didn't work bc syscalls
        xor         r15, r15

        call        menuLoop

        pop         rbp

        ; Return 0 at end
        ; This is basically just a failsafe - should never be reached
        mov         rax, 0
        ret

readInt:
        ; Uses an interrupt to read input for option 
        mov         rax, 3
        mov         rbx, 0
        int         0x80

        ret

printMenu:
        ; Print the menu itself
        mov         rdi, fmt
        mov         rsi, menu1
        mov         rax, 0
        call        printf

        mov         rdi, fmt
        mov         rsi, menu2
        mov         rax, 0
        call        printf

        mov         rdi, fmt
        mov         rsi, menu3
        mov         rax, 0
        call        printf

        mov         rdi, fmt
        mov         rsi, menu4
        mov         rax, 0
        call        printf

        ret

menuLoop:
        ; Loops through menu - controls fLow
        call        printMenu

        ; Get user input, store in option
        mov         rcx, option
        mov         rdx, 2
        call        readInt
        
        ; Navigate the menu options
        ; Quit option
        cmp         [option], byte 'q'
        je          quit

        ; Display option (calls C func)
        cmp         [option], byte 'd'
        je          callDisplay

        cmp         [option], byte 'r'
        je          callRead

        cmp         [option], byte 's'
        je          callShift

        cmp         [option], byte 'j'
        je          callJump


        mov         rdi, fmt
        mov         rsi, foundMsg
        mov         rax, 0
        call        printf

        cmp         [option], byte 'c'
        je          incrementEaster

        ; Loop if control never leaves
        jmp         menuLoop

        ret

incrementEaster:
        ; Counter for easter egg
        add         r12, 1
        cmp         r12, 4
        je          callEaster

        jmp         menuLoop

callEaster:
        ; Calls easter egg C funct
        call        easterEgg ; ;)

        jmp         menuLoop

callRead:
        ; Sets up/calls readMessage C funct
        ; param 1: array (array)
        ; param 2: r15 (int)
        mov         rdi, array
        mov         rsi, r15
        call        readMessage

        ; rax now stores 1 or 0
        ; Increment our counter
        cmp         rax, byte 1
        je          increment

        ; clear rax
        xor         rax, rax

        jmp         menuLoop

increment:
        ; Increments our index counter (r15)
        add         r15, 1
        jmp         menuLoop

callDisplay:
        ; Sets up/Calls display C funct
        mov         rdi, array
        call        display
        jmp         menuLoop

callShift:
        ; Sets up/calls assembly code for shift
        mov         rdi, array
        call        shift

        jmp         menuLoop

callJump:
        ; Sets up/calls jump.asm
        mov         rdi, array
        call        jump

        jmp         menuLoop

quit:
        ; Print "Goodbye!"
        mov         rdi, fmt
        mov         rsi, bye
        mov         rax, 0
        call        printf

        ; Return 0
        xor         rax, rax

        ret