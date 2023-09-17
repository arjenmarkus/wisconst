# doodle_c2.tcl --
#     Simple program to draw a "doodle" - a round shape with a secondary loop at the top
#     Alternative
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
    set x [expr {sin($t) * (1.0 + 2.6*cos($t))/3.6}]
    set y [expr {cos($t) * (1.0 - 2.6*cos($t))/3.6}]

    #lappend coords $t $y
    lappend coords $x $y
}

.c create line $coords
.c scale all 0 0 200 -200
#.c scale all 0 0 20 -200
.c move all 300 50

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {3.5c 3.5c}]
    $pdf1 canvas .c -width 3.2c
    $pdf1 write -file doodle_c2.pdf
}

