# env for interactive shell
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color
export TEXMFHOME=$HOME/.texmf
export PBS_SERVER_FILE=~/.dotfiles/data/server
export GREP_COLORS="ms=00;38;5;157:mc=00;38;5;157:sl=:cx=:fn=00;38;5;74:ln=00;38;5;174:bn=00;38;5;174:se=00;38;5;174"
export GREP_OPTIONS='--color=auto'
export XCRYSDEN_TOPDIR=/mnt/arsiv/software/xcrysden-1.5.53-bin-semishared
export XCRYSDEN_SCRATCH=/tmp
# these only needed by shell, not the child processes
path=($HOME/bin /opt/ruby/bin $path $XCRYSDEN_TOPDIR{,/scripts,/util})
fpath=($HOME/.dotfiles/{autoload,external/completion/src} $fpath)
mailpath=( "$HOME/.pbsjobs?\$(state)" )
DIRSTACKSIZE=20
HISTFILE="$HOME/.dotfiles/tmp/history"
HISTSIZE=12000
SAVEHIST=10000
eval "$(dircolors "$HOME/.dotfiles/data/dircolors")"
# shell options
setopt CHASE_DOTS HASH_LIST_ALL IGNORE_EOF HIST_REDUCE_BLANKS MAGIC_EQUAL_SUBST\
  CORRECT BEEP BRACE_CCL COMBINING_CHARS RC_QUOTES LONG_LIST_JOBS AUTO_RESUME  \
  NOTIFY MULTIOS AUTO_CD AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME CDABLE_VARS     \
  PUSHD_IGNORE_DUPS AUTO_NAME_DIRS EXTENDED_GLOB COMPLETE_IN_WORD ALWAYS_TO_END\
  PATH_DIRS AUTO_MENU AUTO_LIST AUTO_PARAM_SLASH BANG_HIST EXTENDED_HISTORY    \
  INC_APPEND_HISTORY SHARE_HISTORY HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS     \
  HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS   \
  HIST_VERIFY HIST_BEEP

unsetopt CLOBBER BG_NICE HUP CHECK_JOBS NO_MATCH MENU_COMPLETE FLOW_CONTROL    \
  CASE_GLOB
# unsetopt MAIL_WARNING   # Don't print a warning message if a mail file has been accessed.

# packages, modules, functions to load
for i ($HOME/.dotfiles/autosource/*(.)) source $i
source $HOME/.dotfiles/external/hist-search/zsh-history-substring-search.zsh
source $HOME/.dotfiles/external/syntax/zsh-syntax-highlighting.zsh
source $HOME/.dotfiles/external/opp/opp.zsh
source $HOME/.dotfiles/external/opp/opp/surround.zsh
source '/etc/zsh_command_not_found'
source $HOME/.dotfiles/tmp/dirs
for i ($HOME/.dotfiles/autoload/^_*(:t)) autoload -U $i
autoload -U zmv
autoload -U zargs
zmodload zsh/pcre

autoload -Uz promptinit && promptinit
prompt sencer

# settings of the packages
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'

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

eval $(lesspipe)
