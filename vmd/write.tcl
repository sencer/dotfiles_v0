proc savexyz {} {
  set sel [atomselect top "all"]
  set fildes [open pdb.xyz w]
  puts $fildex "autogenerated from pdb file"
  foreach c [$sel get {name x y z}] {
    puts $fildes [format "%2s %14.10f %14.10f %14.10f" [lindex $c 0] [lindex $c 1] [lindex $c 2] [lindex $c 3]]
  }
  close $fildes
  puts stdout "INFO) Saved pdb.xyz file."
}
