" nnoremap Y y$
if !has("gui_running")
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     fix alt shortcuts for terminal                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
"                            some simple funcs                            "
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

" Search for selected text.
" http://vim.wikia.com/wiki/VimTip171
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

nmap <silent> <Plug>VLToggle :let g:VeryLiteral = !g:VeryLiteral
  \\| echo "VeryLiteral " . (g:VeryLiteral ? "On" : "Off")<CR>
if !hasmapto("<Plug>VLToggle")
  nmap <unique> <Leader>vl <Plug>VLToggle
endif
let &cpo = s:save_cpo | unlet s:save_cpo
