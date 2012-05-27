#
# .bashrc - this file runs when any news bash shell is created
#


################################################################################
#
#		ENVIRONMENT VARIABLES
#
################################################################################

PS1="\u@\h:\n\@ \W$ "
SVN_EDITOR="vim"
EDITOR="vim"
VISUAL="vim"

export EDITOR SVN_EDITOR VISUAL 


################################################################################
#
#		ALIASES
#
################################################################################

alias diff='diff -bB'
alias ls='ls -F'
alias lsdir='ls -l | awk '\''/^d/ {print $9;}'\''' 
alias luls='ls -1rt | tail -n 20'
alias localip='ifconfig | grep "inet 192.168"'
alias myip="curl -s http://checkip.dyndns.org | sed 's/[a-zA-Z/<> :]//g'"
alias nl="nl -b a"
alias grep="grep -H -i -n -R "  


#:::::::[ VIM ALIASES ]:::::::::::::::::::::::::::::::::::::::::::::::::::::::::

alias druvi='vim -u ~/opal/vimrc_drupal'
alias wpvi='vim -u ~/opal/vimrc_wordpress'
alias zendvi='vim -u ~/opal/vimrc_zend'
alias rbvi='vim -u ~/opal/vimrc_ruby'
alias civi='vim -u ~/opal/vimrc_codeigniter'


################################################################################
#
#		FUNCTIONS
#
################################################################################

# Keep track of your time. It will update timesheet.txt in your $HOME 
# directory. The options 'in' and 'out' are just for events like meetings or 
# leaving for the day. Use the 'note' option when you wanna say what you worked 
# on, or even just say how long you took for lunch.
#
# $ punch in 
# $ punch in "type a brief message here" 
# $ punch out
# $ punch out "type a brief message here" 
# $ punch note "type a brief message here" 
#
punch(){
	if [[ $1 == "in" ]]; then
		MESG=$(date +"%a %Y-%m-%d %H:%M:%S") 
		MESG="$MESG IN"
		if [[ -n $2 ]]; then
			MESG="$MESG $2"
		fi
		echo $MESG >> $HOME/timesheet.txt 

	elif [[ $1 == "out" ]]; then
		MESG=$(date +"%a %Y-%m-%d %H:%M:%S") 
		MESG="$MESG OUT"
		if [[ -n $2 ]]; then
			MESG="$MESG $2"
		fi
		echo $MESG >> $HOME/timesheet.txt 

	elif [[ $1 == "note" ]]; then
		MESG=$(date +"%a %Y-%m-%d %H:%M:%S") 
		MESG="$MESG NOTE"
		if [[ -n $2 ]]; then
			MESG="$MESG $2"
		fi
		echo $MESG >> $HOME/timesheet.txt 

	else
		echo 'punch in OR punch out OR punch note'
	fi
}

#
# make a directory and go into it 
#
mkgo(){
	mkdir $1 && cd $1
}

today(){
	if [[ $1 == "unix" ]]; then
		echo $(date +"%s") 

	elif [[ $1 == "iso" ]]; then

		if [[ $2 == "text" ]]; then
			echo $(date +"%Y %b %d %H:%M:%S") 
		else
			echo $(date +"%Y-%m-%d %H:%M:%S") 
		fi

	elif [[ $1 == "world" ]]; then

		if [[ $2 == "text" ]]; then
			echo $(date +"%d %b %Y %H:%M:%S") 
		else
			echo $(date +"%d/%m/%Y %H:%M:%S") 
		fi

	elif [[ $1 == "us" ]]; then

		if [[ $2 == "text" ]]; then
			echo $(date +"%b %d, %Y %l:%M %p") 
		else
			echo $(date +"%m/%d/%Y %l:%M %p") 
		fi

	else
		echo $(date +"%a %Y %b %d %l:%M %p") 
	fi
}


touchx(){
	touch $1 && chmod ugo+x $1
	
	if [[ $2 == "phpinfo" ]]; then
		echo "<?php phpinfo(); ?>" >> $1
	fi
}


# mach displays the basic information about the system
mach(){
	echo -e "\nMachine information:" ; uname -a
	echo -e "\nUsers logged on:" ; w -h
	echo -e "\nCurrent date :" ; date
	echo -e "\nMachine status :" ; uptime
	echo -e "\nFilesystem status :"; df -h
}


function show(){
	echo -e "Inform the user what can be used"
	echo -e "--------------------------------"
	
	case "$1" in
	arrays)
		declare -a
		;;
	
	defs)
		declare -f
		;;

	names)
		declare -F
		;;

	readonly)
		declare -r
		;;

	exports)
		declare -x
		;;

	integers)
		declare -i
		;;

	*) 
		echo -e "  arrays -  display known arrays " 
		echo -e "  names - display function names only" 
		echo -e "  defs - display functions names and their definitions"
		echo -e "  readonly - display all the readonly variables"
		echo -e "  export - display all exported variables"
		echo -e "  integers - display all integers"
		;;
	esac
}

function preamble {
    echo '###########################################################'
    echo '# '
    echo '# Hello' `whoami` 
    echo '# You are logged into'  `hostname -f` 
    echo '# '
    echo '# FYI, Today is' `today`
    echo '# '
    echo '###########################################################'
}


# get a list (recursive) of all directories under 'directory'. 
# defaults to current dir.
function lsd()
{
	if [[ $1 ]]; then
		dir=$1
	else
		dir="."
	fi
	
	find $dir -type d
}

