PRGM		=spic1d
FC		=ifort
CC		=icc
FFLAGS		=-O2
CFLAGS 		=
CPPFLAGS	=
LDFLAGS 	=  
NETCDFDIR	=
INCS		=
LIBS		=
FCOMPILE 	= $(FC) $(FFLAGS)
CCOMPILE 	= $(CC) $(CPPFLAGS) $(CFLAGS)
LINKCC 		= $(FC) $(LDFLAGS)

SRCS := $(wildcard *.f90)
MOD := $(shell (find . -name '*.f90' -exec basename {} \; |xargs grep -i "module"  -lI))
SRCS_nomod := $(SRCS:%$(MOD)=%)
SRCS_final =$(MOD) $(SRCS_nomod)
OBJS := $(patsubst %.f90,%.o,$(SRCS_final))

#create the ./data/ directory
temp := $(shell (mkdir data -p))

all : $(PRGM)

$(PRGM):$(OBJS)
	$(LINKCC) $(OBJS) $(LIBS)  -o $(PRGM)

%.o:%.cpp
	$(CCOMPILE) -c $(INCS) $< -o $@

%.o: %.f90
	$(FCOMPILE) -c $(INCS) $< -o $@

clean:
	rm -f $(OBJS) $(PRGM) 
clean-data:
	(cd data; rm -f *.txt *.dat *.nc errfile outfile)
