# env for interactive shell

# moved this part to /etc/zsh/zshenv
# if [[ -n $TMUX  || $TERM == *screen* ]]; then
#   export TERM=xterm-screen-256color
# else
#   export TERM=xterm-256color
#   if [[ `tty` == *pts* ]]; then
#     exec tmux
#   fi
# fi
#
D="$HOME/.dotfiles"
export LANG=en_US.UTF-8
export LC_ALL=$LANG
export LANGUAGE=$LANG
export PATH=$HOME/bin:$PATH:/opt/aiida_epfl-0.5.0/bin
# export PYTHONPATH=/opt/python-ase-3.8.1.3440:/opt/aiida_epfl-0.5.0:$PYTHONPATH
export FPATH=$D/autoload:$D/external/completion/src:$FPATH
export TEXMFHOME=$HOME/.texmf
export R_LIBS="$HOME/.rlibs/"

# variables for the shell itself only

DIRSTACKSIZE=20
HISTFILE="$D/tmp/history"
HISTSIZE=12000
SAVEHIST=10000
KEYTIMEOUT=1
mailpath=( "$D/tmp/mails.log?COMPLETED: \$(tail -1 \$_)" )

# settings about colors etc

autoload -Uz promptinit && promptinit && prompt sencer
export GREP_COLORS="ms=00;38;5;157:mc=00;38;5;157:sl=:cx=:fn=00;38;5;74\
:ln=00;38;5;174:bn=00;38;5;174:se=00;38;5;174"
eval "$(dircolors "$D/data/dircolors")"
tabs -2; tput cuu1

# load settings, then autoloadable functions

for i ($D/autosource/*(.)) source $i
for i ($D/autoload/^_*(:t)) autoload -U $i

# packages, modules, functions to load

source $D/tmp/dirs                  # load previously saved dir names
source '/etc/zsh_command_not_found' # suggest package containing command
autoload -U zmv                     # move files using patterns
# autoload -U zargs                 # zargs argument parser
zmodload zsh/pcre                   # perl compatible shell regex

# this is for pbs server management

typeset -xT PBS_SERVER_LIST pbs_server_list
export PBS_SERVER_LIST=:nano:tiger:della:tigress:edison:hopper:hecate:cori:adroit:tiger-x:

# # vi-mode inner, surround etc text objects

# source $D/external/opp/opp.zsh
# source $D/external/opp/opp/surround.zsh
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround

# history substring search

source $D/external/hist-search/zsh-history-substring-search.zsh
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'

# syntax highlighting settings

source $D/external/syntax/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)  # root

ZSH_HIGHLIGHT_STYLES[default]='fg=254' # commandseparator hashed-command assign
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=198,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=123'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=123,underline'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=123,bold'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=123'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=123'
ZSH_HIGHLIGHT_STYLES[alias]='fg=81'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=229'
ZSH_HIGHLIGHT_STYLES[function]='fg=217'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=40,bold'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=40'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=51'
ZSH_HIGHLIGHT_STYLES[path]='fg=254,underline'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=254,bold"
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=40'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=15,standout'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=81,standout'

unset D i
disable r
source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='-x'
# export NVIM_TUI_ENABLE_TRUE_COLOR=1
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export VIDIR_EDITOR_ARGS="+setf vidir-ls"
export R_LIBS="/opt/rlibs"
export A="$HOME/software/awk-scripts"

export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export WORKON_HOME=~/.virtualenvs
source ~/.local/bin/virtualenvwrapper.sh
export VIRTUAL_ENV_DISABLE_PROMPT=1
# workon main

cat ~/.dotfiles/tmp/work.md
set-pbsserver-var

chmod +x ~/.vocab
~/.vocab
