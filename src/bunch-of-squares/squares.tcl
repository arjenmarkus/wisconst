# squares.tcl --
#     Count the number of sums of squares that add up to a given value.
#     For instance:
#     N=7: 1*4 + 3*1, 7*1                  -> 2
#     N=8: 2*4, 1*4 + 4*1, 8*1             -> 3
#     N=9: 1*9, 2*4 + 1*1, 1*4 + 5*1, 9*1  -> 4
#
#     Shortcuts:
#     If the largest square we allow is 4, then no need to descend further,
#     we can calculate the number of possibilities. This is not so easy with larger squares.
#
#

# countSumsOfSquares --
#     Count the number of sums of squares that result in the given value
#
# Arguments:
#     n             Value to be examined
#     maxsq         Maximum square we can use (optional, used internally)
#
# Returns:
#     Number of sums in question
#
proc countSumsOfSquares {n {maxsq {}}} {
    #puts ">> $n -- $maxsq"

    if { $maxsq == {} } {
        set maxsq [expr {(int(sqrt($n)))**2}]
        #puts ">> $maxsq"
    }

    if { $maxsq > $n } {
        set maxsq 1
    }

    #
    # Shortcuts
    #
    if { $maxsq == 1 } {
        #puts ">> 1"
        return 1
    }

    if { $maxsq == 4 } {
        #puts ">> (4) -- [expr {$n / 4 + 1}]"
        return [expr {$n / 4 + 1}]
    }

    #
    # The general case
    #
    set count   0
    set maxsqm1 [expr {(int(sqrt($maxsq))-1)**2}]

    if { $n == $maxsq } {
        incr count
    }

    set nmsq $n
    while { $nmsq > $maxsq } {
        set nmsq  [expr {$nmsq - $maxsq}]
        set count [expr {$count + [countSumsOfSquares $nmsq $maxsqm1]}]
        #puts ">> recurse $count"
    }

    set maxsq $maxsqm1
    set count [expr {$count + [countSumsOfSquares $n $maxsq]}]
    #puts ">> recurse (2) $count"

    return $count
}


# main --
#     Calculate the number of possibilities for a range of values
#
set outfile [open "squares_count.out" w]

for {set n 1} {$n < 1000} {incr n} {
    set count [countSumsOfSquares $n]
    #puts "$n\t$count\t[expr {$count / $n / sqrt($n)}]"
    puts $outfile "$n\t$count\t[expr {log($count)/double($n)}]"
}
