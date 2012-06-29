# completion options for zsh

#zstyle ':completion:*' completer _expand _complete _ignored
#zstyle ':completion:*' completions 1
#zstyle ':completion:*' glob 1
#zstyle ':completion:*' list-colors ''
#zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-/]=** r:|=**' 'l:|=* r:|=*'
#zstyle ':completion:*' menu select=1
#zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
#zstyle ':completion:*' substitute 1
#zstyle :compinstall filename '/home/srathbun/.oh-my-zsh/custom/complete.zsh'

# completion directory
fpath=($ZSH/zsh-completions $fpath)
# select first entry in menucompletion
# setopt menucomplete
### If you want zsh's completion to pick up new commands in $path automatically
### comment out the next line and un-comment the following 5 lines
zstyle ':completion:::::' completer _complete _match _approximate
#_force_rehash() {
#  (( CURRENT == 1 )) && rehash
#  return 1# Because 	we didn't really complete anything
#}
#zstyle ':completion:::::' completer _force_rehash _complete _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*' menu yes select interactive
zstyle ':completion:*' verbose yes

zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
# zsh 4.1.x only
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

zstyle ':completion:*:match:*' original only

# ignore parent directory
zstyle ':completion:*:(cd|mv|cp):*' ignore-parents parent pwd
# ignore already added files
zstyle ':completion:*:(rm|kill|diff):*' ignore-line yes
# ignore completion functions
zstyle ':completion:*:functions' ignored-patterns '_*'

zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes-names' command  'ps c -u ${USER} -o command | uniq'

