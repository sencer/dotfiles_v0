proc savexyz {sel f} {
  global shift
  set fildes [open $f w]
  puts $fildes [$sel num]
  puts $fildes "celldm [lindex [pbc get -now] 0]"
  foreach c [$sel get {name x y z}] {
    puts $fildes [ \
      format "%-4s %14.10f %14.10f %14.10f" [lindex $c 0] \
      [expr [lindex $c 1]-$shift([$sel molid],0)] \
      [expr [lindex $c 2]-$shift([$sel molid],1)] \
      [expr [lindex $c 3]-$shift([$sel molid],2)] \
    ]
  }
  close $fildes
  puts_red "INFO) Saved $f file."
}
