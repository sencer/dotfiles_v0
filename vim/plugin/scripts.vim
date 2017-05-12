" nnoremap Y y$
if !has("gui_running")

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     fix alt shortcuts for terminal                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !has('nvim')
  let c='a'
  while c <= 'z'
    exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
    let c = nr2char(1+char2nr(c))
  endw
  exec "set <A-->=\e-"
  exec "imap \e- <A-->"
  exec "set <A-+>=\e+"
  exec "imap \e+ <A-+>"
  exec "set <A-=>=\e="
  exec "imap \e= <A-=>"
  set timeout ttimeoutlen=50
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           rename tmux window                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  if $TMUX != ""
    function! Tmux(which)
      if !exists("g:tmux")
        let g:tmux = system("tmux display-message -p '#W'")
      endif
      if a:which == 0
        call system("tmux rename-window " . expand("%:t"))
      else
        call system("tmux rename-window " . g:tmux)
      endif
    endfunction
    au BufNewFile,BufReadPost,FileReadPost,BufEnter * call Tmux(0)
    au VimLeave * call Tmux(1)
  endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     Change case of Visual selection                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ ygv"=TwiddleCase(@")<CR>Pgv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             follow symlink                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! MyFollowSymlink(...)
  if exists('w:no_resolve_symlink') && w:no_resolve_symlink
    return
  endif
  let fname = a:0 ? a:1 : expand('%')
  if fname =~ '^\w\+:/'
    " do not mess with 'fugitive://' etc
    return
  endif
  let fname = simplify(fname)

  let resolvedfile = resolve(fname)
  if resolvedfile == fname
    return
  endif
  let resolvedfile = fnameescape(resolvedfile)
  let resolvedfile = fnamemodify(resolvedfile, ":p")
  echohl WarningMsg | echomsg 'Resolving symlink' fname '=>' resolvedfile | echohl None
  " exec 'noautocmd file ' . resolvedfile
  " XXX: problems with AutojumpLastPosition: line("'\"") is 1 always.
  exec 'file ' . resolvedfile
endfunction
command! FollowSymlink call MyFollowSymlink()
command! ToggleFollowSymlink let w:no_resolve_symlink = !get(w:, 'no_resolve_symlink', 0) | echo "w:no_resolve_symlink =>" w:no_resolve_symlink
au BufReadPost * call MyFollowSymlink(expand('<afile>'))

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Visual star/hash search                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:save_cpo = &cpo | set cpo&vim
if !exists('g:VeryLiteral')
  let g:VeryLiteral = 0
endif

function! s:VSetSearch(cmd)
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  normal! gvy
  if @@ =~? '^[0-9a-z,_]*$' || @@ =~? '^[0-9a-z ,_]*$' && g:VeryLiteral
    let @/ = @@
  else
    let pat = escape(@@, a:cmd.'\')
    if g:VeryLiteral
      let pat = substitute(pat, '\n', '\\n', 'g')
    else
      let pat = substitute(pat, '^\_s\+', '\\s\\+', '')
      let pat = substitute(pat, '\_s\+$', '\\s\\*', '')
      let pat = substitute(pat, '\_s\+', '\\_s\\+', 'g')
    endif
    let @/ = '\V'.pat
  endif
  normal! gV
  call setreg('"', old_reg, old_regtype)
endfunction

vnoremap <silent> * :<C-U>call <SID>VSetSearch('/')<CR>/<C-R>/<CR>
vnoremap <silent> # :<C-U>call <SID>VSetSearch('?')<CR>?<C-R>/<CR>
vmap <kMultiply> *
" nnoremap q* /<C-r><C-a><CR>
" nnoremap q# ?<C-r><C-a><CR>
nmap <silent> <Plug>VLToggle :let g:VeryLiteral = !g:VeryLiteral
  \\| echo "VeryLiteral " . (g:VeryLiteral ? "On" : "Off")<CR>
if !hasmapto("<Plug>VLToggle")
  nmap <unique> <Leader>vl <Plug>VLToggle
endif
let &cpo = s:save_cpo | unlet s:save_cpo

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                fold method                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! FoldText()
  let reg='{{'.'{\d\='
  for c in split(&commentstring, '%s')
    let reg = reg.'\|'.escape(c, '*')
  endfor
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let wlength = min([winwidth(0), 80])
  let indent = max([indent(v:foldstart), v:foldlevel-1])
  let nlines = (v:foldend-v:foldstart+1).' lines '
  let ftext = substitute(getline(v:foldstart), reg,'','g')
  return repeat(' ', indent) . substitute(ftext, '^\s*\(.\{-}\)\s*$', '\1', '')
        \ . repeat(foldchar, wlength - strlen(nlines.ftext) - 2 - indent)
        \ . nlines  . ' ≡'
endfunction

set foldtext=FoldText()
if &foldmethod == 'manual'
  set foldmethod=marker
endif
let &fcs = substitute(&fcs, 'fold:.', 'fold: ', '')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       temprorary tmux completion fix                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" function! TmuxCompleteToggle()
"   if !exists('b:TmuxCompleteBak') || b:TmuxCompleteBak ==# ""
"     let b:TmuxCompleteBak = &completefunc
"     setl completefunc=tmuxcomplete#complete
"     echom "completefunc set to tmuxcomplete#complete"
"   else
"     let &completefunc=b:TmuxCompleteBak
"     echom "completefunc set to " . b:TmuxCompleteBak
"     let b:TmuxCompleteBak = ""
"   endif
" endfunction
" nnoremap <Leader>y :call TmuxCompleteToggle()<CR>
" inoremap <C-J> <C-o>:call TmuxCompleteToggle()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        Insert Spaces until Aligned                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertSpaces()
  let s:ln   = line(".")
  let s:cn   = col(".") - 1
  let s:line = getline(s:ln)
  let s:char = nr2char(getchar())

  let s:i   = 0
  let s:pos = -1
  while s:pos == -1
    let s:i += 1
    let s:pline = getline(s:ln - s:i)
    let s:pos = stridx(s:pline, s:char, s:cn)
    if s:pos > -1 || s:i == s:ln
      break
    endif
  endwhile
  if s:pos > -1
    return repeat(" ", s:pos - s:cn) . s:char
  else
    echom "No `" . s:char . "' found in the previous lines."
    return s:char
  endif
endfunction

inoremap <silent> <C-g> <C-R>=InsertSpaces()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Put distance                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
