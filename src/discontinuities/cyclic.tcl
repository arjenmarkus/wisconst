# cyclic.tcl --
#     Cyclic behaviour induced by switching on/off discharge
#
package require Plotchart
package require math::calculus

lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

pack [canvas .c -width 800 -height 400]

::Plotchart::plotstyle configure default xyplot bottomaxis shownumbers no
::Plotchart::plotstyle configure default xyplot leftaxis shownumbers no

set p [::Plotchart::createXYPlot .c {0.0 11.0 1.0} {0.0 1.5 0.25}]
$p dataconfig okay -colour green
$p dataconfig line -colour black
$p dataconfig max  -colour red

$p legendconfig -spacing 12
$p legend okay "Temperature low enough"
$p legend max  "Maximum allowable"
$p legend line "Temperature exceeds maximum"
$p balloon 2.0 1.2 "Arrival at monitoring point" south

$p plot max   0.0 0.8
$p plot max  11.0 0.8
$p plot okay  0.0 0.0
$p plot okay  2.0 0.0
$p plot okay  2.0 0.6
$p plot okay 11.0 0.6

$p plot line 0.0 0.0
$p plot line 2.0 0.0
$p plot line 2.0 1.0
$p plot line 4.0 1.0
$p plot line 4.0 0.0
$p plot line 6.0 0.0
$p plot line 6.0 1.0
$p plot line 8.0 1.0
$p plot line 8.0 0.0
$p plot line 10.0 0.0
$p plot line 10.0 1.0
$p plot line 11.0 1.0

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {12.5c 6.0c}]
    $pdf1 canvas .c -width 12.2c
    $pdf1 write -file cyclic.pdf
}
