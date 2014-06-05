proc cell {molid} {
  global fname
  global x
  global y
  global z
  global pbcmol
  global celldm
  set pbcmol $molid
  if { ![info exists x] } {
    set x 0
    set y 0
    set z 0
  }
  if { ![info exists celldm] && [info exists fname] } {
    set file [open $fname r]
    while { [gets $file line] != -1 } {
      if {[lindex $line 0] == "CRYST1"} {
        set celldm [lrange $line 1 3]
        break
      }
    }
    close $file
    if { ![info exists celldm] } {
      puts "Enter Cell Dimensions (x y z):"
      flush stdout
      gets stdin celldm
    }
    pbc set $celldm -molid $pbcmol
  }
}
user add key u {
  pbc unwrap -molid $pbcmol -all
  set x 0
  set y 0
  set z 0
  pbc box -molid $pbcmol -shiftcenter "$x $y $z"
}
user add key o {pbc box -molid $pbcmol -toggle -shiftcenter "$x $y $z"}
user add key w { pbc wrap -molid $pbcmol -all }
user add key Right {
  set x [expr $x+0.1]
  pbc wrap -molid $pbcmol -all -shiftcenter "$x $y $z"
  pbc box -molid $pbcmol -shiftcenter "$x $y $z"
}
user add key Left {
  set x [expr $x-0.1]
  pbc wrap -molid $pbcmol -all -shiftcenter "$x $y $z"
  pbc box -molid $pbcmol -shiftcenter "$x $y $z"
}
user add key Home {
  set y [expr $y-0.1]
  pbc wrap -molid $pbcmol -all -shiftcenter "$x $y $z"
  pbc box -molid $pbcmol -shiftcenter "$x $y $z"
}
user add key End {
  set y [expr $y+0.1]
  pbc wrap -molid $pbcmol -all -shiftcenter "$x $y $z"
  pbc box -molid $pbcmol -shiftcenter "$x $y $z"
}
user add key Up {
  set z [expr $z+0.1]
  pbc wrap -molid $pbcmol -all -shiftcenter "$x $y $z"
  pbc box -molid $pbcmol -shiftcenter "$x $y $z"
}
user add key Down {
  set z [expr $z-0.1]
  pbc wrap -molid $pbcmol -all -shiftcenter "$x $y $z"
  pbc box -molid $pbcmol -shiftcenter "$x $y $z"
}
