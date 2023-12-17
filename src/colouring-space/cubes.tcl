# cubes.tcl --
#     Procedures for drawing cubes with a given tag, using the painter's algorithm
#

# drawCube --
#     Draw a single cube in perspective
#
# Arguments:
#     code              Tag to use (actually: "C$code")
#     xstart            X-coordinate of lower left corner
#     ystart            Y-coordinate of lower left corner
#     side              Side of the cube
#
proc drawCube {code xstart ystart side} {

    .c create rectangle $xstart                    $ystart                    [expr {$xstart+$side}]     [expr {$ystart-$side}]        -tag C$code
    .c create polygon   [expr {$xstart+$side}]     $ystart                    [expr {$xstart+1.3*$side}] [expr {$ystart-0.3*$side}] \
                        [expr {$xstart+1.3*$side}] [expr {$ystart-1.3*$side}] [expr {$xstart+$side}]     [expr {$ystart-$side}]        -tag C$code -fill {} -outline black
    .c create polygon   $xstart                    [expr {$ystart-$side}]     [expr {$xstart+$side}]     [expr {$ystart-$side}] \
                        [expr {$xstart+1.3*$side}] [expr {$ystart-1.3*$side}] [expr {$xstart+0.3*$side}] [expr {$ystart-1.3*$side}]    -tag C$code -fill {} -outline black
}

# drawCubes --
#     Draw the cubes using a simple encoding
#
# Arguments:
#     encoding          Nested list encoding the cubes
#
# Note:
#     The argument defines the cubes to be drawn via planes.
#     Planes are given from front to back (and are drawn from
#     back to front. Each plane is a matrix with codes indicating
#     which cubes to draw, where a "0" means skip the cube at
#     that position.
#
proc drawCubes {encoding} {
    set side 50

    for {set i 0} {$i < [llength $encoding]} {incr i} {
        set plane [lindex $encoding end-$i]

        set xoffset [expr {0.3 * $side * ([llength $encoding] - $i)}]
        #set yoffset [expr {$side * ([llength $encoding] - $i)}]
        set yoffset [expr {-$xoffset}]

        for {set j 0} {$j < [llength $plane]} {incr j} {
            set row [lindex $plane end-$j]

            set ystart [expr {$yoffset + $side * ([llength $plane] - $j + 1)}]

            for {set k 0} {$k < [llength $row]} {incr k} {
                set code [lindex $row $k]

                set xstart [expr {$xoffset + $side * $k}]

                if { $code != "0" } {
                    puts "$code -- $xstart -- $ystart"
                    drawCube $code $xstart $ystart $side
                }
            }
        }
    }
}

