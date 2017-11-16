@ Lucas Street
@ Reads string from STDIN and stores it in an array. Returns the length of the
@ string.
@ Nov 16, 2017

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constants
        .equ    STDIN, 0
        .equ    NULL, 0
        .equ    NEWLINE, 10          @ '\n'

        .text
        .align  2
        .global readLn
        .type   readLn, %function

readLn:
        sub     sp, sp, 16      @ space for saving regs
        str     r4, [sp, 4]     @ save r4
        str     r5, [sp, 8]     @      r5
        str     fp, [sp, 12]    @      fp
        str     lr, [sp, 16]    @      lr
        add     fp, sp, 12      @ set our frame pointer

        mov     r4, r0          @ r4 = char *
        mov     r5, 0           @ r5 = length

        mov     r0, STDIN       @ keyboard input
        mov     r1, r4          @ specify where to put the char
        mov     r2, 1           @ read 1 byte
        bl      read
loop:
        ldrb    r3, [r4]        @ get a char
        cmp     r3, NEWLINE     @ if newline char...
        beq     break           @   break
        add     r4, r4, 1       @ else, increment pointer
        add     r5, r5, 1       @ increase length
        mov     r0, STDIN       @ keyboard input
        mov     r1, r4          @ specify where to put the char
        mov     r2, #1          @ read a char
        bl      read
        b       loop            @ continue
break:
        mov     r0, NULL        @ store null terminator in r0
        strb    r0, [r4]        @ replace '\n' with '\0'
        
        mov     r0, r5          @ return the length
        ldr     r4, [sp, 4]     @ restore r4
        ldr     r5, [sp, 8]     @      r5
        ldr     fp, [sp, 12]    @      fp
        ldr     lr, [sp, 16]    @      lr
        add     sp, sp, 16      @ space for saving regs
        bx      lr              @ return
