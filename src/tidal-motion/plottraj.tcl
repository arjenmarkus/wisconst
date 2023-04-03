# plottraj.tcl --
#     Plot a sample trajectory
#
lappend auto_path d:/tcl-programs/pdf4tcl-head/pdf4tcl
package require pdf4tcl

package require Plotchart

pack [canvas .c -width 700 -height 700]
set p [::Plotchart::createXYPlot .c {-2500.0 2500.0 500.0} {-15000.0 15000.0 5000.0}]

set x0 0.0
set y0 0.0

set u1 0.2
set v0 0.02
set v1 0.7
set v2 0.025e-3
set omega [expr {2.0 * acos(-1) / 45000.0}]

set w1 [expr {$v0 - $u1 * $v2 / $omega}]
set w2 [expr {($v1 - $x0 * $v2) / $omega}]
set w3 [expr {$u1 * $v2 / (4.0 * $omega ** 2)}]

console show
puts "w1 = $w1"
puts "w2 = $w2"
puts "w3 = $w3"

$p dataconfig data  -colour blue
$p dataconfig point -colour blue -type symbol

$p dataconfig residual -colour red -type both

$p plot zero -2500.0 0.0
$p plot zero  2500.0 0.0
$p plot zero  {}     {}
$p plot zero     0.0 -15000.0
$p plot zero     0.0  15000.0

$p plot residual [expr {$u1/$omega}] 0.0
$p plot residual [expr {$u1/$omega}] [expr {$v0 * 8*12.5 * 3600.0}]

$p plot point [expr {$u1/$omega}] 0.0

for {set i 0} {$i < 4*8*12.5} {incr i} {
    set t [expr {$i * 3600.0 / 4.0}]
    set x [expr {$u1/$omega * cos($omega * $t)}]
    set y [expr {$y0 + $w1 * $t - $w2 * sin($omega*$t) + $w3 * cos(2.0 * $omega * $t)}]

    #puts "$x -- $y -- [expr {$w2 * sin($omega*$t)}]"
    $p plot data $x $y
}

$p plot point $x $y


after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {8.0c 8.0c}]
    $pdf1 canvas .c -width 7.8c
    $pdf1 write -file trajectory.pdf
}



