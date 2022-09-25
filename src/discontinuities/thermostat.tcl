# thermostat.tcl --
#     Simulate thermostat
#
package require Plotchart
package require math::calculus

lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

proc f {x y} {
    if { $y <= 1.0 } {
        set df [expr {-$y+10.0}]
    } else {
        set df [expr {-$y+0.0}]
    }
    return $df
}

pack [canvas .c -width 800 -height 400]
set p [::Plotchart::createXYPlot .c {0.0 5.0 1.0} {-1.0 3.0 1.0}]

$p dataconfig euler      -colour red
$p dataconfig heun       -colour blue
$p dataconfig rungekutta -colour green

$p legendconfig -spacing 12 -position bottom-right
$p legend euler      "Euler"
$p legend heun       "Heun"
$p legend rungekutta "Runge-Kutta"

#
# Solve the equation over the interval [0,5]
#
set xend 5.0

foreach numberSteps {30} {

    set y1        0.0
    set y2        0.0
    set y3        0.0
    set maxError1 0.0
    set maxError2 0.0
    set maxError3 0.0

    set dx  [expr {$xend / $numberSteps}]
    for {set i 0} {$i < $numberSteps} {incr i} {
        set x [expr {$i * $dx}]

        $p plot euler        $x $y1
        $p plot heun       $x $y2
        $p plot rungekutta $x $y3

        set y1 [::math::calculus::eulerStep $x $dx $y1 f]
        set y2 [::math::calculus::heunStep $x $dx $y2 f]
        set y3 [::math::calculus::rungeKuttaStep $x $dx $y3 f]
    }

    set x [expr {$i * $dx}]
    $p plot euler      $x $y1
    $p plot heun       $x $y2
    $p plot rungekutta $x $y3
}

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {12.5c 6.0c}]
    $pdf1 canvas .c -width 12.2c
    $pdf1 write -file thermostat.pdf
}

