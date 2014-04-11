proc state {} {
  global x
  global y
  global z
  global celldm
  global viewvmd
  set viewvmddir [pwd]
  while { ! [info exists viewvmd] && ! [string equal / $viewvmddir] } {
    set tmp [file join $viewvmddir view.vmd]
    if { [file exists $tmp] } {
      set viewvmd $tmp
      puts "Sourcing $tmp"
    } else {
      set viewvmddir [file dirname $viewvmddir]
    }
  }
  if { ! [info exists viewvmd] } {
    set viewvmd "view.vmd"
  }
  if { [file exists $viewvmd] } {
    catch { source $viewvmd }
  } else {
    #some default settings
    catch {color Name O pink}
    catch {color Name Ti white}
    catch {color Element Ti silver}
    catch {color Element Ni silver}
    catch {color Element Co silver}
    catch {color Element Al gray}
    foreach mid [molinfo list] {
      molinfo $mid set {
        center_matrix rotate_matrix scale_matrix global_matrix
      } {
        {{1 0 0 -5} {0 1 0 -6} {0 0 1 -6} {0 0 0 1}}
        {{1 0 0 0} {0 0 1 0} {0 -1 0 0} {0 0 0 1}}
        {{0.19 0 0 0} {0 0.19 0 0} {0 0 0.19 0} {0 0 0 1}}
        {{1 0 0 -0.04} {0 1 0 -0.16} {0 0 1 0} {0 0 0 1}}
      }
      mol delrep 0 $mid
      mol representation VDW 0.300000 18.000000
      mol color Element
      mol selection all
      mol addrep $mid
      mol representation DynamicBonds 2.300000 0.100000 16.000000
      mol color Element
      mol selection all and not name H
      mol addrep $mid
      mol representation DynamicBonds 1.100000 0.100000 16.000000
      mol color Element
      mol selection all
      mol addrep $mid
    }
  }
  user add key W {
    puts stdout "[tput cub 10][tput setaf 1]INFO) Saving the current view.";tput sgr0
    global representations
    global viewpoints
    save_viewpoint
    save_reps

    set fildes [open view.vmd w]

    puts $fildes "display resize [display get size]"

    if {[display get depthcue] == "on"} {
      puts $fildes "display depthcue on"
      puts $fildes "display cuestart [display get cuestart]"
      puts $fildes "display cueend [display get cueend]"
      puts $fildes "display cuedensity [display get cuedensity]"
      puts $fildes "display cuemode [display get cuemode]"
    }
    foreach i [material list] {
      foreach j [material settings $i] k {ambient specular diffuse shininess opacity outline outlinewidth transmode} {
        puts $fildes "material change $k $i $j"
      }
    }

    foreach mol [molinfo list] {
      puts $fildes "if {[lsearch [molinfo list] $mol] >= 0} {"
      # delete all representations
      puts $fildes "  set numrep [molinfo $mol get numreps]"
      puts $fildes "  for {set i 0} {\$i < \$numrep} {incr i} {"
      puts $fildes "    mol delrep \$i $mol"
      puts $fildes "  }"
      if [info exists representations($mol)] {
        set i 0
        foreach rep $representations($mol) {
          foreach {r s c m pbc numpbc on selupd colupd colminmax smooth framespec cplist} $rep { break }
          puts $fildes "  mol representation $r"
          puts $fildes "  mol color $c"
          puts $fildes "  mol selection {$s}"
          puts $fildes "  mol material $m"
          puts $fildes "  mol addrep $mol"
          puts $fildes "  mol showrep $mol $i $on"
          if {[string length $pbc]} {
            puts $fildes "  mol showperiodic top $i $pbc"
            puts $fildes "  mol numperiodic top $i $numpbc"
          }
          incr i
        }
      }
      puts $fildes "  molinfo $mol set {center_matrix rotate_matrix scale_matrix global_matrix} [list $viewpoints($mol)]"
      puts $fildes "}"
      puts $fildes "\# done with molecule $mol"
    }
    save_colors $fildes
    # save_labels $fildes
    if { [info exists celldm] } {
      puts $fildes "set x $x"
      puts $fildes "set y $y"
      puts $fildes "set z $z"
      puts $fildes "set celldm \"$celldm\""
      puts $fildes "pbc set \$celldm"
      puts $fildes "pbc box -shiftcenter \"\$x \$y \$z\""
      puts $fildes "pbc wrap -shiftcenter \"\$x \$y \$z\""
      puts $fildes "pbc box -off"
      # puts $fildes "cell"
    }
    close $fildes
    puts -nonewline ""
  }
}

