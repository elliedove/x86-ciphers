# x86 Ciphers - Jump and Shift Ciphers
Several elementary historical ciphers implemented in x86_64 ASM
Completed to learn fundamentals of x86_64 in Spring 2021

Although not flawless, this exercise in low-leveling programming provided me with perfect insight into the basics of x86 and the needed amount of management and design on the programmer side. 

This program is assembled with NASM via Makefile and uses a mix of syscalls and calls to C functions (validate.c) to allow the user to store 10 individual messages to be 'encrypted'. Message length does not have to be predetermined, and is dynamically allocated via validate.c. 

A tiny easter-egg is included with C code to print a scannable Spotify song link, but ASCII formatting in-terminal may vary.
