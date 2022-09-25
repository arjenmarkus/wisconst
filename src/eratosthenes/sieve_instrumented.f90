! sieve_instrumented.f90 --
!     Instrumented implementation of the Sieve of Eratosthenes
!
module sieves
    implicit none

contains

! sieve4 --
!     Implementation using "advancing multiples"
!
! Arguments:
!     next           Next prime
!
subroutine sieve4( next )
    integer, intent(out) :: next

    logical, save :: first = .true.

    integer, dimension(:), allocatable, save :: prime
    integer, dimension(:), allocatable, save :: multiple
    integer, dimension(:), allocatable       :: tmp
    integer                                  :: candidate
    integer                                  :: time

    if ( first ) then
        first = .false.
        prime    = (/ 2 /)
        multiple = (/ 2 /)
        next     = prime(1)
        return
    endif

    time = 0
    !
    ! Regular search for the next one
    ! (Note: we need to update the multiples immediately)
    !
    candidate = minval(multiple) + 1
    time      = time + size(multiple)

    do while ( any( multiple == candidate ) )
        time = time + size(multiple)
        candidate = candidate + 1
        do while ( any( multiple < candidate ) )
            time = time + 2 * size(multiple)
            multiple  = merge( multiple+prime, multiple, multiple < candidate )
        enddo
    enddo

    next = candidate

    prime    = (/ prime,    next /)
    multiple = (/ multiple, next /)

    time = time + 2 * size(multiple)

    write(*,*) next, time

end subroutine sieve4

end module sieves

! main --
!     Test the sieves
!
program test_sieves

    use sieves

    implicit none

    integer                            :: i
    integer                            :: number

    do i = 1,1000
        call sieve4( number )
    enddo

end program test_sieves
