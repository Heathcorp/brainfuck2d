#include "List2D.h"

#include <stdlib.h>

struct List2D L2D_init() {
	struct List2D list;
	list.rows = 0;
	list.cols = 0;
	list.data = NULL;
	return list;
}

void L2D_free(struct List2D* list) {
	free(list->data);
}


char* L2D_access(struct List2D* list, int row, int col) {
	if(row >= list->rows || col >= list->cols) {
		// needs resizing, determine the new size to allocate
		int newrows, newcols;
		for(newrows = list->rows ? list->rows : 1; !(row < newrows); newrows *= 2);
		for(newcols = list->cols ? list->cols : 1; !(col < newcols); newcols *= 2);

		// allocate new data block
		char* newdata = calloc(newrows * newcols, 1);

		// copy old data into new block
		for(int r = 0; r < list->rows; r++) {
			for(int c = 0; c < list->cols; c++) {
				newdata[(r * newcols) + c] = list->data[(r * list->cols) + c];
			}
		}

		free(list->data);
		list->data = newdata;
		list->rows = newrows;
		list->cols = newcols;	
	}

	return &(list->data[(row * list->cols) + col]);
}
