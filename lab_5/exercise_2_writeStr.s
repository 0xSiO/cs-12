@ Lucas Street
@ writeStr function. Takes a char *, prints chars until \0 and returns the
@ length of the string.
@ Nov 16, 2017

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constants
        .equ    STDOUT,1
        .equ    NULL,0

        .text
        .align  2
        .global writeStr
        .type   writeStr, %function

writeStr:
        sub     sp, sp, 16      @ space for saving regs
        str     r4, [sp, 0]     @ save r4
        str     r5, [sp, 4]     @      r5
        str     fp, [sp, 8]     @      fp
        str     lr, [sp, 12]    @      lr
        add     fp, sp, 12      @ set our frame pointer

        mov     r4, r0          @ r4 = char * as first arg
        mov     r5, 0           @ r5 = length, initally 0
loop:
        ldrb    r3, [r4]        @ get a char from the pointer
        cmp     r3, NULL        @ if we reached the \0...
        beq     done            @ break

        mov     r0, STDOUT
        mov     r1, r4          @ current char
        mov     r2, 1           @ display 1 char
        bl      write

        add     r4, r4, 1       @ increment pointer
        add     r5, r5, 1       @ increase count
        b       loop            @ continue
done:
        mov     r0, r5          @ return the length
        ldr     r4, [sp, 0]     @ restore r4
        ldr     r5, [sp, 4]     @         r5
        ldr     fp, [sp, 8]     @         fp
        ldr     lr, [sp, 12]    @         lr
        add     sp, sp, 16      @ restore sp
        bx      lr              @ return to caller
