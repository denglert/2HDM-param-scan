OBJ_ParameterScan_Hybrid_MultiDim = ../lib/ParameterScan_Hybrid_MultiDim.cpp.o

CMN =

binaries : ../bin/ParameterScan_Hybrid_MultiDim

#######

#LINKER = ifort
LINKER = g++

../bin/ParameterScan_Hybrid_MultiDim: $(OBJ_ParameterScan_Hybrid_MultiDim)
ifeq ($(LINKER),ifort)
	$(FC) -o $@ $^ $(FLFLAGS) 
endif
ifeq ($(LINKER),g++)
	$(CC) $^ $(CLFLAGS) -o $@
endif

####################
## -- Linking -- ###
####################

# Important: You need to set the apropriate paths for the libs
LIBDIRLINK = $(HOME)/lib/links/libs
INCDIRLINK = $(HOME)/lib/links/inc

####################
## -- Fortran -- ###
####################

#FC    = gfortran
FC     = ifort

FCFLAGS = -c

#FLFLAGS = -cxxlib -nofor_main -\#
FLFLAGS = -cxxlib -nofor_main

../lib/%.f.o : %.f
	$(FC) $(FCFLAGS) $< -o $@ 

#################
### -- C++ -- ###
#################

CC     = g++
#CC     = icc

CCFLAGS = -I../inc/ -I$(INCDIRLINK) $(2HDMCCFLAGS) -MMD -MF .depend_cpp
CLFLAGS = $(2HDMCLFLAGS) $(HB_HS_LFLAGS)

# 2HDMC
2HDMCCFLAGS = -I/local/software/gsl/1.15/include -DHiggsBounds
2HDMCLFLAGS = -L$(LIBDIRLINK) -l2HDMC -L/local/software/gsl/1.15/lib -lgsl -lgslcblas -lgfortran

# HiggsBounds/HiggsSignals
HB_HS_LFLAGS = -L$(LIBDIRLINK) -lHB -lHS

### General compilation rule for .cpp sources
../lib/%.cpp.o : %.cpp
	$(CC) $(CCFLAGS) -c $< -o $@

include .depend_cpp
