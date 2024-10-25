CC = gcc
MPICC = mpicc
NVCC = nvcc
CFLAGS = -O3 -std=gnu11 -Wall
OMPFLAGS = -fopenmp
NVCCFLAGS = -O3
SFMTDIR = ../misc/SFMT-src-1.5.1
SFMTFLAGS = -I$(SFMTDIR) -D SFMT_MEXP=19937
MISC_OBJS = SFMT.o timer.o

all: random random_omp

random: random.o $(MISC_OBJS)
	$(CC) $(CFLAGS) $(SFMTFLAGS) -o $@ $^ -lm

random_omp: random_omp.o $(MISC_OBJS)
	$(CC) $(CFLAGS) $(OMPFLAGS) $(SFMTFLAGS) -o $@ $^ -lm

random.o: random.c
	$(CC) $(CFLAGS) $(SFMTFLAGS) -c $<

random_omp.o: random_omp.c
	$(CC) $(CFLAGS) $(OMPFLAGS) $(SFMTFLAGS) -c $<

SFMT.o: $(SFMTDIR)/SFMT.c $(SFMTDIR)/SFMT.h
	$(CC) $(CFLAGS) $(SFMTFLAGS) -c $<

timer.o: ../misc/timer.c
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f random random_omp  *.o

distclean: clean
	rm -f *.dat
