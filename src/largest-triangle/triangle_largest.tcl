# triangle_largest.tcl --
#     Draw a square and a triangle - various situations
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

pack [canvas .c -width 500 -height 500 -bg white]


set y [expr {(2 - sqrt(3)) * 300}]

.c create line 100 [expr {100+$y}] 400 100 [expr {400-$y}] 400 100 [expr {100+$y}] -fill red -width 2

.c create line 100 100 400 100 400 400 100 400 100 100 -width 3

.c create oval  95               [expr {100+$y-5}] 105               [expr {100+$y+5}] -fill grey  -outline black
.c create oval 395                95               405               105               -fill grey  -outline black
.c create oval [expr {400-$y-5}] 395               [expr {400-$y+5}] 405               -fill grey  -outline black

.c create text  90               [expr {100+$y}] -text "A" -anchor e
.c create text 400                90             -text "B" -anchor s
.c create text [expr {400-$y}]   410             -text "C" -anchor n


after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {4.2c 4.2c}]
    $pdf1 canvas .c -width 4.2c
    $pdf1 write -file triangle_largest.pdf
}


