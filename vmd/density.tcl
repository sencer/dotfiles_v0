proc density {{fname density.dat} {res 0.1} {st all} {molid top} {fi 0}} {

  if {$molid == "top"} {
    set molid [molinfo top]
  }

  set sel [atomselect top "$st"]
  set f [open $fname w]

  set z [molinfo top get c]
  set r [expr 1/$res]
  set n [expr int(ceil($z*$r))]
  set bins [lrepeat $n 0.0]
  lassign [lindex [pbc get -namd] 0] t1 t2 t3
  set A [expr [lindex $t1 0]*[lindex $t2 1]]
  set nf [molinfo top get numframes]

  for {set i $fi} {$i < $nf} {incr i} {
    $sel frame $i
    set L [vecscale [$sel get z] $r]
    set M [$sel get mass]
    foreach j $L m $M {
      set ind [expr int($j)%$n]

      lset bins $ind [expr [lindex $bins $ind]+$m]
    }
  }

  set r $r/$A/$nf*10/6.0221413

  for {set i 0} {$i < $n} {incr i} {
    puts $f [format "%9.5f %9.5f" [expr $i*$res]   \
      [expr [lindex $bins $i]*$r]]
  }

  close $f
  $sel delete

}
