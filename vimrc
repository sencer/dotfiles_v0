set nocompatible

filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Load Bundles                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'gmarik/vundle'
Plugin 'sencer/mustang-vim'
Plugin 'mhinz/vim-signify'
Plugin 'chrisbra/color_highlight'
Plugin 'salsifis/vim-transpose'
Plugin 'sk1418/HowMuch'
Plugin 'junegunn/vim-easy-align'
Plugin 'kien/ctrlp.vim'
Plugin 'kshenoy/vim-signature'
Plugin 'bling/vim-airline'
Plugin 'SirVer/UltiSnips'
Plugin 'sencer/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Shougo/neocomplete.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'thinca/vim-ref'
Plugin 'tpope/vim-dispatch'
Plugin 'jcfaria/Vim-R-plugin'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-eunuch'
Plugin 'kana/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-fugitive'
Plugin 'sencer/vis'
Plugin 'tommcdo/vim-exchange'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'vim-scripts/ReplaceWithRegister'
Plugin 'kana/vim-niceblock'
Plugin 'jiangmiao/auto-pairs'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-underscore'
Plugin 'kana/vim-textobj-indent'
Plugin 'kana/vim-textobj-syntax'
Plugin 'b4winckler/vim-angry'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-rails'
Plugin 'fncll/wordnet.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'vim-jp/cpp-vim'
Plugin 'tpope/vim-git'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'leshill/vim-json'
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'vim-ruby/vim-ruby'
Plugin 'andersoncustodio/vim-tmux'
Plugin 'ap/vim-css-color'
Plugin 'tpope/vim-markdown'
Plugin 'sencer/gnuplot.vim'
Plugin 'vim-scripts/awk.vim'

colorscheme mustang
if has('gui_running')
  set guifont=Monaco\ 11
  set guioptions=aeip
  let g:ref_man_cmd = 'man -P cat'
else
  set term=$TERM
endif

filetype plugin indent on
syntax on
runtime! macros/matchit.vim

let g:netrw_home = $HOME . '/.dotfiles/tmp'
let g:netrw_browsex_viewer = "xdg-open"
let g:netrw_list_hide='.*\.swp$,.*\.pyc$,.*~'
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4 " 3 for new tab
let g:netrw_preview = 1
let g:netrw_altv = 0
let g:netrw_winsize = 25

let g:syntastic_enable_balloons = 1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_check_on_wq = 0
let g:syntastic_always_populate_loc_list = 1

let g:airline_theme='bubblegum'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_symbols = { 'linenr': '¶', 'branch'     : '⎇',
                        \ 'paste' : 'ρ', 'whitespace' : 'Ξ' }
let g:airline_mode_map = { '__' : '-', 'n' : 'N', 'i' : 'I',  'R'  : 'R',
                         \ 'c'  : 'C', 'v' : 'V', 'V' : 'VL', '' : 'VB' }
let g:airline#extensions#tagbar#flags = 'f'
let g:airline#extensions#tabline#enabled = 1

let g:signify_vcs_list = [ 'git' ]
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsCenterLine = 0

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'Et'

let g:HowMuch_auto_engines = ['py']
let g:HowMuch_scale = 9

let g:tex_flavor = "latex"
let g:LatexBox_Folding = 1
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

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_select = 0
let g:neocomplete#use_vimproc = 1
let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#force_omni_input_patterns = {
      \    'tex' : '\v(\\\k+|\{[^}]*|\$[^$ ~]*)$',
      \ 'python' : '\k\.\k\{1,}$',
      \   'html' : '\(<\|<\/\|<[^>]\+ \|<[^>]\+=\"\)\k\{1,}$',
      \    'css' : '\(^\s\|[;{]\)\s*\k\{1,}$',
      \     'js' : '\k\.\k\{1,}$',
      \    'xml' : '\(<\|<\/\|<[^>]\+ \|<[^>]\+=\"\)\k\{1,}$',
      \   'ruby' : '\v([^. \t](\.|::)|(^|[^:]):)\k*$'
      \ }
inoremap <expr> <CR>  <C-r>=pumvisible() ? neocomplete#close_popup() : "\<C-v><CR>"<CR>
au FileType c,cpp,cuda,python :call neocomplete#init#disable()
let g:ycm_filetype_whitelist = { 'c': 1, 'cpp': 1, 'cuda': 1, 'python': 1 }
let g:ycm_key_list_select_completion = ["<C-n>", "<Down>"]
let g:ycm_key_list_previous_completion = ["<C-p>", "<Up>"]
let g:ycm_key_detailed_diagnostics = ''
let g:ycm_confirm_extra_conf = 0

let g:UltiSnipsJumpForwardTrigger = "<TAB>"
let g:UltiSnipsJumpBackwardTrigger = "<S-TAB>"
let g:UltiSnipsSnippetsDir = "~/.vim/bundle/vim-snippets/UltiSnips"
let g:UltiSnipsEditSplit = "vertical"

set modeline ve=block,onemore ",insert
set nu rnu nowrap list ls=2 "showmode pastetoggle=<F2>
set nrformats-=octal showmatch autoread
set backspace=indent,eol,start ww+=<,>,[,],~,h,l
set smartindent autoindent copyindent
set smarttab tabstop=2 shiftwidth=2 shiftround expandtab
set incsearch hlsearch ignorecase smartcase gdefault infercase
set showbreak=… listchars=trail:·,eol:¬,tab:»-,extends:❯,precedes:❮
set wildmenu wildmode=full " set wildmode=longest:full,list #Tab won't work
set wildignore=*.o,*~,*.swp
set swb=useopen,usetab,newtab showtabline=1 history=1000
set lazyredraw noerrorbells visualbell ttyfast
set autochdir scrolloff=3 siso=8 showcmd hidden formatoptions+=j nojoinspaces
set clipboard=unnamedplus,autoselect
set t_ut=  mouse=a " tmux fixes
set mousemodel=popup_setpos shell=/bin/zsh ffs+=mac tpm=50 viminfo^=!,%
set undofile undodir=~/.undodir undolevels=1000 undoreload=1000
let &colorcolumn="".join(range(81,999),",")

noremap <silent> <C-Z> :GundoToggle<CR>
noremap <silent> <F2> :set invpaste<CR>
noremap <silent> <F9> :TagbarToggle<CR>
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
noremap j gj
noremap k gk
nnoremap <silent> cog :SignifyToggle<CR>
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
vnoremap <C-c> "+y
vmap <Leader><Enter> <Plug>(LiveEasyAlign)
vmap <expr> <A-=> ":normal " . (col("'<")+1) . "li<A-=><CR>"
imap <A-=> <C-c>hdiWa<C-R>=<C-R>"<CR> <C-c>i
"dirty way of adding a space w/o ACP^^^^^^^
inoremap <C-U> <C-G>u<C-U>
nnoremap <silent> gl ?\W<CR>l:s/\v(%#\w+)(\_W+)(\w+)/\3\2\1/<CR><C-o>/\w\+\_W\+<CR>:noh<CR>
nnoremap <silent> gh ?\W\+<CR>Bl:s/\v(%#\w+)(\_W+)(\w+)/\3\2\1/<CR><C-o>:noh<CR>
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>
nnoremap <BS> dh
nnoremap <CR> i<CR><ESC>
map <silent> <F10> :echom "hi<" . synIDattr(synID(line("."),col("."),1),"name")
      \. '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
map Q gq
nnoremap <silent> <F3> :exec (&ft == 'vim' ? '' : &ft) . ' ' . getline('.')<CR>
vnoremap <silent> <F3> :<C-U>exec (&ft == 'vim' ? '' : &ft) . ' ' . getreg('*')<CR>

au BufRead,BufNewFile input*txt set commentstring=\!\ %s
au FileType awk set commentstring=#\ %s
au InsertEnter * set norelativenumber
au InsertLeave * set relativenumber
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif
