#include <cstdio>
#include "stack/stack.h"

int main() {
	int *st = new int[10];
	push(&st, 8);
	push(&st, 9);
	printf("%d, %d\n", pop(&st), pop(&st));
}
