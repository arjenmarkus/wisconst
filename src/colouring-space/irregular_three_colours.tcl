# irregular_three_colours.tcl --
#     Draw cubes with three colours - irregular
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

pack [canvas .c -width 900 -height 250]

source cubes.tcl

# Three colours
drawCubes {
   { { 2 1 1 }
     { 3 3 1 }
     { 1 1 1 } }
   { { 2 3 1 }
     { 3 3 3 }
     { 2 3 1 } }
   { { 2 2 2 }
     { 2 3 3 }
     { 2 2 1 } }
}

drawCubes {
   { { 5 4 4 }
     { 6 6 4 }
     { 4 4 4 } }
   { { 5 6 4 }
     { 6 6 6 }
     { 5 6 4 } }
   { { 5 5 5 }
     { 5 6 6 }
     { 5 5 4 } }
}

.c itemconfigure C1 -fill red
.c itemconfigure C2 -fill green
.c itemconfigure C3 -fill blue
.c itemconfigure C4 -fill red
.c itemconfigure C5 -fill green
.c itemconfigure C6 -fill blue

.c move all  30  30
.c move C4  200   0
.c move C5  400   0
.c move C6  600   0

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {6.5c 1.8c}]
    $pdf1 canvas .c -width 6.2c
    $pdf1 write -file irregular_three_colours.pdf
}


