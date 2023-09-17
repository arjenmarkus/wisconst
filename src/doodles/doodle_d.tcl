# doodle_d.tcl --
#     Simple program to draw a "doodle" - two loops and two cusps
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
    set x [expr {sin($t)**3}]
    set y [expr {cos($t) + cos(3.0*$t)}]

    lappend coords $x $y
}

.c create line $coords
.c scale all 0 0 100 -100
.c move all 300 300

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {3.5c 3.5c}]
    $pdf1 canvas .c -width 3.2c
    $pdf1 write -file doodle_d.pdf
}

