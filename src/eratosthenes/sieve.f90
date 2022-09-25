! sieve.f90 --
!     Straightforward implementation of the Sieve of Eratosthenes
!
module sieves
    implicit none

contains

! sieve1 --
!     Implementation using do-loop
!
! Arguments:
!     number            Number range to scan
!     result            Resulting array of primes
!
subroutine sieve1( number, result )

    integer, intent(in)                :: number
    integer, dimension(:), allocatable :: result

    integer, dimension(:), allocatable :: array
    integer, dimension(:), allocatable :: primes
    integer, dimension(1)              :: p
    integer                            :: count

    allocate( array(number), primes(number) )

    array    = 1
    array(1) = 0
    primes   = 0

    count = 0
    do while ( any( array == 1 ) )
        p                 = maxloc( array )
        count             = count + 1
        primes(count)     = p(1)
        array(p(1)::p(1)) = 0
    enddo

    allocate( result(count) )
    result = primes(1:count)

end subroutine sieve1

! sieve2 --
!     Recursive implementation with pack()
!
! Arguments:
!     number            Number range to scan
!     result            Resulting array of primes
!
subroutine sieve2( number, result )

    integer, intent(in)                :: number
    integer, dimension(:), allocatable :: result

    integer, dimension(:), allocatable :: array
    integer                            :: i

    allocate( array(number-1) )  ! Skip 1

    array = [(i, i=2,number)]

    call sieve2_recursive( [(i, i=1,0)], array )
contains
recursive subroutine sieve2_recursive( primes, array )
    integer, dimension(:) :: primes
    integer, dimension(:) :: array

    if ( size(array) /= 0 ) then
        call sieve2_recursive( [primes, array(1)], pack( array, mod(array, array(1)) /= 0 ) )
    else
        allocate( result(size(primes)) )
        result = primes
    endif
end subroutine sieve2_recursive
end subroutine sieve2

! sieve3 --
!     Recursive implementation
!
! Arguments:
!     number            Number range to scan
!     result            Resulting array of primes
!
subroutine sieve3( number, result )

    integer, intent(in)                :: number
    integer, dimension(:), allocatable :: result

    integer, dimension(0)              :: work
    integer, dimension(:), allocatable :: array
    integer                            :: prime

    allocate( array(number) )

    array    = 1
    array(1) = 0
    prime    = 2

    call sieve3_recursive( array, prime, work )
contains
recursive subroutine sieve3_recursive( array, prime, primes )
    integer, dimension(:) :: array
    integer               :: prime
    integer, dimension(:) :: primes

    integer, dimension(1) :: p

    p     = maxloc( array )
    prime = p(1)
    if ( array(prime) /= 0 ) then
        array(prime::prime) = 0
        call sieve3_recursive( array, prime, [primes, prime] )
    else
        allocate( result(size(primes)) )
        result = primes
    endif
end subroutine sieve3_recursive
end subroutine sieve3


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

    if ( first ) then
        first = .false.
        allocate( prime(1), multiple(1) )
        prime(1)    = 2
        multiple(1) = 2

        next = prime(1)
        return
    endif

    !
    ! Regular search for the next one
    ! (Note: we need to update the multiples immediately)
    !
    candidate = minval(multiple) + 1
    do while ( any( multiple == candidate ) )
        candidate = candidate + 1
        do while ( any( multiple < candidate ) )
            multiple  = merge( multiple+prime, multiple, multiple < candidate )
        enddo
    enddo

    next = candidate

    call allocate_new( prime,    (/ prime,    next /) )
    call allocate_new( multiple, (/ multiple, next /) )

contains
!
! Note: can be much shorter with "source =" or automatic allocation
!
subroutine allocate_new( array, values )
    integer, dimension(:), allocatable :: array
    integer, dimension(:)              :: values

    deallocate( array )
    allocate( array(size(values)) )

    array = values

end subroutine allocate_new
end subroutine sieve4

end module sieves

! main --
!     Test the sieves
!
program test_sieves

    use sieves

    implicit none

    integer, dimension(:), allocatable :: primes
    integer                            :: i
    integer                            :: number

    call sieve1( 100, primes )
    write( *, '(10i5)' ) primes

    deallocate(primes)
    call sieve2( 100, primes )
    write( *, '(10i5)' ) primes

    deallocate(primes)
    call sieve3( 100, primes )
    write( *, '(10i5)' ) primes

    deallocate( primes )
    allocate( primes(100) )
    do i = 1,100
        call sieve4( primes(i) )
        if ( primes(i) > 100 ) then
            number = i - 1
            exit
        endif
    enddo
    write( *, '(10i5)' ) primes(1:number)

end program test_sieves
