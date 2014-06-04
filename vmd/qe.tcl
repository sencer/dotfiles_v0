proc qe_input {f} {
  global env
  global fname
  if {[file exists $f]} {
    set fname /tmp/vmd_auto.xyz
    exec $env(HOME)/bin/in2xyz $f > $fname
    mol load xyz $fname
  }
}

proc qe_output {f} {
  global env
  global fname
  if {[file exists $f]} {
    set fname /tmp/vmd_auto.pdb
    exec $env(HOME)/bin/pt $f > $fname
    mol load pdb $fname
  }

}
