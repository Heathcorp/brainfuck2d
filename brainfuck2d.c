#include <stdio.h>
#include <stdlib.h>

#include "List2D.h"
#include "Tape2D.h"

#define MAX_LOOPS 1024 * 256

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
	int loopcount = 0;
	int skiploop = -1;
	for(char op; op = program[pc]; pc++) {
		int chk = 0;
		int poppedloop;

		if(op == '[') {
			loops[loopcount++] = pc;
			if(skiploop == -1 && *tape.head == 0) {
				skiploop = pc;
			}
		} else if(op == ']') {
			poppedloop = loops[--loopcount];
			if(skiploop == poppedloop) {
				skiploop = -1;
			} else if(skiploop == -1 && *tape.head) {
				pc = poppedloop - 1;
			}
		}

		if (skiploop > -1) continue;
		int ch;
		switch (op) {
		case '+':
			*tape.head = (*tape.head + 1) % 256;
			break;
		case '-':
			*tape.head = (*tape.head + 255) % 256;
			break;

		case '>':
			chk = T2D_move(&tape, tape.row, tape.col + 1);
			break;
		case '<':
			chk = T2D_move(&tape, tape.row, tape.col - 1);
			break;
		case '/':
			chk = T2D_move(&tape, tape.row - 1, tape.col);
			break;
		case '\\':
			chk = T2D_move(&tape, tape.row + 1, tape.col);
			break;

		case '.':
			putchar(*tape.head);
			break;
		case ',':
			ch = getchar();
			if(ch == -1) ch = 0;
			*tape.head = ch;
			break;

		case '[':
			break;
		case ']':
			break;

		case '#':
			// debug
			if(skiploop == -1) T2D_printgrid(&tape, tape.row - 5, tape.col - 10, tape.row + 5, tape.col + 24);
			break;
		case '$':
			// debug
			if(skiploop == -1) printf("DEBUG: %d\n", *tape.head);
			break;
		case '~':
			// debug
			if(skiploop == -1) return -1;
			break;
		default:
			break;
		}

		if(chk) {
			perror("aborted");
			return -1;
		}
	}

	T2D_free(&tape);
}
