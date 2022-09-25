# graph_xaxis.tcl --
#     Draw a graph of the solution along the x-axis
#
lappend auto_path d:/tcl-programs/pdf4tcl-head/pdf4tcl
package require pdf4tcl

package require Plotchart

pack [canvas .c -width 500 -height 300]

set p [::Plotchart::createXYPlot .c {0 120.0 20.0} {0 10.0 2.0}]

$p dataconfig near -colour red
$p dataconfig far  -colour green

$p legendconfig -spacing 14
$p legend near "Near-field"
$p legend far  "Far-field"

$p vtext "Concentration (g/m3)"
$p xtext "Distance from source (m)"

set pi [expr {4.0*atan(1.0)}]

for {set i 1} {$i < 500} {incr i} {
    set x [expr {$i * 0.1}]
    set y [expr {200.0 / (5.0 * $x)}]

    if { $y < 10.0 } {
        $p plot near $x $y
    }
}

for {set i 1} {$i < 120} {incr i} {
    set x [expr {$i}]
    set y [expr {40.0 * sqrt(2.0 / ($pi * 5.0 * $x))}]

    if { $y < 10.0 } {
        $p plot far $x $y
    }
}

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {13.5c 8.0c}]
    $pdf1 canvas .c -width 13.0c
    $pdf1 write -file graph_xaxis.pdf
}


