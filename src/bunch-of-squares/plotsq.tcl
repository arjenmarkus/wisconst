# plotsq.tcl --
#     Plot the relation between n and the number of sums of squares
#

lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

package require Plotchart

pack [canvas .c -width 700 -height 500]

set p [::Plotchart::createXLogYPlot .c {0 1000 250} {1.0 1.0e10 100.0}]

$p dataconfig fit  -colour red
$p dataconfig fit2 -colour green

set infile [open "squares_count.out"]

while { [gets $infile line] >= 0 } {
    lassign $line n count dummy

    $p plot data $n $count

    $p plot fit  $n [expr {exp(0.7*sqrt($n))}]
    #$p plot fit2 $n [expr {exp(0.8*sqrt($n))}]
}

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {7.5c 5.0c}]
    $pdf1 canvas .c -width 7.2c
    $pdf1 write -file squares.pdf
}

