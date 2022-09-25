# bend.tcl --
#     Sketch of bended solution - fourth example
#
package require Plotchart
package require math::calculus

lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

pack [canvas .c -width 600 -height 400]

::Plotchart::plotstyle configure default xyplot leftaxis shownumbers   no
#::Plotchart::plotstyle configure default xyplot leftaxis showaxle      no
#::Plotchart::plotstyle configure default xyplot leftaxis color         white
::Plotchart::plotstyle configure default xyplot bottomaxis shownumbers no
#::Plotchart::plotstyle configure default xyplot bottomaxis showaxle    no
#::Plotchart::plotstyle configure default xyplot bottomaxis color       white

set p [::Plotchart::createXYPlot .c {-3.0 3.0 1.0} {0.0 1.0 1.0}]

$p plot line -2.5  0.0
$p plot line  0.0  0.5
$p plot line  2.5  0.0

set xyt [::Plotchart::coordsToPixel [$p canvas] -2.5  -0.01]
.c create text $xyt -text "-L" -anchor n
set xyt [::Plotchart::coordsToPixel [$p canvas]  2.5  -0.01]
.c create text $xyt -text "L" -anchor n
set xyt [::Plotchart::coordsToPixel [$p canvas]  0.0  -0.01]
.c create text $xyt -text "0" -anchor n
set xyt [::Plotchart::coordsToPixel [$p canvas]  0.1   0.7]
.c create text $xyt -text "Source" -anchor w

set xy1 [::Plotchart::coordsToPixel [$p canvas]  0.0   0.0]
set xy2 [::Plotchart::coordsToPixel [$p canvas]  0.0   1.0]
.c create line [concat $xy1 $xy2] -dash "-"

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {12.5c 6.0c}]
    $pdf1 canvas .c -width 12.2c
    $pdf1 write -file bend.pdf
}
