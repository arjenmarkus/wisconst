# river_sketch.tcl --
#     Sketch of the river being monitored
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

pack [canvas .c -width 900 -height 300 -bg white]

.c create polygon {  0   0   0  50   0  50  200 180  500  50  900 180  900 180  900   0  900   0   0   0   0   0} -fill lightgrey -smooth 1
.c create polygon {  0 300   0 150   0 150  200 280  500 150  900 280  900 280  900 300  900 300   0 300   0 300} -fill lightgrey -smooth 1

.c create line 100  30 100 130 -width 10 -arrow last
.c create text 120  80 -text "Discharge" -anchor w

.c create line  80 155 120 175 -arrow last
.c create line 180 195 220 195 -arrow last
.c create line 280 185 320 175 -arrow last
.c create line 380 160 420 150 -arrow last
.c create line 480 135 520 135 -arrow last
.c create line 580 135 620 145 -arrow last
.c create line 680 155 720 165 -arrow last
.c create line 780 185 820 195 -arrow last

.c create line 700 140 750 100 -arrow last -dash "--" -width 2
.c create oval 670 110 730 170
.c create text 720  90 -text "Monitoring" -anchor se
.c create line 760 120 760  20 -width 2
.c create line 760 120 860 120 -width 2

.c create line 760 100 810  80 830 70 840  90 860  45 -smooth 1 -width 2
.c create line 760  60 860  60 -fill red -width 2


after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {12.5c 4.0c}]
    $pdf1 canvas .c -width 12.2c
    $pdf1 write -file river_sketch.pdf
}
