#
# vmd draw extension procedures
# 
# version 1.0
# Copyright (c) 2006 Axel Kohlmeyer <akohlmey@cmm.chem.upenn.edu>
#
########################################################################
# replace the default 'draw delete' with a version that
# can handle multiple arguments (which may even be lists).
proc vmd_draw_delete {args} {
    set mol [lindex $args 0]
 
    foreach list [lrange $args 1 end] {
        if {$list == "all"} {
            graphics $mol delete all
	    return
        }
        foreach id $list {
            graphics $mol delete $id
        }
    }
    return
}

########################################################################
# this is an improved version of the 'draw arrow' extension
# as described in the user's guide. this version also returns
# the list of graphic ids for easy selective deletion.
proc vmd_draw_arrow {args} {
    set usage {"draw arrow {x1 y1 z1} {x2 y2 z2} [scale <s>] [resolution <res>] [radius <r>] [filled <yes/no>]"}
    # defaults
    set scale 0.8
    set res 6
    set radius 0.2
    set filled yes

    if {[llength $args] < 3} {
        error "wrong # args: should be $usage"
    }
    set mol   [lindex $args 0]
    set start [lindex $args 1]
    set end   [lindex $args 2]
    if {[llength $start] != 3 || [llength $end] != 3} {
        error "wrong type of args: should be $usage"
    }

    foreach {flag value} [lrange $args 3 end] {
        switch -glob $flag {
            scale  {set scale  $value}
            res*   {set res    $value}
            rad*   {set radius $value}
            fill*  {set filled $value}
            default {error "unknown option '$flag': should be $usage" }
        }
    }
    set middle [vecadd $start [vecscale $scale [vecsub $end $start]]] 
    return [list \
        [graphics $mol cylinder $start $middle radius $radius \
                resolution $res filled $filled] \
        [graphics $mol cone $middle $end radius [expr $radius * 1.7] \
                resolution $res ] \
    ]
}

########################################################################
# define a vector drawing function. contrary to the arrow example 
# from the users guide, the vector is defined by it's origin, 
# a diretion at this point, and a scaling factor.
# the function returns a list of the graphics ids for easy deletion.
proc vmd_draw_vector {args} {
    set usage {"draw vector {x1 y1 z1} {x2 y2 z2} [scale <s>] [resolution <res>] [radius <r>] [filled <yes/no>]"}
    # defaults
    set scale 0.8
    set res 6
    set radius 0.2
    set filled yes

    if {[llength $args] < 3} {
        error "wrong # args: should be $usage"
    }
    set mol    [lindex $args 0]
    set center [lindex $args 1]
    set vector [lindex $args 2]
    if {[llength $center] != 3 || [llength $vector] != 3} {
        error "wrong type of args: should be $usage"
    }

    foreach {flag value} [lrange $args 3 end] {
        switch -glob $flag {
            scale  {set scale  $value}
            res*   {set res    $value}
            rad*   {set radius $value}
            fill*  {set filled $value}
            default {error "unknown option '$flag': should be $usage" }
        }
    }
    
    set vechalf [vecscale [expr $scale * 0.5] $vector]
    return [list \
        [graphics $mol cylinder [vecsub $center $vechalf] \
            [vecadd $center [vecscale 0.7 $vechalf]] \
              radius $radius resolution $res filled $filled] \
        [graphics $mol cone [vecadd $center [vecscale 0.7 $vechalf]] \
   	    [vecadd $center $vechalf] radius [expr $radius * 1.7] \
              resolution $res]]
}

########################################################################
# add a 'draw prism' command similar to triangle
# but with an (optional) width (i.e. a 'thick triangle').
proc vmd_draw_prism {args} {
    set usage {"draw prism {x1 y1 z1} {x2 y2 z2} {x3 y3 z3} [width <w>] [filled <yes/no>]"}
    # defaults
    set width 0.1
    set filled yes

    if {[llength $args] < 4} {
        error "wrong # args: should be $usage"
    }
    set mol [lindex $args 0]
    set v1  [lindex $args 1]
    set v2  [lindex $args 2]
    set v3  [lindex $args 3]
    if {[llength $v1] != 3 || [llength $v2] != 3 || [llength $v3] != 3} {
        error "wrong type of args: should be $usage"
    }

    foreach {flag value} [lrange $args 4 end] {
        switch -glob $flag {
            wid*   {set width  $value}
            fill*  {set filled $value}
            default {error "unknown option '$flag': should be $usage" }
        }
    }
   
    # empty list to store graphics indices in. is used as
    # return value, so that they can be selectively deleted.
    set objs {}

    set norm  [veccross [vecsub $v1 $v2] [vecsub $v2 $v3]]
    set scale [expr 0.5 * $width * [veclength $norm]]

    # construct edge positions:
    set off [vecscale $scale $norm]
    set vt1 [vecadd $v1 $off]
    set vt2 [vecadd $v2 $off]
    set vt3 [vecadd $v3 $off]
    set vb1 [vecsub $v1 $off]
    set vb2 [vecsub $v2 $off]
    set vb3 [vecsub $v3 $off]

    if { [string match {y*} $filled] || $filled == 1} {
        lappend objs [graphics $mol triangle $vt1 $vt2 $vt3]
        lappend objs [graphics $mol triangle $vb1 $vb2 $vb3]
    }

    lappend objs [graphics $mol triangle $vt1 $vt2 $vb2]
    lappend objs [graphics $mol triangle $vt1 $vb1 $vb2]

    lappend objs [graphics $mol triangle $vt1 $vt3 $vb3]
    lappend objs [graphics $mol triangle $vt1 $vb1 $vb3]

    lappend objs [graphics $mol triangle $vt2 $vt3 $vb3]
    lappend objs [graphics $mol triangle $vt2 $vb2 $vb3]

    return $objs
}

############################################################
# Local Variables:
# mode: tcl
# time-stamp-format: "%u %02d.%02m.%y %02H:%02M:%02S %s"
# End:
############################################################
