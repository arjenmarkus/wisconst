# plot_uniform.tcl --
#     Plot the distribution of a sum of uniform variates
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl
package require Plotchart

pack [canvas .c -width 600 -height 400]

set p [::Plotchart::createXYPlot .c {0 1.01 0.25} {0 3.01 0.5}]

$p dataconfig sum1 -colour blue
$p dataconfig sum2 -colour red
$p dataconfig sum4 -colour magenta

$p legendconfig -spacing 14

$p legend sum1 "One variate"
$p legend sum2 "Sum of two variates"
$p legend sum4 "Sum of four variates"

# sgn --
#     Return the sign of a variable
#
# Arguments:
#     x               The value whose sign is to be returned
#
proc ::tcl::mathfunc::sgn {x} {
    if { $x > 0.0 } {
        return 1
    } elseif { $x < 0.0 } {
        return -1
    }
    return 0
}



for {set i 0} {$i <= 100} {incr i} {
    set x [expr {0.01*$i}]

    set sum1 1.0
    if { $i == 0 || $i == 100 } {
        set sum1 0.0
    }

    set u    [expr {2.0 * $x}]
    set sum2 [expr {(-2.0 + $u) * sgn(-2.0 + $u) - 2.0 * (-1.0 + $u) * sgn(-1.0 + $u) + $u * sgn($u)}]

    set u    [expr {4.0 * $x}]
    set sum4 [expr {( (-4.0 + $u)**3 * sgn(-4.0 + $u) - 4.0 * (-3.0 + $u)**3 * sgn(-3.0 + $u) +
                        6.0 * (-2.0 + $u)**3 * sgn(-2.0 + $u) - 4.0 * (-1.0 + $u)**3 * sgn(-1.0 + $u) + $u**3 * sgn($u) ) / 3.0}]

    $p plot sum1 $x $sum1
    $p plot sum2 $x $sum2
    $p plot sum4 $x $sum4
}


after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {6.2c 4.2c}]
    $pdf1 canvas .c -width 6.2c
    $pdf1 write -file uniform_distros.pdf
}

