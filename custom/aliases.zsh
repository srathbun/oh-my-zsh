# aliases for zsh
alias man=" TERMINFO=~/.terminfo/ LESS=C PAGER=less man"

# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm="rm -i" will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.

# see the usage of a command in history
alias hist=" history | grep $1" #Requires one input

# ALIAS TO REMOTE SERVERS
alias h91502="ssh 192.168.1.43"
alias repo="ssh 192.168.20.24"
alias lddmonline="ssh lddmonline.com"
# alias ANYNAMEHERE="ssh YOURWEBSITE.com -l USERNAME -p PORTNUMBERHERE"

# Alias"s to some of my BashScripts
# alias bics="sh /home/crouse/scripts/bics/bics.sh"
# alias backup="sh /home/crouse/scripts/usalugbackup.sh"
# alias calc="sh /home/crouse/scripts/bashcalc.sh"
# alias makepdf="sh /home/crouse/scripts/makepdf.sh"
# alias phonebook="sh /home/crouse/scripts/PHONEBOOK/baps.sh"
# alias pb="sh /home/crouse/scripts/PHONEBOOK/baps.sh"
# alias ppe="/home/crouse/scripts/passphraseencryption.sh"
# alias scripts="cd /home/crouse/scripts"

# shell fu commands
alias list="find ${*-.} -type f | xargs file | awk -F, \"{print $1}\" | awk \"{$1=NULL;print $0}\" | sort | uniq -c | sort -nr"
# Alias"s to modified commands
alias ps="ps auxf"
alias home="cd ~"
alias pg="ps aux | grep $1"  #requires an argument
alias un="tar -zxvf"
alias mountedinfo="df -hT"
alias ping="ping -c 10"
alias openports="netstat -nape --inet"
alias ns="netstat -alnp --protocol=inet | grep -v CLOSE_WAIT | cut -c-6,21-94 | tail +2"
alias du1="du -h --max-depth=1"
alias da="date \"+%Y-%m-%d %A    %T %Z\""
alias ezrc="vim ~/.zshrc"
alias nuke="kill -9"

# Interactive operation...
# alias rm="rm -i"
# alias cp="cp -i"
# alias mv="mv -i"

# Default to human readable figures
alias df="df -h"
alias du="du -h"

# Misc :)
alias less="less -R"                          # raw control characters
alias whence="type -a"                        # where, of a sort
alias grep="grep -r --color"                  # show differences in colour
alias diff="diff -ayw --suppress-common-lines" # suppress common lines, ignore whitespace and output in column format
alias ports="netstat -tulpn"
alias update="apt-get update && apt-get upgrade"

# Some shortcuts for different directory listings
alias ..=" cd .."
alias cd=" cd"
alias prev=" cd -"
alias ls=" ls -h -F -G"                 # classify files in colour
alias dir=" ls --color=auto --format=vertical"
alias vdir=" ls --color=auto --format=long"
alias ll=" ls -l"                              # long list
alias la=" ls -Al"                             # all but . and ..
alias l=" ls -CF"                              #
alias lx=" ls -lXB"        			  # sort by extension
alias lk=" ls -lSr"            			  # sort by size
alias lc=" ls -lcr"			      # sort by change time
alias lu=" ls -lur"     			  # sort by access time
alias lr=" ls -lR"              			  # recursive ls
alias lt=" ls -ltr"             			  # sort by date
alias lm=" ls -al |more"        			  # pipe through "more"

# this may be deprecated
# alias ls="/bin/ls -F --color=tty --show-control-chars"	# color and show control chars

# Alias chmod commands
alias mx="chmod a+x"
alias 000="chmod 000"
alias 644="chmod 644"
alias 755="chmod 755"

# Alias xterm and aterm
alias term="xterm -bg AntiqueWhite -fg Black &"
alias termb="xterm -bg AntiqueWhite -fg NavyBlue &"
alias termg="xterm -bg AntiqueWhite -fg OliveDrab &"
alias termr="xterm -bg AntiqueWhite -fg DarkRed &"
alias aterm="aterm -ls -fg gray -bg black"
alias xtop="xterm -fn 6x13 -bg LightSlateGray -fg black -e top &"
alias xsu="xterm -fn 7x14 -bg DarkOrange4 -fg white -e su &"

# Alias for lynx web browser
alias bbc="lynx -term=vt100 http://news.bbc.co.uk/text_only.stm"
alias nytimes="lynx -term=vt100 http://nytimes.com"
alias dmregister="lynx -term=vt100 http://desmoinesregister.com"

alias spell="echo $@ | aspell -a list"

# vim without plugins
alias vi="vim -u NONE -N"

# ssh aliases
alias sshdev="ssh -i ~/.ssh/devBoxes dev.e6.rcg.local"
alias sshprod="ssh -i ~/.ssh/devBoxes prod.e6.rcg.local"

# tmux with color support
alias tmux='tmux -2'
