@ Lucas Street
@ Main function to test writeStr function
@ Nov 16, 2017

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constant program data
        .section .rodata
        .align   2
str:
        .asciz "Testing test\n"

        .text
        .align  2
        .global main
        .type   main, %function

main:
        sub     sp, sp, 8       @ space for fp, lr
        str     fp, [sp, 0]     @ save fp
        str     lr, [sp, 4]     @   and lr
        add     fp, sp, 4       @ set our frame pointer
        
        ldr     r0, strAddress  @ load char * as first argument
        bl      writeStr

        mov     r0, 0           @ return 0;
        ldr     fp, [sp, 0]     @ restore caller fp
        ldr     lr, [sp, 4]     @       lr
        add     sp, sp, 8       @   and sp
        bx      lr              @ return

strAddress:
        .word str

