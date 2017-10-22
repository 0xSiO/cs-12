@ Lucas Street
@ Returns 255.
@ Oct 21, 2017

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Program code
        .text
        .align  2
        .global two_fifty_five
        .type   two_fifty_five, %function
two_fifty_five:
        str     fp, [sp, -4]!   @ save caller frame pointer
        add     fp, sp, 0       @ establish our frame pointer

        mov     r3, 255         @ return 255;
        mov     r0, r3          @ return values go in r0

        sub     sp, fp, 0       @ restore stack pointer
        ldr     fp, [sp], 4     @ restore caller's frame pointer
        bx      lr              @ back to caller
