! uniform_groups.f90 --
!     The variance of the sum of n uniform random numbers
!     - the question about groups.
!
program uniform_groups
    implicit none

    integer, parameter         :: maxgroups = 100
    integer                    :: i, j, no_samples
    real, dimension(maxgroups) :: r, sum_r, sum_square, variance

    sum_r      = 0.0
    sum_square = 0.0
    no_samples = 100000

    do i = 1,no_samples
        call random_number( r )

        do j = 1,maxgroups
            sum_r(j)      = sum_r(j)      + sum( r(1:j) )
            sum_square(j) = sum_square(j) + sum( r(1:j) ) ** 2
        enddo
    enddo

    do j = 1,maxgroups
        variance(j) = ( sum_square(j) - sum_r(j)**2/no_samples ) / (no_samples - 1) / j**2
    enddo

    write( *, '(i5,3g12.4)' ) (j , sum_r(j), sum_square(j), variance(j) ,j=1,maxgroups)
end program uniform_groups
