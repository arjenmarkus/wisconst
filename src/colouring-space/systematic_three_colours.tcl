# systematic_three_colours.tcl --
#     Draw cubes with three colours in a systematic way
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

pack [canvas .c -width 350 -height 350]

source cubes.tcl

# Three colours
drawCubes {
   { { 1 0 0 0 0 }
     { 1 2 0 0 0 }
     { 1 2 3 0 0 }
     { 0 2 3 0 0 }
     { 0 0 3 0 0 } }

   { { 0 0 0 0 0 }
     { 0 0 0 0 0 }
     { 1 1 1 0 0 }
     { 0 2 2 2 0 }
     { 0 0 3 3 3 } }
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
    set pdf1 [::pdf4tcl::new %AUTO% -paper {3.5c 3.5c}]
    $pdf1 canvas .c -width 3.2c
    $pdf1 write -file systematic_three_colours.pdf
}


