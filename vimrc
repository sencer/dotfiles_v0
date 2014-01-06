set nocompatible

filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Load Bundles                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'gmarik/vundle'
Bundle 'altercation/vim-colors-solarized'
Bundle 'sencer/vim-colors-github'
Bundle 'jpo/vim-railscasts-theme'
" Bundle 'Lokaltog/vim-distinguished'
" Bundle 'morhetz/gruvbox'
" Bundle 'tomasr/molokai'
" Bundle 'vim-scripts/wombat256.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'chrisbra/color_highlight'
Bundle 'edsono/vim-matchit'
" Bundle 'grncdr/camelcasemotion'
Bundle 'salsifis/vim-transpose'
Bundle 'sk1418/HowMuch'
Bundle 'godlygeek/tabular'
Bundle 'honza/vim-snippets'
Bundle 'jiangmiao/auto-pairs'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'kien/ctrlp.vim'
Bundle 'kshenoy/vim-signature'
Bundle 'Lokaltog/vim-powerline'
Bundle 'MarcWeber/ultisnips'
Bundle 'maxbrunsfeld/vim-yankstack'
Bundle 'scrooloose/nerdtree'
Bundle 'sencer/AutoComplPop'
"Bundle 'Valloric/YouCompleteMe'
Bundle 'sencer/normal.vim'
Bundle 'sjl/gundo.vim'
Bundle 'tomtom/tlib_vim'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-fugitive'
" Bundle 'vim-scripts/SearchComplete'
Bundle 'vim-scripts/VIM-Color-Picker'
Bundle 'vis'

Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'majutsushi/tagbar'
Bundle 'ap/vim-css-color'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'inkarkat/argtextobj.vim'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'othree/html5.vim'
Bundle 'Rip-Rip/clang_complete'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-endwise'
Bundle 'sencer/gnuplot.vim'
Bundle 'marijnh/tern_for_vim'

let g:syntastic_enable_balloons = 1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_check_on_wq = 0

filetype plugin indent on
syntax on

colorscheme railscasts
" hi ColorColumn ctermbg=235 guibg=#2c2d27 " fix for wombat theme
if has('gui_running')
  " colorscheme solarized
  " set background=dark
  set guifont=Dejavu\ Sans\ Mono\ 11
  let g:nerdtree_tabs_open_on_gui_startup=0
  " let g:Powerline_colorscheme = 'solarized16'
endif

let g:Powerline_symbols='unicode'
let g:Powerline_mode_n=' N '
let g:Powerline_mode_i=' I '
let g:Powerline_mode_R=' R '
let g:Powerline_mode_v=' V '
let g:Powerline_mode_V=' V⋅L '
let g:Powerline_mode_cv=' V⋅B '
let g:Powerline_stl_path_style = 'short'

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
let g:AutoPairsShortcutToggle = ''

let g:HowMuch_auto_engines = ['py']

set nu rnu nowrap list ls=2  "showmode pastetoggle=<F2>
set nrformats-=octal showmatch autoread
set backspace=indent,eol,start ww+=<,>,[,],~
set smartindent autoindent copyindent
set smarttab tabstop=2 shiftwidth=2 shiftround expandtab
set incsearch hlsearch ignorecase smartcase gdefault
set showbreak=↪\  listchars=trail:·,eol:¬,tab:»-,extends:❯,precedes:❮
set wildmenu wildmode=full " set wildmode=longest:full,list  #Tab won't work
set wildignore=*.o,*~,*.swp
set swb=useopen,usetab,newtab showtabline=1 history=200
set lazyredraw noerrorbells visualbell ttyfast
set autochdir scrolloff=3 siso=8 showcmd hidden formatoptions+=j nojoinspaces
set clipboard=unnamedplus,autoselect,exclude:cons\|linux
set t_ut=  mouse=a " tmux fixes
let &colorcolumn="".join(range(81,999),",")

call yankstack#setup()
noremap <silent> <C-Z>  :GundoToggle<CR>
noremap <silent> <F2> :set invpaste<CR>
noremap <silent> <A-o> :NERDTreeMirrorToggle<CR>
noremap <silent><F9> :TagbarToggle<CR>
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
noremap j gj
noremap k gk
nmap Y y$
nnoremap g/ //e<CR>v??<CR>
nnoremap <silent> cog :GitGutterToggle<CR>
nnoremap <silent> coe :ColorToggle<CR>
nnoremap <silent> <Leader>w :w!<CR>
nnoremap <A-=> <C-W>>
nnoremap <A--> <C-W><
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
nnoremap <silent> <C-Left> :tabprevious<CR>
nnoremap <silent> <C-Right> :tabnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>
vnoremap > >gv
vnoremap < <gv
vmap <A-=> di<C-R>=<C-R>"<CR>
imap <A-=> <ESC>hdiWa<C-R>=<C-R>"<CR>
inoremap <C-U> <C-G>u<C-U>
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

au BufRead,BufNewFile input*txt set commentstring=\!\ %s
au InsertEnter * set norelativenumber
au InsertLeave * set relativenumber
au FileType ruby let g:rubycomplete_buffer_loading=1
au FileType ruby let g:rubycomplete_classes_in_global=1
