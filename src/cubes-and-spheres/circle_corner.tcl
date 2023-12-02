# circle_corner.tcl --
#     Draw a corner - circle and square - to illustrate the integral
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

pack [canvas .c -width 160 -height 160]

.c create line  20 120 140 120
.c create line  20   0  20 120
.c create arc  -80  20 120 220
.c create line  20  40 100  40 100 120
.c create line  20 120  80  40  80 120 -fill grey -dash -

.c create text 100 130 -text 1 -anchor n
.c create text 120 130 -text R -anchor n
.c create text  80 130 -text z -anchor n

# centre: 20, 120
# R = 100, xi = sqrt(R**2 - 1**2) = sqrt(10000 - 6400) = sqrt(3600) = 60
# "1" = 80

if {0} {
.c create text       25  25 -text "A" -font "Helvetica 14"
.c create rectangle  50  50 150 150 -fill blue
.c create oval       50  50 150 150 -fill lime -outline black

set radius [expr {50 * sqrt(2)}]

.c create text       225  25 -text "B" -font "Helvetica 14"
.c create oval       [expr {300-$radius}] [expr {100-$radius}] [expr {300+$radius}] [expr {100+$radius}] -fill lime
.c create rectangle  250  50 350 150 -fill blue -outline black
}

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {3.5c 3.5c}]
    $pdf1 canvas .c -width 3.2c
    $pdf1 write -file circle_corner_sketch.pdf
}
