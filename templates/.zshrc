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
plugins=(git github git-flow mercurial pip python compleat command-not-found cpanm debian dircycle dirpersist django extract heroku perl rvm zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# active highlighter scripts
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern root)

ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')


# Customize to your needs...
export PATH=/home/srathbun/.local/bin:/home/srathbun/.local/bin:/home/srathbun/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:

export EDITOR="vim"

# WELCOME SCREEN
#######################################################

echo -ne "${WHITE} USA Linux Users Group ${NC}"; echo "";
echo -e "Kernel Information: " `uname -smr`;
echo -e ${LIGHTBLUE}`bash --version`;echo ""
echo -ne "Hello $USER today is "; date
echo -e "${WHITE}"; cal ; echo "";
echo -ne "${CYAN}";netinfo;
echo -e "${RED}"; tail $ZSH/log/.zsh_history | cut -f 2 -d ';'; echo ""
echo -e "${CYAN}"; mountedinfo ; echo ""
echo -ne "${WHITE} http://usalug.org${NC}"; echo ""; fortune -s; echo ""
