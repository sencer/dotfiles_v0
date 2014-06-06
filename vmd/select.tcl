package provide VisualSelect

namespace eval ::VisualSelect {
  namespace export toggle update apply destroy push rotate
  variable active
  variable stack
  variable repids
  variable vselect
}

proc ::VisualSelect::toggle {} {
  variable active
  if {![info exists active] || $active == 0} {
    puts_red "Visual Selection mode enabled"
    set active 1
    variable stack
    if {![info exists stack]} {
      set stack {""}
    }
    trace add variable ::vmd_pick_event write VisualSelect::modify
    user add key Control-s {VisualSelect::rotate}
    user add key Alt-s {VisualSelect::push}
  } else {
    puts_red "Visual Selection mode disabled"
    set active 0
    trace remove variable ::vmd_pick_event write VisualSelect::modify
    destroy
  }
}

proc ::VisualSelect::modify {args} {
  global vmd_pick_atom
  global vmd_pick_mol
  # a list of the atoms included in the current vselect
  variable vselect
  # initialize
  if {![info exists vselect]} {
    set vselect {}
  }

  # if picked atom is already in the vselect
  # remove it, otherwise add.
  set check_exists [lsearch $vselect $vmd_pick_atom]
  if {$check_exists == -1} {
    lappend vselect $vmd_pick_atom
  } else {
    set vselect [lreplace $vselect $check_exists $check_exists]
  }
  apply $vmd_pick_mol
}

proc ::VisualSelect::apply {mol} {
  variable vselect
  # an array of the repid of the representation used to display vselect in
  # with molid as the array indices
  variable repids
  # if representation is created, just update the vselect
  # otherwise create the representation
  if {[info exists repids($mol)]} {
    if {[llength $vselect] == 0} {
      mol modselect $repids($mol) $mol "none"
    } else {
      mol modselect $repids($mol) $mol "index [join $vselect]"
    }
  } else {
    mol representation CPK 1.35 0.75
    mol color {ColorID 4}
    mol selection index [join $vselect]
    mol addrep $mol
    set repids($mol) [expr [molinfo $mol get numreps]-1]
  }

}

proc ::VisualSelect::destroy {} {
  variable repids
  variable vselect
  if {[info exists vselect]} {
    unset vselect
  }
  foreach {mol rep} [array get repids] {
    mol delrep $rep $mol
  }
  unset repids
}

proc ::VisualSelect::push {} {
  variable stack
  variable vselect
  lappend stack $vselect
}

proc ::VisualSelect::rotate {} {
  variable stack
  variable vselect
  global vmd_pick_mol
  set vselect [lindex $stack end]
  apply $vmd_pick_mol
  set stack [linsert $stack 0 $vselect]
  set stack [lreplace $stack end end]
}
