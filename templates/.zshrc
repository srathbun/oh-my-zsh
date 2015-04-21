# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
export ZSH

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="srathbun"

# Example aliases
alias zshconfig="vim $ZSH/custom/"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# zsh-syntax-highlighting plugin must be last in list
ZSH_TMUX_AUTOSTART=true
plugins=(tmux git github git-flow mercurial npm pip python compleat cpanm debian dircycle dirpersist django extract heroku perl zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# active highlighter scripts
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern root)

ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')

# To differentiate aliases from other command types
ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'

ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=yellow'

ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[function]='fg=white'

ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=cyan'

ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=magenta'

#ZSH_HIGHLIGHT_STYLES[assign]=none

# Customize to your needs...
export PATH=/Users/srathbun/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/share/npm/bin:

export BYOBU_PREFIX=$(brew --prefix)
export EDITOR="vim"
source ~/.profile # sources the doctorjs profile info, to set it up

# disable nodeenv path change, since it conflicts with prompt
export NODE_VIRTUAL_ENV_DISABLE_PROMPT=1
export VIRTUAL_ENV_DISABLE_PROMPT=1
# use brew python stuff
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

eval "$(rbenv init -)"
# add cscope db
# CSCOPE_DB=~/cscope/cscope.out; export CSCOPE_DB

source ~/perl5/perlbrew/etc/bashrc

# WELCOME SCREEN
#######################################################

echo -ne "${WHITE} USA Linux Users Group ${NC}"; echo "";
echo -e "Kernel Information: " `uname -smr`;
echo -e ${LIGHTBLUE}`zsh --version`;echo ""
echo -ne "Hello $USER today is "; date
echo -e "${WHITE}"; cal ; echo "";
echo -ne "${CYAN}";netinfo;
echo -e "${RED}"; tail $ZSH/log/.zsh_history | cut -f 2 -d ';'; echo ""
echo -e "${CYAN}"; mountedinfo ; echo ""
echo -ne "${WHITE} http://usalug.org${NC}"; echo ""
