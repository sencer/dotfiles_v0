set textwidth=78
set conceallevel=2
set concealcursor=c
set formatoptions+=n
hi Conceal guibg=NONE

set spell
set foldmethod=expr
syntax spell toplevel

setl thesaurus+=$HOME/.vim/dictionaries/moby
setl dictionary+=$HOME/.vim/dictionaries/tex

au InsertLeave,CursorHold,CursorHoldI <buffer> :up

function! SyncTex()
  let cmd = 'evince_forward_search ' . expand("%:p:r") . '.pdf ' . line(".") . ' ' . expand("%:p")
  let output = system(cmd)
endfunction
nnoremap <buffer> <silent> <Leader>ls :call SyncTex()<CR>

nmap <buffer> <F6>   <Plug>LatexChangeEnv
vmap <buffer> <F7>   <Plug>LatexWrapSelection
vmap <buffer> <S-F7> <Plug>LatexEnvWrapSelection
imap <buffer> ((     \eqref{
