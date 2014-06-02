proc savexyz {} {
  global x
  global y
  global z
  global celldm
  set sel [atomselect top "all"]
  set fildes [open vmd.xyz w]
  puts $fildes [$sel num]
  puts $fildes "CRYST1 $celldm"
  foreach c [$sel get {name x y z}] {
    puts $fildes [format "%2s %14.10f %14.10f %14.10f" [lindex $c 0] [expr [lindex $c 1]-$x] [expr [lindex $c 2]-$y] [expr [lindex $c 3]-$z]]
  }
  close $fildes
  puts_red "INFO) Saved vmd.xyz file."
}
