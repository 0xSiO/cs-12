@ Lucas Street
@ Alternate version of inputFrac to allow entering hex numbers
@ Dec 05, 2017

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constants
        .equ    maxChars,9      @ max input chars
        .equ    input1,-24      @ first input
        .equ    input2,-36      @ second input
        .equ    locals,24       @ space for local vars

        .section .rodata
        .align  2
numInput:
        .asciz        "Numerator (hex): "
denInput:
        .asciz "Denominator (hex): "

        .text
        .align  2
        .global inputFrac
        .type   inputFrac, %function

inputFrac:
        sub     sp, sp, 16      @ space for saving regs
        str     r4, [sp, 0]     @ save r4
        str     r5, [sp, 4]     @      r5
        str     fp, [sp, 8]     @      fp
        str     lr, [sp, 12]    @      lr
        add     fp, sp, 12      @ set our frame pointer
        sub     sp, sp, locals  @ for local vars
        
        mov     r4, r0          @ save address to frac struct

        ldr     r0, numInputAddr @ prompt user for numerator
        bl      writeStr
        
        add     r0, fp, input1  @ first input char * as arg 1
        mov     r1, maxChars    @ restrict input size as arg 2
        bl      readLn

        add     r0, fp, input1  @ first input char * as arg 1
        bl      hexToInt        @ convert hex string to integer
        mov     r5, r0          @ save result
        str     r5, [r4, 0]     @ store in first word of frac

        ldr     r0, denInputAddr @ prompt for denominator
        bl      writeStr

        add     r0, fp, input2  @ second input char * as arg 1
        mov     r1, maxChars    @ restrict input size as arg 2
        bl      readLn

        add     r0, fp, input2  @ second input char * as arg 1
        bl      hexToInt        @ convert hex string to integer
        mov     r5, r0          @ save result
        str     r5, [r4, 4]     @ store in second word of frac
        
        mov     r0, 0           @ return 0;
        add     sp, sp, locals  @ deallocate local vars
        ldr     r4, [sp, 0]     @ restore r4
        ldr     r5, [sp, 4]     @         r5
        ldr     fp, [sp, 8]     @         fp
        ldr     lr, [sp, 12]    @         lr
        add     sp, sp, 16      @ restore sp
        bx      lr              @ return

numInputAddr:
        .word    numInput
denInputAddr:
        .word    denInput
