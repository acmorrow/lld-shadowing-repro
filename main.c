#include <stdio.h>
#include <stdlib.h>

#include "symbol_user.h"

int main(int argc, char* argv[]) {
    int result = use_symbol(argc);
    printf("use_symbol returned %d\n", result);
    return EXIT_SUCCESS;
}
