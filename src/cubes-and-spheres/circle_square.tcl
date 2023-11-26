# circle_square.tcl --
#     Draw a circle (disk) and a (filled square) - different sizes
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

pack [canvas .c -width 400 -height 200]

.c create text       25  25 -text "A" -font "Helvetica 14"
.c create rectangle  50  50 150 150 -fill blue
.c create oval       50  50 150 150 -fill lime -outline black

set radius [expr {50 * sqrt(2)}]

.c create text       225  25 -text "B" -font "Helvetica 14"
.c create oval       [expr {300-$radius}] [expr {100-$radius}] [expr {300+$radius}] [expr {100+$radius}] -fill lime
.c create rectangle  250  50 350 150 -fill blue -outline black

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {3.5c 1.75c}]
    $pdf1 canvas .c -width 3.2c
    $pdf1 write -file circle_square_sketch.pdf
}
