package provide VisualSelect

namespace eval ::VisualSelect {
  variable active 0
  variable stack {""}
  variable repid
  variable vselect {}
  variable rincr 15
  variable tincr 0.5
}

proc ::VisualSelect::Initialize {args} {
  trace add variable ::vsel write VisualSelect::Trace
  user add key v { VisualSelect::Toggle }
  user add key V { VisualSelect::Export }
  user add key Control-v {VisualSelect::RotateStack}
  user add key Control-m {puts [VisualSelect::TIncr [expr $VisualSelect::tincr- 0.5]]}
  user add key Control-i {puts [VisualSelect::TIncr [expr $VisualSelect::tincr+ 0.5]]}
  user add key Alt-m  {puts [VisualSelect::RIncr [expr $VisualSelect::rincr -2]]}
  user add key Alt-i  {puts [VisualSelect::RIncr [expr $VisualSelect::rincr +2]]}
}

proc ::VisualSelect::Toggle {} {
  variable active
  global vsel
  if {$active} {
    set active 0
    puts_red "Visual Selection mode disabled"
    trace remove variable ::vmd_pick_event write VisualSelect::Modify
    user add key Alt-v {puts "You need to be in VisualSelect mode"}
    user add key H {puts "You need to be in VisualSelect mode"}
    user add key J {puts "You need to be in VisualSelect mode"}
    user add key K {puts "You need to be in VisualSelect mode"}
    user add key L {puts "You need to be in VisualSelect mode"}
    user add key I {puts "You need to be in VisualSelect mode"}
    user add key M {puts "You need to be in VisualSelect mode"}
    user add key h {rotate y by -2}
    user add key j {rotate x by  2}
    user add key k {rotate x by -2}
    user add key l {rotate y by  2}
    user add key i {rotate z by  2}
    user add key m {rotate z by -2}
    Destroy
  } else {
    set active 1
    puts_red "Visual Selection mode enabled"
    trace add variable ::vmd_pick_event write VisualSelect::Modify
    user add key Alt-v {VisualSelect::Push}
    user add key h {VisualSelect::Rotate "y" -$VisualSelect::rincr}
    user add key j {VisualSelect::Rotate "x"  $VisualSelect::rincr}
    user add key k {VisualSelect::Rotate "x" -$VisualSelect::rincr}
    user add key l {VisualSelect::Rotate "y"  $VisualSelect::rincr}
    user add key m {VisualSelect::Rotate "z" -$VisualSelect::rincr}
    user add key i {VisualSelect::Rotate "z"  $VisualSelect::rincr}
    user add key H {VisualSelect::Translate "y"  $VisualSelect::tincr}
    user add key J {VisualSelect::Translate "x" -$VisualSelect::tincr}
    user add key K {VisualSelect::Translate "x"  $VisualSelect::tincr}
    user add key L {VisualSelect::Translate "y" -$VisualSelect::tincr}
    user add key I {VisualSelect::Translate "z"  $VisualSelect::tincr}
    user add key M {VisualSelect::Translate "z" -$VisualSelect::tincr}
    if {[info exists vsel]} {
      Trace
    } else {
      global vsel
      set vsel [atomselect top "none"]
      $vsel global
    }
    mouse mode pick
  }
}

proc ::VisualSelect::Modify {args} {
  global vmd_pick_atom
  variable vselect
  # if picked atom is already in the vselect remove it, otherwise add.
  set check_exists [lsearch $vselect $vmd_pick_atom]
  if {$check_exists == -1} {
    lappend vselect $vmd_pick_atom
  } else {
    set vselect [lreplace $vselect $check_exists $check_exists]
  }
  Export
}

proc ::VisualSelect::Apply {} {
  global vsel
  variable repid
  set mol [$vsel molid]
  if {[info exists repid]} {
    mol modselect $repid $mol [$vsel text]
  } else {
    mol representation CPK 1.35 0.75
    mol color {ColorID 4}
    mol selection [$vsel text]
    mol addrep $mol
    set repid [expr [molinfo $mol get numreps]-1]
  }
}

proc ::VisualSelect::Destroy {} {
  variable repid
  mol delrep $repid top
  unset repid
}

proc ::VisualSelect::Push {} {
  variable stack
  variable vselect
  lappend stack $vselect
}

proc ::VisualSelect::RotateStack {} {
  variable stack
  variable vselect
  variable active
  if {!$active} {
    Toggle
  }
  set vselect [lindex $stack end]
  set stack [linsert $stack 0 $vselect]
  set stack [lreplace $stack end end]
  Export
}

proc ::VisualSelect::Trace {args} {
  global vsel
  variable vselect
  variable active
  if {!$active} {
    Toggle
  }
  set vselect "[$vsel list]"
  Apply
}

proc ::VisualSelect::Rotate {{ axis "z" } { inc 2 }} {
  global vsel
  variable vselect
  set gc [GetCenter $vsel]
  $vsel moveby [vecscale -1 $gc]
  $vsel move [transaxis $axis $inc]
  $vsel moveby $gc
}

proc ::VisualSelect::Translate { {axis "z"} { inc 0.2 } } {
  global vsel
  variable vselect
  if {$axis == "x"} {
    set vec "$inc 0 0"
  } elseif {$axis == "y"} {
    set vec "0 $inc 0"
  } elseif {$axis == "z"} {
    set vec "0 0 $inc"
  }
  $vsel moveby $vec
}

proc ::VisualSelect::RIncr {num} {
  variable rincr
  set rincr $num
  return "Rotation angle set to $num degrees"
}

proc ::VisualSelect::TIncr {num} {
  variable tincr
  set tincr $num
  return "Translation quantum set to $num angstroms"
}

proc ::VisualSelect::Export {} {
  global vsel
  variable vselect
  if {[$vsel list] != [lsort vselect]} {
    set mol [$vsel molid]
    namespace inscope :: {$vsel delete}
    set sel [expr [llength $vselect]?"index [join $vselect]":"none"]
    set vsel [atomselect $mol $sel]
    $vsel global
  }
}
