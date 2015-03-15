set textwidth=80
set conceallevel=2
set concealcursor=c
set formatoptions+=n
hi Conceal guibg=NONE

set spell
set foldmethod=expr
syntax spell toplevel
let g:tex_flavor = "latex"

let g:LatexBox_complete_inlineMath = 1
let g:LatexBox_fold_automatic = 0
let g:LatexBox_viewer = "$HOME/bin/evince"
let g:LatexBox_latexmk_async = 1
let g:LatexBox_latexmk_preview_continuously = 1
let g:LatexBox_quickfix = 0
let g:LatexBox_ignore_warnings = [
      \'Underfull',
      \'Overfull',
      \'specifier changed to',
      \'Class revtex4',
      \'PDF inclusion: multiple',
      \'Unused global option'
      \]

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
