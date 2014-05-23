function! s:FindStartingIndex()
    let cur_line = getline('.')
    " locate the start of the word
    let start = col('.') - 1
    while start > 0 && cur_line[start - 1] =~ '[^:,\t]'
        let start -= 1
    endwhile

    " lstrip()
    while cur_line[start] =~ '[ ]'
        let start += 1
    endwhile

    return start
endfunction

function! s:GenerateCompletions(findstart, base)
    if a:findstart
        return s:FindStartingIndex()
    endif
    let results = []
    let cmd = '$HOME/bin/ph ' . shellescape(a:base) . ' 2>/dev/null'
    let lines = split(system(cmd), "\n")
    call remove(lines, 0)
    for my_line in lines
        let fields = split(my_line, "\t")
        let entry = {
              \'word': fields[1] . ' <' . fields[0] . '>',
              \'abbr': fields[1],
              \'menu': fields[2],
              \'icase': 1
              \}
        call add(results, entry)
    endfor
    return results
endfunction

function! QueryCommandComplete(findstart, base)
  " if synID(line('.'), 1, 1) == 99 || synID(line('.')+1, 1, 1) == 99
  "synID 99 is the header syntax.
  return s:GenerateCompletions(a:findstart, a:base)
  " endif
endfunction

function! MuttIndent(lnum)
  let s:prev_line = getline(a:lnum - 1)
  if s:prev_line =~? '\v^(to|b?cc):.*,$'
    return &shiftwidth
  else
    return indent(a:lnum - 1)
  endif
endfunction

setlocal omnifunc=QueryCommandComplete indentexpr=MuttIndent(v:lnum)

syn match mailTable keepend contains=mailEmail "^\s*|.*" transparent
setlocal noexpandtab autoindent spell spelllang=en,tr fo+=w
NeoCompleteDisable
