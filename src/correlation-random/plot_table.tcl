# plot_table.tcl --
#     Plot the contents of the table
#
lappend auto_path d:/tcl-programs/pdf4tcl-head
package require pdf4tcl

package require Plotchart

#N	<0.2	<0.5	<0.7	<0.9	<1.0	>=1.0
set data {
3	139	226	155	220	260	0
4	212	292	198	197	101	0
5	265	336	208	149	42	0
6	323	366	188	112	11	0
7	334	395	190	68	13	0
8	350	432	167	48	3	0
9	395	429	130	45	1	0
10	438	433	102	27	0	0
11	450	435	99	16	0	0
12	471	422	94	13	0	0
13	513	405	75	7	0	0
14	511	417	67	5	0	0
15	529	412	56	3	0	0
16	527	423	48	2	0	0
17	544	422	31	3	0	0
18	588	370	41	1	0	0
19	588	388	24	0	0	0
20	617	360	23	0	0	0
}


pack [canvas .c -width 700 -height 500]
set p  [::Plotchart::createXYPlot .c {0 21 5} {0 700 100}]

$p dataconfig p2  -type both -symbol up      -colour black
$p dataconfig p5  -type both -symbol down    -colour lime
$p dataconfig p7  -type both -symbol plus    -colour orange
$p dataconfig p9  -type both -symbol cross   -colour red
$p dataconfig p10 -type both -symbol circle  -colour magenta

$p legendconfig -spacing 12 -position top-left
$p legend p2 "< 0.2"
$p legend p5 "0.2 - 0.5"
$p legend p7 "0.5 - 0.7"
$p legend p9 "0.7 - 0.9"
$p legend p10 "> 0.9"

foreach {n p2 p5 p7 p9 p10 dummy} $data {
    $p plot p2 $n $p2
    $p plot p5 $n $p5
    $p plot p7 $n $p7
    $p plot p9 $n $p9
    $p plot p10 $n $p10
}

after 1000 {
    set pdf1 [::pdf4tcl::new %AUTO% -paper {7.5c 5.5c}]
    $pdf1 canvas .c -width 7.2c
    $pdf1 write -file effect_set_size.pdf
}
