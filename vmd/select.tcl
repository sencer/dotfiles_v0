package provide VisualSelect

namespace eval ::VisualSelect {
  variable active
  variable stack
  variable repids
  variable vselect
  variable rincr 15
  variable tincr 0.5
}

proc ::VisualSelect::Initialize {args} {
  variable active 0
  variable stack {""}
  variable repids
  variable vselect {}
  trace add variable ::vsel write VisualSelect::Trace
  user add key v { VisualSelect::Toggle }
  user add key Control-v {VisualSelect::RotateStack}
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
    }
    mouse mode pick
  }
}

proc ::VisualSelect::Modify {args} {
  global vmd_pick_atom
  global vmd_pick_mol
  variable vselect

  # if picked atom is already in the vselect
  # remove it, otherwise add.
  set check_exists [lsearch $vselect $vmd_pick_atom]
  if {$check_exists == -1} {
    lappend vselect $vmd_pick_atom
  } else {
    set vselect [lreplace $vselect $check_exists $check_exists]
  }
  Apply $vmd_pick_mol
}

proc ::VisualSelect::Apply {mol} {
  variable vselect
  # an array of the repid of the representation used to display vselect in
  # with molid as the array indices
  variable repids
  # if representation is created, just update the vselect
  # otherwise create the representation
  set sel [expr [llength $vselect]?"index [join $vselect]":"none"]
  if {[info exists repids($mol)]} {
    mol modselect $repids($mol) $mol $sel
  } else {
    mol representation CPK 1.35 0.75
    mol color {ColorID 4}
    mol selection $sel
    mol addrep $mol
    set repids($mol) [expr [molinfo $mol get numreps]-1]
  }
}

proc ::VisualSelect::Destroy {} {
  variable repids
  variable vselect
  set vselect {}
  foreach {mol rep} [array get repids] {
    mol delrep $rep $mol
    unset repids($mol)
  }
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
  Apply 0
  set stack [linsert $stack 0 $vselect]
  set stack [lreplace $stack end end]
}

proc ::VisualSelect::Trace {args} {
  global vsel
  variable vselect
  variable active
  if {!$active} {
    Toggle
  }
  set vselect "[$vsel list]"
  Apply [$vsel molid]
}

proc ::VisualSelect::Rotate {{ axis "z" } { inc 2 }} {
  global vsel
  set gc [geom_center $vsel]
  $vsel moveby [vecscale -1 $gc]
  $vsel move [transaxis $axis $inc]
  $vsel moveby $gc
}

proc ::VisualSelect::Translate { {axis "z"} { inc 0.2 } } {
  global vsel
  if {$axis == "x"} {
    set vec "$inc 0 0"
  } elseif {$axis == "y"} {
    set vec "0 $inc 0"
  } elseif {$axis == "z"} {
    set vec "0 0 $inc"
  }
  $vsel moveby $vec
}
