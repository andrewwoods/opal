#
# .bashrc - this file runs when any news bash shell is created
#
export OPAL_DIR="$HOME/opal"

################################################################################
#
#		COLORS
#
#e###############################################################################
export TERM=xterm-color

# Reset
Color_Off='\033[0m'       # Text Reset

export Color_Off

# Regular Colors
#---------------------------------------
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

export Black Red Green Yellow 
export Blue Purple Cyan White


# Bold
#---------------------------------------
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

export BBlack BRed BGreen BYellow 
export BBlue BPurple BCyan BWhite

# Underline
#---------------------------------------
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White
export UBlack URed UGreen UYellow 
export UBlue UPurple UCyan UWhite

# Background
#---------------------------------------
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White
export On_Black On_Red On_Green On_Yellow 
export On_Blue On_Purple On_Cyan On_White

# High Intensty
#---------------------------------------
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White
export IBlack IRed IGreen IYellow 
export IBlue IPurple ICyan IWhite

# Bold High Intensty
#---------------------------------------
BIBlack='\e[1;90m'      # Black
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIBlue='\e[1;94m'       # Blue
BIPurple='\e[1;95m'     # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White
export BIBlack BIRed BIGreen BIYellow 
export BIBlue BIPurple BICyan BIWhite

# High Intensty backgrounds
#---------------------------------------
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[10;95m'  # Purple
On_ICyan='\e[0;106m'    # Cyan
On_IWhite='\e[0;107m'   # White
export On_IBlack On_IRed On_IGreen On_IYellow 
export On_IBlue On_IPurple On_ICyan On_IWhite


if [[ $OPAL_NOOB -eq '1' ]]; then
	echo "Loading Noob Settings"
	source $OPAL_DIR/noob.bash
fi



################################################################################
#
#		ENVIRONMENT VARIABLES
#
################################################################################

if [ "$UID" = "0" ]; then
  PS1="${BRed}${On_Black}\u${BBlue}@\h${Color_Off}:\n\@ \W \\$ "
else
  PS1="${BGreen}\u@\h:${Color_Off}\n\@ \W $ "
fi

EDITOR="vim"
PAGER="less"
GIT_EDITOR=$EDITOR
SVN_EDITOR=$EDITOR
VISUAL=$EDITOR

export EDITOR GIT_EDITOR SVN_EDITOR VISUAL 


################################################################################
#
#		ALIASES
#
################################################################################

alias please='sudo'
alias diff='diff -bB'
alias empty='truncate'
alias ls='ls -F'
alias lsdir='ls -l | awk '\''/^d/ {print $9;}'\''' 
alias luls='ls -1rt | tail -n 20'
alias localip='ifconfig | grep "inet 192.168"'
alias myip="curl http://ifconfig.me"
alias nl="nl -b a"
alias number="nl -b a"
alias nocomment='grep -Ev '\''^(#|$)'\'''
alias vi="vim"
alias weather="telnet rainmaker.wunderground.com 3000"

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
function punch(){
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
function mkcd (){
	mkdir $1 && cd $1
}

#
# change to a  directory and list its content 
#
function cdls (){
	cd $1 && ls 
}

#
# display a date using the specified format 
# 
#
function today(){
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

#
# touch a file and make it executable. touch creates the file if it doesn't exist
#
function touchx(){
	touch $1 && chmod ugo+x $1
	
	if [[ $2 == "phpinfo" ]]; then
		echo "<?php phpinfo(); ?>" >> $1
	fi
}

#
# displays the basic information about the system
#
function mach(){
	echo -e "\nMachine information:" ; uname -a
	echo -e "\nUsers logged on:" ; w -h
	echo -e "\nCurrent date :" ; date
	echo -e "\nMachine status :" ; uptime
	echo -e "\nFilesystem status :"; df -h
}

#
# display information about an aspect of the bash programming environment
#
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
	name=$(whoami)
	host=$(hostname -f)
	thisday=$(today now)

    echo '###########################################################'
    echo '# '
    prompt "# Hello ${name}"  
    prompt "# You are logged into ${host}"  
    echo '# '
    prompt "# Today is ${thisday}" 
    echo '# '
    echo '###########################################################'
}

#
# get a recursive ilist of all directories under 'directory'. defaults to cwd.
#
function lsd()
{
	if [[ $1 ]]; then
		dir=$1
	else
		dir="."
	fi
	
	find $dir -type d
}

#
# Tell the user whan a command is done
#
function say_done()
{
	if [[ -n $(which say) ]]; then
		say "done"
	else 
		echo "Done!"
	fi
}

#
#
#
function bak()
{
	if [ -d $1 ]; then
		tar -zcvf $1{.tar.gz,}
	elif [ -f $1 ]; then
		cp $1{,.bak}
	else
		echo "do something else"
	fi
}

#
# "uncompress" a file from a variety of formats
#
function extract()
{
	if [ -f $1 ]; then
		case $1 in
		*.tar.bz2)  tar xjf $1 ;;
		*.tar.gz)   tar xzf $1 ;;
		*.bz2)      bunzip2 $1 ;;
		*.rar)      rar x $1 ;;
		*.gz)       gunzip  $1 ;;
		*.tar)      tar xf $1 ;;
		*.tbz2)     tar xjf $1 ;;
		*.tgz)      tar xzf $1 ;;
		*.zip)      unzip $1 ;;
		*.Z)        uncompress $1 ;;
		*.7z)       7z x $1 ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

#
# otd - On This Day. Display what happened on this day in history
#
function otd()
{
	today_date=$(date +"%m/%d")
	echo ""
	echo "On this date"

	cals=(/usr/share/calendar/calendar.computer \
	/usr/share/calendar/calendar.history \
	/usr/share/calendar/calendar.music \
	/usr/share/calendar/calendar.judaic \
	/usr/share/calendar/calendar.mine \
	/usr/share/calendar/calendar.christian)

	for i in "${cals[@]}"; do
		if [ -f $i ]; then
			grep -h "^${today_date}" $i
		fi
	done
}

#
# display a dynamic prompt
#
function prompt()
{
	$OPAL_DIR/typer $1
}

#
# Exchange the contents of two files
#
function swap()
{
	temp="temp.tmp"

	mv $1 $temp
	mv $2 $1
	mv $temp $2
}

#
# Display a list of your ssh keys
#
function lskeys()
{
	prompt "my ssh keys"
	ls ~/.ssh/*.pub	
}

#
# remove the contents of a file without destroying the file 
#
function truncate()
{
	cat /dev/null > $1
}

#
# lookup the definition of a word
#
function define()
{
	curl dict://dict.org/d:"$@";
}

#
# Create a SHA1 digest of a file
#
function sha1()
{
	if [[ -n $(which openssl) ]]; then
		openssl sha1 $@
	else 
		echo "openssl is required, but not installed"
	fi
}

#
# lookup the http status code by number to refresh your memory
#
function htstatus()
{
	grep -A 1 ^$1 $OPAL_DIR/data/http-status-codes.txt
	echo " "
	echo "see http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html for more information"
}

#
# a floating point calculator
#
function calc()
{ 
	awk 'BEGIN { OFMT="%f"; print '"$*"'; exit}'; 
}

#
# lookup country code
#
function country()
{
	awk -F "\t" -f $OPAL_DIR/country_lookup.awk -v country=$1  $OPAL_DIR/data/iso-country-codes.txt 
}

