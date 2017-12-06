@ Lucas Street
@ Grab an integer from the user
@ Dec 05, 2017

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constants
        .equ    locals,8        @ space for local vars

        .section .rodata
        .align  2
input:
        .asciz "%i"

        .text
        .align  2
        .global inputInt
        .type   inputInt, %function

inputInt:
        sub     sp, sp, 8       @ space for fp, lr
        str     fp, [sp, 0]     @ save fp
        str     lr, [sp, 4]     @   and lr
        add     fp, sp, 4       @ set our frame pointer
        sub     sp, sp, locals  @ for local vars
        
        ldr     r0, inputAddr   @ format string
        add     r1, fp, 8       @ address of local var as 2nd arg
        bl      scanf
        
        ldr     r0, [fp, 8]     @ return the integer
        add     sp, sp, locals  @ deallocate local var
        ldr     fp, [sp, 0]     @ restore caller fp
        ldr     lr, [sp, 4]     @       lr
        add     sp, sp, 8       @   and sp
        bx      lr              @ return

inputAddr:
        .word    input
