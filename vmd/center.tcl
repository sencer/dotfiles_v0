proc GetCenter {selection} {
  set gc [veczero]
  foreach coord [$selection get {x y z}] {
    set gc [vecadd $gc $coord]
  }
  return [vecscale [expr 1.0 /[$selection num]] $gc]
}

proc GetMassCenter {selection} {
  if {[$selection num] <= 0} {
    set selection [atomselect top "all"]
  }
  set com [veczero]
  set mass 0
  foreach coord [$selection get {x y z}] m [$selection get mass] {
    set mass [expr $mass + $m]
    set com [vecadd $com [vecscale $m $coord]]
  }
  if {$mass == 0} {
    error "center_of_mass: total mass is zero"
  }
  return [vecscale [expr 1.0/$mass] $com]
}

proc CenterAtom {at {center "none"} {molid top}} {
  # Fix atom with index $at of mol $molid at $center through out the
  # simulation. $center is the center of unit cell by default.
  global shift
  if {$center == "none"} {
    set center [vecscale [vecadd {*}[lrange {*}[pbc get -namd] 0 2]] 0.5]
  }
  set all [atomselect top all]
  set atom [atomselect top "index $at"]
  set nf [molinfo $molid get numframes]
  for {set i 0} {$i <= $nf} {incr i} {
    animate goto $i
    set r [lindex [$atom get {x y z}] 0]
    $all moveby [vecsub $center $r]
    pbc wrap  -shiftcenter "$shift(0,0) $shift(0,1) $shift(0,2)"
    hunwrap
  }
  pbc box -shiftcenter "$shift(0,0) $shift(0,1) $shift(0,2)"
}
