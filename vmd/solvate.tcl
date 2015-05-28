proc addwater {{solute top} {mind 2}} {
  if { $solute=="top" } then { set solute [ molinfo top ] }
  # create a solvation box with the same size of cell
  set ratio 0.92
  set max [vecscale [expr 1/$ratio] [molinfo $solute get {a b c}]]
  solvate -minmax "{0 0 0} [list $max]" -o auto_add_water_solvate
  foreach f [glob auto_add_water_solvate.*] { file delete $f }
  set num [expr [lindex [molinfo list] end]]
  # pbc set "$max [molinfo $solute get {alpha beta gamma}]" -molid $num

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
  # combine and remove overlapping
  set combined [TopoTools::mergemols "$solute $num"]
  molinfo $combined set {a b c alpha beta gamma} \
    [molinfo $solute get {a b c alpha beta gamma}]
  set sel [atomselect $solute all]
  set tmp [$sel num]
  atomselect macro solute "index < [$sel num]"
  $sel delete
  set sel [atomselect $combined \
    "not (same fragment as (exwithin $mind of solute))"]
  set tmp [expr [$sel num]-$tmp]
  $sel writepdb "merged.pdb"
  $sel delete
  mol delete $num
  mol delete [expr $num+1]
  mol new "merged.pdb" waitfor all
  return [expr $tmp/3]
}

proc hunwrap {{molid top} {rad 1}} {
  set H [atomselect top "name H"]
  $H set radius $rad
  if { $molid=="top" } then { set molid [ molinfo top ] }
  set cell {*}[pbc get -namd]
  set inv [inverse3 [transtranspose $cell]]
  foreach dir {0 1 0 2 0 1 0 2} {
    topo clearbonds
    mol bondsrecalc $molid
    set sel [atomselect $molid "name H and numbonds 0"]
    if {[$sel num] < 1} { break }
    $sel delete
    hswap $molid $dir $cell $inv
  }
  $H set radius 1.0
  $H delete
}

proc hswap {molid dir mat inv} {
  global shift
  set s "$shift($molid,0) $shift($molid,1) $shift($molid,2)"
  set sel [atomselect $molid "name H and numbonds 0"]
  foreach ind [$sel get index] pos [$sel get {x y z}] {
    set r [vecdot "[lindex $inv $dir]" [vecsub $pos $s]]
    set atom [atomselect $molid "index $ind"]
    # puts $r
    if {$r < 0.20} {
      $atom moveby [lindex $mat $dir]
    } elseif {$r > 0.80} {
      $atom moveby [vecscale -1 [lindex $mat $dir]]
    }
    $atom delete
  }
  $sel delete
}
