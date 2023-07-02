# chkcorr.tcl --
#     Check the autocorrelation of a series of random numbers
#
package require math::statistics

set random {}
for {set i 0} {$i < 1000} {incr i} {
   lappend random [expr {rand()}]
}

puts [::math::statistics::autocorr $random]
