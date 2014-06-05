proc toggle_select_mode {} {
  global select_mode_active
  global sel_rep
  if {![info exists select_mode_active] || $select_mode_active == 0} {
    set select_mode_active 1
    trace add variable ::vmd_pick_event write add_to_selection
  } else {
    set select_mode_active 0
    trace add variable ::vmd_pick_event write add_to_selection
    destroy_selection
  }
}

proc add_to_selection {args} {
  global vmd_pick_mol
  global vmd_pick_atom
  global sel_rep
  global sel_curr
  if {![info exists sel_curr]} {
    set sel_curr {}
  }

  set check_exists [lsearch $sel_curr $vmd_pick_atom]
  if {$check_exists == -1} {
    lappend sel_curr $vmd_pick_atom
  } else {
    set sel_curr [lreplace $sel_curr $check_exists $check_exists]
  }

  if {[info exists sel_rep($vmd_pick_mol)]} {
      mol modselect $sel_rep($vmd_pick_mol) $vmd_pick_mol \
        "index [join $sel_curr]"
  } else {
    mol representation VDW 0.400000 18.000000
    mol color {ColorID 4}
    mol selection index $vmd_pick_atom
    mol addrep $vmd_pick_mol
    set sel_rep($vmd_pick_mol) [expr [molinfo $vmd_pick_mol get numreps]-1]
  }
}

proc destroy_selection {} {
  global sel_rep
  foreach {mol rep} [array get sel_rep] {
    mol delrep $rep $mol
  }
}
