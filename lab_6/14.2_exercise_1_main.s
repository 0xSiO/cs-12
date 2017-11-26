@ Lucas Street
@ Prompts user to enter a string, converts it to lowercase, and prints the result.
@ This code is copied from my solution for exercise 4 of the previous lab, only 
@ the readLn function has changed.
@ Nov 26, 2017

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constants
        .equ    length, 50      @ amount of memory for string

        .section .rodata
        .align  2
prompt:
        .asciz "Enter a string. "

@ The program
        .text
        .align  2
        .global main
        .type   main, %function
main:
        sub     sp, sp, 16      @ space for saving regs
                                @ (keeping 8-byte sp align)
        str     r4, [sp, 4]     @ save r4
        str     fp, [sp, 8]     @      fp
        str     lr, [sp, 12]    @      lr
        add     fp, sp, 12      @ set our frame pointer

        mov     r0, length      @ how many bytes to allocate
        bl      malloc          @ allocate memory on the heap
        mov     r4, r0          @ pointer to new memory

        ldr     r0, promptAddress  @ prompt to enter a string
        bl      writeStr
        
        mov     r0, r4          @ load char * as first argument
        mov     r1, length      @ load max length as second argument
        bl      readLn          @ read user input into char *
        
        mov     r0, r4          @ load char * as first argument
        bl      writeStr        @ write string that char * points to
        
        mov     r0, r4          @ load char * as first argument
        bl      free            @ don't leak memory!
        
        mov     r0, 0           @ return 0;
        ldr     r4, [sp, 4]     @ restore r4
        ldr     fp, [sp, 8]     @         fp
        ldr     lr, [sp, 12]    @         lr
        add     sp, sp, 16      @         sp
        bx      lr              @ return

promptAddress:
        .word    prompt
