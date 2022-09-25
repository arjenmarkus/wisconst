# triangle_sketch.tcl --
#     Draw a square and a triangle - various situations
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

pack [canvas .c -width 500 -height 500 -bg white]

.c create line 100 100 400 100 400 400 100 400 100 100 -width 3

.c create line 100 350 310 400 260 100 100 350

.c create oval  95 345 105 355 -fill grey  -outline black
.c create oval 305 395 315 405 -fill grey  -outline black
.c create oval 255  95 265 105 -fill grey  -outline black

.c create text  90 350 -text "A" -anchor e
.c create text 260  90 -text "B" -anchor s
.c create text 310 410 -text "C" -anchor n

.c create line  75 100  75 350 -arrow both
.c create line 100  70 260  70 -arrow both
.c create line 100 430 310 430 -arrow both

.c create text  65 230 -text "a" -anchor e
.c create text 180  70 -text "b" -anchor s
.c create text 205 435 -text "c" -anchor n

#.c create line 260 100 260 400 -dash -


after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {4.2c 4.2c}]
    $pdf1 canvas .c -width 4.2c
    $pdf1 write -file triangle_sketch.pdf
}


