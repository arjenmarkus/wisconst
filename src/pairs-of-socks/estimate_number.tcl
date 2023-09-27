# estimate_number.tcl --
#     Estimate the number of socks for the probability to become 0.5 or more
#
package require math

foreach n {2 3 4 5 6 7 8 9 10 15 20 25 30 100} {
    for {set m 2} {$m < 2*$n} {incr m} {
        set p1   [::math::choose $n $m]
        set p2   [::math::choose [expr {2*$n}] $m]
        set prob [expr {1.0 - 2.0**$m * $p1/double($p2)}]

        #puts "$n: $m -- $p1 -- $p2 -- $prob"

        if { $prob >= 0.5 } {
            puts "$n: $m -- $p1 -- $p2 -- $prob"
            break
        }
    }
}
