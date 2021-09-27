# Zebra

This repo started after cloning from ... on 2021/09/21

Generate book text dump:

```sh
./booktool -rb book.bin -w dump.txt
```


Zebra
=====

Othello program created by Gunnar Andersson

This repository has started by uploading original code, as of 2014/04/29, by Gunnar Andersson

## Web sites

* Gunner's website: http://radagast.se/othello/
* Original source code: http://radagast.se/othello/zebra.tar.gz


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

