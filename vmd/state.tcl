proc hier_search {f} {
  set dir [pwd]
  while { ![file exists $dir/$f] } {
    set tmp $dir
    set dir [file normalize $dir/..]
    if {[string equal $tmp $dir]} {
      return "view.vmd"
    }
  }
  return $dir/view.vmd
}

proc state {mid} {
  load_defaults $mid
}

proc save_view {} {

  puts_red "INFO) Saving the current view."

  global shift

  if {![info exists viewvmd]} {
    set viewvmd [hier_search view.vmd]
  }

  set fildes [open $viewvmd w]

  puts $fildes "display resize [display get size]"

  puts $fildes "proc state {molid} {"
  set cond " if"
  foreach mol [molinfo list] {
    puts $fildes " $cond { \$molid == $mol } {"
    set cond elseif
    puts $fildes "    set nrep \[molinfo \$molid get numreps\]"
    puts $fildes "    for {set i 0} {\$i < \$nrep} {incr i} {"
    puts $fildes "      mol delrep 0 \$molid"
    puts $fildes "    }"
    set nrep [molinfo $mol get numreps]
    for {set i 0} {$i < $nrep} {incr i} {
      puts $fildes "    mol representation [join [molinfo $mol get "{rep $i}"]]"
      puts $fildes "    mol color [join [molinfo $mol get "{color $i}"]]"
      puts $fildes "    mol selection [join [molinfo $mol get "{selection $i}"]]"
      puts $fildes "    mol material [join [molinfo $mol get "{material $i}"]]"
      puts $fildes "    mol addrep \$molid"

      set sp [mol showperiodic $mol $i]
      if {[string length $sp]} {
        puts $fildes "    mol showperiodic \$molid $i $sp"
        puts $fildes "    mol numperiodic \$molid $i [mol numperiodic $mol $i]"
      }

      if { ![mol showrep $mol $i] } {
        puts $fildes "    mol showrep \$molid $i 0"
      }
    }
    if {![molinfo $mol get drawn]} {
      puts $fildes "    molinfo \$molid set drawn 0"
    }
    if {![molinfo $mol get active]} {
      puts $fildes "    molinfo \$molid set active 0"
    }
    puts $fildes "    molinfo \$molid set center_matrix {[molinfo $mol get center_matrix]}"
    puts $fildes "    molinfo \$molid set rotate_matrix {[molinfo $mol get rotate_matrix]}"
    puts $fildes "    molinfo \$molid set scale_matrix {[molinfo $mol get scale_matrix]}"
    puts $fildes "    molinfo \$molid set global_matrix {[molinfo $mol get global_matrix]}"
    if {[molinfo $mol get fixed]} {
      puts $fildes "    molinfo \$molid set fixed 1"
    }
    if { [molinfo $mol get a] > 0} {
      puts $fildes "    pbc set [pbc get -now -molid $mol] -molid \$molid -all"
    }
    puts -nonewline $fildes "  }"
  }
  puts $fildes " else {"
  puts $fildes "    load_defaults \$molid"
  puts $fildes "  }"
  puts $fildes "  catch {mol top [molinfo top]}"
  puts $fildes "  global shift"
  puts $fildes "  array set shift {[array get shift]}"
  puts $fildes "  if { \[info exists shift(\$molid,0)\] } {"
  puts $fildes "    pbc box -molid \$molid -shiftcenter \"\$shift(\$molid,0) \$shift(\$molid,1) \$shift(\$molid,2)\" -off"
  puts $fildes "    pbc wrap -molid \$molid -shiftcenter \"\$shift(\$molid,0) \$shift(\$molid,1) \$shift(\$molid,2)\""
  puts $fildes "  }"

  puts $fildes "}"
  close $fildes
}

user add key W save_view

proc load_defaults {mid} {
    global fname
    set nrep [molinfo $mid get numreps]
    for {set i [expr $nrep-1]} {$i > -1} {incr i -1} {
      mol delrep $i $mid
    }
    mol representation VDW 0.300000 18.000000
    mol color Element
    mol selection all
    mol addrep $mid
    mol representation DynamicBonds 2.300000 0.100000 16.000000
    mol color Element
    mol selection not name H
    mol addrep $mid
    mol representation DynamicBonds 1.200000 0.100000 16.000000
    mol color Element
    mol selection all
    mol addrep $mid
    if {[string match "*.cube" $fname]} {
      mol representation Isosurface 0.01000 0 0 0 1 1
      mol color ColorID 0
      mol selection all
      mol material Opaque
      mol addrep 0
      mol representation Isosurface -0.01000 0 0 0 1 1
      mol color ColorID 4
      mol selection all
      mol material Opaque
      mol addrep 0
    }
    set shift($mid,0) 0
    set shift($mid,1) 0
    set shift($mid,2) 0
    display resetview
}
