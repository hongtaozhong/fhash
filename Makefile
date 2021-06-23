FC := gfortran
FFLAGS := -O3 -g -fbounds-check -Wall -Wextra -cpp -Wno-unused-dummy-argument

.PHONY: all test clean ref

all: test

test: fhash_modules fhash_test.f90
	$(FC) $(FFLAGS) fhash_modules.f90 fhash_test.f90 -o fhash_test.out && ./fhash_test.out

ref: benchmark.cc
	g++ -O3 -std=c++14 benchmark.cc -o ref.out && ./ref.out

clean:
	rm -rf *.mod *.o

fhash_modules: fhash.f90 fhash_modules.f90
	$(FC) $(FFLAGS) -c fhash_modules.f90

real: fhash_modules_reals fhash_test_reals.f90
	$(FC) $(FFLAGS) fhash_modules_reals.f90 fhash_test_reals.f90 -o fhash_test.out && ./fhash_test.out

fhash_modules_real: fhash.f90 fhash_modules_reals.f90
	$(FC) $(FFLAGS) -c fhash_modules_reals.f90

fhash_modules_new: fhash.f90 fhash_modules_new.f90
	$(FC) $(FFLAGS) -c fhash_modules_new.f90

testnew: fhash_modules_new fhash_test_new.f90
	$(FC) $(FFLAGS) fhash_modules_new.f90 fhash_test_new.f90 -o fhash_test.out && ./fhash_test.out
