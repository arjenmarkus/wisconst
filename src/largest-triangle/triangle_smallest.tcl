# triangle_smallest.tcl --
#     Draw a square and a triangle - various situations
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

pack [canvas .c -width 500 -height 500 -bg white]


set x [expr {0.5 * sqrt(3) * 300 + 100}]

.c create line 100 250 $x 100 $x 400 100 250 -fill red -width 2

.c create line 100 100 400 100 400 400 100 400 100 100 -width 3

.c create oval            95 245           105 255 -fill grey  -outline black
.c create oval [expr {$x-5}]  95 [expr {$x+5}] 105 -fill grey  -outline black
.c create oval [expr {$x-5}] 395 [expr {$x+5}] 405 -fill grey  -outline black

.c create text  90 250 -text "A" -anchor e
.c create text 300  90 -text "B" -anchor s
.c create text 300 410 -text "C" -anchor n


after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {4.2c 4.2c}]
    $pdf1 canvas .c -width 4.2c
    $pdf1 write -file triangle_smallest.pdf
}


