# jumpexact2.tcl --
#     Exact solution (jump at x=1) - second example
#
package require Plotchart
package require math::calculus

lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

proc exact {x} {
    if { $x >= 1.0 } {
        set y [expr {exp(1.0-$x)}]
    } else {
        set y 0.0
    }
    return $y
}

pack [canvas .c -width 800 -height 400]
set p [::Plotchart::createXYPlot .c {0.0 5.0 0.5} {-0.25 1.0 0.25}]
$p dataconfig line -colour lightgrey
$p dataconfig data -colour green

$p plot line 0.0 0.0
$p plot line 5.0 0.0

set numberSteps 200
set xend        5.0
set dx          [expr {$xend / $numberSteps}]

for {set i 0} {$i < $numberSteps} {incr i} {
    set x [expr {$i * $dx}]

    $p plot data $x [exact $x]
}

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {12.5c 6.0c}]
    $pdf1 canvas .c -width 12.2c
    $pdf1 write -file jumpexact2.pdf
}
