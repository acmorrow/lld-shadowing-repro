#include "symbol_user.h"

#include "symbol_wrapper.h"

int use_symbol(int value) {
    return wrapped_symbol(value);
}
