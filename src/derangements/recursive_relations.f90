! recursive_relations.f90 --
!     Examine a few very basic looking recursive relations - permutations and derangements
!     and some variants
!     Note that the relations look very similar, but the results grow apart quickly.
!
!     It seems the ratios converge:
!     permmin/permutations -> 3-e ~=  0.2817
!     permplus/permutations -> e-1 ~= 1.718
!
!     For derangements the exact relation is: derangements/permutations -> 1/e
!     Variant: derangem2/permutations -> 1+1/e   - logical: it is the sum of derangements and permutations
!     Variant: derangem3/permutations -> e/5 (?)
!
program recursion
    use iso_fortran_env, only: int64
    implicit none

    integer(kind=int64) :: i, permutations, derangements, permmin, permplus, derangem3, d4

    permutations  = 1
    derangements  = 0
    derangem3     = 0
    permmin       = 1
    permplus      = 1

    write(*,'(5i20,5g12.4)') permutations, permmin, permplus, derangem3, derangements, &
   &    dble(permmin)/permutations, dble(permplus)/permutations, &
   &    dble(derangem3)/permutations, &
   &    dble(derangements)/permutations

    do i = 2,15
        permutations = permutations * i
        derangements = derangements * i + (-1)**i
        derangem3    = derangem3    * i + max(0, (-1)**i)

        permmin      = permmin      * i - 1
        permplus     = permplus     * i + 1

        write(*,'(5i20,5g12.4)') permutations, permmin, permplus, derangem3, derangements, &
   &        dble(permmin)/permutations, dble(permplus)/permutations, &
   &        dble(derangem3)/permutations, &
   &        dble(derangements)/permutations
    enddo

    permutations = 1
    d4 = 1
    do i = 2,15
        permutations = permutations * i
        d4           = d4           * i + merge( 1, 0, mod(i,3) == 0 )

        write(*,'(2i20,5g15.8)') permutations, d4, dble(d4)/permutations
    enddo
end program recursion
