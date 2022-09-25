# correlation_random.tcl --
#     Construct the distribution of correlation coefficients of random points
#
package require Plotchart
package require math::statistics

pack [canvas .c -width 700 -height 700] [canvas .c2 -width 700 -height 700] -side right
set p  [::Plotchart::createHistogram .c {-1.0 1.0 0.25} {0 300 50}]
set p2 [::Plotchart::createHistogram .c2 {0.0 1.0 0.25} {0 350 50}]

for {set i 0} {$i < 1000} {incr i} {

    set xlist {}
    set ylist {}

    for {set k 0} { $k < 3} {incr k} {
        lappend xlist [expr {rand()}]
        lappend ylist [expr {rand()}]
    }

    lappend correlations [::math::statistics::corr $xlist $ylist]
    lappend r2           [expr {[::math::statistics::corr $xlist $ylist] ** 2}]
}

set limits   {-0.8 -0.6 -0.4 -0.2 0.0 0.2 0.4 0.6 0.8 1.0}
set limitsr2 {0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0}
set histogram   [::math::statistics::histogram $limits $correlations]
set histogramr2 [::math::statistics::histogram $limitsr2 $r2]

foreach x $limits y $histogram {
    if { $x ne {} } {
        $p  plot data $x $y
    }
}

foreach x $limitsr2 y $histogramr2 {
    if { $x ne {} } {
        $p2 plot data $x $y
    }
}
