function! prose#setup()
  setlocal wrap
  setlocal spell
  setlocal background=light
  setlocal foldlevel=99
  setlocal scrolloff=999
  setlocal nocindent
  setlocal nosmartindent
  setlocal formatoptions=jtcraqn1w
  colorscheme PaperColor
  let g:airline_theme='PaperColor'
  let g:limelight_conceal_ctermfg = 'gray'
  let g:limelight_default_coefficient = 0.7
  autocmd! User GoyoEnter nested call prose#enter()
  autocmd! User GoyoLeave nested call prose#exit()
endfunction

function! prose#enter()
  echom "test!"
  setlocal noshowcmd
  setlocal noshowmode
  silent !tmux set status off
  autocmd! RNU
endfunction

function! prose#exit()
  set showcmd
  set showmode
  silent !tmux set status on
  augroup RNU
    autocmd!
    au RNU InsertEnter * set norelativenumber
    au RNU InsertLeave * set relativenumber
  augroup END
endfunction
