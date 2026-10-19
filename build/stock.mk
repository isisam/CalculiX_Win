# Stock CalculiX 2.21; portability and dependency overrides only.
include Makefile.inc
SCCXMAIN=ccx_2.21.c
OBJECTS=$(SCCXF:.f=.o) $(SCCXC:.c=.o)
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@
%.o: %.f
	$(FC) $(FFLAGS) -c $< -o $@
ccx.exe: ccx_2.21.o ccx_2.21.a
	$(FC) -o $@ ccx_2.21.o ccx_2.21.a $(LIBS) -fopenmp $(LDFLAGS)
ccx_2.21.a: $(OBJECTS)
	$(AR) rcs $@ $(OBJECTS)
