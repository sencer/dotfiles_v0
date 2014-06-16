proc savexyz {sel f} {
  global x
  global y
  global z
  set fildes [open $f w]
  puts $fildes [$sel num]
  puts $fildes "celldm [pbc get -now]"
  foreach c [$sel get {name x y z}] {
    puts $fildes [format "%-4s %14.10f %14.10f %14.10f" [lindex $c 0] [expr [lindex $c 1]-$x] [expr [lindex $c 2]-$y] [expr [lindex $c 3]-$z]]
  }
  close $fildes
  puts_red "INFO) Saved $f file."
}
