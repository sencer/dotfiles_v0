syn region texDiffAddStyle matchgroup=texDiffStyle start="\\DIFaddbegin\(FL\)\?\s*" end="\s*\\DIFaddend\(FL\)\?"  concealends contained contains=@texDiffGroup
syn region texDiffDelStyle matchgroup=texDiffStyle start=" \\DIFdelbegin\(FL\)\?\s*" end="\s*\\DIFdelend\(FL\)\?" concealends contained contains=@texDiffGroup
syn region texDiffInStyle  matchgroup=texDiffStyle start="\\DIF\(add\|del\)\(FL\)\?{" skip="{\_.\{-}}" end="}\ze" concealends contained transparent
syn region texDiffInCmd    matchgroup=texDiffStyle start="%DIF\(DEL\|AUX\)CMD\s\?<\?\s\?" end="%%%\|%DIFAUXCMD"   concealends contained transparent keepend

syn cluster texDiffGroup          contains=texDiffInStyle,texDiffInCmd
syn cluster texFoldGroup          add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd
syn cluster texBoldGroup          add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd
syn cluster texItalGroup          add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd
syn cluster texRefGroup           add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd
syn cluster texMathZones          add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd
syn cluster texDocGroup           add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd
syn cluster texPartGroup          add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd
syn cluster texChapterGroup       add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd
syn cluster texSectionGroup       add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd
syn cluster texSubSectionGroup    add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd
syn cluster texSubSubSectionGroup add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd
syn cluster texParaGroup          add=texDiffAddStyle,texDiffDelStyle,texDiffInStyle,texDiffInCmd

hi link texDiffAddStyle Underlined
hi link texDiffDelStyle Error
hi link texDiffStyle    Statement

function! LatexDiffAccept()
  let pos = getpos('.')
  let syn = synID(pos[1], pos[2], 1)
  if syn == 228 || syn == 229 || syn == 230
    normal 6l
    call search ('\v\zs\\DIF(add|del)begin', 'b')
    let beg = getpos(".")
    let chr = getline(".")[col(".")+3]
    if chr ==? 'd'
      call search('\\DIFdelend\(FL\)\?\zs')
      let end = getpos(".")
      if end[1] == beg[1]
        exec "normal " . (end[2] - beg[2] + 1) . "dh"
      else
        exec "normal " . beg[1] . "gg0" . beg[2] . "lhD"
        exec "normal " . end[1] . "gg0" . end[2] . "dl"
        if (end[1] - beg[1]) > 1
          exec "normal " . (beg[1] + 1) . "gg" . (end[1] - beg[1] - 1) . "dd"
        endif
      endif
    elseif chr ==? 'a'
      normal df{]}
      let beg = getpos(".")
      call search('\\DIFaddend\(FL\)\?\zs')
      let end = getpos(".")
      exec "normal " . (end[2] - beg[2]) . "dh"
    endif
  endif
endfunction
nnoremap dq :call LatexDiffAccept()<CR>
