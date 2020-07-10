#include "symbol_wrapper.h"

#include "good_symbol.h"

int wrapped_symbol(int value) {
    return shadowed(value);
}
