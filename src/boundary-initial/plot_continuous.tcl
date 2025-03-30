# plot_continuous.tcl --
#     Plot the concentrations as function of time
#     for a continuous inflow
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl
package require Plotchart
package require math::calculus

global x D u pi

set u  [expr {1.0}]
set D  [expr {1.0}]
set pi [expr {acos(-1.0)}]

# cstar --
#     Function to be integrated
#
# Arguments:
#     t                 Time
#
# Result:
#     Function value at time t
#
# Note:
#     It is uses a global variable x. The name comes from the
#     short note.
#     Diffusion coefficient is chosen as 1 ,2/s, the flow velocity
#     as 1 m/s, but imported as global.
#
proc cstar {t} {
    global x D u pi

    set expon [expr {-$u*$x / (2.0*$D) -($u**2) * $t / (4.0*$D) - $x**2/(4.0*$D*$t)}]
    set func  [expr { $x / sqrt(4.0*$pi*$D*$t**3) * exp($expon) }]

    return $func
}

#console show

pack [canvas .c -width 700 -height 500]
set p [::Plotchart::createXYPlot .c {0 5 1} {0 1.01 0.25}]

$p legendconfig -spacing 14

foreach t {0.001 0.01 0.1 1.0 10.0 100.0} colour {black blue lime red magenta cyan} {
    $p dataconfig $colour -colour $colour
    $p legend $colour "t = $t"

    puts "$t -- $colour"
    for {set i 1} {$i < 100} {incr i} {
        set x [expr {$i * 0.05}]
        set f [::math::calculus::integral 0.00001 $t 100 cstar]

        #puts "$x -- $f"

        $p plot $colour $x $f
    }
}

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {9.5c 6.2c}]
    $pdf1 canvas .c -width 9.2c
    $pdf1 write -file water_tube.pdf
}
