# sphere_cube.tcl --
#     Draw the caps of a sphere included in a cube
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

pack [canvas .c -width 320 -height 320]

.c create rectangle  20 100 220 320 -fill lightgrey
.c create polygon   220 320 300 220 300  20 220 100 -fill lightgrey -outline black
.c create polygon    20 100 100  20 300  20 220 100 -fill lightgrey -outline black

.c create oval       20 100 220 320 -fill white
.c create polygon   120 113  27  60 200   8 293  60 -fill white -smooth 1 -outline black
.c create polygon   208 210 260  28 315 110 255 312 -fill white -smooth 1 -outline black

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {3.5c 3.5c}]
    $pdf1 canvas .c -width 3.2c
    $pdf1 write -file sphere_cube_sketch.pdf
}
