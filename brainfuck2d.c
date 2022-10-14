#include <stdio.h>
#include <stdlib.h>

#include "Tape2D.h"

#define MAX_LOOPS 1024

int readfile(char** buf, char* filename);
int bf2d(char* program);

int main(int argv, char**argc) {
	if(argv != 2) {
		fprintf(stderr, "incorrect arguments\n");
		return 1;
	}

	char* program;
	if(readfile(&program, argc[1]) == -1) {
		perror("readfile failed");
		return 1;
	}

	// execute the program
	if(bf2d(program) == -1) return 1;

	free(program);
}

int readfile(char** buf, char* filename) {
	// open file
	FILE* file = fopen(filename, "r");
	if(file == NULL) return -1;

	// find file length
	int chk = fseek(file, 0, SEEK_END);
	size_t filesize = ftell(file);
	rewind(file);

	// read whole file
	*buf = malloc(filesize);
	chk += fread(*buf, 1, filesize, file);
	chk += fclose(file);
	if(chk != filesize) return -1;

	return filesize;
}

int bf2d(char* program) {
	struct Tape2D tape = T2D_init();

	int pc = 0;
	int loops[MAX_LOOPS] = {0};
	int loop = -1;
	for(char op; op = program[pc]; pc++) {
		switch (op) {
		case '+':
			(*tape.head)++;
			break;
		case '-':
			(*tape.head)--;
			break;

		case '>':
			T2D_move(&tape, tape.row, tape.col + 1);
			break;
		case '<':
			T2D_move(&tape, tape.row, tape.col - 1);
			break;
		case '/':
			T2D_move(&tape, tape.row - 1, tape.col);
			break;
		case '\\':
			T2D_move(&tape, tape.row + 1, tape.col);
			break;

		case '.':
			putchar(*tape.head);
			break;
		case ',':
			*tape.head = getchar();
			break;

		case '[':
			break;
		case ']':
			break;
		}
	}

	T2D_free(&tape);
}
