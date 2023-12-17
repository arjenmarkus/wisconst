# two_colours.tcl --
#     Draw cubes with two colours
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

pack [canvas .c -width 600 -height 250]

source cubes.tcl

# Two colours
drawCubes {
   { { 2 1 }
     { 1 1 } }
   { { 2 2 }
     { 2 1 } }
}

drawCubes {
   { { 4 3 }
     { 3 3 } }
   { { 4 4 }
     { 4 3 } }
}

.c itemconfigure C1 -fill white
.c itemconfigure C2 -fill grey
.c itemconfigure C3 -fill white
.c itemconfigure C4 -fill grey

.c move all  30  30
.c move C3  200   0
.c move C4  400   0


after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {6.5c 1.8c}]
    $pdf1 canvas .c -width 6.2c
    $pdf1 write -file two_colours.pdf
}


