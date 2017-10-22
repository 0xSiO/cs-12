# Lucas Street

CFLAGS = -g -Wall

.PHONY: clean
clean:
	rm -f out/* **/*.o

lab1: lab_1/main.o
	gcc $(CFLAGS) -o out/$@ $+

lab2: lab_2/main.o
	gcc $(CFLAGS) -lwiringPi -o out/$@ $+

lab3: lab_3/main.o lab_3/forty_two.o lab_3/negative_one.o lab_3/two_fifty_five.o
	gcc -o out/$@ $+
