@ Lucas Street
@ Displays the contents of a fraction
@ Dec 05, 2017

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constants
        .section .rodata
        .align 2
format:
        .asciz "%i / %i\n"

        .text
        .align  2
        .global printFrac
        .type   printFrac, %function

printFrac:
        sub     sp, sp, 16      @ space for saving regs
                                @ (keeping 8-byte sp align)
        str     r4, [sp, 4]     @ save r4
        str     fp, [sp, 8]     @      fp
        str     lr, [sp, 12]    @      lr
        add     fp, sp, 12      @ set our frame pointer
        
        mov     r4, r0          @ save address of frac
        
        ldr     r0, formatAddr  @ address of format string as arg 1
        ldr     r1, [r4, 0]     @ numerator as arg 2 (1st word)
        ldr     r2, [r4, 4]     @ denominator as arg 3 (2nd word)
        bl      printf          @ display formatted string

        mov     r0, 0           @ return 0;
        ldr     r4, [sp, 4]     @ restore r4
        ldr     fp, [sp, 8]     @         fp
        ldr     lr, [sp, 12]    @         lr
        add     sp, sp, 16      @         sp
        bx      lr              @ return

formatAddr:
        .word format
