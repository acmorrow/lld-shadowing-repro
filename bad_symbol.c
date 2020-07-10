#include <stdio.h>
#include <stdlib.h>

int shadowed(int x) {
    printf("Called shadowed in libbad, aborting");
    abort();
}
