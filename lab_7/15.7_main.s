@ Lucas Street
@ Adds 1 to a user-inputted fraction and prints the result.
@ Dec 05, 2017

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constants
        .equ    frac,-12        @ location of fraction struct
        .equ    locals,8        @ space for locals

        .text
        .align  2
        .global main
        .type   main, %function

main:
        sub     sp, sp, 8       @ space for fp, lr
        str     fp, [sp, 0]     @ save fp
        str     lr, [sp, 4]     @   and lr
        add     fp, sp, 4       @ set our frame pointer
        sub     sp, sp, locals  @ for the structs

        add     r0, fp, frac    @ address of frac as first arg
        bl      createFrac      @ create empty fraction

        add     r0, fp, frac    @ address of frac as first arg
        bl      inputFrac       @ set frac to user input

        add     r0, fp, frac    @ address of frac as first arg
        mov     r1, 1           @ integer 1 as second arg
        bl      addIntToFrac    @ add integer to frac

        add     r0, fp, frac    @ address of frac as first arg
        bl      printFrac       @ print frac

        mov     r0, 0           @ return 0;
        add     sp, sp, locals  @ deallocate local vars
        ldr     fp, [sp, 0]     @ restore caller fp
        ldr     lr, [sp, 4]     @       lr
        add     sp, sp, 8       @   and sp
        bx      lr              @ return
