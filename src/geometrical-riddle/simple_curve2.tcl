# simple_curve2.tcl --
#     Draw simple curve
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

pack [canvas .c -width 650 -height 300 -bg white]

.c create rectangle   0   0 200 300 -fill lightgrey -outline lightgrey
.c create rectangle 400   0 650 300 -fill lightgrey -outline lightgrey

.c create line   0 250 650 250
.c create line 200   0 200 300
.c create text 190 260 -text "0"
.c create line 400 250 400 255
.c create text 400 260 -text "1"
.c create line 600 250 600 255
.c create text 600 260 -text "2"
.c create line 200  50 195  50
.c create text 190  50 -text "1"
.c create line 200 150 195 150
.c create text 190 150 -text "1/2" -anchor e

set x 0
while {$x < 600} {
    .c create line $x 250 $x 200 [expr {$x+50}] 200 [expr {$x+50}] 250 [expr {$x+100}] 250 -width 3
    set x [expr {$x + 100}]
}
.c create line $x 250 $x 200 [expr {$x+50}] 200 -width 3

set x 0
while {$x < 600} {
    .c create line $x 250 $x 184 [expr {$x+50}] 184 [expr {$x+50}] 250 [expr {$x+100}] 250 -width 3 -dash -
    set x [expr {$x + 100}]
}
.c create line $x 250 $x 184 [expr {$x+50}] 184 -width 3 -dash -


after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {9.5c 4.5c}]
    $pdf1 canvas .c -width 9.2c
    $pdf1 write -file simple-curve2.pdf
}

