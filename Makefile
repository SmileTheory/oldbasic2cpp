CC=gcc

default: oldbasic2cpp.exe oldbasic_space.exe

oldbasic2cpp.c: oldbasic2cpp.lex
	flex -o $@ $<

oldbasic_space.c: oldbasic_space.lex
	flex -o $@ $<

oldbasic_space.exe: oldbasic_space.c
	$(CC) $< -o $@

oldbasic2cpp.exe: oldbasic2cpp.c
	$(CC) $< -o $@
