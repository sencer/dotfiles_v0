set textwidth=80
set conceallevel=2
set concealcursor=c
set formatoptions+=n
hi Conceal guibg=NONE

let g:tex_flavor = "latex"
" let g:tex_fold_enabled = 1

set spell
syntax spell toplevel

let g:LatexBox_complete_inlineMath = 1

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
