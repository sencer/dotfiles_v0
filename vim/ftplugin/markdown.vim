set autowrite
" au BufWritePost <buffer> Make!
set makeprg=markdown\ \<\ %\ \>\ %:r.html

inoremap JK <C-c>"zyy"zpVr=o<CR>
inoremap KJ <C-c>"zyy"zpVr-o<CR>

let g:airline_theme='PaperColor'
let g:markdown_folding = 1
colorscheme PaperColor

set spell
set textwidth=78
set foldlevel=99
set wrap
set scrolloff=999
set noshowcmd
set noshowmode

let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_default_coefficient = 0.7

function! s:goyo_enter()
  silent !tmux set status off
  autocmd! RNU
endfunction

function! s:goyo_leave()
  silent !tmux set status on
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
