# correlation_random_table.tcl --
#     Determine the distribution of correlation coefficients of random points.
#     How often is the absolute value larger than 0.5, 0.7 or 0.9 as function
#     of the number of pairs?
#
package require math::statistics

set limits   {0.2 0.5 0.7 0.9 1.0}

for {set pairs 20} {$pairs < 101} {incr pairs 10} {
    set correlations {}
    for {set i 0} {$i < 1000} {incr i} {

        set xlist {}
        set ylist {}

        for {set k 0} {$k < $pairs} {incr k} {
            lappend xlist [expr {rand()}]
            lappend ylist [expr {rand()}]
        }

        lappend correlations [expr {abs([::math::statistics::corr $xlist $ylist])}]
    }

    set histogram [::math::statistics::histogram $limits $correlations]

    puts "$pairs\t[join $histogram \t]"
}
