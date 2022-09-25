# number_visitors_smooth.tcl --
#     Draw the smooth graph illustrating visitors arriving and leaving
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

package require Plotchart

pack [canvas .c -width 700 -height 400]

set p [::Plotchart::createXYPlot .c {0 3.5 0.5} {0 12 2}]

$p dataconfig data -colour red -width 3

set dt [expr {1.0/6.0}]

$p plot data 0.0 0.0
$p plot data 1.0 6.0
$p plot data [expr {$dt*10.0}] 6.0
$p plot data [expr {$dt*16.0}] 0.0
$p plot data 3.5 0.0

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {7.5c 4.2c}]
    $pdf1 canvas .c -width 9.2c
    $pdf1 write -file number_visitors_smooth.pdf
}

