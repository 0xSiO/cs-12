/**
 * Lucas Street
 * C program to test functions written in assembly (characters).
 * Oct 21, 2017
 */

#include "stdio.h"

char L(void);
char u(void);
char c(void);

int main(void)
{
    printf("My name: %c%c%c", L(), u(), c());
    return 0;
}
