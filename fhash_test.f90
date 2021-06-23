program fhash_test

  use fhash_module__ints_double
  use ints_module

  implicit none

  real :: start, finish
  integer :: numKeys
  integer :: numDim = 66

  print *, 'Start benchmark:'

  ! Benchmark
  numKeys = 8000000
  call cpu_time(start)
  call benchmark(numDim, numKeys)
  call cpu_time(finish)
  print '("Time finish = ", G0.3," seconds.")', finish - start

  contains

  subroutine benchmark(n_ints, n_keys)
    integer, intent(in) :: n_ints, n_keys
    type(fhash_type__ints_double) :: h

    type(ints_type) :: key
    type(reals_type) :: realValue

    real :: start, finish
    integer :: i, j


    print '("n_ints: ", I0, ", n_keys: ", I0)', n_ints, n_keys

    call cpu_time(start)
    call h%reserve(n_keys * 2)
    allocate(key%ints(n_ints))
    allocate(realValue%reals(n_ints))

    do i = 1, n_keys
      do j = 1, n_ints
        key%ints(j) = i + j
        realValue%reals(j) = (i + j)*0.50d-2
      enddo
      !call random_number(randomGen)
      !call h%set(key, (i + j) * randomGen)
      call h%set(key, realValue)
    enddo
    call cpu_time(finish)
    print '("Time insert = ", G0.3," seconds.")', finish - start
    call h%clear()
  end subroutine

end program
