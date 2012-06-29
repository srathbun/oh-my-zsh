# history options for zsh
HISTSIZE=20000
SAVEHIST=15000
HISTFILE=$ZSH/log/.zsh_history
setopt appendhistory SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_REDUCE_BLANKS

