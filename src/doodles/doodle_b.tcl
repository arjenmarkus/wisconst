# doodle_b.tcl --
#     Simple program to draw a "doodle" - point on a  figure eight curve, moving
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl
package require Plotchart

pack [canvas .c -width 1200 -height 600]

#
# Construct the list of coordinate pairs, using a parameter representation
#
set t 0.0

for {set i 0} {$i < 700} {incr i} {
    set t [expr {0.03*$i}]
    set x [expr {0.2*$t - 0.6*sin(2*$t)}]
    set y [expr {cos($t)}]

    lappend coords $x $y
}

.c create line $coords
.c scale all 0 0 200 -200
.c move all 100 300

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {9.5c 3.0c}]
    $pdf1 canvas .c -width 9.2c
    $pdf1 write -file doodle_b.pdf
}

