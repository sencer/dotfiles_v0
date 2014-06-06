proc geom_center {selection} {
  set gc [veczero]
  foreach coord [$selection get {x y z}] {
    set gc [vecadd $gc $coord]
  }
  return [vecscale [expr 1.0 /[$selection num]] $gc]
}

proc mass_center {selection} {
  if {[$selection num] <= 0} {
    error "center_of_mass: needs a selection with atoms"
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