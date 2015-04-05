#
# .bashrc - this file runs when any news bash shell is created
#
export OPAL_DIR="$HOME/opal"
export OPAL_VERSION="1.3"

export cals=(/usr/share/calendar/calendar.computer \
	/usr/share/calendar/calendar.history \
	/usr/share/calendar/calendar.holiday \
	/usr/share/calendar/calendar.usholiday \
	/usr/share/calendar/calendar.music \
	/usr/share/calendar/calendar.judaic \
	/usr/share/calendar/calendar.christian)

if [[ $OPAL_NOOB -eq '1' ]]; then
	echo "Loading Noob Settings"
	source $OPAL_DIR/noob.bash
fi



################################################################################
#
#		ENVIRONMENT VARIABLES
#
################################################################################


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
alias diff='diff -bBs'
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

alias bvi='vim -u ~/opal/vimrc_bash'
alias civi='vim -u ~/opal/vimrc_codeigniter'
alias druvi='vim -u ~/opal/vimrc_drupal'
alias rbvi='vim -u ~/opal/vimrc_ruby'
alias svi='vim -u ~/opal/vimrc_symfony'
alias wpvi='vim -u ~/opal/vimrc_wordpress'
alias zendvi='vim -u ~/opal/vimrc_zend'


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
# 
#
# $ punch in 
# $ punch in "type a brief message here" 
# $ punch out
# $ punch out "type a brief message here" 
# $ punch note "type a brief message here" 
#
function punch(){

	DATADIR=$(datadir)
	DATESTAMP=$(date +"%a %Y-%m-%d %H:%M:%S")

	if [[ $1 == "in" ]]; then
		MESG=$DATESTAMP
		MESG="$MESG IN"
		if [[ -n $2 ]]; then
			MESG="$MESG $2"
		fi
		echo $MESG >> $DATADIR/timesheet.txt

	elif [[ $1 == "out" ]]; then
		MESG=$DATESTAMP
		MESG="$MESG OUT"
		if [[ -n $2 ]]; then
			MESG="$MESG $2"
		fi
		echo $MESG >> $DATADIR/timesheet.txt

	elif [[ $1 == "note" ]]; then
		MESG=$DATESTAMP
		MESG="$MESG NOTE"
		if [[ -n $2 ]]; then
			MESG="$MESG $2"
		fi
		echo $MESG >> $DATADIR/timesheet.txt

	elif [[ $1 == "switch" ]]; then
		MESG=$DATESTAMP
		MESG="$MESG OUT"
		echo $MESG >> $DATADIR/timesheet.txt

		MESG=$DATESTAMP
		MESG="$MESG IN"
		if [[ -n $2 ]]; then
			MESG="$MESG $2"
		fi
		echo $MESG >> $DATADIR/timesheet.txt

	else
		echo 'punch in OR punch out OR punch note OR punch switch'
	fi
}

#
# make a directory and go into it
#
# mkcd( String directory )
#
function mkcd (){
	mkdir $1 && cd $1
}

#
# change to a directory and list its content
#
# cdls( String directory )
#
function cdls (){
	cd $1 && ls 
}

#
# display a date using the specified format
# 
# today( String style [, String type] )
#	style = unix|iso|world|us|default
#	type  = text|numeric
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
# touchx( String filename [, String content] )
#	filename - the file you want to create and make executable
#	content - The type of content to add to the file. Currently, phpinfo is the only value.
#
function touchx(){
	touch $1 && chmod ugo+x $1
	
	if [[ $2 == "phpinfo" ]]; then
		echo "<?php phpinfo(); ?>" >> $1
	fi

	if [[ $1 == 'robots.txt' ]]; then
		echo "User-agent: *" >> $1
		echo "Disallow: /" >> $1
		echo "" >> $1
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
		echo -e "  exports - display all exported variables"
		echo -e "  integers - display all integers"
		;;
	esac
}

#
# Display a block message to the user about who and where they are
#
function preamble {
	name=$(whoami)
	host=$(hostname -f)
	thisday=$(today default)

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
# get a recursive list of all directories under 'directory'. defaults to cwd.
#
# lsd( [String directory] )
#	directory - the directory you want to recursively list the contents of.
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
# Tell the user when a command is done
#
function say_done()
{
	if [[ -n $(which say) ]]; then
		say "it is done"
	else 
		echo "Done!"
	fi
}

#
# Create a backup of a file or directory
#
# extract( String path )
#	path - if path is a file, copy of the file will be made with .bak appended to it's name.
#          if path is a dir, a compressed tarball will be made of the directory 
#
function bak()
{
	if [ -d $1 ]; then
		dir=$1
		dir=${dir%/}
		echo $dir	
		tarfile="${dir}.tar.gz"
		tar -zcvf $tarfile $dir
	elif [ -f $1 ]; then
		cp $1{,.bak}
	else
		echo "BAK: unsupported item type - must be file or directory"
	fi
}

#
# "uncompress" a file from a variety of common formats
#
# extract( String filename )
#	filename - must be a common compressed file type like ZIP or Tar
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
		echo "File not found: '$1'"
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


	for i in "${cals[@]}"; do
		if [ -f $i ]; then
			grep -h "^${today_date}" $i
		fi
	done
}


#
# get the current git branch your on
#
parse_git_branch() {
       git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

#
# display a dynamic prompt. Gets it name from displaying message to users in shell scripts
#
# prompt( String content )
#
function prompt()
{
	$OPAL_DIR/typer "$1"
}


#
# set a bash prompt. 
#
# set_prompt( String type ) - type can be brief, full, color, or compact
#
function set_prompt()
{
	case "$1" in
	brief)
		PS1="\u@\h \W\$(parse_git_branch)\$ "
		;;

	full)
		# andrewwoods@tardis.local ~/opal
		# Sat Jan 18 22:37:10 [626]$ 
		PS1="\n\u@\H \W\n\d \t [\!]\$(parse_git_branch)\$ "
		;;

	compact)
		PS1="\n\u@\h\n\A \W\$(parse_git_branch)\$ "
		;;

	debug)
		PS1="a=\a\nA=\A\nd=\d\nh=\h\nH=\H\nj=\j\nl=\l\ns=\s\nt=\t\nT=\T\n@=\@\nT=\T\nu=\u\nv=\v\nV=\V\nw=\w\nW=\W\n!=\!\n#=\#\n$=\$\n \$ "
		;;

	*)
		echo 'Whoops! brief, full, color, or compact'
		;;
	esac
}




#
# Display an entire file, in the style of prompt. 
#
# type_file( String filename )
#	filename - the first file 
#
function type_file()
{
	$OPAL_DIR/typer -f $1
}

#
# Exchange the contents of two files
#
# truncate( String file_one, String file_two )
#	file_one - the first file 
#	file_two - the two file 
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
# truncate( String filename )
#	filename - the file from which you want to remove the contents 
#
function truncate()
{
	cat /dev/null > $1
}

#
# lookup the dictionary definition of a word
#	
# define( String word )
#	word - the word you want to define 
#
function define()
{
	curl dict://dict.org/d:"$@";
}

#
# Create a SHA1 digest of a file
#
# sha1( String filename )
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
# htstatus( Integer code )
#	code - the numeric status code. e.g. 200 
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
# calc( String equation )
#
function calc()
{ 
	awk 'BEGIN { OFMT="%f"; print '"$*"'; exit}'; 
}

#
# lookup country code
#
# country( String )
#
function country()
{
	awk -F "\t" -f $OPAL_DIR/country_lookup.awk -v country=$1  $OPAL_DIR/data/iso-country-codes.txt 
}

#
# name the current Terminal tab
#
# tabname( String name )
#
function tabname()
{
	printf "\e]1;$1\a";
}

#
# name the window your in
#
# winname( String name )
#	name = a space delmited string. it's best to keep it short but unique.
#
function winname()
{
	printf "\e]2;$1\a";
}

#
# turn on/off OS X Finders ability to display hidden files
#
# toggle_dotfiles( Boolean display )
#
function show_dotfiles() 
{
	case $# in
		1) 
			if [[ $1 == 'true' || $1 == 'yes' ]]
			then
				defaults write com.apple.finder AppleShowAllFiles $1
				killall Finder 
			elif [[ $1 == 'false' || $1 == 'no' ]]
			then
				defaults write com.apple.finder AppleShowAllFiles $1
				killall Finder
			else
				echo "needs to be true or false"
			fi
		;;

		*) echo "usage: show_dotfiles true|false" 1>&2

	esac
}

#
# display a NUMbered SEGment of a file
#
# when only the start_line is specified, a range of 10 lines before and after
# that line will be displayed. when start_line and end_line are specified, those
# lines and all those between will be displayed
#
# numseg( string filename, int start_line [, int last_line] )
#
function numseg()
{
	range=10
	filename=$1

	if [[ -z $3 ]]; then
		start=$( calc $2-$range)
		end=$(calc $2+$range)
	else
		start=$2
		end=$3
	fi

	nl $filename | awk "NR >= $start  && NR <=  $end  "
}

#
# display a SEGment of a file
#
# when only the start_line is specified, a range of 10 lines before and after
# that line will be displayed. when start_line and end_line are specified, those
# lines and all those between will be displayed
#
# seg( string filename, int start_line [, int last_line] )
#
function seg()
{
	range=10
	filename=$1

	if [[ -z $3 ]]; then
		start=$( calc $2-$range)
		end=$(calc $2+$range)
	else
		start=$2
		end=$3
	fi

	awk "NR >= $start  && NR <=  $end  " $filename
}


#
# Display the previous month, current month, and next month
#
function cal3()
{
	cal -my $(date -v-1m "+%m %Y")
	cal
	cal -my $(date -v+1m "+%m %Y")
}

#
# Display the previous month, current month, and next month vertically
#
function ncal3()
{
    ncal -my $(date -v-1m "+%m %Y")
    echo ' '
    ncal
    echo ' '
    ncal -my $(date -v+1m "+%m %Y")
}

#
# Detect if dropbox is available
#
function datadir()
{
	DROPBOX="$HOME/Dropbox"

	if [[ -d "$1" && -w "$1" ]]
	then
		echo $1
	elif [[ -d "$DROPBOX" && -w "$DROPBOX" ]]
	then
		echo $DROPBOX
	else
		echo $HOME
	fi
}


#
# $ note work "type a brief message here. quotes are required (for now)"
# $ note type a brief message here
#
function note(){
	NOW=$(today iso)
	DATADIR=$(datadir)

	if [[ $1 == "work" ]]
	then
		MESG="$NOW "
		shift
		if [[ -n $2 ]]; then
			MESG="$MESG $@"
		fi
		echo $MESG >> $DATADIR/notes.work.txt

	elif [[ $1 == "dev" ]]
	then
		MESG="$NOW "
		shift
		if [[ -n $2 ]]; then
			MESG="$MESG $@"
		fi
		echo $MESG >> $DATADIR/notes.development.txt

	elif [[ $1 == "home" ]]
	then
		MESG="$NOW "
		shift
		if [[ -n $2 ]]; then
			MESG="$MESG $@"
		fi
		echo $MESG >> $DATADIR/notes.home.txt

	else
		MESG="$NOW $@"
		echo $MESG >> $DATADIR/notes.txt
	fi
}


