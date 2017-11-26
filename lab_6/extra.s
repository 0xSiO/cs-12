@ Lucas Street
@ Improved exercise 4: use printf to display result and display the converted
@ integers instead of the hexadecimcal versions
@ Nov 26, 2017

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
prompt:
        .asciz        "Enter up to 32-bit hex number: "
format:
        .asciz        "%i + %i = %i\n"

        .text
        .align  2
        .global main
        .type   main, %function
main:
        sub     sp, sp, 16      @ space for saving regs
        str     r4, [sp, 0]     @ save r4
        str     r5, [sp, 4]     @      r5
        str     fp, [sp, 8]     @      fp
        str     lr, [sp, 12]    @      lr
        add     fp, sp, 12      @ set our frame pointer
        sub     sp, sp, locals  @ for local vars
        
        ldr     r0, promptAddr  @ prompt user
        bl      writeStr
        
        add     r0, fp, input1  @ first input char * as arg 1
        mov     r1, maxChars    @ restrict input size as arg 2
        bl      readLn

        add     r0, fp, input1  @ first input char * as arg 1
        bl      hexToInt        @ convert hex string to integer
        mov     r4, r0          @ save result

        ldr     r0, promptAddr  @ prompt for second input
        bl      writeStr

        add     r0, fp, input2  @ second input char * as arg 1
        mov     r1, maxChars    @ restrict input size as arg 2
        bl      readLn

        add     r0, fp, input2  @ second input char * as arg 1
        bl      hexToInt        @ convert hex string to integer
        mov     r5, r0          @ save result

        ldr     r0, formatAddr  @ display result
        mov     r1, r4          @ first input as arg 1
        mov     r2, r5          @ second input as arg 2
        add     r3, r4, r5      @ sum as arg 3
        bl      printf
        
        mov     r0, 0           @ return 0;
        add     sp, sp, locals  @ deallocate local vars
        ldr     r4, [sp, 0]     @ restore r4
        ldr     r5, [sp, 4]     @      r5
        ldr     fp, [sp, 8]     @         fp
        ldr     lr, [sp, 12]    @         lr
        add     sp, sp, 16      @ restore sp
        bx      lr              @ return

promptAddr:
        .word    prompt
formatAddr:
        .word    format
