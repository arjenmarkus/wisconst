# integral_cap.tcl --
#     Illustrate the cap and the integral to determine the volume
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

pack [canvas .c -width 200 -height 200]

.c create arc   30  30 170 170 -start 315 -extent 90 -style chord -fill blue
.c create line  10 100 190 100
.c create line 100  10 100 190
.c create oval  30  30 170 170
.c create text 145 100 -text "1" -anchor ne
.c create text 175 100 -text "R" -anchor nw

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {3.5c 3.5c}]
    $pdf1 canvas .c -width 3.2c
    $pdf1 write -file integral_chord.pdf
}
