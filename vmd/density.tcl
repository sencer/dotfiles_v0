proc density {{fname density.dat} {res 0.1} {st all} {molid top}} {

  if {$molid == "top"} {
    set molid [molinfo top]
  }

  set sel [atomselect top "$st"]
  set f [open $fname w]

  set z [molinfo top get c]
  set r [expr 1/$res]
  set n [expr int(ceil($z*$r))]
  set bins [lrepeat $n 0.0]
  set A [expr [join [molinfo top get {a b}] "*"]]
  set nf [molinfo top get numframes]

  for {set i 0} {$i < $nf} {incr i} {
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
