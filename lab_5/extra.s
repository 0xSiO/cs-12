@ Lucas Street
@ Read two integers from STDIN and multiply them, printing and returning 
@ the result (0 to 255)
@ Nov 16, 2017

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

        .section .rodata
        .align 2
format:
        .asciz "%i" @ an integer
output:
        .asciz "Product: %d\n"

@ Program code
        .text
        .align  2
        .global main
        .type   main, %function
main:
        stmfd   sp!, {r4, r5, r6, fp, lr}
        add     fp, sp, 16      @ establish our frame pointer
        sub     sp, sp, 20      @ space for local vars

        ldr     r0, formatAddr  @ load format string
        mov     r1, sp          @ store input at top of stack
        bl      scanf
        ldr     r4, [sp, 0]     @ save result

        ldr     r0, formatAddr  @ load format string
        mov     r1, sp          @ store input at top of stack
        bl      scanf
        ldr     r5, [sp, 0]     @ save result

        mul     r6, r4, r5      @ save the product

        ldr     r0, outputAddr  @ print output string
        mov     r1, r6          @ load product as second argument
        bl      printf

        mov     r0, r6          @ return the product

        add     sp, sp, 20      @ deallocate local vars
        ldmfd   sp!, {r4, r5, r6, fp, pc}

formatAddr:
        .word format
outputAddr:
        .word output
