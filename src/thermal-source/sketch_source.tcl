# sketch_source.tcl --
#     Sketch of a radial thermal source
#
lappend auto_path d:/tcl-programs/pdf4tcl-head/pdf4tcl
package require pdf4tcl

pack [canvas .c -width 250 -height 150]

.c create rectangle 50 25 150 125 -width 2 -fill lightgrey -dash "."
.c create line 110  75 130  75 -arrow last
.c create line  90  75  70  75 -arrow last
.c create line 100  65 100  45 -arrow last
.c create line 100  85 100 105 -arrow last

.c create line [expr {100+7}] [expr {75+7}] [expr {100+7+14}] [expr {75+7+14}] -arrow last
.c create line [expr {100-7}] [expr {75+7}] [expr {100-7-14}] [expr {75+7+14}] -arrow last
.c create line [expr {100-7}] [expr {75-7}] [expr {100-7-14}] [expr {75-7-14}] -arrow last
.c create line [expr {100+7}] [expr {75-7}] [expr {100+7+14}] [expr {75-7-14}] -arrow last

.c create line  -10  10  40  10 -arrow last
.c create line  -10  30  40  30 -arrow last
.c create line  -10  50  40  50 -arrow last
.c create line  -10  70  40  70 -arrow last
.c create line  -10  90  40  90 -arrow last
.c create line  -10 110  40 110 -arrow last
.c create line  -10 130  40 130 -arrow last

.c create line  160  10 210  10 -arrow last
.c create line  160  30 210  30 -arrow last
.c create line  160  50 210  50 -arrow last
.c create line  160  70 210  70 -arrow last
.c create line  160  90 210  90 -arrow last
.c create line  160 110 210 110 -arrow last
.c create line  160 130 210 130 -arrow last

.c move all 25 0

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {13.5c 8.0c}]
    $pdf1 canvas .c -width 13.0c
    $pdf1 write -file sketch_source.pdf
}


