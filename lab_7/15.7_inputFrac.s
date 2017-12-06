@ Lucas Street
@ Sets the value of a fraction from user input.
@ Dec 05, 2017

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Strings
        .section .rodata
        .align  2

numInput:
        .asciz "Numerator: "
denInput:
        .asciz "Denominator: "

        .text
        .align  2
        .global inputFrac
        .type   inputFrac, %function

inputFrac:
        sub     sp, sp, 16      @ space for saving regs
        str     r4, [sp, 4]     @ save r4
        str     fp, [sp, 8]     @      fp
        str     lr, [sp, 12]    @      lr
        add     fp, sp, 12      @ set our frame pointer
        
        mov     r4, r0          @ save address to frac struct
        
        ldr     r0, numInputAddr @ numerator prompt as arg 1
        bl      writeStr        @ write prompt

        bl      inputInt        @ acquire an integer
        str     r0, [r4, 0]     @ store in the first word of frac
                
        ldr     r0, denInputAddr @ denominator prompt as arg 1
        bl      writeStr        @ write prompt
        
        bl      inputInt        @ acquire an integer
        str     r0, [r4, 4]     @ store in second word of frac

        mov     r0, 0           @ return 0;
        ldr     r4, [sp, 4]     @ restore r4
        ldr     fp, [sp, 8]     @         fp
        ldr     lr, [sp, 12]    @         lr
        add     sp, sp, 16      @         sp
        bx      lr              @ return

        .align  2
numInputAddr:
        .word   numInput
denInputAddr:
        .word   denInput
