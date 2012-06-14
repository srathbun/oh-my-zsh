# Personalized!

# Grab the current version of ruby in use (via RVM): [ruby-1.8.7]
if which rvm-prompt &> /dev/null; then
  DALLAS_CURRENT_RUBY_="%{$fg[white]%}[%{$fg[magenta]%}\$(~/.rvm/bin/rvm-prompt i v)%{$fg[white]%}]%{$reset_color%}"
else
  if which rbenv &> /dev/null; then
    DALLAS_CURRENT_RUBY_="%{$fg[white]%}[%{$fg[magenta]%}\$(rbenv version | sed -e 's/ (set.*$//')%{$fg[white]%}]%{$reset_color%}"
  fi
fi
# my prompt stuff

setopt prompt_subst
autoload -Uz vcs_info

# zstyle setup of the vcs_info display
# Information in "man zshcontrib"

# check for changes in the git repository
# 
# can be slow, comment it out if you encounter delays
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:hg:*' check-for-changes true
 
# Used VCS use 
# %  vcs_info_printsys 
# for supported systems 
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:git*:*' get-revision true
zstyle ':vcs_info:hg*:*' get-revision true
zstyle ':vcs_info:hg*:*' get-mq false
zstyle ':vcs_info:hg*:*' get-bookmarks true

# Format when some action is going on in 
# your repository (rebranch,merge conflict, ...)
#
#zstyle ':vcs_info:*' actionformats "[%{$fg[magenta]%}%s%{$reset_color%}|%{$fg[cyan]%}%b%{$reset_color%}|%{$fg[white]%}%a%{$reset_color%}]"

#zstyle ':vcs_info:*' actionformats "%{$fg[yellow]%}%c %u %{$reset_color%}\
#[%{$fg[magenta]%}%s%{$reset_color%}|\
#%{$fg[cyan]%}%b%{$reset_color%}|\
#%{$fg[white]%}%a%{$reset_color%}]"

# Default format: [git|master]  
#zstyle ':vcs_info:*' formats       "[%{$fg[magenta]%}%s%{$reset_color%}|\
#%{$fg[cyan]%}%b%{$reset_color%}]"

zstyle ':vcs_info:hg*' formats "%F{8}(%s)[%F{244}%i%F{11}%u %F{88}%U%b%%u%f %F{18}%m%F{8}]%f"
zstyle ':vcs_info:hg*' actionformats "%F{8}(%s|%F{9}%a%F{8})[%F{244}%i%F{11}%u %F{88}%U%b%%u%f %F{18}%m%F{8}]%f"

# hash changes branch misc
zstyle ':vcs_info:git*' formats "(%s)[%12.12i %u %b %m]"
zstyle ':vcs_info:git*' actionformats "(%s|%a)[%12.12i %u %b %m]"

zstyle ':vcs_info:hg*:*' unstagedstr "+"
#zstyle ':vcs_info:git:*' formats   "%{$fg[yellow]%}%c %u %{$reset_color%}\
#[%{$fg[magenta]%}%s%{$reset_color%}|\
#%{$fg[cyan]%}%b%{$reset_color%}]"
#
# Different branch formats
# [svn|www-1173739]
zstyle ':vcs_info:git:*' branchformat '%b-%r'
zstyle ':vcs_info:hg:*' branchformat '%b'
# use %h to get the hash for hg revisions
zstyle ':vcs_info:hg:*' hgrevformat '%r'

# get vcs_info to collect informations
precmd () { 
	vcs_info
}

NET_LOCATION='%{$fg[red]%}%n%{$reset_color%} at %U%{$fg[green]%}%m%u%{$reset_color%}'

LOCATION='in %{$fg_bold[blue]%}${PWD/#$HOME/~}%{$reset_color%}'

function check_make () {
	make -q &>/dev/null
	if [ $? -eq 1 ]; then
		echo -ne "!"
	fi
}

# Use a % for normal users and a # for privelaged (root) users.
USER_PRIV="%(!.%{$fg_bold[red]%}#.%{$fg_bold[blue]%}%%)%{$reset_color%}"
ADDITIONAL_INFO="[ %F{11}\$(check_make)%f ]"

#REPOS='$(hg_prompt_info_with_color)$(git_prompt_info)'
REPOS='${vcs_info_msg_0_}'

function virtualenv_info {
	    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

PROMPT="
$NET_LOCATION $LOCATION
$REPOS
$(virtualenv_info)$ADDITIONAL_INFO$USER_PRIV "

# Use %_ to show why you are in a continued prompt
# Expansion prompt for multiline commands
PROMPT2="%{$fg[white]%}%_> %{$reset_color%}"

# SELECT prompt
PROMPT3="%{$fg[white]%}?# %{$reset_color%}"

# Trace prompt for debugging
PROMPT4="%{$fg[cyan]%}+%N%{$reset_color%}%{$fg[white]%}:%i> %{$reset_color%}"

# Right prompt setup
# Grab the current date (%D) and time (%T) wrapped in []: [%D %T]
CURRENT_TIME='%F{241}[%f%{$fg[yellow]%}%D %T%F{241}]%f%{$reset_color%}'

RPROMPT="$CURRENT_TIME%(?,, [status: %?])%(1j, [jobs: %j],)"
