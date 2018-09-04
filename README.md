# oldbasic2cpp
Tool to assist porting 80s BASIC programs to C++.

# What's this?
A lex script that does the simple but time-consuming parts parts of converting an old 80s BASIC program to roughly equivalent and somewhat readable C++ code.

This is NOT meant to be an automatic process. The resultant C++ file will need substantial editing to get working.

On the nice side, the C++ code can easily and clearly be compared to the original BASIC code, providing a change history.

If you want something that just works, try [QB64](https://www.qb64.org/).

If you want a more mature project that works on a dialect of BASIC newer than you'd find on 8-bit computers, try [BaCon](http://www.basic-converter.org/).

# What it does
- convert some simple BASIC commands to direct C++ equivalents (IF -> if, FOR -> for, GOTO -> goto, etc)
- convert PRINT/INPUT commands to roughly equivalent cout/cin calls
- convert some simple BASIC string handling to std::string equivalents (LEFT$, RIGHT$, MID$, STR$, etc)

# What it doesn't
- convert many BASIC commands, such as:
  - DEF FN
- parse a bunch of BASIC commands, such as:
  - ASC, ATN, CHR$, COS, DATA, ELSE, EXP, GET, LIST, LOAD, LOG, NEW, NOT, PEEK, POKE, POS, READ, RESTORE, RUN, SAVE, SIN, SGN, SPC, TAN, TIME, VAL
- separate out GOSUB routines
- make clean, structured code at all
- handle integer variables
- handle arrays and regular variables with the same name
- put variable declarations in the right place

# How do I use it?
`oldbasic2cpp <input_file.bas >output_file.cpp`

# Wait, what's oldbasic_space for?
oldbasic_space is for inserting whitespace around commands, a necessary step before using a program with oldbasic2cpp.  It's used similarly:
`oldbasic_space <unspaced.bas >spaced.bas`

It also has some use for converting old programs which have little to no whitespace to work with QBasic/QB64, but YMMV.
