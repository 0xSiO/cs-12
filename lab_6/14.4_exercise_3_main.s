@ Lucas Street
@ Translation of 14.4_exercise_1_main.c into assembly.
@ Nov 26, 2017

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constants
        .equ    maxChars,9      @ max input chars
        .equ    theString,-16   @ for input string
        .equ    locals,16       @ space for local vars

        .section .rodata
        .align  2
prompt:
        .asciz        "Enter up to 32-bit hex number: "
format:
        .asciz        "The integer is: %i\n"

        .text
        .align  2
        .global main
        .type   main, %function
main:
        sub     sp, sp, 8       @ space for fp, lr
        str     fp, [sp, 0]     @ save fp
        str     lr, [sp, 4]     @   and lr
        add     fp, sp, 4       @ set our frame pointer
        sub     sp, sp, locals  @ for local vars
        
        ldr     r0, promptAddr  @ prompt user for string
        bl      writeStr
        
        add     r0, fp, theString  @ load char * as first arg
        mov     r1, maxChars    @ restrict input size as second arg
        bl      readLn
        
        add     r0, fp, theString  @ load char * as first arg
        bl      hexToInt        @ convert contents of string

        mov     r1, r0          @ store return value
        ldr     r0, formatAddr  @ print result
        bl      printf
        
        mov     r0, 0           @ return 0;
        add     sp, sp, locals  @ deallocate local var
        ldr     fp, [sp, 0]     @ restore caller fp
        ldr     lr, [sp, 4]     @       lr
        add     sp, sp, 8       @   and sp
        bx      lr              @ return

promptAddr:
        .word    prompt
formatAddr:
        .word    format
