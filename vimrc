" Load Plugins {{{1
filetype off
call plug#begin('~/.vim/bundle')
" Appearance {{{2
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'Konfekt/FastFold'
Plug 'regedarek/ZoomWin'

" Essential {{{2
Plug 'imain/notmuch-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tmux-plugins/vim-tmux-focus-events'
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
Plug 'arecarn/selection.vim'
Plug 'arecarn/crunch.vim'
Plug 'PeterRincker/vim-narrow'
" Plug 'haya14busa/incsearch.vim'
Plug 'sencer/vis'
Plug 'gioele/vim-autoswap'

" Text Objects {{{2
Plug 'AndrewRadev/sideways.vim'

" File Type Plugins {{{2
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tpope/vim-git'
Plug 'LaTeX-Box-Team/LaTeX-Box'
" Plug 'lervag/vimtex'
Plug 'vim-ruby/vim-ruby'
Plug 'osyo-manga/vim-monster'
Plug 'sencer/gnuplot.vim'
Plug 'sencer/abinitio.vim'
Plug 'sencer/lammps.vim'
Plug 'tmux-plugins/vim-tmux'
Plug 'sencer/vim-markdown'
Plug 'tmhedberg/SimpylFold'
Plug 'purpleP/python-syntax'

" Completion and Tags {{{2
Plug 'rstacruz/vim-closer'
Plug 'SirVer/UltiSnips'
Plug 'sencer/vim-snippets'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer'}
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
Plug 'kana/vim-textobj-user'

" Various {{{2
Plug 'dhruvasagar/vim-table-mode'
Plug 'KabbAmine/vCoolor.vim'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'kshenoy/vim-signature'
Plug 'chrisbra/color_highlight'
Plug 'ap/vim-css-color'
Plug 'neomake/neomake'
" Plug 'scrooloose/syntastic'
" Plug 'rking/ag.vim'
" Plug 'ctrlpvim/ctrlp.vim'
" Plug 'JazzCore/ctrlp-cmatcher', { 'do': './install.sh' }
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-vinegar'
Plug 'simnalamburt/vim-mundo'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/vim-easy-align'
Plug 'AndrewRadev/writable_search.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'christoomey/vim-tmux-runner'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'fs111/pydoc.vim'

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

" neomake settings {{{2
let g:neomake_open_list = 2
" " syntastic settings {{{2
" let g:syntastic_enable_balloons = 1
" let g:syntastic_error_symbol='✗'
" let g:syntastic_warning_symbol='⚠'
" let g:syntastic_check_on_wq = 0
" let g:syntastic_always_populate_loc_list = 1

" airline settings {{{2
let g:airline_theme='base16'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_detect_spell = 0
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.readonly = ''
let g:airline_mode_map = { '__' : '-', 'n' : 'N', 'i' : 'I',  'R'  : 'R',
      \ 'c'  : 'C', 'v' : 'V', 'V' : 'VL', '' : 'VB' }
let g:airline#extensions#tagbar#flags = 'f'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs=0
let g:airline#extensions#tabline#buffer_idx_mode = 1
for s:i in [1,2,3,4,5,6,7,8,9]
  exec 'nmap <Leader>'.s:i.' <Plug>AirlineSelectTab'.s:i
endfor

" youcompleteme settings {{{2
let g:ycm_key_list_select_completion = ["<C-n>", "<Down>"]
let g:ycm_key_list_previous_completion = ["<C-p>", "<Up>"]
let g:ycm_confirm_extra_conf = 0

" ultisnips settings {{{2
let g:UltiSnipsJumpForwardTrigger = "<TAB>"
let g:UltiSnipsJumpBackwardTrigger = "<S-TAB>"
let g:UltiSnipsSnippetsDir = "~/.vim/bundle/vim-snippets/UltiSnips"
let g:UltiSnipsEditSplit = "vertical"

" ctrlp settings {{{2
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_extensions = ['line', 'quickfix', 'dir' ]
let g:ctrlp_match_func = {'match': 'matcher#cmatch'}
" let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" crunch settings {{{2
let g:crunch_result_type_append = 0
let g:crunch_user_variables = {
      \ 'e'  :  2.71828182846,
      \ 'pi' :  3.14159265359,
      \ 'b2a':  0.529177249,
      \ 'ev' : 13.6056923,
      \ }

" latexbox settings {{{2
let g:tex_flavor = "latex"
" let g:vimtex_fold_enabled = 1
" let g:vimtex_fold_comments = 1
" let g:vimtex_quickfix_mode = 2
" let g:vimtex_quickfix_open_on_warning = 0
" let g:vimtex_viewer_general = "$HOME/bin/evince"
" let g:vimtex_quickfix_ignored_warnings = [
"       \ 'Underfull',
"       \ 'Overfull',
"       \ 'specifier changed to',
"       \ ]
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

" rainbow parens {{{2
let g:rainbow#pairs = [['(', ')'], ['{', '}'], ['[', ']']]

" vcoolor {{{2
let g:vcoolor_disable_mappings = 1
let g:vcoolor_map = '<F5>'

" notmuch {{{2
let g:notmuch_show_folded_threads = 1
let g:notmuch_datetime_format = '%d.%m.%y %H:%M:%S'
let g:notmuch_reader = 'mutt -f %s'
let g:notmuch_folders = [
      \ ['Princeton', 'tag:princeton and not tag:sent'],
      \ ['Gmail', 'tag:gmail and not tag:sent'],
      \ ['Princeton Sent', 'tag:princeton and tag:sent'],
      \ ['Gmail Sent', 'tag:gmail and tag:sent'],
      \ ]

let g:notmuch_custom_search_maps = {
      \ 'd': 'search_tag("+deleted -inbox -unread")',
      \ }
" au BufReadPost notmuch-show set noai nosi tw=80 ma
" let g:notmuch_custom_show_maps = {
"       \ 'd':  'show_tag("+deleted -inbox -unread")',
"       \ }

" various settings {{{2
let g:surround_no_insert_mappings = 1
let g:gitgutter_enabled = 0
au FileType python,tex,latex,vim,tcl
      \ let b:closer = 1 |
      \ let b:closer_flags = '([{'

"}}}1

" VIM settings {{{1

" better defaults and theme {{{2
set termguicolors
set background=dark
let base16colorspace=256
colorscheme gruvbox
if has('gui_running')
  " set guifont=Monaco\ 11
  set guifont=FuraMonoForPowerline\ Nerd\ Font\ 14.5
  set guioptions=aeip
  runtime ftplugin/man.vim
  nnoremap K :<C-U>exe "Man" v:count "<C-r><C-w>"<CR>
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
set softtabstop=2
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
set relativenumber

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
set wildignorecase

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
vnoremap <C-a> <C-a>gv
vnoremap <C-x> <C-x>gv
vnoremap . :norm.<CR>
" nnoremap <CR> i<CR><ESC>
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
nnoremap <silent> coz :MundoToggle<CR>
nnoremap <silent> cof :Vexplore!<CR>
nnoremap <silent> coo :RainbowParentheses!!<CR>

" exchange mappings {{{2
nmap cx <Plug>(Exchange)
nmap gl <Plug>(Exchange)iww.ebb
nmap gh <Plug>(Exchange)iwb.w

" argument mappings
nmap <, :SidewaysLeft<CR>
nmap >. :SidewaysRight<CR>
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI

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

" Crunch mapping
imap <A-=> <C-o>vBg=

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
" youcompleteme maps {{{2
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
" ctrlp maps {{{2
nnoremap <Leader>a  :Ag <C-R>=expand("<cword>")<CR><CR>
nnoremap <Leader>A  :Ag <C-R>=expand("<cWORD>")<CR><CR>
nnoremap <Leader>/  :Ag 
nnoremap <Leader>b  :Buffers<CR>
nnoremap <Leader>c  :BCommits<CR>
nnoremap <Leader>f  :Files<CR>
nnoremap <Leader>l  :Lines<CR>
nnoremap <Leader>j  :History<CR>
nnoremap <Leader>m  :Marks<CR>
nnoremap <Leader>s  :Snippets<CR>
nnoremap <Leader>t  :Tags<CR>
nnoremap <Leader>;  :History:<CR>
nnoremap <Leader>:  :Commands<CR>
" buffer maps {{{2
nnoremap <expr> <Leader>q len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))==1 ? ':q<CR>' : ':bw<CR>'
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
