fun! S2L (var)
  if type(a:var) ==? 1
    return eval('[' . substitute(a:var, '\v(\r|\s)+', ", ", "g") . ']')
  else
    return a:var
  endif
endfun

fun! Sum (var)
  let s:v = S2L(a:var)
  let s:sum = 0
  for s:i in s:v
    let s:sum += s:i
  endfor
  return s:sum
endfun

fun! Average (var)
  let s:v = S2L(a:var)
  return Sum(s:v)/len(s:v)
endfun
