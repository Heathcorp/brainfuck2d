#include "Tape2D.h"
#include "List2D.h"

#include <stdlib.h>
#include <stdio.h>

struct Tape2D T2D_init() {
	struct Tape2D tape;
	tape.row = 0;
	tape.col = 0;
	tape.quad0 = L2D_init();
	tape.quad1 = L2D_init();
	tape.quad2 = L2D_init();
	tape.quad3 = L2D_init();
	tape.head = L2D_access(&tape.quad0, 0, 0);
	return tape;
}

int T2D_free(struct Tape2D* tape) {
	L2D_free(&tape->quad0);
	L2D_free(&tape->quad1);
	L2D_free(&tape->quad2);
	L2D_free(&tape->quad3);
}


int T2D_move(struct Tape2D* tape, int row, int col) {
	if(row >= 0 && col >= 0) {
		// quadrant 0
		tape->head = L2D_access(&tape->quad0, row, col);
	} else if(row >= 0 && col < 0) {
		// quadrant 1
		tape->head = L2D_access(&tape->quad1, row, -col - 1);
	} else if(row < 0 && col < 0) {
		// quadrant 2
		tape->head = L2D_access(&tape->quad2, -row - 1, -col - 1);
	} else if(row < 0 && col >= 0) {
		// quadrant 3
		tape->head = L2D_access(&tape->quad3, -row - 1, col);
	}

	tape->row = row;
	tape->col = col;

	if(tape->head == NULL) return -1;

	return 0;
}

int T2D_printgrid(struct Tape2D* tape, int startrow, int startcol, int endrow, int endcol) {
	int oldrow = tape->row;
	int oldcol = tape->col;

	puts("DEBUG START");
	for(int row = startrow; row <= endrow; row++) {
		for(int col = startcol; col <= endcol; col++) {
			T2D_move(tape, row, col);

			printf("%02X%c", *tape->head, (row == oldrow && col == oldcol - 1) ? '(' : ((row == oldrow && col == oldcol) ? ')' : ' '));
		}
		puts("");
	}
	puts("DEBUG END");

	// reset the tape position
	T2D_move(tape, oldrow, oldcol);
}
