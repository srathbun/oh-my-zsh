# Functions for zsh
# #########

# Some example functions
# function settitle() { echo -ne "\e]2;$@\a\e]1;$@\a"; }
function build() { flex -Cf scanner.l; gcc -Wall -O -mno-cygwin -o $1 scanner.c; }
function debugflex() { flex -d scanner.l; gcc -mno-cygwin -o $1 scanner.c; }
function debugc() { flex scanner.l; gcc -g -Wall -mno-cygwin -o $1 scanner.c; }
# use ctrl l to clear screen

netinfo ()
{
echo "--------------- Network Information ---------------"
ifconfig | awk /'inet addr/ {print $2}'
ifconfig | awk /'Bcast/ {print $3}'
ifconfig | awk /'inet addr/ {print $4}'
ifconfig | awk /'HWaddr/ {print $4,$5}'
echo "---------------------------------------------------"
}

function include_d {
	dir=$1
	if [ -d $HOME/.$dir.d -a -r $HOME/.$dir.d -a -x $HOME/.$dir.d ]; then
		for i in $HOME/.$dir.d/*.sh; do
			 source $i
		done
	fi
}

#include_d bash_functions
#include_d bash_aliases
#include_d bash_completion
