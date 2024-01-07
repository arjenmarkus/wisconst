# draw_squares_systematic.tcl --
#     Draw squares with a given tag -- systematic solution
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl
pack [canvas .c -width 778 -height 610]

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

# Six colours
if {1} {
drawSquares {
   { 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 }
   { 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 }
   { 1 2 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 2 1 }
   { 1 2 3 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 3 2 1 }
   { 1 2 3 4 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 4 3 2 1 }
   { 1 2 3 4 5 6 6 6 6 6 6 6 6 6 6 6 6 6 5 4 3 2 1 }
   { 1 2 3 4 5 6 1 1 1 1 1 1 1 1 1 1 1 6 5 4 3 2 1 }
   { 1 2 3 4 5 6 1 2 2 2 2 2 2 2 2 2 1 6 5 4 3 2 1 }
   { 1 2 3 4 5 6 1 2 3 3 3 3 3 3 3 2 1 6 5 4 3 2 1 }
   { 1 2 3 4 5 6 1 2 3 4 4 4 4 4 3 2 1 6 5 4 3 2 0 }
   { 1 2 3 4 5 6 1 2 3 4 5 5 5 4 3 2 1 6 5 4 3 0 0 }
   { 1 2 3 4 5 6 1 2 3 4 5 6 5 4 3 2 1 6 5 4 0 0 0 }
   { 1 2 3 4 5 6 6 6 6 6 6 6 5 4 3 2 1 6 5 0 0 0 0 }
   { 1 2 3 4 5 5 5 5 5 5 5 5 5 4 3 2 1 6 0 0 0 0 0 }
   { 1 2 3 4 4 4 4 4 4 4 4 4 4 4 3 2 1 0 0 0 0 0 0 }
   { 1 2 3 3 3 3 3 3 3 3 3 3 3 3 3 2 1 0 0 0 0 0 0 }
   { 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 0 0 0 0 0 0 }
   { 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 }
}
}

.c itemconfigure C1 -fill red
.c itemconfigure C2 -fill green
.c itemconfigure C3 -fill blue
.c itemconfigure C4 -fill yellow
.c itemconfigure C5 -fill magenta
.c itemconfigure C6 -fill orange

.c move all  30  30

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {3.5c 2.7c}]
    $pdf1 canvas .c -width 3.2c
    $pdf1 write -file systematic_spiralling.pdf
}

