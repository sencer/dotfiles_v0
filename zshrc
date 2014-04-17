# env for interactive shell
D="$HOME/.dotfiles/"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color
export PATH=$HOME/bin:/opt/ruby/bin:$PATH
export MAILPATH="$D/tmp/mails.log?COMPLETED: \$(tail -1 mails)"
export FPATH=$D/autoload:$D/external/completion/src:$FPATH
export TEXMFHOME=$HOME/.texmf

# variables for the shell itself only

DIRSTACKSIZE=20
HISTFILE="$D/tmp/history"
HISTSIZE=12000
SAVEHIST=10000

# load settings, then autoloadable functions

for i ($D/autosource/*(.)) source $i
for i ($D/autoload/^_*(:t)) autoload -U $i

# settings about colors etc

autoload -Uz promptinit && promptinit && prompt sencer
export GREP_COLORS="ms=00;38;5;157:mc=00;38;5;157:sl=:cx=:fn=00;38;5;74\
:ln=00;38;5;174:bn=00;38;5;174:se=00;38;5;174"
export GREP_OPTIONS='--color=auto'
eval "$(dircolors "$D/data/dircolors")"

# packages, modules, functions to load

source $D/tmp/dirs                  # load previously saved dir names
source '/etc/zsh_command_not_found' # suggest package containing command
autoload -U zmv                     # move files using patterns
# autoload -U zargs                 # zargs argument parser
zmodload zsh/pcre                   # perl compatible shell regex
eval $(lesspipe)                    # let less open pdfs, rars etc

# this is for pbs server management

typeset -xT pbs_server_list PBS_SERVER_LIST
export pbs_server_list=nano:tiger:della:tigress:edison:hopper

# vi-mode inner, surround etc text objects

source $D/external/opp/opp.zsh
source $D/external/opp/opp/surround.zsh

# history substring search

source $D/external/hist-search/zsh-history-substring-search.zsh
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'

# syntax highlighting settings

source $D/external/syntax/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)  # root

ZSH_HIGHLIGHT_STYLES=(
  default                         'fg=254'
  unknown-token                   'fg=198,bold'
  command                         'fg=123'
  precommand                      'fg=123,underline'
  reserved-word                   'fg=123,bold'
  single-hyphen-option            'fg=123'
  double-hyphen-option            'fg=123'
  alias                           'fg=81'
  builtin                         'fg=229'
  function                        'fg=217'
  double-quoted-argument          'fg=40,bold'
  single-quoted-argument          'fg=40'
  back-quoted-argument            'fg=51'
  path                            'fg=254,underline'
  dollar-double-quoted-argument   "fg=254,bold"
  back-double-quoted-argument     'fg=40'
  globbing                        'fg=15,standout'
  history-expansion               'fg=81,standout'
) # commandseparator hashed-command assign

unset D i
