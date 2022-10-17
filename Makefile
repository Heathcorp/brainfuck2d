CC=gcc
ARGS=-g -O0

CCC=$(CC) $(ARGS)

%.o:%.c
	$(CCC) -c $^ -o $@

brainfuck2d: brainfuck2d.o List2D.c Tape2D.o
	$(CCC) $^ -o $@

clean:
	rm -f *.o