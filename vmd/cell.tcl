proc cell {} {
  global fname
  global x
  global y
  global z
  global celldm
  set x 0
  set y 0
  set z 0
  set mol [molinfo top]
  if { ![info exists celldm] } {
    set file [open $fname r]
    while { [gets $file line] != -1 } {
      if {[lindex $line 0] == "CRYST1"} {
        set celldm [lrange $line 1 3]
        break
      }
    }
    close $file
    puts "Enter Cell Dimensions (x y z):"
    flush stdout
    gets stdin celldm
    pbc set $celldm
  }
  user add key u {
    pbc unwrap -all
    set x 0
    set y 0
    set z 0
    pbc box -shiftcenter "$x $y $z" }  
  user add key o {pbc box -toggle -shiftcenter "$x $y $z"}  
  user add key w { pbc wrap -all }  
  user add key Right {
    set x [expr $x+0.1]
    pbc wrap -all -shiftcenter "$x $y $z"
    pbc box -shiftcenter "$x $y $z" }  
  user add key Left {
    set x [expr $x-0.1]
    pbc wrap -all -shiftcenter "$x $y $z"
    pbc box -shiftcenter "$x $y $z" }  
  user add key Page_Down {
    set y [expr $y-0.1]
    pbc wrap -all -shiftcenter "$x $y $z"
    pbc box -shiftcenter "$x $y $z" }  
  user add key Page_Up {
    set y [expr $y+0.1]
    pbc wrap -all -shiftcenter "$x $y $z"
    pbc box -shiftcenter "$x $y $z" }  
  user add key Up {
    set z [expr $z+0.1]
    pbc wrap -all -shiftcenter "$x $y $z"
    pbc box -shiftcenter "$x $y $z" }
  user add key Down {
    set z [expr $z-0.1]
    pbc wrap -all -shiftcenter "$x $y $z"
    pbc box -shiftcenter "$x $y $z" } }
