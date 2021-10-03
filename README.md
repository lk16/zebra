# Zebra

Very strong othello/reversi bot, [written by](http://radagast.se/othello/) Gunnar Andersson.

This repo contains a few minor tweaks:
- `-evalone` flag: evaluates one move and exits
- `-quiet` flag: outputs evaluation and nothing else

Example of their uses:

```sh
./zebra -quiet -l 18 26 28 18 26 28 -slack 0 -evalone -seq 'e6f4g3d6c4'
```

This command outputs the following on my machine.

```
-->  18  +9.37        1556481  f6 f7 d3 c5 f5     0.6 s  2526993 nps
PV: f6 f7 d3 c5 f5 f3 d7 e7 c6 e3 b4 c3 b3 b5 g4 a5 d8
```

## README (ORIGINAL)
----- LICENSE -----

This piece of software is released under the GPL.
See the file COPYING for more information.

----- COMPILING -----

You need make and a C compiler, e.g. GCC, to compile Zebra.  Run "make all"
to build Zebra and some tools.  I have built Zebra using Cygwin and GCC 3.2.
Using an older or newer version of GCC should work fine.  ICC should also
work, but I have not access to it.  The inline assembly can only be used
if you run GCC, so performance will probably take a big hit if you use a
compiler that is not capable of reading GCC-style inline assembly.

----- RUNNING -----

Copy coeffs2.bin and book.bin from the directory where WZebra is installed
to the directory where Zebra and its tools are found.
"./zebra -help" describes the available options.  If you find the help text
too terse: Use the force, read the source.
