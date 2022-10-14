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
		int rows, cols;
		for(rows = list->rows; row < rows; rows *= 2);
		for(cols = list->cols; col < cols; cols *= 2);

		// allocate new data block
		char* newdata = calloc(rows, cols);

		// copy old data into new block
		for(int r = 0; r < list->rows; r++) {
			for(int c = 0; c < list->cols; c++) {
				int index = (r * c) + c;
				newdata[index] = list->data[index];
			}
		}

		free(list->data);
		list->data = newdata;
		list->rows = rows;
		list->cols = cols;	
	}

	return list->data + (row * list->cols) + col;
}
