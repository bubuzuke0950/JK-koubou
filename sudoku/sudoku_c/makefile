CC = gcc
CFLAGS = -O3 -std=gnu11 -Wall
OMPFLAGS = -fopenmp
SFMTDIR = ../misc/SFMT-src-1.5.1
SFMTFLAGS = -I$(SFMTDIR) -DSFMT_MEXP=19937
MISC_OBJS = SFMT.o timer.o

all: sudoku sudoku_omp

sudoku: sudoku.o $(MISC_OBJS)
	$(CC) $(CFLAGS) $(SFMTFLAGS) -o $@ $^ -lm

sudoku_omp: sudoku_omp.o $(MISC_OBJS)
	$(CC) $(CFLAGS) $(OMPFLAGS) $(SFMTFLAGS) -o $@ $^ -lm

sudoku.o: sudoku.c
	$(CC) $(CFLAGS) $(SFMTFLAGS) -c $<

sudoku_omp.o: sudoku_omp.c
	$(CC) $(CFLAGS) $(OMPFLAGS) $(SFMTFLAGS) -c $<

SFMT.o: $(SFMTDIR)/SFMT.c
	$(CC) $(CFLAGS) $(SFMTFLAGS) -c $<

timer.o: ../misc/timer.c
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f sudoku sudoku_omp *.o

distclean: clean
	rm -f *.dat