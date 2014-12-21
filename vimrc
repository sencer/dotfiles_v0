set nocompatible

filetype off

call plug#begin('~/.vim/bundle')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Load Bundles                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'sencer/mustang-vim'
Plug 'mhinz/vim-signify'
Plug 'chrisbra/color_highlight'
Plug 'salsifis/vim-transpose'
Plug 'sk1418/HowMuch'
Plug 'junegunn/vim-easy-align'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'kshenoy/vim-signature'
Plug 'bling/vim-airline'
Plug 'SirVer/UltiSnips'
Plug 'sencer/vim-snippets'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer', 'for': ['c', 'cpp', 'cuda', 'python']}
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/vimproc.vim', { 'do': './make -f make_unix.mak' }
Plug 'tpope/vim-dispatch'
Plug 'jcfaria/Vim-R-plugin', { 'for': 'r' }
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'kana/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'sencer/vis'
Plug 'tommcdo/vim-exchange'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'kana/vim-niceblock'
Plug 'jiangmiao/auto-pairs'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-underscore'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'b4winckler/vim-angry'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails', { 'for': ['ruby', 'eruby'] }
Plug 'fncll/wordnet.vim'
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
Plug 'vim-jp/cpp-vim', { 'for': 'cpp' }
Plug 'tpope/vim-git'
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }  "not
Plug 'leshill/vim-json', { 'for': 'json' }
Plug 'LaTeX-Box-Team/LaTeX-Box', { 'for': ['tex', 'latex'] } 
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby', 'eruby'] }
Plug 'andersoncustodio/vim-tmux'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-markdown', { 'for': 'markdown' } "not
Plug 'sencer/gnuplot.vim', { 'for': 'gnuplot' } "not
Plug 'vim-scripts/awk.vim', { 'for': 'awk' } "not
Plug 'linktohack/vim-space'
Plug 'AndrewRadev/writable_search.vim'
Plug 'mileszs/ack.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'slim-template/vim-slim', { 'for': 'slim' } "not
Plug 'wellle/tmux-complete.vim'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
let g:notes_directories = ['~/gdrive/notes']
let g:notes_suffix = '.md'

call plug#end()

colorscheme mustang
if has('gui_running')
  set guifont=Monaco\ 11
  set guioptions=aeip
else
  set term=$TERM
endif

filetype plugin indent on
syntax on
runtime! macros/matchit.vim

let g:netrw_home = $HOME . '/.dotfiles/tmp'
let g:netrw_browsex_viewer = "xdg-open"
let g:netrw_list_hide=netrw_gitignore#Hide().'.*\.swp$,.*\.pyc$,.*~'
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
let g:ycm_key_list_select_completion = ["<C-n>", "<Down>"]
let g:ycm_key_list_previous_completion = ["<C-p>", "<Up>"]
let g:ycm_key_detailed_diagnostics = ''
let g:ycm_confirm_extra_conf = 0

let g:UltiSnipsJumpForwardTrigger = "<TAB>"
let g:UltiSnipsJumpBackwardTrigger = "<S-TAB>"
let g:UltiSnipsSnippetsDir = "~/.vim/bundle/vim-snippets/UltiSnips"
let g:UltiSnipsEditSplit = "vertical"

let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
nnoremap <F8> :Ack "\b<C-R><C-W>\b"<CR>:cw<CR>

set modeline ve=block,onemore ",insert
set nu rnu nowrap list ls=2 "showmode pastetoggle=<F2>
set nrformats-=octal showmatch autoread
set backspace=indent,eol,start ww+=<,>,[,],~,h,l
set smartindent autoindent copyindent
set smarttab tabstop=2 shiftwidth=2 shiftround expandtab
set incsearch hlsearch ignorecase smartcase gdefault infercase
set showbreak=… listchars=trail:·,eol:¬,tab:»-,extends:❯,precedes:❮,nbsp:∴
set wildmenu wildmode=full " set wildmode=longest:full,list #Tab won't work
set wildignore=*.o,*~,*.swp
set swb=useopen,usetab,newtab showtabline=1 history=1000
set lazyredraw noerrorbells visualbell ttyfast
set autochdir scrolloff=3 siso=8 showcmd hidden formatoptions+=j nojoinspaces
set clipboard^=unnamedplus
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
nnoremap cof :Vexplore!<CR>
nnoremap <CR> i<CR><ESC>
map <silent> <F10> :echom "hi<" . synIDattr(synID(line("."),col("."),1),"name")
      \. '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
map Q gq
nnoremap <silent> <F3> :exec (&ft == 'vim' ? '' : &ft) . ' ' . getline('.')<CR>
vnoremap <silent> <F3> :<C-U>exec (&ft == 'vim' ? '' : &ft) . ' ' . getreg('*')<CR>
onoremap <silent>m //e<CR>

au BufRead,BufNewFile input*txt set commentstring=\!\ %s
au FileType awk set commentstring=#\ %s
au InsertEnter * set norelativenumber
au InsertLeave * set relativenumber
au VimLeave * call system("xsel -ib", getreg('+'))
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif
