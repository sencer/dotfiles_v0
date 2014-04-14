fpath=(
  $HOME/.dotfiles/funcs/
  $HOME/.dotfiles/external/completion/src/
  $fpath
)
source $HOME/.dotfiles/external/hist-search/zsh-history-substring-search.zsh
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'
source $HOME/.dotfiles/external/syntax/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)  # root
ZSH_HIGHLIGHT_STYLES[default]='fg=254'
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
# 'commandseparator' 'hashed-command' 'assign'
source $HOME/.dotfiles/external/opp/opp.zsh
source $HOME/.dotfiles/external/opp/opp/surround.zsh

zmodload zsh/pcre
autoload -U zmv
autoload -U zargs

eval "$(dircolors "$HOME/.dotfiles/data/dircolors")"

export PATH=~/bin/:/mnt/arsiv/software/espresso-5.0.2/bin/:/opt/ruby/bin/:$PATH
export TERM=xterm-256color
export TEXMFHOME=$HOME/.texmf
export DIRSTACKSIZE=20
export PBSSERVERFILE=~/.settings/.server
export GREP_COLORS="ms=00;38;5;157:mc=00;38;5;157:sl=:cx=:fn=00;38;5;74:ln=00;38;5;174:bn=00;38;5;174:se=00;38;5;174"
export GREP_OPTIONS='--color=auto'
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
autoload -Uz promptinit && promptinit
prompt sencer

eval `lesspipe`
eval `lessfile`

for i in ~/.settings/*(.); do source $i;done

setopt CHASE_DOTS HASH_LIST_ALL IGNORE_EOF HIST_REDUCE_BLANKS MAGIC_EQUAL_SUBST
setopt BRACE_CCL          # Allow brace character class list expansion.
setopt COMBINING_CHARS    # Combine zero-length punctuation characters (accents)
setopt RC_QUOTES          # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
setopt LONG_LIST_JOBS     # List jobs in the long format by default.
setopt AUTO_RESUME        # Attempt to resume existing job before creating a new process.
setopt NOTIFY             # Report status of background jobs immediately.
unsetopt BG_NICE          # Don't run all background jobs at a lower priority.
unsetopt HUP              # Don't kill jobs on shell exit.
unsetopt CHECK_JOBS       # Don't report on jobs when shell exit.
# unsetopt MAIL_WARNING     # Don't print a warning message if a mail file has been accessed.
unsetopt NO_MATCH

source ~/.profile
source '/etc/zsh_command_not_found'
