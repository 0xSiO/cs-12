@ Lucas Street
@ Returns 'u' to caller.
@ Oct 21, 2017

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Program code
        .text
        .align  2
        .global u
        .type   u, %function
u:
        str     fp, [sp, -4]!   @ save caller frame pointer
        add     fp, sp, 0       @ establish our frame pointer

        mov     r0, 'u          @ return 'u'

        sub     sp, fp, 0	      @ restore stack pointer
        ldr     fp, [sp], 4     @ restore caller's frame pointer
        bx      lr              @ back to caller
