function! prose#setup()
  setlocal wrap
  setlocal spell
  setlocal background=light
  setlocal foldlevel=99
  setlocal scrolloff=999
  setlocal nocindent
  setlocal nosmartindent
  setlocal formatoptions=jtcraqn1w
  command! W echo "noop"
  let g:goyo_width = 76
  set textwidth=73
  let g:limelight_conceal_ctermfg = 'gray'
  let g:limelight_default_coefficient = 0.7
  call textobj#sentence#init()
  autocmd! User GoyoEnter nested call prose#enter()
  autocmd! User GoyoLeave nested call prose#exit()
endfunction

function! prose#enter()
  setlocal noshowcmd
  setlocal noshowmode
  setlocal cursorline
  if !has("gui_running")
    silent !tmux set status off
  endif
  autocmd! RNU
endfunction

function! prose#exit()
  set showcmd
  set showmode
  if !has("gui_running")
    silent !tmux set status on
  endif
  setlocal nocursorline
  augroup RNU
    autocmd!
    au RNU InsertEnter * set norelativenumber
    au RNU InsertLeave * set relativenumber
  augroup END
endfunction
