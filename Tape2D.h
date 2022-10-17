#ifndef TAPE_2D_H
#define TAPE_2D_H

#include "List2D.h"

struct Tape2D {
	struct List2D quad0;
	struct List2D quad1;
	struct List2D quad2;
	struct List2D quad3;

	int row, col;
	int* head;
};

struct Tape2D T2D_init();
int T2D_free(struct Tape2D* tape);

int T2D_move(struct Tape2D* tape, int row, int col);

int T2D_printgrid(struct Tape2D* tape, int startrow, int startcol, int endrow, int endcol);

#endif