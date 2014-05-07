syn region texDiffAddStyle matchgroup=texDiffStyle start="\\DIFaddbegin\(FL\)\?\s*" end="\s*\\DIFaddend\(FL\)\?"  concealends contained contains=@texDiffGroup
syn region texDiffDelStyle matchgroup=texDiffStyle start="\\DIFdelbegin\(FL\)\?\s*" end="\s*\\DIFdelend\(FL\)\?" concealends contained contains=@texDiffGroup
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

" Not yet covering the cases where DIFaddbegin/DIFaddend constructs has multiple
" DIFadd{}s. Use with care.
"
function! LatexDiffReview(arg)
  let pos = getpos('.')
  let syn = synID(pos[1], pos[2], 1)
  if syn == 228 || syn == 229 || syn == 230
    normal 6l
    call search ('\v\zs\\DIF(add|del)begin', 'b')
    let chr = getline(".")[col(".")+3]
    if (a:arg == 0 && chr ==? 'd') || ( a:arg == 1 && chr ==? 'a' )
      call s:LatexDiffDelAll()
    elseif (a:arg == 1 && chr ==? 'd') || ( a:arg == 0 && chr ==? 'a' )
      call s:LatexDiffDelTag()
    endif
  endif
endfunction

function! s:LatexDiffDelTag()
  "should be at the beginning
  execute "normal d/{\<CR>dl]}"
  call s:LatexDiffDelAll()
endfunction

function! s:LatexDiffDelAll()
  "should be at the beginning
  execute "normal d/\\vDIF(add|del)end(FL)? \\zs\<CR>"
endfunction

" accept
nnoremap <silent> dq :call LatexDiffReview(0)<CR>
" reject
nnoremap <silent> dr :call LatexDiffReview(1)<CR>
