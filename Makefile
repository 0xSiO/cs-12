# Lucas Street

CFLAGS = -g -Wall

%.o: %.c
	gcc $(CFLAGS) -c -o $@ $<

lab1: lab_1/main.o
	gcc $(CFLAGS) -o out/$@ $+

lab2: lab_2/main.o
	gcc $(CFLAGS) -lwiringPi -o out/$@ $+

clean:
	rm -f out/* **/*.o
