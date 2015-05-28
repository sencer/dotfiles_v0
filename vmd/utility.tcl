proc puts_red {string} {
  puts stdout "\033\[31m$string\033\[0m"
}

proc inverse3 {matrix} {
  set matrix "[map {x {return "$x 0.0"}} [lrange $matrix 0 2]] {0 0 0 1}"
  set inv [measure inverse "$matrix"]
  return "{[lrange [lindex $inv 0] 0 2]} {[lrange [lindex $inv 1] 0 2]} {[lrange [lindex $inv 2] 0 2]}"
}

proc framedo {pr args} {
  set nf [molinfo top get numframes]
  for {set i 0} {$i < $nf} {incr i} {
    animate goto $i
    catch {
      apply $pr {*}$args
    }
    catch {
      $pr {*}$args
    }
  }
}

proc map {lambda list} {
  set result {}
  foreach item $list {
    lappend result [apply $lambda $item]
  }
  return $result
}

proc lambda {arglist body {ns {}}} {
  list ::apply [list $arglist $body $ns]
}
