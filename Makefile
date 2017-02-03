#-----------BEGIN MAKEFILE-------------------------------------------------
         SHELL         = /bin/sh
         DEF_FLAGS     = -P -C -traditional 
         EXEC          = nhwave
#==========================================================================
#--------------------------------------------------------------------------
#        PRECISION          DEFAULT PRECISION: SINGLE                     
#                           UNCOMMENT TO SELECT DOUBLE PRECISION
#--------------------------------------------------------------------------
#--------------------------------------------------------------------------
         FLAG_1 = -DDOUBLE_PRECISION
         FLAG_2 = -DPARALLEL
#         FLAG_3 = -DLANDSLIDE
#          FLAG_4 = -DSALINITY
#          FLAG_5 = -DTEMPERATURE
#           FLAG_6 = -DBUBBLE
#         FLAG_7 = -DSEDIMENT
#         FLAG_8 = -DVEGETATION
#          FLAG_9 = -DINTEL
#          FLAG_10 = -DFOAM
#          FLAG_11 = -DCOUPLING
#         FLAG_12 = -DDEBUG
#         FLAG_13 = -DUSE_INTERP
#         FLAG_14 = -DAMR
#         FLAG_15 = -DX1D
#          FLAG_16 = -DOBSTACLE
#          FLAG_17 = -DMASK3D_TOPLAYER
#          FLAG_19 = -DFROUDE_CAP
#          FLAG_20 = -DBOWLINGBALL_TEST
#--------------------------------------------------------------------------
#  mpi defs 
#--------------------------------------------------------------------------
         CPP      = /usr/bin/cpp 
         CPPFLAGS = $(DEF_FLAGS)
#         FC       = ifort
         FC        = mpif90
         DEBFLGS  = 
         OPT      = #-g
         CLIB     = 
#==========================================================================
         FFLAGS = $(DEBFLGS) $(OPT) 
         MDEPFLAGS = --cpp --fext=f90 --file=-
         RANLIB = ranlib
#--------------------------------------------------------------------------
#  CAT Preprocessing Flags
#--------------------------------------------------------------------------
         CPPARGS = $(CPPFLAGS) $(DEF_FLAGS) $(FLAG_1) $(FLAG_2) $(FLAG_3) \
                   $(FLAG_4) $(FLAG_5) $(FLAG_6) $(FLAG_7) $(FLAG_8) \
                   $(FLAG_9) $(FLAG_10) $(FLAG_11) $(FLAG_12) $(FLAG_13) \
                   $(FLAG_14) $(FLAG_15) $(FLAG_16) $(FLAG_17) $(FLAG_18) \
                   $(FLAG_19) $(FLAG_20)
#--------------------------------------------------------------------------
#  Libraries           
#--------------------------------------------------------------------------
          LIBS  = -L/Users/fengyanshi15/Public/hypre-2.8.0b/src/hypre/lib -lHYPRE
         INCS  = -I/Users/fengyanshi15/Public/hypre-2.8.0b/src/hypre/include
#--------------------------------------------------------------------------
#  Preprocessing and Compilation Directives
#--------------------------------------------------------------------------
.SUFFIXES: .o .f90 .F .F90 

.F.o:
	$(CPP) $(CPPARGS) $*.F > $*.f90
	$(FC)  -c $(FFLAGS) $(INCS) $*.f90
#	\rm $*.f90
#--------------------------------------------------------------------------
#  NHWAVE Source Code.
#--------------------------------------------------------------------------

MODS  = mod_param.F mod_global.F mod_util.F mod_nesting.F \

MAIN  = master.F main.F nhwave.F io.F init.F bc.F interp.F

SRCS = $(MODS)  $(MAIN)

OBJS = $(SRCS:.F=.o) nspcg.o

#--------------------------------------------------------------------------
#  Linking Directives               
#--------------------------------------------------------------------------

$(EXEC):	$(OBJS)
		$(FC) $(FFLAGS) $(LDFLAGS) -o $(EXEC) $(OBJS) $(LIBS)
#--------------------------------------------------------------------------
#  Cleaning targets.
#--------------------------------------------------------------------------

clean:
		/bin/rm -f *.o *.mod *.f90

clobber:	clean
		/bin/rm -f *.f90 *.o nhwave







