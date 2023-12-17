# network_two_colours.tcl --
#     Draw cubes with two colours
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

pack [canvas .c -width 700 -height 350]

source cubes.tcl

# Two colours
drawCubes {
   { { 0 0  0 0  0 0  0 0  0 0  0 0 }
     { 0 1  0 1  0 1  0 1  0 1  0 1 }
     { 0 0  0 0  0 0  0 0  0 0  0 0 }
     { 0 1  0 1  0 1  0 1  0 1  0 1 } }
   { { 0 1  0 1  0 1  0 1  0 1  0 1 }
     { 1 1  1 1  1 1  1 1  1 1  1 1 }
     { 0 1  0 1  0 1  0 1  0 1  0 1 }
     { 1 1  1 1  1 1  1 1  1 1  1 1 } }
   { { 0 0  0 0  0 0  0 0  0 0  0 0 }
     { 0 1  0 1  0 1  0 1  0 1  0 1 }
     { 0 0  0 0  0 0  0 0  0 0  0 0 }
     { 0 1  0 1  0 1  0 1  0 1  0 1 } }
}

.c itemconfigure C1 -fill white
.c itemconfigure C2 -fill grey

.c move all  30  30

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {7.5c 3.0c}]
    $pdf1 canvas .c -width 7.2c
    $pdf1 write -file network_two_colours.pdf
}


