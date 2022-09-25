# diffusion.tcl --
#     Sketch of diffusion problem - third example
#
package require Plotchart
package require math::calculus

lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

proc exact {x} {
    if { $x >= -1.5 } {
        set y [expr {(1.5+$x)**2}]
    } else {
        set y 0.0
    }
    return $y
}

pack [canvas .c -width 600 -height 400]

::Plotchart::plotstyle configure default xyplot leftaxis shownumbers   no
::Plotchart::plotstyle configure default xyplot leftaxis showaxle      no
::Plotchart::plotstyle configure default xyplot leftaxis color         white
::Plotchart::plotstyle configure default xyplot bottomaxis shownumbers no
::Plotchart::plotstyle configure default xyplot bottomaxis showaxle    no
::Plotchart::plotstyle configure default xyplot bottomaxis color       white

set p [::Plotchart::createXYPlot .c {-2.0 3.0 1.0} {-2.0 1.0 1.0}]
$p dataconfig line -colour lightgrey
$p dataconfig data -colour green

$p plot line -2.0  0.0
$p plot line  3.0  0.0
$p plot axis  0.0  0.0
$p plot axis  0.0 -2.0

set xy1 [::Plotchart::coordsToPixel [$p canvas]  0.0   0.0]
set xy2 [::Plotchart::coordsToPixel [$p canvas] -0.3  -1.5]
set xyt [::Plotchart::coordsToPixel [$p canvas] -0.35 -0.7]
.c create rectangle [concat $xy1 $xy2] -fill lightgrey -outline lightgrey
.c create text $xyt -text "Consumption" -anchor e

set xyt [::Plotchart::coordsToPixel [$p canvas]  0.55 -1.0]
.c create text $xyt -text "Diffusion\nof oxygen" -anchor w

set xyt [::Plotchart::coordsToPixel [$p canvas]  0.0   0.5]
.c create text $xyt -text "Atmosphere"

foreach x {-1.5 -1.0 -0.5 0.0 0.5 1.0 1.5 2.0 2.5} {
    set xy1 [::Plotchart::coordsToPixel [$p canvas]  $x    0.1]
    set xy2 [::Plotchart::coordsToPixel [$p canvas]  $x    0.3]
    .c create line [concat $xy1 $xy2] -arrow first
}

set numberSteps 200
set xend        2.0
set dx          [expr {$xend / $numberSteps}]

for {set i 0} {$i < $numberSteps} {incr i} {
    set x [expr {-$i * $dx}]

    $p plot data [exact $x] $x
}

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {12.5c 6.0c}]
    $pdf1 canvas .c -width 12.2c
    $pdf1 write -file diffusion.pdf
}
