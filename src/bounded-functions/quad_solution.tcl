# quad_solution.tcl --
#     Simple experiments with bounded functions and the possibilities regarding non-existence of an average
#
#     This series:
#     n**2: x in [1,4): f(x) = 1
#           x in [4,9): f(x) = 0
#           x in [9,16): f(x) = 1
#           x in [16,25): f(x) = 0
#           ...
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl
package require Plotchart

pack [canvas .c -width 950 -height 600 -bg white]

set p [::Plotchart::createXYPlot .c {0 100 20} {0.0 1.0 0.25}]

set n      0
set fnodd  0.0
set fneven 0.75

#$p dataconfig odd  -type symbol -symbol up     -colour blue
#$p dataconfig even -type symbol -symbol circle -colour red
$p dataconfig odd  -type both -symbol up     -colour blue
$p dataconfig even -type both -symbol circle -colour red

$p plot odd $n $fnodd
$p plot even $n $fneven

for {set n 1} {$n < 100} {incr n} {
    set fnodd  [expr {((2.0*$n)/(2.0*$n+1))**2 * $fnodd + (4.0*$n-1)/(2.0*$n+1)**2}]
    set fneven [expr {((2.0*$n+1)/(2.0*$n+2))**2 * $fneven + (4.0*$n-3)/(2.0*$n+2)**2}]

    $p plot odd $n $fnodd
    $p plot even $n $fneven
}

$p plot line   0.0 0.999
$p plot line 100.0 0.999

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {9.5c 6.2c}]
    $pdf1 canvas .c -width 9.2c
    $pdf1 write -file quad_solution.pdf
}
