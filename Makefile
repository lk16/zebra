#
#  File:          Makefile
#
#  Author:        Gunnar Andersson (gunnar@radagast.se)
#
#  Created:       July 2, 1997
#
#  Modified:      December 25, 2005
#



# --- Files ---

SRCS = \
        bitbcnt.c \
        bitbmob.c \
        bitboard.c \
        bitbtest.c \
        cntflip.c \
        counter.c \
        display.c \
        doflip.c \
        end.c \
        epcstat.c \
        error.c \
        eval.c \
        game.c \
        getcoeff.c \
        globals.c \
        hash.c \
        learn.c \
        midgame.c \
        moves.c \
        myrandom.c \
        opname.c \
        osfbook.c \
        patterns.c \
        pcstat.c \
        probcut.c \
        safemem.c \
        search.c \
        stable.c \
        thordb.c \
        timer.c \
        unflip.c

HEADERS = \
        autoplay.h \
        bitbcnt.h \
        bitbmob.h \
        bitboard.h \
        bitbtest.h \
        cntflip.h \
        constant.h \
        counter.h \
        display.h \
        doflip.h \
        end.h \
        epcstat.h \
        error.h \
        eval.h \
        game.h \
        getcoeff.h \
        globals.h \
        hash.h \
        learn.h \
        macros.h \
        magic.h \
        midgame.h \
        moves.h \
        myrandom.h \
        opname.h \
        osfbook.h \
        patterns.h \
        pcstat.h \
        porting.h \
        probcut.h \
        psdump.h \
        safemem.h \
        search.h \
        stable.h \
        texts.h \
        thordb.h \
        timer.h \
        unflip.h


BOOKTOOL_SRCS        = $(SRCS) booktool.c

PRACTICE_SRCS        = practice.c
ENDDEV_SRCS        = enddev.c
ALL_SRCS        = $(SRCS) $(PRACTICE_SRCS) $(ENDDEV_SRCS) zebra.c scrzebra.c booktool.c autop.c thorop.c tune8dbs.c

OBJS            = $(SRCS:.c=.o)
BOOKTOOL_OBJS        = $(BOOKTOOL_SRCS:.c=.o)
PRACTICE_OBJS        = $(PRACTICE_SRCS:.c=.o)
ENDDEV_OBJS        = $(ENDDEV_SRCS:.c=.o)

AUTOPLAY_EXE        = autoplay
BOOKTOOL_EXE        = booktool
PRACTICE_EXE        = practice
ENDDEV_EXE        = enddev
ZEBRA_EXE        = zebra
SCRZEBRA_EXE        = scrzebra
TUNE8DBS_EXE        =        tune8dbs



# --- Libraries

LDFLAGS                = -static -lm -lz
#LDFLAGS        = -static -lm -lz -Wl,-Map,map.out



# --- Programs ---

CC              = gcc
CXX                = g++


# --- Flags ---

DEFS =                -DINCLUDE_BOOKTOOL -DTEXT_BASED -DZLIB_STATIC

WARNINGS =        -Wall -Wcast-align -Wwrite-strings -Wstrict-prototypes -Winline
OPTS =                -O4 -s -fomit-frame-pointer -falign-functions=32
#OPTS =                -O4 -s -fomit-frame-pointer -mtune=core2 -falign-functions=32

CFLAGS =        $(OPTS) $(WARNINGS) $(DEFS)
CXXFLAGS =        $(CFLAGS)



# --- Targets ---

all                : libzebra.a zebra scrzebra booktool practice enddev tune8dbs

zebra                : $(OBJS) zebra.o autop.o
        $(CC) -o $(ZEBRA_EXE) $(CFLAGS) $(OBJS) zebra.o autop.o $(LDFLAGS)

scrzebra        : $(OBJS) scrzebra.o autop.o
        $(CC) -o $(SCRZEBRA_EXE) $(CFLAGS) $(OBJS) scrzebra.o autop.o $(LDFLAGS)

libzebra.a:        $(OBJS)
        ar rcv libzebra.a $(OBJS)
        ranlib libzebra.a

clean                :
        $(RM) $(OBJS) booktool.o zebra.o scrzebra.o $(ZEBRA_EXE) a.out core \
        *.stackdump gmon.out $(PRACTICE_OBJS) $(PRACTICE_EXE) \
        libzebra.a *.da autop.o \
        $(BOOKTOOL_OBJS) $(ENDDEV_OBJS) \
        $(AUTOPLAY_EXE) $(BOOKTOOL_EXE) $(ENDDEV_EXE) $(SCRZEBRA_EXE) $(TUNE8DBS_EXE) \


booktool        : $(OBJS) $(BOOKTOOL_OBJS) autop.o
        $(CC) -o $(BOOKTOOL_EXE) $(CFLAGS) $(BOOKTOOL_OBJS) autop.o $(LDFLAGS)

practice        : $(PRACTICE_OBJS) $(OBJS) autop.o
        $(CC) -o $(PRACTICE_EXE) $(CFLAGS) $(PRACTICE_OBJS) $(OBJS) autop.o $(LDFLAGS)

enddev        : $(ENDDEV_OBJS) $(OBJS) autop.o
        $(CC) -o $(ENDDEV_EXE) $(CFLAGS) $(ENDDEV_OBJS) $(OBJS) autop.o $(LDFLAGS)

zsrc:
        tar cf zebra.tar $(ALL_SRCS) $(HEADERS) Makefile \
        openings.txt COPYING README
        gzip --best -f zebra.tar

bookinst:
        $(CC) -o bookinst $(CFLAGS) bookinst.c myrandom.o

tune8dbs:
        $(CC) -o $(TUNE8DBS_EXE) $(CFLAGS) tune8dbs.c $(LDFLAGS)

genbb:        genbb.o
        $(CC) -o genbb genbb.o

genmmx:        genmmx.o
        $(CXX) -o genmmx genmmx.o

depend:
        makedepend -Y $(ALL_SRCS)

# .s file dependencies.

bitbcnt.s        : bitbcnt.c bitboard.h
        $(CC) $(CFLAGS) -S bitbcnt.c
bitbmob.s        : bitboard.h bitbmob.c end.h
        $(CC) $(CFLAGS) -S bitbmob.c
bitbtest.s        : bitboard.h bitbtest.c
        $(CC) $(CFLAGS) -S bitbtest.c
bitbvald.s        : bitboard.h bitbvald.c
        $(CC) $(CFLAGS) -S bitbvald.c
doflip.s        : doflip.c error.h globals.h hash.h macros.h moves.h patterns.h texts.h unflip.h
        $(CC) $(CFLAGS) -S doflip.c
end.s                : autoplay.h bitbcnt.h bitbmob.h bitboard.h bitbtest.h cntflip.h constant.h counter.h display.h doflip.h end.c end.h epcstat.h eval.h getcoeff.h globals.h hash.h macros.h midgame.h moves.h osfbook.h probcut.h search.h stable.h texts.h timer.h unflip.h
        $(CC) $(CFLAGS) -S end.c
getcoeff.s        :  constant.h error.h eval.h getcoeff.c macros.h magic.h moves.h patterns.h safemem.h search.h texts.h
        $(CC) $(CFLAGS) -S getcoeff.c
moves.s                : cntflip.h constant.h doflip.h globals.h hash.h macros.h moves.c moves.h patterns.h search.h texts.h unflip.h
        $(CC) $(CFLAGS) -S moves.c

# The dependendices below were generated by "make depend".
# DO NOT DELETE

bitbcnt.o: macros.h
bitbmob.o: bitbmob.h bitboard.h macros.h end.h search.h constant.h counter.h
bitbmob.o: globals.h
bitboard.o: bitboard.h macros.h constant.h
bitbtest.o: macros.h bitboard.h
cntflip.o: cntflip.h constant.h error.h macros.h moves.h texts.h
counter.o: counter.h macros.h
display.o: porting.h constant.h display.h search.h counter.h macros.h
display.o: globals.h eval.h safemem.h texts.h timer.h
doflip.o: doflip.h macros.h error.h globals.h constant.h hash.h moves.h
doflip.o: patterns.h texts.h unflip.h
end.o: porting.h autoplay.h bitbcnt.h bitboard.h macros.h bitbmob.h end.h
end.o: search.h constant.h counter.h globals.h bitbtest.h cntflip.h display.h
end.o: doflip.h epcstat.h eval.h getcoeff.h hash.h midgame.h moves.h
end.o: osfbook.h probcut.h pcstat.h stable.h texts.h timer.h unflip.h
epcstat.o: epcstat.h
error.o: porting.h error.h texts.h
eval.o: counter.h macros.h eval.h search.h constant.h globals.h moves.h
game.o: porting.h bitboard.h macros.h constant.h display.h search.h counter.h
game.o: globals.h end.h error.h eval.h game.h getcoeff.h hash.h midgame.h
game.o: moves.h myrandom.h osfbook.h patterns.h probcut.h epcstat.h pcstat.h
game.o: stable.h texts.h thordb.h timer.h unflip.h
getcoeff.o: porting.h constant.h error.h eval.h search.h counter.h macros.h
getcoeff.o: globals.h getcoeff.h magic.h moves.h patterns.h safemem.h texts.h
globals.o: globals.h constant.h
hash.o: error.h hash.h constant.h macros.h myrandom.h safemem.h search.h
hash.o: counter.h globals.h
learn.o: porting.h constant.h end.h search.h counter.h macros.h globals.h
learn.o: game.h hash.h learn.h moves.h osfbook.h patterns.h timer.h
midgame.o: autoplay.h constant.h display.h search.h counter.h macros.h
midgame.o: globals.h eval.h getcoeff.h hash.h midgame.h moves.h myrandom.h
midgame.o: patterns.h pcstat.h probcut.h epcstat.h texts.h timer.h
moves.o: cntflip.h constant.h doflip.h macros.h globals.h hash.h moves.h
moves.o: patterns.h search.h counter.h texts.h unflip.h
myrandom.o: myrandom.h
opname.o: opname.h
osfbook.o: porting.h autoplay.h constant.h counter.h macros.h display.h
osfbook.o: search.h globals.h end.h error.h eval.h game.h getcoeff.h hash.h
osfbook.o: magic.h midgame.h moves.h myrandom.h opname.h osfbook.h patterns.h
osfbook.o: safemem.h texts.h timer.h
patterns.o: constant.h display.h search.h counter.h macros.h globals.h
patterns.o: patterns.h
pcstat.o: porting.h pcstat.h
probcut.o: porting.h constant.h epcstat.h pcstat.h probcut.h
safemem.o: error.h macros.h safemem.h texts.h
search.o: constant.h counter.h macros.h error.h hash.h globals.h moves.h
search.o: search.h texts.h
stable.o: porting.h bitboard.h macros.h bitbtest.h constant.h end.h search.h
stable.o: counter.h globals.h patterns.h
thordb.o: porting.h bitboard.h macros.h constant.h error.h moves.h myrandom.h
thordb.o: patterns.h safemem.h texts.h thordb.h thorop.c
timer.o: porting.h constant.h macros.h timer.h
unflip.o: macros.h unflip.h
practice.o: constant.h display.h search.h counter.h macros.h globals.h game.h
practice.o: moves.h osfbook.h patterns.h
enddev.o: constant.h display.h search.h counter.h macros.h globals.h game.h
enddev.o: hash.h learn.h moves.h myrandom.h osfbook.h patterns.h timer.h
zebra.o: constant.h counter.h macros.h display.h search.h globals.h doflip.h
zebra.o: end.h error.h eval.h game.h getcoeff.h hash.h learn.h midgame.h
zebra.o: moves.h myrandom.h osfbook.h patterns.h thordb.h timer.h
scrzebra.o: zebra.c constant.h counter.h macros.h display.h search.h
scrzebra.o: globals.h doflip.h end.h error.h eval.h game.h getcoeff.h hash.h
scrzebra.o: learn.h midgame.h moves.h myrandom.h osfbook.h patterns.h
scrzebra.o: thordb.h timer.h
booktool.o: constant.h hash.h macros.h osfbook.h search.h counter.h globals.h
autop.o: autoplay.h
