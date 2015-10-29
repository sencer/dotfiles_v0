package provide Rebond

# TODO extend to triclinic.

namespace eval ::Rebond {

  # this is actually half-width of the grid
  # like radius - but defining a cube
  variable width 1.2

  namespace eval len {
    variable OO 2.2 CC 2.2 NN 2.2 HH 1.0 CO 2.2 OC 2.2 CN 2.1 NC 2.1 \
             CH 1.3 HC 1.3 ON 1.9 NO 1.9 OH 1.3 HO 1.3 NH 1.3 HN 1.3
  }

}

proc ::Rebond::Index {x y z} {
  variable nx
  variable ny
  variable nz
  return [expr (($x)%$nx)*$ny*$nz+(($y)%$ny)*$nz+(($z)%$nz)]
}

proc ::Rebond::Initialize {sel} {
  return "Rebonds module initialized"
}

proc ::Rebond::InitGrid {} {
  variable width
  variable mid
  variable nx "[expr 1+int([lindex $mid 0]/$width)]"
  variable ny "[expr 1+int([lindex $mid 1]/$width)]" 
  variable nz "[expr 1+int([lindex $mid 2]/$width)]"
  variable nbins [expr [Index $nx-1 $ny-1 $nz-1]+1]
}

proc ::Rebond::CurrentFrame {sel {frame now}} {
  if {![info exists mid] || [$sel molid] ne $mid} {
    variable mid [$sel molid]
    variable names [$sel get name]
  }

  $sel frame $frame
  set tmp [vecscale 0.5 [molinfo top get {a b c alpha beta gamma} frame $frame]]

  if { $tmp ne $mid } {
    # cell size changed, update pbc and reinitialize grid
    set mid "$tmp"
    InitGrid
  }

  # reset bonds
  variable bonds
  set bonds [lrepeat [$sel num] {}]

  # $sel frame now
  variable coor [$sel get "x y z"]
  Rebond [Bin]
}

proc ::Rebond::Rebond {bins} {
  variable nbins
  variable ny
  variable nz

  for {set i 0} {$i < $nbins} {incr i} {
    set b1 [lindex $bins $i]
    if { [llength $b1] } {
      set x [expr $i/($ny*$nz)]
      set y [expr $i%($ny*$nz)/$nz]
      set z [expr $i%($ny*$nz)%$nz]
      DoBox $b1
      DoBoxes $b1 [lindex $bins [Index $x $y $z+1]]
      for {set j -1} {$j < 2} {incr j} {
        DoBoxes $b1 [lindex $bins [Index $x $y+1 $z+$j]]
        for {set k -1} {$k < 2} {incr k} {
          DoBoxes $b1 [lindex $bins [Index $x+1 $y+$k $z+$j]]
        }
      }
    }
  }
}

proc ::Rebond::DoBox {box} {
  set nat [llength $box]
  for {set i 0} {$i < $nat - 1} {incr i} {
    for {set j [expr $i+1]} {$j < $nat} {incr j} {
      DoAtoms [lindex $box $i] [lindex $box $j]
    }
  }
}

proc ::Rebond::DoBoxes {box1 box2} {
  if { [llength $box2] } {
    foreach atom $box1 {
      foreach other $box2 {
        DoAtoms $atom $other
      }
    }
  }
}

proc ::Rebond::DoAtoms {atom1 atom2} {
  variable bonds
  variable names
  if { $atom1 ne $atom2 && \
       [PDist $atom1 $atom2] < [set Rebond::len::[lindex $names $atom1][lindex $names $atom2]]} {
    lset bonds $atom1 "[lindex $bonds $atom1] $atom2"
    lset bonds $atom2 "[lindex $bonds $atom2] $atom1"
  }
}

proc ::Rebond::Bin {} {
  variable coor
  variable width
  variable nbins
  variable mid
  set bins [lrepeat $nbins {}]
  set cnt  0
  for {set i 0} {$i < 3} {incr i} {
    set m($i) [lindex $mid $i]
  }
  foreach xyz $coor {
    for {set i 0} {$i < 3} {incr i} {
      set c($i) [lindex $xyz $i]
      set c($i) [expr int((0.5*$c($i) - floor($c($i)/(2*$m($i)))*$m($i))/$width)]
    }
    set ind [Index $c(0) $c(1) $c(2)]

    lset bins $ind "[lindex $bins $ind] $cnt"
    incr cnt
  }
  return $bins
}

proc ::Rebond::PDist {c1 c2} {
  variable mid
  variable coor
  set v1 [lindex $coor $c1]
  set v2 [lindex $coor $c2]

  return [veclength "[expr [lindex $mid 0] - abs([lindex $mid 0] - abs([lindex $v1 0] - [lindex $v2 0]))] \
                     [expr [lindex $mid 1] - abs([lindex $mid 1] - abs([lindex $v1 1] - [lindex $v2 1]))] \
                     [expr [lindex $mid 2] - abs([lindex $mid 2] - abs([lindex $v1 2] - [lindex $v2 2]))]"]
}

proc ::Rebond::Fragments {sel} {
  variable bonds
  variable names
  set atoms [$sel list]

  set groups  ""
  set visited ""
  set toVisit ""

  foreach atom $atoms {
    if {[lsearch $visited $atom] == -1} {

      set subgroup $atom
      lappend visited $atom
      lappend toVisit {*}[lindex $bonds $atom]

      while {[llength $toVisit] > 0} {
        lappend subgroup [lindex $toVisit 0]
        lappend visited  [lindex $toVisit 0]
        set toVisit [lreplace $toVisit 0 0]
        lappend toVisit {*}[ldiff [lindex $bonds [lindex $subgroup end end]] "$visited $toVisit"]
      }
      lappend groups $subgroup
    }
  }
  return $groups
}

# Utility functions:

proc ldiff {a b} {
# returns the elements in list a that are not present in list b
  set diff {}
  foreach i $a {
    if {[lsearch -exact $b $i]==-1} {
      lappend diff $i
    }
  }
  return $diff
}

proc lcount {inlist} {
# count occurences of elements in a list of strings, return a list of "tuples"
  set species [lsort -uniq "$inlist"]
  set out {}
  foreach type $species {
    lappend out "$type [strcnt $inlist $type]"
  }
  return $out
}

proc strcnt {str char} {
# count the occurences of a string (char) in another (str). originally written
# for characters, so the bad naming of variables.
 return [expr {([string length " $str"]-[string length [string map "{ $char} {}" " $str"]])/[string length " $char"]}]
}

proc sel2chm {sel frag} {
# take a selection, and the corresponding fragments list from the proc fragment
# return the chemical composition of each fragment.

  set names [$sel get name]
  set formulas ""

  foreach ind $frag {
    set formula {}
    foreach i $ind {
      lappend formula [lindex $names $i]
    }
    lappend formulas [chm2txt [lcount [lsort $formula]]]
  }
  return $formulas
}

proc chm2txt {inp} {
# return a string of the given chemical composition
# inp is a list of of tuples like "{C 2} {O 1} {H 5}"
  set tmp ""
  foreach i $inp {
    set sp  [lindex $i 0]
    set num [lindex $i 1]
    set tmp "$tmp[expr ($num)?{$sp[expr ($num>1)?$num:{}]}:{}]"
  }
  return $tmp
}

proc rebond {{sel top} {frame now}} {
  if {$sel eq "top"} {
    set sel [atomselect top all]
  }
  Rebond::CurrentFrame $sel $frame
  global frags
  set frags [Rebond::Fragments $sel]
  return [lcount [sel2chm $sel $frags]]
}
