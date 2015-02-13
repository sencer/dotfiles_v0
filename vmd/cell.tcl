proc cell {molid} {
  global fname
  global x
  global y
  global z
  if { ![info exists x] } {
    set x($molid) 0
    set y($molid) 0
    set z($molid) 0
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

user add key u {
  pbc unwrap -all
  set x($pbcmol) 0
  set y($pbcmol) 0
  set z($pbcmol) 0
  pbc box -shiftcenter "$x($pbcmol) $y($pbcmol) $z($pbcmol)"
}
user add key o {pbc box -toggle -shiftcenter "$x($pbcmol) $y($pbcmol) $z($pbcmol)"}
user add key w { pbc wrap -all }
user add key Right {
  set x($pbcmol) [expr $x($pbcmol)+0.1]
  pbc wrap -all -shiftcenter "$x($pbcmol) $y($pbcmol) $z($pbcmol)"
  pbc box -shiftcenter "$x($pbcmol) $y($pbcmol) $z($pbcmol)"
}
user add key Left {
  set x($pbcmol) [expr $x($pbcmol)-0.1]
  pbc wrap -all -shiftcenter "$x($pbcmol) $y($pbcmol) $z($pbcmol)"
  pbc box -shiftcenter "$x($pbcmol) $y($pbcmol) $z($pbcmol)"
}
user add key Home {
  set y($pbcmol) [expr $y($pbcmol)-0.1]
  pbc wrap -all -shiftcenter "$x($pbcmol) $y($pbcmol) $z($pbcmol)"
  pbc box -shiftcenter "$x($pbcmol) $y($pbcmol) $z($pbcmol)"
}
user add key End {
  set y($pbcmol) [expr $y($pbcmol)+0.1]
  pbc wrap -all -shiftcenter "$x($pbcmol) $y($pbcmol) $z($pbcmol)"
  pbc box -shiftcenter "$x($pbcmol) $y($pbcmol) $z($pbcmol)"
}
user add key Up {
  set z($pbcmol) [expr $z($pbcmol)+0.1]
  pbc wrap -all -shiftcenter "$x($pbcmol) $y($pbcmol) $z($pbcmol)"
  pbc box -shiftcenter "$x($pbcmol) $y($pbcmol) $z($pbcmol)"
}
user add key Down {
  set z($pbcmol) [expr $z($pbcmol)-0.1]
  pbc wrap -all -shiftcenter "$x($pbcmol) $y($pbcmol) $z($pbcmol)"
  pbc box -shiftcenter "$x($pbcmol) $y($pbcmol) $z($pbcmol)"
}
