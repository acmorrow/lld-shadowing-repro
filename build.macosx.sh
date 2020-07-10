set -eufx

LINKFLAGS="-Wl,-rpath,."

clang -c bad_symbol.c -o bad_symbol.o
libtool -static -o libbad_symbol.a -s bad_symbol.o

clang -c good_symbol.c -o good_symbol.o
clang -shared -o libgood_symbol.dylib good_symbol.o -Wl,-exported_symbols_list,libgood_symbol.exported_symbols_list libbad_symbol.a $LINKFLAGS

clang -c symbol_wrapper.c -o symbol_wrapper.o
clang -shared -o libsymbol_wrapper.dylib symbol_wrapper.o libgood_symbol.dylib libbad_symbol.a $LINKFLAGS

clang -c symbol_user.c -o symbol_user.o
clang -shared -o libsymbol_user.dylib symbol_user.o libsymbol_wrapper.dylib libbad_symbol.a $LINKFLAGS

clang main.c -o main libsymbol_user.dylib libbad_symbol.a $LINKFLAGS

./main || echo "FAILED"
