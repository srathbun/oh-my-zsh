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
autoload -U colors && colors
autoload -U promptinit
autoload -Uz vcs_info

# zstyle setup of the vcs_info display
# Information in "man zshcontrib"

# check for changes in the git repository
# 
# can be slow, comment it out if you encounter delays
zstyle ':vcs_info:(hg*|git*):*' check-for-changes true
 
# Used VCS use 
# %  vcs_info_printsys 
# for supported systems 
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:(hg*|git*):*' get-revision true
zstyle ':vcs_info:hg*:*' get-mq false
zstyle ':vcs_info:hg*:*' get-bookmarks true

# Default format: [git|master]  
zstyle ':vcs_info:hg*' formats "%F{8}(%s)[%F{244}%i%u %F{88}%U%b%%u%f %F{18}%m%F{8}]%f"
zstyle ':vcs_info:hg*' actionformats "%F{8}(%s|%F{9}%a%F{8})[%F{244}%i%F{11}%u %F{88}%U%b%%u%f %F{18}%m%F{8}]%f"

# patch info
zstyle ':vcs_info:hg*:*' get-unapplied true
zstyle ':vcs_info:hg*:*' patch-format "mq(%g):%n/%c %p"
zstyle ':vcs_info:hg*:*' nopatch-format "mq(%g):%n/%c %p"

# hash changes branch misc
zstyle ':vcs_info:git*' formats "%F{8}(%s)[%F{244}%12.12i %c%F{11}%u %F{88}%U%b%%u%f %F{18}%m%F{8}]%f"
zstyle ':vcs_info:git*' actionformats "%F{8}(%s|%F{9}%a%F{8})[%F{244}%12.12i %c%F{11}%u %F{88}%U%b%%u%f %F{18}%m%F{8}]%f"

# staged or unstaged
zstyle ':vcs_info:hg*:*' unstagedstr "%F{11}+%f"
zstyle ':vcs_info:git*:*' stagedstr "%F{11}S%f"
zstyle ':vcs_info:git*:*' unstagedstr "%F{9}U%f"

# Different branch formats
# [svn|www-1173739]
zstyle ':vcs_info:git:*' branchformat '%b-%r'
zstyle ':vcs_info:hg:*' branchformat '%b'
# use %h to get the hash for hg revisions
zstyle ':vcs_info:hg:*' hgrevformat '%r'

# debug?
zstyle ':vcs_info:*+*:*' debug false
# hooks
# currently hg-storerev and hg-branchhead do not work
# zstyle ':vcs_info:hg*+set-message:*' hooks hg-storerev hg-branchhead 
zstyle ':vcs_info:hg*+set-message:*' hooks mq-vcs
zstyle ':vcs_info:git*+set-message:*' hooks git-st git-stash git-untracked


### Store the localrev and global hash for use in other hooks
function +vi-hg-storerev() {
    user_data[localrev]=${hook_com[localrev]}
    user_data[hash]=${hook_com[hash]}
}

### Show marker when the working directory is not on a branch head
# This may indicate that running `hg up` will do something
function +vi-hg-branchhead() {
    local branchheadsfile i_tiphash i_branchname
    local -a branchheads

    local branchheadsfile=${hook_com[base]}/.hg/branchheads.cache

    # Bail out if any mq patches are applied
    [[ -s ${hook_com[base]}/.hg/patches/status ]] && return 0

    if [[ -r ${branchheadsfile} ]] ; then
        while read -r i_tiphash i_branchname ; do
            branchheads+=( $i_tiphash )
        done < ${branchheadsfile}

        if [[ ! ${branchheads[(i)${user_data[hash]}]} -le ${#branchheads} ]] ; then
            hook_com[revision]="${c4}%F{9}^%f${c2}${hook_com[revision]}"
        fi
    fi
}

### Show when mq itself is under version control
function +vi-mq-vcs() {
	if [[ -d ${hook_com[base]}/.hg/patches/.hg ]]; then
		hook_com[hg-mqpatch-string]="mq:${hook_com[hg-mqpatch-string]}"
	fi
}

# Show remote ref name and number of commits ahead-of or behind
function +vi-git-st() {
	local ahead behind remote
	local -a gitstatus

	# Are we on a remote-tracking branch?
	remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
				--symbolic-full-name --abbrev-ref 2>/dev/null)}

	if [[ -n ${remote} ]] ; then
		# for git prior to 1.7
		# ahead=$(git rev-list origin/${hook_com[branch]}..HEAD | wc -l)
		ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
		(( $ahead )) && gitstatus+=( "%F{11}+${ahead}%f" )

		# for git prior to 1.7
		# behind=$(git rev-list HEAD..origin/${hook_com[branch]} | wc -l)
		behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
		(( $behind )) && gitstatus+=( "%F{9}-${behind}%f" )

		hook_com[branch]="${hook_com[branch]}%u %F{8}[%F{88}${remote} %f${(j:/:)gitstatus}%F{8}]%f"
	fi
}

# Show count of stashed changes
function +vi-git-stash() {
	local -a stashes

	if [[ -s ${hook_com[base]}/.git/refs/stash ]] ; then
		stashes=$(git stash list 2>/dev/null | wc -l)
		hook_com[misc]+=" (${stashes} stashed)"
	fi
}


# Indicate if there are any untracked files present
function +vi-git-untracked() {
	local untracked

	#check if there's at least 1 untracked file
	untracked=${$(git ls-files --exclude-standard --others | head -n 1)}

	if [[ -n ${untracked} ]] ; then
		hook_com[unstaged]="${hook_com[unstaged]}%F{11}?%f"
	fi
}



# get vcs_info to collect informations
precmd () { 
	vcs_info
}

NET_LOCATION='%{$fg[red]%}%n%{$reset_color%} at %U%{$fg[green]%}%m%u%{$reset_color%}'

LOCATION='in %{$fg_bold[blue]%}${PWD/#$HOME/~}%{$reset_color%}'

# If there is a makefile in the current dir, check if it is up to date
function check_make () {
	make -q &>/dev/null
	if [ $? -eq 1 ]; then
		echo -ne "!"
	fi
}

# Use a % for normal users and a # for privelaged (root) users.
USER_PRIV="%(!.%{$fg_bold[red]%}#.%{$fg_bold[blue]%}%%)%{$reset_color%}"
# status indicators for various things
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
