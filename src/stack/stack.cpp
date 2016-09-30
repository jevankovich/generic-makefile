#include "stack.h"

void push(stack st, int val) {
	*(*st++) = val;
}

int pop(stack st) {
	return *(*--st);
}
