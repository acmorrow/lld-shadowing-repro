# lld-shadowing-repro

Minimal repro for https://jira.mongodb.org/browse/SERVER-49375

- On linux systems, run `build.sh` to compile, link, and run. You can
uncomment other values of `LINKERFLAGS` in the script to use `ld.gold`
or `ld.bfd` instead of `ld.lld`.

- On macOS, run `build.macosx.sh` to compile, link, and run.

The expected behavior is that the program runs succesfully, because
the linker script applied to `libsymbol_wrapper.[so|dylib]` will
disambiguate the symbol in such a way that a static definition from
`libbad_symbol.a` will not be incorporated into
`libsymbol_user.[so|dylib]`.

This appears to work correctly with `ld.bfd` and `ld.gold`, but not
with `ld.lld`.

LLVM bug: https://bugs.llvm.org/show_bug.cgi?id=46676
