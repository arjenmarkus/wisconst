# plot_cart.tcl --
#     Plot the concentrations as function of time
#     for the simple CART problem
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl
package require Plotchart
package require math::calculus

pack [canvas .c -width 700 -height 500]
set p [::Plotchart::createXYPlot .c {0 1.25 0.2} {0 1.20 0.25}]

$p legendconfig -spacing 14 -position top-left

foreach t {0.1 0.2 0.4 0.6 0.8 1.0} colour {black blue lime red magenta cyan} {
    $p dataconfig $colour -colour $colour
    $p legend $colour "t = $t"

    $p plot $colour 0.0  0.0
    $p plot $colour $t   $t
    $p plot $colour 1.25 $t
}

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {9.5c 6.2c}]
    $pdf1 canvas .c -width 9.2c
    $pdf1 write -file cart_channel.pdf
}
