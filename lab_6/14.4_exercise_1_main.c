/* 
 * Lucas Street
 * Prompts user for hex number and converts it to an int.
 * Nov 26, 2017
 */

#include <stdio.h> 

int writeStr(char *);
int readLn(char *, int);
int hexToInt(char *);

int main()
{
  int theNumber;
  char theString[9];
  
  writeStr("Enter up to 32-bit hex number: ");
  readLn(theString, 9);
  theNumber = hexToInt(theString);

  printf("The integer is: %i\n", theNumber);

  return 0;
}

/*
 * To get this to compile I used the Makefile recipe:
 * lab6: lab_6/14.4_exercise_1_main.o lab_6/14.4_exercise_1_hexToInt.o lab_6/14.2_exercise_1_writeStr.o lab_6/14.4_exercise_1_readLn.o
 *     gcc -o out/$@ $+
 *
 * Sample output:
 * Enter up to 32-bit hex number:
 * 3ad
 * The integer is: 941
 *
 * Exercise 2: Yes, this program works the same for uppercase and lowercase since
 * both are above the number characters '0'-'9' in the ASCII table
 */
