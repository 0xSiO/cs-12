@ Lucas Street
@ Experiment to try printing to the screen.
@ Oct 21, 2017

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

        .global _start
_start:
        mov     r7, 4           @ system call 4 is WRITE
        mov     r0, 1           @ write to stream 1, the monitor
        mov     r2, 12          @ length of string to write
        ldr     r1, =msg        @ load msg onto the screen
        swi     0

end:
        mov     r7, 1           @ go back to terminal
        swi     0

.data
msg:
    .ascii "Hello world\n"
