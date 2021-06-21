program test_log10
real(8) :: x = 9.943d-18
integer, parameter :: num_digits = 2
integer y, y2, y3
y = floor(log10(x))
y2 = nint(   10**(log10(x) -y+num_digits))
y3 = y2*100 + y
write(*,*) y, y2, y3
end program test_log10
