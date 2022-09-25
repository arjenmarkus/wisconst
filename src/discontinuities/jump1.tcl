# jump1.tcl --
#     Simulate jumps - first example
#
package require Plotchart
package require math::calculus

lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

proc f {x y} {
    if { $x > 1.0 } {
        set df [expr {1.0 - $y}]
    } else {
        set df [expr {0.0 - $y}]
    }
    return $df
}

proc exact {x} {
    if { $x >= 1.0 } {
        set y [expr {1.0 - exp(1.0-$x)}]
    } else {
        set y 0.0
    }
    return $y
}

pack [canvas .c -width 600 -height 400]
set p [::Plotchart::createXYPlot .c {0.0 0.6 0.1} {0.0 0.5 0.1}]

$p dataconfig euler      -colour red
$p dataconfig heun       -colour blue
$p dataconfig rungekutta -colour green

$p legendconfig -spacing 12
$p legend euler      "Euler"
$p legend heun       "Heun"
$p legend rungekutta "Runge-Kutta"

#
# Solve the equation over the interval [0,2]
#
set xend 5.0

foreach numberSteps {10 20 30 40 50 60 70 80 90 100} {

    set y1        0.0
    set y2        0.0
    set y3        0.0
    set maxError1 0.0
    set maxError2 0.0
    set maxError3 0.0

    set dx  [expr {$xend / $numberSteps}]
    for {set i 0} {$i < $numberSteps} {incr i} {
        set x [expr {$i * $dx}]

        set y1 [::math::calculus::eulerStep $x $dx $y1 f]
        set y2 [::math::calculus::heunStep $x $dx $y2 f]
        set y3 [::math::calculus::rungeKuttaStep $x $dx $y3 f]

        set error1    [expr {abs($y1 - [exact $x])}]
        set error2    [expr {abs($y2 - [exact $x])}]
        set error3    [expr {abs($y3 - [exact $x])}]
        set maxError1 [expr {$error1 > $maxError1 ? $error1 : $maxError1}]
        set maxError2 [expr {$error2 > $maxError2 ? $error2 : $maxError2}]
        set maxError3 [expr {$error3 > $maxError3 ? $error3 : $maxError3}]
        #puts "$x $y [exact $x]"
    }

    $p plot euler      $dx $maxError1
    $p plot heun       $dx $maxError2
    $p plot rungekutta $dx $maxError3

    puts "$numberSteps $dx $maxError1 $maxError2 $maxError3"
}

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {9.5c 6.0c}]
    $pdf1 canvas .c -width 9.2c
    $pdf1 write -file jump1.pdf
}
