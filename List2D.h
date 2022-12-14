#ifndef LIST_2D_H
#define LIST_2D_H

struct List2D {
	int* data;

	int rows;
	int cols;
};

struct List2D L2D_init();
void L2D_free(struct List2D* list);

int* L2D_access(struct List2D* list, int row, int col);

#endif