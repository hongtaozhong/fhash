program fhash_test_new

  use, intrinsic :: iso_fortran_env
  use fhash_module__ints_double
  use fhash_module__int_ints_ptr
  use ints_module

  implicit none

  real :: start, finish
  integer :: numKeys

  !call test_contructor()
  !call test_reserve()
  !call test_insert_and_get_ints_double()
  !call test_insert_and_get_int_ints_ptr()
  !call test_insert_get_and_remove_int_ints_ptr()
  !call test_iterate()

  !print *, 'ALL TESTS PASSED.'
  print *, 'Start benchmark:'

  ! Benchmark
  numKeys = 10000000
#ifdef __GFORTRAN__
  if (__SIZEOF_POINTER__ == 8) numKeys = numKeys * 2
#else
  if (int_ptr_kind() == 8) numKeys = numKeys * 2
#endif
  call cpu_time(start)
  call benchmark(66, numKeys)
  call cpu_time(finish)
  print '("Time finish = ", G0.3," seconds.")', finish - start

  contains


  subroutine benchmark(n_ints, n_keys)
    integer, intent(in) :: n_ints, n_keys
    type(fhash_type__ints_double) :: h
    type(ints_type) :: key
    type(reals_type) :: values
    real :: start, finish
    integer :: i, j
    real(8) :: genNum, reNum
    logical :: stats

    print '("n_ints: ", I0, ", n_keys: ", I0)', n_ints, n_keys

    call cpu_time(start)
    call h%reserve(n_keys * 2)

    allocate(key%ints(n_ints))
    allocate(values%reals(n_ints))
    
    do i = 1, n_keys
      do j = 1, n_ints
         key%ints(j) = i + j
         call random_number(values%reals(j)) 
      enddo
      !call random_number(genNum)
      call h%set(key, values)
      !call h%get(key, reNum, stats)
      !write(*,*) 'gen', genNum, 're', reNum
      !if ((.not. stats) .and. (abs(reNum-genNum) > epsilon(reNum))) then
      !   stop 'GET PROBLEM'
      !endif

      
    enddo
    call cpu_time(finish)
    print '("Time insert = ", G0.3," seconds.")', finish - start
    call h%clear()
  end subroutine

end program fhash_test_new
