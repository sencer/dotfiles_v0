proc puts_red {string} {
  puts stdout "\033\[31m$string\033\[0m"
}

proc inverse3 {matrix} {
  lassign $matrix row1 row2 row3
  set m [measure inverse "{$row1 0} {$row2 0} {$row3 0} {0 0 0 1}"]
  return "{[lrange [lindex $m 0] 0 2]} {[lrange [lindex $m 1] 0 2]} {[lrange [lindex $m 2] 0 2]}"
}

proc framedo {pr {molid top} args} {
  if {$molid == "top"} { set molid [molinfo top] }
  set nf [molinfo $molid get numframes]
  for {set i 0} {$i < $nf} {incr i} {
    animate goto $i
    $pr {*}$args
  }
}
