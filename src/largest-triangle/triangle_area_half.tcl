# triangle_area_half.tcl --
#     Draw a square and a triangle - various situations
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

pack [canvas .c -width 500 -height 500 -bg white]


.c create line 100 350 400 100 400 400 100 350 -fill red
.c create line 100 200 400 100 400 400 100 200 -fill blue

.c create line 100 100 400 100 400 400 100 400 100 100 -width 3

.c create oval  95 345 105 355 -fill grey  -outline black
.c create oval  95 195 105 205 -fill grey  -outline black
.c create oval 395  95 405 105 -fill grey  -outline black
.c create oval 395 395 405 405 -fill grey  -outline black

.c create text  90 350 -text "A1" -anchor e
.c create text  90 200 -text "A2" -anchor e
.c create text 400  90 -text "B" -anchor s
.c create text 400 410 -text "C" -anchor n

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {4.2c 4.2c}]
    $pdf1 canvas .c -width 4.2c
    $pdf1 write -file triangle_area_half.pdf
}


