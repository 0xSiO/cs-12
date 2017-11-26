# Lucas Street

CFLAGS = -g -Wall

.PHONY: clean
clean:
	rm -f out/* **/*.o

lab1: lab_1/main.o
	gcc $(CFLAGS) -o out/$@ $+

lab2: lab_2/main.o
	gcc $(CFLAGS) -lwiringPi -o out/$@ $+

lab3: lab_3/main.o lab_3/l.o lab_3/u.o lab_3/c.o
	gcc -o out/$@ $+

lab4: lab_4/main.o
	gcc -o out/$@ $+

lab5: lab_5/exercise_4_main.o lab_5/exercise_5_writeStr.o lab_5/exercise_4_readLn.o
	gcc -o out/$@ $+

lab6: lab_6/14.4_exercise_4_main.o lab_6/14.4_exercise_1_hexToInt.o lab_6/14.4_exercise_4_intToHex.o lab_6/14.2_exercise_1_writeStr.o lab_6/14.4_exercise_1_readLn.o
	gcc -o out/$@ $+
