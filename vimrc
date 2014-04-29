set nocompatible

filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Load Bundles                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'gmarik/vundle'
Bundle 'sencer/vim-colors-github'
Bundle 'jpo/vim-railscasts-theme'
Bundle 'chriskempson/base16-vim'
" Bundle 'altercation/vim-colors-solarized'
" Bundle 'Lokaltog/vim-distinguished'
" Bundle 'morhetz/gruvbox'
" Bundle 'tomasr/molokai'
" Bundle 'vim-scripts/wombat256.vim'
Bundle 'mhinz/vim-signify'
Bundle 'chrisbra/color_highlight'
Bundle 'edsono/vim-matchit'
Bundle 'salsifis/vim-transpose'
Bundle 'sk1418/HowMuch'
Bundle 'godlygeek/tabular'
Bundle 'honza/vim-snippets'
Bundle 'kien/ctrlp.vim'
Bundle 'kshenoy/vim-signature'
Bundle 'bling/vim-airline'
Bundle 'bling/vim-bufferline'
Bundle 'MarcWeber/ultisnips'
Bundle 'sencer/AutoComplPop'
" Bundle 'Valloric/YouCompleteMe'
Bundle 'sencer/normal.vim'
Bundle 'sjl/gundo.vim'
Bundle 'tomtom/tlib_vim'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-eunuch'
Bundle 'kana/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-fugitive'
" Bundle 'vim-scripts/SearchComplete'
Bundle 'vim-scripts/VIM-Color-Picker'
Bundle 'vis'
Bundle 'vim-scripts/ReplaceWithRegister'
Bundle 'kana/vim-niceblock'
Bundle 'kana/vim-arpeggio'
Bundle 'jiangmiao/auto-pairs'
Bundle 'kana/vim-textobj-user'
Bundle 'kana/vim-textobj-underscore'
Bundle 'kana/vim-textobj-indent'
Bundle 'kana/vim-textobj-syntax'
Bundle 'b4winckler/vim-angry'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'c9s/vimomni.vim'
Bundle 'tpope/vim-rails'
Bundle 'majutsushi/tagbar'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'Rip-Rip/clang_complete'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-endwise'
Bundle 'sencer/gnuplot.vim'
Bundle 'sheerun/vim-polyglot'
" Bundle 'edkolev/tmuxline.vim'

colorscheme railscasts
" hi ColorColumn ctermbg=235 guibg=#2c2d27 " fix for wombat theme
if has('gui_running')
  set guifont=Dejavu\ Sans\ Mono\ 11
  set guioptions=aeiM
else
  set term=$TERM
endif

filetype plugin indent on
syntax on

let g:syntastic_enable_balloons = 1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_check_on_wq = 0
let g:syntastic_always_populate_loc_list = 1

let g:bufferline_echo = 0
let g:airline_theme='bubblegum'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_symbols = { 'linenr'     : '¶', 'branch'     : '⎇',
                        \ 'paste'      : 'ρ', 'whitespace' : 'Ξ' }
let g:airline_mode_map = { '__' : '-', 'n'  : 'N', 'i'  : 'I', 'R'  : 'R',
                         \ 'c'  : 'C', 'v'  : 'V', 'V'  : 'VL', '' : 'VB' }
let g:airline#extensions#tagbar#flags = 'f'

let g:signify_vcs_list = [ 'git' ]
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsCenterLine = 0

let g:UltiSnips = {
      \ 'ExpandTrigger' : "<Tab>",
      \ 'JumpForwardTrigger' : "<Tab>",
      \ 'JumpBackwardTrigger' : "<S-Tab>",
      \ 'ListSnippets' : "<C-Tab>",
      \ 'EditSplit' : "vertical",
      \ 'snipmate_ft_filter': {'default': {'filetypes': ['all', 'FILETYPE']}},
      \ 'always_use_first_snippet': 1
      \ }


let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'Et'

let g:HowMuch_auto_engines = ['py']

let g:LatexBox_Folding = 1
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

set modeline ve=block,onemore ",insert
set nu rnu nowrap list ls=2  "showmode pastetoggle=<F2>
set nrformats-=octal showmatch autoread
set backspace=indent,eol,start ww+=<,>,[,],~,h,l
set smartindent autoindent copyindent
set smarttab tabstop=2 shiftwidth=2 shiftround expandtab
set incsearch hlsearch ignorecase smartcase gdefault
set showbreak=… listchars=trail:·,eol:¬,tab:»-,extends:❯,precedes:❮
set wildmenu wildmode=full " set wildmode=longest:full,list  #Tab won't work
set wildignore=*.o,*~,*.swp
set swb=useopen,usetab,newtab showtabline=1 history=200
set lazyredraw noerrorbells visualbell ttyfast
set autochdir scrolloff=3 siso=8 showcmd hidden formatoptions+=j nojoinspaces
set clipboard=unnamedplus,autoselect,exclude:cons\|linux
set t_ut=  mouse=a " tmux fixes
let &colorcolumn="".join(range(81,999),",")

call arpeggio#load()
Arpeggio inoremap jk <ESC>
Arpeggio imap -= <ESC>hdiWa<C-R>=<C-R>"<CR>
Arpeggio vmap -= di<C-R>=<C-R>"<CR>

noremap <silent> <C-Z>  :GundoToggle<CR>
noremap <silent> <F2> :set invpaste<CR>
noremap <silent><F9> :TagbarToggle<CR>
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
noremap j gj
noremap k gk
nnoremap <silent> cog :GitGutterToggle<CR>
nnoremap <silent> coe :ColorToggle<CR>
nnoremap <silent> <Leader>w :up!<CR>
nnoremap <A-=> <C-W>>
nnoremap <A--> <C-W><
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
nnoremap <silent> <C-Left> :tabprevious<CR>
nnoremap <silent> <C-Right> :tabnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>
nmap Y y$
vnoremap > >gv
vnoremap < <gv
vmap <A-=> di<C-R>=<C-R>"<CR>
imap <A-=> <ESC>hdiWa<C-R>=<C-R>"<CR>
inoremap <C-U> <C-G>u<C-U>
nnoremap <silent> gl ?\W<CR>l:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR>:noh<CR>
"call histdel("search", -2)<CR>
nnoremap <silent> gh ?\W\+<CR>nW:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>:noh<CR>
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>

map <silent> <F10> :echom "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

au BufRead,BufNewFile input*txt set commentstring=\!\ %s
au InsertEnter * set norelativenumber
au InsertLeave * set relativenumber
