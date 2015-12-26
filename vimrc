" Load Plugins {{{1
set nocompatible
filetype off
call plug#begin('~/.vim/bundle')
" Appearance {{{2
Plug 'sencer/mustang-vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'bling/vim-airline'

" Essential {{{2
Plug 'tommcdo/vim-exchange'
Plug 'bruno-/vim-vertical-move'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-rsi'
Plug 'kana/vim-repeat'
Plug 'kana/vim-niceblock'
Plug 'salsifis/vim-transpose'
Plug 'sk1418/HowMuch'
Plug 'PeterRincker/vim-narrow'
Plug 'haya14busa/incsearch.vim'
Plug 'sencer/vis'
Plug 'lutostag/vim-autoswap'

" Text Objects {{{2
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-underscore'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'b4winckler/vim-angry'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'jeetsukumaran/vim-indentwise'

" File Type Plugins {{{2
Plug 'jcfaria/Vim-R-plugin'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-jp/cpp-vim'
Plug 'tpope/vim-git'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'leshill/vim-json'
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'vim-scripts/tcl.vim--smithfield'
Plug 'vim-scripts/tcl.vim--smithfield-indent'
Plug 'MatlabFilesEdition'
" Plug 'JuliaLang/julia-vim'
Plug 'sencer/gnuplot.vim'
Plug 'vim-scripts/awk.vim'
Plug 'tpope/vim-markdown'
Plug 'slim-template/vim-slim'
Plug 'andersoncustodio/vim-tmux'
Plug 'chrisbra/vim-zsh'

" Completion and Tags {{{2
Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/UltiSnips'
Plug 'sencer/vim-snippets'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer'}
Plug 'ervandew/supertab'
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-endwise'
Plug 'wellle/tmux-complete.vim'

" Writing {{{2
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'sencer/wordnet.vim'
Plug 'reedes/vim-textobj-sentence'
Plug 'reedes/vim-wordy'
Plug 'tpope/vim-abolish'
Plug 'jdelkins/vim-correction'

" Various {{{2
Plug 'KabbAmine/vCoolor.vim'
Plug 'airblade/vim-gitgutter'
Plug 'kshenoy/vim-signature'
Plug 'chrisbra/color_highlight'
Plug 'ap/vim-css-color'
Plug 'scrooloose/syntastic'
Plug 'rking/ag.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'sjl/gundo.vim'
Plug 'sencer/vim-notes'
Plug 'xolox/vim-misc'
Plug 'Shougo/vimproc.vim', { 'do': './make -f make_unix.mak' }
Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/vim-easy-align'
Plug 'AndrewRadev/writable_search.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'christoomey/vim-tmux-runner'
Plug 'itchyny/thumbnail.vim'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'gelguy/snapshot.vim'

" and load {{{2
call plug#end()

filetype plugin indent on
syntax on

if !(exists('g:loaded_matchit')) && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" }}}1

" Plugin settings {{{1

" netrw settings {{{2
let g:netrw_home = $HOME . '/.dotfiles/tmp'
let g:netrw_browsex_viewer = "xdg-open"
let g:netrw_list_hide=netrw_gitignore#Hide().'.*\.swp$,.*\.pyc$,.*~'
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_preview = 1
let g:netrw_altv = 0
let g:netrw_winsize = 25

" syntastic settings {{{2
let g:syntastic_enable_balloons = 1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_check_on_wq = 0
let g:syntastic_always_populate_loc_list = 1

" airline settings {{{2
let g:airline_theme='bubblegum'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.readonly = ''
let g:airline_mode_map = { '__' : '-', 'n' : 'N', 'i' : 'I',  'R'  : 'R',
      \ 'c'  : 'C', 'v' : 'V', 'V' : 'VL', '' : 'VB' }
let g:airline#extensions#tagbar#flags = 'f'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs=0
let g:airline#extensions#tabline#buffer_idx_mode = 1
for s:i in [1,2,3,4,5,6,7,8,9]
  exec 'nmap <Leader>'.s:i.' <Plug>AirlineSelectTab'.s:i
endfor

" youcompleteme settings {{{2
let g:ycm_key_list_select_completion = ["<C-n>", "<Down>"]
let g:ycm_key_list_previous_completion = ["<C-p>", "<Up>"]
let g:ycm_key_detailed_diagnostics = ''
let g:ycm_key_invoke_completion= ''
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1

" ultisnips settings {{{2
let g:UltiSnipsJumpForwardTrigger = "<TAB>"
let g:UltiSnipsJumpBackwardTrigger = "<S-TAB>"
let g:UltiSnipsSnippetsDir = "~/.vim/bundle/vim-snippets/UltiSnips"
let g:UltiSnipsEditSplit = "vertical"

" supertab {{{2
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = '<C-x><C-u>'

" autopairs {{{2
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsCenterLine = 0

" ctrlp settings {{{2
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" howmuch settings {{{2
let g:HowMuch_auto_engines = ['py']
let g:HowMuch_scale = 9

" latexbox settings {{{2
let g:tex_flavor = "latex"
let g:LatexBox_Folding = 1
let g:LatexBox_complete_inlineMath = 1
let g:LatexBox_viewer = "$HOME/bin/evince"
let g:LatexBox_fold_automatic = 1
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

" vcoolor {{{2
let g:vcoolor_disable_mappings = 1
let g:vcoolor_map = '<F5>'

" various settings {{{2
let g:notes_suffix = '.md'
let g:notes_directories = ['~/gdrive/notes']
let g:agprg = 'ag --nogroup --nocolor --column'

"}}}1

" VIM settings {{{1

" better defaults and theme {{{2
colorscheme mustang
if has('gui_running')
  set guifont=Monaco\ 11
  set guioptions=aeip
else
  if has('nvim')
    runtime! python_setup.vim
  else
    set term=$TERM
  endif
endif
set backspace=indent,eol,start
set whichwrap+=<,>,[,],~,h,l
set nrformats-=octal
set t_ut=                                                      " a fix for tmux
set formatoptions+=j
set nojoinspaces                    "consider using joinspaces and cpoptions+=J
set history=1000
set autochdir
set scrolloff=3
set sidescrolloff=8
set clipboard^=unnamedplus
set shell=/bin/zsh
set fileformats+=mac
set viminfo^=!
set complete-=t

" do not use tab char unlessed forced to do so {{{2
set expandtab
set smarttab
set tabstop=2
set shiftwidth=2
set shiftround

" search settings {{{2
set incsearch
set hlsearch
set gdefault
set ignorecase
set smartcase

" apply settings from the modeline {{{2
set modeline

" move cursor to places w/o any char in block mode {{{2
set virtualedit=block,onemore

" show numbers and relative numbers {{{2
set number

augroup RNU
  autocmd!
  au RNU InsertEnter * set norelativenumber
  au RNU InsertLeave * set relativenumber
augroup END

" do not soft-wrap lines {{{2
set nowrap

" show non-visible chars {{{2
set list
set listchars=trail:·,eol:¬,tab:»-,extends:❯,precedes:❮,nbsp:∴
set showbreak=…

" undo settings {{{2
set undofile
set undodir=~/.undodir
set undolevels=1000
set undoreload=1000

" swap settings {{{2
set directory=~/.vimswap

" visual settings and clues {{{2
let &colorcolumn="".join(range(81,999),",")
set laststatus=2
set showtabline=1
set wildmenu
set wildmode=longest:full,full
set showmatch
set showcmd
set noshowmode
set noerrorbells
set visualbell
set lazyredraw
set ttyfast

" use mouse {{{2
set mouse=a
set mousemodel=popup_setpos

" completion {{{2
set infercase
set wildignore=*.o,*~,*.swp
set thesaurus+=$HOME/.vim/dictionaries/moby
set dictionary+=/usr/share/dict/words

" buffers {{{2
set autoread
set switchbuf=useopen,usetab
set hidden
set tabpagemax=1 "not a big fan of tabs

" indentation {{{2
set cindent
set cinoptions+=l1
set smartindent
set autoindent
set copyindent

" fold {{{2
set foldlevel=1
"}}}1

" Mappings {{{1
" some sane defaults and tweaks "{{{2
nmap Y y$
noremap Q gq
vnoremap > >gv
vnoremap < <gv
nnoremap <CR> i<CR><ESC>
inoremap <C-l> <C-O>:redraw!<CR>
" nnoremap <BS> dh

" use space as leader {{{2
map <Space> <nop>
map <Space> <Leader>

" swap keys for visual and visual block modes {{{2
nnoremap    v   <C-V>
nnoremap <C-V>     v
vnoremap    v   <C-V>
vnoremap <C-V>     v

" toggles {{{2
nnoremap <silent> <F2> :set invpaste<CR>
nnoremap <silent> <F9> :TagbarToggle<CR>
nnoremap <silent> cog :GitGutterToggle<CR>
nnoremap <silent> coe :ColorToggle<CR>
nnoremap <silent> coz :GundoToggle<CR>
nnoremap <silent> cof :Vexplore!<CR>
nnoremap <F8> :Ag "\b<C-R><C-W>\b"<CR>:cw<CR>

" exchange mappings {{{2
nmap cx <Plug>(Exchange)
nmap gl <Plug>(Exchange)iww.ebb
nmap gh <Plug>(Exchange)iwb.w
nmap >. <Plug>(Exchange)iaf,l.eb
nmap <, <Plug>(Exchange)iaF,h.

" EasyAlign {{{2
vmap <Enter> <Plug>(LiveEasyAlign)
nmap ga <Plug>(EasyAlign)

" insert mode mappings {{{2
inoremap <C-U> <C-G>u<C-U>
inoremap jk <ESC>
inoremap ;; <ESC>g_a;
inoremap ;: <ESC>g_a:
inoremap ;{ <ESC>o{<CR>}<ESC>O

" <Space><Space> for commenting {{{2
vmap <Leader><Space> gc
nmap <Leader><Space> gcc

" <Leader>w and x to exit to save file if there are changes {{{2
nnoremap <silent> <Leader>w :up!<CR>
nnoremap <silent> <Leader>x :x!<CR>

" <Alt>= for a simple calculator {{{2
vmap <expr> <A-=> ":normal " . (col("'<")+1) . "li<A-=><CR>"
imap <A-=> <C-c>hdiWa<C-R>=<C-R>"<CR> <C-c>i

" resize vertical splits, that I use most. {{{2
nnoremap <A-=> <C-W>>
nnoremap <A--> <C-W><

" run current line {{{2
nnoremap <silent> <F3> :exec (&ft == 'vim' ? '' : &ft) . ' ' . getline('.')<CR>
vnoremap <silent> <F3> :<C-U>exec (&ft == 'vim' ? '' : &ft) . ' ' . getreg('*')<CR>

" show current syntax information {{{2
map <silent> <F10> :echom "hi<" . synIDattr(synID(line("."),col("."),1),"name")
      \. '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" <Leader>t for thumbnail view of buffers
nnoremap <Leader>t :Thumbnail<CR>
" incsearch mappings {{{2
map g/ <Plug>(incsearch-stay)
" gitgutter maps {{{2
nmap [h <Plug>GitGutterPrevHunk
nmap ]h <Plug>GitGutterNextHunk
" fugitive maps {{{2
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>ga :Gcommit --amend<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
" youcompleteme maps
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
" }}}1

" Auto commands {{{1
augroup vimrc

  autocmd!

  "set QE input file comment string
  au vimrc BufRead,BufNewFile input*txt set commentstring=\!\ %s

  " set awk commentstring
  au vimrc FileType awk set commentstring=#\ %s

  " save the clipboard on leave
  au vimrc VimLeave * call system("xsel -ib", getreg('+'))

  " open the file with last viewed line
  au vimrc BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

  " syntax based omnicompleteion, if there is no omnifunc
  au Filetype *
        \	if &omnifunc == "" |
        \		setlocal omnifunc=syntaxcomplete#Complete |
        \	endif
augroup END
"}}}1

" Commands {{{1
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif
" }}}
