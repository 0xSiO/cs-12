@ Lucas Street
@ Create an empty fraction, default value 0.
@ Dec 05, 2017

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constants
        .equ numerator,0
        .equ denominator,1

        .text
        .align  2
        .global createFrac
        .type   createFrac, %function

createFrac:
        sub     sp, sp, 8       @ space for fp, lr
        str     fp, [sp, 0]     @ save fp
        str     lr, [sp, 4]     @   and lr
        add     fp, sp, 4       @ set our frame pointer

        mov     r1, numerator   @ reasonable numerator
        str     r1, [r0, 0]     @ first word

        mov     r1, denominator @ reasonable denominator
        str     r1, [r0, 4]     @ next word

        mov     r0, 0           @ return 0;
        ldr     fp, [sp, 0]     @ restore caller fp
        ldr     lr, [sp, 4]     @       lr
        add     sp, sp, 8       @   and sp
        bx      lr              @ return
