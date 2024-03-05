# graph.tcl ---
#     Plot the concentrations of conservative and decaying substances
#
#     Note:
#     For x > 3 the calculated age is very inaccurate due to numerical
#     problems.
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

package require Plotchart
package require math::special

pack [canvas .c -width 700 -height 500] [canvas .c2 -width 700 -height 500]
set p  [::Plotchart::createXYPlot .c  {0 3 0.5} {0. 1.01 0.2}]
set p2 [::Plotchart::createXYPlot .c2 {0 3 0.5} {0. 4.0 1.0}]

set disp  1.0
set decay 0.1

set k [expr {sqrt($decay/$disp)}]

$p dataconfig T1 -colour blue
$p dataconfig T2 -colour green
$p dataconfig T3 -colour red
$p dataconfig T4 -colour magenta

$p2 dataconfig T1 -colour blue
$p2 dataconfig T2 -colour green
$p2 dataconfig T3 -colour red
$p2 dataconfig T4 -colour magenta

$p dataconfig DT1 -colour blue
$p dataconfig DT2 -colour green
$p dataconfig DT3 -colour red
$p dataconfig DT4 -colour magenta

$p legendconfig -spacing 14
$p legend T1 "TIme = 0.1"
$p legend T2 "TIme = 0.3"
$p legend T3 "TIme = 1.0"
$p legend T4 "TIme = 3.0"

$p2 legendconfig -spacing 14
$p2 legend T1 "TIme = 0.1"
$p2 legend T2 "TIme = 0.3"
$p2 legend T3 "TIme = 1.0"
$p2 legend T4 "TIme = 3.0"

foreach {t tag} {0.1 T1 0.3 T2 1.0 T3 3.0 T4} {
    $p2 plot $tag 0.0 $t
    $p2 plot $tag 3.0 $t
    $p2 plot $tag {} {}


    set x 0.0
    while {$x < 3.01} {
        set c [::math::special::erfc [expr {$x/2.0/sqrt($disp*$t)}]]

        set d1 [::math::special::erf  [expr {(2.0*$k*$t - $x)/(2.0 * sqrt($t))}]]
        set d2 [::math::special::erfc [expr {(2.0*$k*$t + $x)/(2.0 * sqrt($t))}]]
        set d  [expr {0.5 * exp(-$k*$x) * ($d1 + exp(2.0*$k*$x) * $d2 + 1)}]

        set age [expr {log($c/$d) / $decay}]
        #puts "$d1/$d2 -- [expr {$d1/$d2}]"

        $p plot $tag  $x $c
        $p plot D$tag $x $d

        $p2 plot $tag $x $age

        set x [expr {$x + 0.1}]
    }
}

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {3.5c 2.5c}]
    $pdf1 canvas .c -width 3.2c
    $pdf1 write -file conservative_decaying.pdf

    set pdf2 [::pdf4tcl::new %AUTO% -paper {3.5c 2.5c}]
    $pdf2 canvas .c2 -width 3.2c
    $pdf2 write -file estimated_age.pdf
}

