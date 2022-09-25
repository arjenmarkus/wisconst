# candidate_circle.tcl --
#     Draw a small set of points with circles to illustrate the "candidate" circle.
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

pack [canvas .c -width 500 -height 500 -bg white]


.c create arc  -50  50 350 450 -fill grey  -outline grey -start -60 -extent 120 -style chord

.c create arc  150  50 550 450 -fill grey  -outline grey -start 120 -extent 120 -style chord

.c create oval 150 150 350 350 -fill white -outline black

.c create oval [expr {150-5}] [expr {250-5}] [expr {150+5}] [expr {250+5}] -fill black
.c create oval [expr {350-5}] [expr {250-5}] [expr {350+5}] [expr {250+5}] -fill black

.c create oval [expr {225-5}] [expr {300-5}] [expr {225+5}] [expr {300+5}] -fill red
.c create oval [expr {265-5}] [expr {270-5}] [expr {265+5}] [expr {270+5}] -fill red
.c create oval [expr {167-5}] [expr {255-5}] [expr {167+5}] [expr {255+5}] -fill red


after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {4.2c 4.2c}]
    $pdf1 canvas .c -width 4.2c
    $pdf1 write -file candidate_circle.pdf
}


