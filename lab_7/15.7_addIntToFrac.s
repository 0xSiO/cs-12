@ Lucas Street
@ Add an integer to a fraction
@ Dec 05, 2017

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

        .text
        .align  2
        .global addIntToFrac
        .type   addIntToFrac, %function

addIntToFrac:
        sub     sp, sp, 16      @ space for saving regs
                                @ (keeping 8-byte sp align)
        str     r4, [sp, 4]     @ save r4
        str     fp, [sp, 8]     @      fp
        str     lr, [sp, 12]    @      lr
        add     fp, sp, 12      @ set our frame pointer
        
        mov     r4, r0          @ save address of frac
        
        ldr     r0, [r4, 4]     @ get denominator (2nd word)
        mul     r2, r1, r0      @ integer times denominator
        ldr     r0, [r4, 0]     @ get numerator (1st word)
        add     r2, r2, r0      @ numerator + (integer X denonimator)
        str     r2, [r4, 0]     @ save numerator (1st word)
        
        mov     r0, 0           @ return 0;
        ldr     r4, [sp, 4]     @ restore r4
        ldr     fp, [sp, 8]     @         fp
        ldr     lr, [sp, 12]    @         lr
        add     sp, sp, 16      @         sp
        bx      lr              @ return
