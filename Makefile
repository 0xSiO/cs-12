# Lucas Street

CFLAGS = -g -Wall

%.o: %.c
	gcc $(CFLAGS) -c -o $@ $<

lab1: lab_1/main.o
	gcc $(CFLAGS) -o out/$@ $+

clean:
	rm -f out/* **/*.o
