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
