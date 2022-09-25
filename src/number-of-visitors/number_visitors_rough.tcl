# number_visitors_rough.tcl --
#     Draw the schematic graph illustrating visitors arriving and leaving
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

package require Plotchart

pack [canvas .c -width 700 -height 400]

set p [::Plotchart::createXYPlot .c {0 3.5 0.5} {0 12 2}]

set dt [expr {1.0/6.0}]

$p dataconfig sum -colour red -width 3

for {set i 0} {$i < 10} {incr i} {
    set xy [concat [::Plotchart::coordsToPixel .c [expr {$dt*$i}]     $i]            \
                   [::Plotchart::coordsToPixel .c [expr {$dt*$i+1.0}] [expr {$i+1}]] ]
    .c create rectangle $xy -fill lightgrey -outline black -tag box
    #.c create rectangle $xy                               -tag
}

set h    0
set next 1

for {set i 0} {$i < 20} {incr i} {
    if { $next } {
        $p plot sum [expr {$dt*$i}]     $h
    }

    $p plot sum [expr {$dt*$i}]     [expr {$h+1}]
    $p plot sum [expr {$dt*($i+1)}] [expr {$h+1}]

    if { $i < 5 } {
        set h [expr {$h + 1}]
        set next 1
    } else {
        set next 0
    }
    if { $i > 8 } {
        set h [expr {max(-1,$h - 1)}]
        set next 0
    }

}

.c lower box

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {7.5c 4.2c}]
    $pdf1 canvas .c -width 9.2c
    $pdf1 write -file number_visitors_rough.pdf
}

