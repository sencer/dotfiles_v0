set conceallevel=2
set concealcursor=c
hi Conceal guibg=NONE

set foldmethod=expr
syntax spell toplevel

function! SyncTex()
  let cmd = 'evince_forward_search ' . expand("%:p:r") . '.pdf ' . line(".") . ' ' . expand("%:p")
  let output = system(cmd)
endfunction

nnoremap <buffer> <silent> <Leader>ls :call SyncTex()<CR>
nmap <buffer> <F6>   <Plug>LatexChangeEnv
vmap <buffer> <F7>   <Plug>LatexWrapSelection
vmap <buffer> <S-F7> <Plug>LatexEnvWrapSelection
imap <buffer> ((     \eqref{

call prose#setup()
