proc addwater {solute mind} {

  # create a solvation box with the same size of cell
  set ratio 0.87
  set num [expr [lindex [molinfo list] end]+2]
  set max {}
  foreach r [molinfo $solute get {a b c}] {
    lappend max [expr $r/$ratio]
  }
  solvate -minmax "{0 0 0} [list $max]"

  # shrink it to set density ~1
  set sel [atomselect $num "name OH2"]
  foreach i [$sel get index] {
    set O [atomselect $num "index $i"]
    set water [atomselect $num "same fragment as index $i"]
    set vec {}
    foreach dir {x y z} {
      set r [$O get $dir]
      lappend vec [expr ($ratio-1)*$r]
    }
    $water moveby $vec
    $water delete
    $O delete
  }
  $sel delete

  set combined [TopoTools::mergemols "$solute $num"]
  molinfo $combined set {a b c alpha beta gamma} \
    [molinfo $solute get {a b c alpha beta gamma}]
  set sel [atomselect $solute all]
  atomselect macro solute "index < [$sel num]"
  $sel delete
  set sel [atomselect $combined \
    "not (same fragment as (exwithin $mind of solute))"]
  $sel writepdb "merged.pdb"
  $sel delete
  mol delete $num
  mol delete [expr $num+1]
  mol new "merged.pdb"
}
