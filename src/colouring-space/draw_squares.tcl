# draw_squares.tcl --
#     Draw squares with a given tag
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl
pack [canvas .c -width 950 -height 400]

# drawSquare --
#     Draw a single square (noting complicated)
#
# Arguments:
#     code              Tag to use (actually: "C$code")
#     xstart            X-coordinate of lower left corner
#     ystart            Y-coordinate of lower left corner
#     side              Side of the cube
#
proc drawSquare {code xstart ystart side} {

    .c create rectangle $xstart                    $ystart                    [expr {$xstart+$side}]     [expr {$ystart-$side}]        -tag C$code
}

# drawSquares --
#     Draw the squares using a simple encoding
#
# Arguments:
#     encoding          Nested list encoding the squares
#
proc drawSquares {encoding} {
    set side 30

    for {set i 0} {$i < [llength $encoding]} {incr i} {
        set row [lindex $encoding end-$i]

        set ystart [expr {$side * ([llength $encoding] - $i)}]

        for {set j 0} {$j < [llength $row]} {incr j} {
            set code   [lindex $row $j]
            set xstart [expr {$side * $j}]
            if { $code ne "0" } {
                drawSquare $code $xstart $ystart $side
            }
        }
    }
}

# Two colours
if {1} {
drawSquares {
   { 0 0 0 0 0 1 1 1 }
   { 2 2 2 2 2 2 2 1 }
   { 2 1 1 1 1 1 2 1 }
   { 2 1 2 2 2 1 2 1 }
   { 2 1 2 1 2 1 2 1 }
   { 2 1 2 1 1 1 2 1 }
   { 2 1 2 2 2 2 2 1 }
   { 2 1 1 1 1 1 1 1 }
   { 2 2 2 2 0 0 0 0 }
}
}

# Three colours
if {1} {
drawSquares {
   { 0 0 0 0 5 5 5 5 }
   { 0 0 0 3 3 3 3 5 }
   { 0 0 4 4 4 4 3 5 }
   { 5 5 5 5 5 4 3 5 }
   { 5 3 3 3 5 4 3 5 }
   { 5 3 4 5 5 4 3 5 }
   { 5 3 4 4 4 4 3 5 }
   { 5 3 3 3 3 3 3 5 }
   { 5 5 5 5 5 5 5 5 }
}
}

# Four colours
if {1} {
drawSquares {
   { 0 0 0 0 0 9 9 9 9 9 }
   { 0 0 0 0 7 7 7 7 7 9 }
   { 0 0 0 8 8 8 8 8 7 9 }
   { 0 0 6 6 6 6 6 8 7 9 }
   { 9 9 9 9 9 9 6 8 7 9 }
   { 9 7 7 7 7 9 6 8 7 9 }
   { 9 7 8 8 7 9 6 8 7 9 }
   { 9 7 8 6 9 9 6 8 7 9 }
   { 9 7 8 6 6 6 6 8 7 9 }
   { 9 7 8 8 8 8 8 8 7 9 }
   { 9 7 7 7 7 7 7 7 7 9 }
   { 9 9 9 9 9 9 9 9 9 9 }
}
}

.c itemconfigure C1 -fill red
.c itemconfigure C2 -fill green

.c itemconfigure C3 -fill red
.c itemconfigure C4 -fill green
.c itemconfigure C5 -fill blue

.c itemconfigure C6 -fill red
.c itemconfigure C7 -fill green
.c itemconfigure C8 -fill blue
.c itemconfigure C9 -fill yellow

.c move all  30  30
.c move C3  300   0
.c move C4  300   0
.c move C5  300   0
.c move C6  600   0
.c move C7  600   0
.c move C8  600   0
.c move C9  600   0


after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {3.5c 1.5c}]
    $pdf1 canvas .c -width 3.2c
    $pdf1 write -file squares_spiralling.pdf
}

