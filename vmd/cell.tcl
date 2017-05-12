proc cell {molid} {
  global fname
  global shift
  if { ![info exists shift($molid,0)] } {
    array set shift "[array get shift] [list $molid,0 0 $molid,1 0 $molid,2 0]"
  }
  if { [molinfo $molid get a] == 0.0 && [info exists fname] } {
    set file [open $fname r]
    while { [gets $file line] != -1 } {
      if {[lindex $line 0] == "celldm"} {
        pbc set [lrange $line 1 end] -molid $molid -all
        break
      }
    }
    close $file
  }
}

proc shift_cell {dir p} {
  global shift
  set t [molinfo top]
  set shift($t,$dir) [expr $shift($t,$dir)+$p*0.1]
  pbc wrap -all -shiftcenter "$shift($t,0) $shift($t,1) $shift($t,2)"
  pbc box -shiftcenter "$shift($t,0) $shift($t,1) $shift($t,2)"
}

proc pbc_dist {sel1 {sel2 -1}} {

  if {$sel2 == -1} {
    set dr [vecsub {*}[$sel1 get {x y z}]]
  } else {
    set dr [vecsub {*}[$sel1 get {x y z}] {*}[$sel2 get {x y z}]]
  }
  
  set pbc [vecscale 0.5 [molinfo top get {a b c}]]

  set dist 0
  foreach dx $dr len $pbc {
    set dx [expr abs($dx)]
    if { $dx > $len } {
      set dx [expr 2*$len-$dx]
    }
    set dist [expr $dist+$dx*$dx]
  }
  return [expr sqrt($dist)]
}

user add key u {
  set t [molinfo top]
  pbc unwrap -all
  array set shift [list $t,0 0 $t,1 0 $t,2 0]
  pbc box -shiftcenter "$shift($t,0) $shift($t,1) $shift($t,2)"
}

user add key o {
  set t [molinfo top]
  pbc box -toggle -shiftcenter "$shift($t,0) $shift($t,1) $shift($t,2)"
}
user add key w { pbc wrap -all }

user add key Right { shift_cell 0  1 }
user add key Left  { shift_cell 0 -1 }
user add key Home  { shift_cell 1 -1 }
user add key End   { shift_cell 1  1 }
user add key Up    { shift_cell 2  1 }
user add key Down  { shift_cell 2 -1 }
