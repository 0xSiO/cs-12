/**
 * Lucas Street
 * C program to test functions written in assembly (numbers).
 * Oct 21, 2017
 */

#include "stdio.h"

int forty_two(void);
int neg_one(void);
int two_fifty_five(void);

int main(void)
{
    printf("Forty two: %i\n", forty_two());
    printf("Negative one: %i\n", neg_one());
    printf("Two hundred fifty-five: %i\n", two_fifty_five());
    return 0;
}
