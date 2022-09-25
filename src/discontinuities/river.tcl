# river.tcl --
#     Exact solution for a point source at x = 0
#
package require Plotchart
package require math::calculus

lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

proc exact {x} {
    if { $x < 0.0 } {
        set y [expr {exp($x)}]
    } else {
        set y 1.0
    }
    return $y
}

pack [canvas .c -width 800 -height 400]
set p [::Plotchart::createXYPlot .c {-2.0 3.0 1.0} {-0.25 1.1 0.25}]
$p dataconfig line -colour lightgrey
$p dataconfig data -colour green

$p plot line -2.0 0.0
$p plot line  3.0 0.0

set xy1 [::Plotchart::coordsToPixel [$p canvas]  0.0   0.0]
set xy2 [::Plotchart::coordsToPixel [$p canvas]  0.0   1.0]
.c create line [concat $xy1 $xy2] -dash "-"

set xyt [::Plotchart::coordsToPixel [$p canvas]  0.1   0.7]
.c create text $xyt -text "Source" -anchor w


set numberSteps 200
set xend        5.0
set dx          [expr {$xend / $numberSteps}]

for {set i 0} {$i < $numberSteps} {incr i} {
    set x [expr {-2.0 + $i * $dx}]

    $p plot data $x [exact $x]
}

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {12.5c 6.0c}]
    $pdf1 canvas .c -width 12.2c
    $pdf1 write -file river.pdf
}
