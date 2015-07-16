#
# .bashrc - this file runs when any news bash shell is created
#
################################################################################

export OPAL_DIR="$HOME/opal"
export OPAL_VERSION="1.4"

source $OPAL_DIR/util.bash

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
alias jsvi='vim -u ~/opal/vimrc_js'
alias lvi='vim -u ~/opal/vimrc_laravel'
alias rbvi='vim -u ~/opal/vimrc_ruby'
alias svi='vim -u ~/opal/vimrc_symfony'
alias wpvi='vim -u ~/opal/vimrc_wordpress'
alias zendvi='vim -u ~/opal/vimrc_zend'
alias scribe='vim -u ~/opal/vimrc_scribe'


################################################################################
#
#		FUNCTIONS
#
################################################################################

#
# punch - Keeps track of your time. Updates the timesheet.txt in your
# datadir(). The options 'in' and 'out' are just for events like meetings or
# leaving for the day. Use the 'note' option when you wanna say what you worked
# on, or even just say how long you took for lunch.
#
# @param String $action Allowed Values: in, out, note, switch.
#        'switch' will clock you OUT of one task AND IN on another
# @param String Optional $message What did your work on? messages with multiple
#        words must be enclosed in quotes.
#
#
# $ punch in
# $ punch in "type a brief message here"
# $ punch out
# $ punch out "type a brief message here"
# $ punch note "type a brief message here"
#
function punch()
{

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
# mkcd - make a directory and go into it
#
# @param String $directory
#
function mkcd()
{
	mkdir $1 && cd $1
}

#
# cdls - change to a directory and list its content
#
# @param String $directory
#
function cdls()
{
	cd $1 && ls
}

#
# touchx - touch a file and make it executable. touch creates the file if it doesn't exist
#
# @param String $filename the file you want to create and make executable
# @param String Optional $content The type of content to add to the file.
#       'phpinfo' will inject PHP code into the file.
#
function touchx()
{
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
# mach displays the basic information about the machine/system you're using.
#
function mach()
{
	echo -e "\nMachine information:" ; uname -a
	echo -e "\nUsers logged on:" ; w -h
	echo -e "\nCurrent date :" ; date
	echo -e "\nMachine status :" ; uptime
	echo -e "\nFilesystem status :"; df -h
}

#
# show - display information about an aspect of the bash programming environment
#
# @param String $type the type for information you want to display.
#        Allowed Values: arrays, defs, names, readonly, exports, integers
#
function show()
{
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
# preamble - Display a block message to the user about who and where they are
#
function preamble()
{
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
# lsd - get a recursive list of all directories under 'directory'. defaults to cwd.
#
# @param String $directory the directory for which you want to recursively list the contents.
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
# say_done - Tell the user when a command is done
#
# @param String Optional $message the message to be read out loud
#
function say_done()
{
	if [[ -n $1 ]]; then
		message=$@
	else
		message="It is Done!"
	fi

	if [[ -n $(which say) ]]; then
		say $message
	else
		echo $message
	fi
}

#
# bak - Create a backup of a file or directory
#
# @param String $path when path is a file, a copy is made with .bak appended to it's name.
#        if path is a directory, a compressed tarball will be made of the directory
#
function bak()
{
	bakfile="$1.bak"
	filename="$bakfile"
	i=1
	while [ -e $filename ]
	do
		filename="${bakfile}.${i}"
		(( i++ ))
	done

	if [ -d $1 ]; then
		dir=$1
		dir=${dir%/}
		echo $dir
		tarfile="${dir}.tar.gz"
		tar -zcvf $tarfile $dir
	elif [ -f $1 ]; then
		cp $1 $filename
	else
		echo "BAK: unsupported item type - must be file or directory"
	fi
}

#
# extract - "uncompress" a file from a variety of common formats
#
# @param String $filename must be a common compressed file type like ZIP or Tar
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
# parse_git_branch - get the current git branch your on
#
function parse_git_branch()
{
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}


#
# set_prompt - set the style of bash prompt used.
#
# @param String $type Allowed values: brief, full, compact, or debug
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
# swap - Exchange the contents of two files
#
# @param String $file_one
# @param String $file_two
#
function swap()
{
	temp="temp.tmp"

	mv $1 $temp
	mv $2 $1
	mv $temp $2
}

#
# lskeys - Display a list of your ssh keys.
#
function lskeys()
{
	prompt "my ssh keys"
	ls ~/.ssh/*.pub
}

#
# truncate - remove the contents of a file without destroying the file
#
# @param String $filename - file from which you want to remove the contents
#
function truncate()
{
	cat /dev/null > $1
}

#
# define - lookup the dictionary definition of a word
#
# @param String $word the term you want to define
#
function define()
{
	curl dict://dict.org/d:"$@";
}

#
# sha1 - Create a SHA1 digest of a file
#
# @param String $filename the filename for which you want to know/generate it's sha1
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
# htstatus - lookup the http status code by number to refresh your memory
#
# @param Integer $code the numeric status code. e.g. 200
#
# Examples:
#
# $ htstatus 200
#
# $ htstatus 416
#
function htstatus()
{
	grep -A 1 ^$1 $OPAL_DIR/data/http-status-codes.txt
	echo " "
	echo "see http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html for more information"
}

#
# calc - a floating point calculator
#
# @param String $equation the equation you want to execute
#
function calc()
{
	awk 'BEGIN { OFMT="%f"; print '"$*"'; exit}';
}

#
# country - lookup country code to retrieve the country name
#
# @param String $code the 2-letter or 3-letter country code
#
function country()
{
	awk -F "\t" -f $OPAL_DIR/country_lookup.awk -v country=$1  $OPAL_DIR/data/iso-country-codes.txt
}

#
# tabname - assign a name to the active terminal tab
#
# @param String $name the desired tab name. if more than 1 word, enclose with quotes
#
function tabname()
{
	printf "\e]1;$1\a";
}

#
# winname - assign a name to the window your active terminal window
#
# @param String $name the desired window name. if more than 1 word, enclose with quotes
#
function winname()
{
	printf "\e]2;$1\a";
}

#
# show_dotfiles - turn on/off OS X Finders ability to display hidden files
#
# @param Boolean $view determines if hidden files should be displayed.
#        Allowed values: yes, true, no, false
#
function show_dotfiles()
{
	case "$1" in
	true|yes)
		defaults write com.apple.finder AppleShowAllFiles $1
		killall Finder
		;;
	false|no)
		defaults write com.apple.finder AppleShowAllFiles $1
		killall Finder
		;;

	*) echo "usage: show_dotfiles yes|no|true|false" 1>&2

	esac
}

#
# numseg - Display a NUMbered SEGment of a file
#
# when only the start_line is specified, a range of 10 lines before and after
# that line will be numbered and displayed. when start_line and end_line are
# specified, those lines and all those between will be numbered and displayed
#
# @param String $filename the text file with the content
# @param Integer $start
# @param Integer Optional $end
#
# Examples:
#
# Display lines 90 - 110. Line 100 is the middle line of content
# $ seg error.log 100
#
# Display lines 100 through 140.
# $ seg error.log 100 140
#
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
# seg - Display a SEGment of a file
#
# when only the start_line is specified, a range of 10 lines before and after
# that line will be displayed. when start_line and end_line are specified, those
# lines and all those between will be displayed
#
# @param String $filename the text file with the content
# @param Integer $start
# @param Integer Optional $end
#
# Examples:
#
# Display lines 90 - 110. Line 100 is the middle line of content
# $ seg error.log 100
#
# Display lines 100 through 140.
# $ seg error.log 100 140
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
# cal3 - Display the previous month, current month, and next month
#
function cal3()
{
	cal -my $(date -v-1m "+%m %Y")
	cal
	cal -my $(date -v+1m "+%m %Y")
}

#
# ncal3 - Display the previous month, current month, and next month vertically
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
# note - record a note to a file from the command line
#
# @param String Optional $destinationCode
# @param String $note_text
#
# Examples:
# $ note work "type a brief message here. quotes are required (for now)"
# $ note type a brief message here
#
function note()
{
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

#
# traceurl - decode/unfurl a short url recursively to it's final destination
#
# @param String $url the address of the website you want to check
#
function traceurl()
{

	if [[ -n $1 ]]
	then
		curl --location --head $1
	else
		echo 'Whoops! You forgot to specify a short URL'
	fi
}

#
# check_site - determine if a website is available yet. keep checking until it is
#
# @param String $url the address of the website you want to check
# @param Integer $interval the number of seconds to wait
#
function check_site()
{
	declare -i i=0

	if [ -z "$2" ]
	then
		# set the default interval, in seconds
		interval=10
	else
		interval=$2
	fi

	while ! curl -m 5 $1 2>/dev/null;
	do
		sleep $interval;
		ans=$(( i % 30 ))
		if [ $ans == 0 ]; then
			ts=$( date )
			echo "Still down at $ts "
		fi
		i=$(( i +  1  ))
		echo -n ".";
	done;

	say_done 'OK! The site is up now!' ;
}


