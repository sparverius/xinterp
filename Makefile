######
#
# For building xinterp
#
######

CC=gcc
SED=sed
RMF=rm -f

######

MAKE=make

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######
#
CFLAGS=
#
# CFLAGS=-g
# CFLAGS=-g -O
# CFLAGS=-g -O2
#
GCFLAG=
GCFLAG=-DATS_MEMALLOC_LIBC
GCFLAG=-DATS_MEMALLOC_GCBDW
#
LIBGC=
LIBGC=-lgc
#
######

SRCSATS := \
intrep0.sats \
interp0.sats \
intrep0_jsonize.sats \
interp0_jsonize.sats \


SRCDATS := \
intrep0.dats \
intrep0_print.dats \
intrep0_dynexp.dats \
interp0.dats \
interp0_print.dats \
interp0_envmap.dats \
interp0_dynexp.dats \
intrep0_jsonize.dats \
interp0_jsonize.dats \


######

OBJSATS := \
$(patsubst %.sats, BUILD/%_sats.o, $(SRCSATS))
OBJDATS := \
$(patsubst %.dats, BUILD/%_dats.o, $(SRCDATS))

######

XATSHOMEQ=./../xanadu/
XATSQ=./../xanadu/srcgen/xats
XJSONQ=./../xjsonize


INCLUDE:=
INCLUDE+=-I"."
INCLUDE+=-I$(XATSQ)
LIBRARY:=-L"$(XATSHOMEQ)/lib" -lxatsopt
LIBRARY+=-L"$(XJSONQ)/lib" -lxjsonize

######
#
all:: \
xinterp
xinterp: \
DATS/xinterp.dats \
$(OBJSATS) $(OBJDATS) ; \
$(PATSCC) -cleanaft -o ./bin/xinterp \
$(INCLUDE) $(CFLAGS) $(GCFLAG) $^ $(LIBGC) $(LIBRARY)
#
######

libxatsopt: ; \
(cd ./../xanadu/srcgen/xats && $(MAKE) libxatsopt)

######

BUILD/%_sats.c: \
./SATS/%.sats ; $(PATSOPT) -o $@ --static $<
BUILD/%_dats.c: \
./DATS/%.dats ; $(PATSOPT) -o $@ --dynamic $<

######

BUILD/%_sats.o: \
BUILD/%_sats.c; \
$(PATSCC) $(INCLUDE) $(CFLAGS) -o $@ -c $<
BUILD/%_dats.o: \
BUILD/%_dats.c; \
$(PATSCC) $(INCLUDE) $(CFLAGS) $(GCFLAG) -o $@ -c $<

######
#
# HX-2018-10-07:
# '--output-a .depend' means
# appending instead of overwriting
#
SATS_SRCSATS := \
$(patsubst %.sats, SATS/%.sats, $(SRCSATS))
DATS_SRCDATS := \
$(patsubst %.dats, DATS/%.dats, $(SRCDATS))
#
depend:: ; $(RMF) .depend
#
depend:: ; \
$(PATSOPT) --output-a .depend --depgen -s $(SATS_SRCSATS)
depend:: ; \
$(PATSOPT) --output-a .depend --depgen -d $(DATS_SRCDATS)
depend:: ; \
$(PATSOPT) --output-a .depend --depgen -d DATS/xinterp.dats
#
depend:: ; \
$(SED) -i -e 's/^SATS/BUILD/' -e 's/^DATS/BUILD/' .depend
#
-include .depend
#
######

test:: cbref
cbref: ; ./bin/xinterp -d TEST/cbref.dats
#
test:: foldl
foldl: ; ./bin/xinterp -d TEST/foldl.dats
#
test:: gfact
gfact: ; ./bin/xinterp -d TEST/gfact.dats
#
test:: kfact
kfact: ; ./bin/xinterp -d TEST/kfact.dats
test:: kfibo
kfibo: ; ./bin/xinterp -d TEST/kfibo.dats
test:: kisevn
kisevn: ; ./bin/xinterp -d TEST/kisevn.dats
#
test:: pswap
pswap: ; ./bin/xinterp -d TEST/pswap.dats
#
test:: sieve
sieve: ; ./bin/xinterp -d TEST/sieve.dats
test:: sieve_vt
sieve_vt: ; ./bin/xinterp -d TEST/sieve_vt.dats

######

clean:: ; $(RMF) BUILD/*_?ats.c
clean:: ; $(RMF) BUILD/*_?ats.o
clean:: ; $(RMF) xinterp_dats.o
clean:: ; $(RMF) xinterp_dats.c

cleanall:: clean
cleanall:: ; $(RMF) ./bin/xinterp
# cleanall:: ; $(RMF) $(XATSHOMEQ)/lib/libxatsopt.a
# cleanall:: ; $(MAKE) -C $(XATSQ) cleanall

######

###### end of [Makefile] ######
