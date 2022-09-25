# bounded.tcl --
#     Draw the bounded function with exponentially sized intervals
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

pack [canvas .c -width 950 -height 100 -bg white]

.c create line   0  60 950  60
.c create line  50   0  50 100

.c create text  45 15 -text 1 -anchor e
.c create line  45 15 50 15

set xscale [expr {900 / 9.0}]
foreach x {0 1 2 4 8} {
    set xt [expr {50 + $x * $xscale}]
    .c create text $xt 65 -text $x -anchor ne
    .c create line $xt 60 $xt 70
}

set xold 0
set y 0
foreach x {1 2 4 8} {
    set xt1 [expr {50 + $xold * $xscale}]
    set xt2 [expr {50 + $x    * $xscale}]

    if { $y == 0 } {
        .c create line $xt1 60 $xt2 60 -width 3
        .c create line $xt2 60 $xt2 15 -width 3
    } else {
        .c create line $xt1 15 $xt2 15 -width 3
        .c create line $xt2 15 $xt2 60 -width 3
    }

    set xold $x
    set y    [expr {1 - $y}]
}

.c create line $xt2 60 950 60 -width 3

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {9.5c 1.2c}]
    $pdf1 canvas .c -width 9.2c
    $pdf1 write -file bounded.pdf
}
