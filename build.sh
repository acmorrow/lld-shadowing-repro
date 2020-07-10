set -eufx

LINKERFLAGS="-fuse-ld=lld -Wl,--trace-symbol=shadowed"
# LINKERFLAGS="-fuse-ld=gold -Wl,--trace-symbol,shadowed"
# LINKERFLAGS="-fuse-ld=bfd -Wl,--trace-symbol=shadowed"

LINKFLAGS="$LINKERFLAGS -Wl,-rpath,."

clang -fPIC -c bad_symbol.c -o bad_symbol.o
ar rcs libbad_symbol.a bad_symbol.o

clang -fPIC -c good_symbol.c -o good_symbol.o
clang -shared -o libgood_symbol.so good_symbol.o -Wl,--version-script=libgood_symbol.version_script libbad_symbol.a $LINKFLAGS

clang -fPIC -c symbol_wrapper.c -o symbol_wrapper.o
clang -shared -o libsymbol_wrapper.so symbol_wrapper.o libgood_symbol.so libbad_symbol.a $LINKFLAGS

clang -fPIC -c symbol_user.c -o symbol_user.o
clang -shared -o libsymbol_user.so symbol_user.o libsymbol_wrapper.so libbad_symbol.a $LINKFLAGS

clang -fPIE -pie main.c -o main libsymbol_user.so libbad_symbol.a $LINKFLAGS

./main || echo "FAILED"
