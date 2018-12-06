#
# File and Directory related functions
#
################################################################################




#
# bak - Create a backup of a file or directory
#
# @param String $path when path is a file, a copy is made with .bak appended to
# it's name. if path is a directory, a compressed tarball will be made of the
# directory
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
# cdls - change to a directory and list its content
#
# @param String $directory
#
function cdls()
{
	cd "$1" && ls -F -G
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
# lsd - get a recursive list of all directories under 'directory'.
#   defaults to cwd.
#
# @param String $directory the directory for which you want to recursively list
#   the contents.
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
# mkcd - make a directory and go into it. For more than one directory
#        go into the last one
#
# @param String $directory
#
function mkcd()
{
    last="${@: -1}";
    mkdir -p "$@" && cd "${last}"
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
# touchx - touch a file and make it executable. touch creates the file if it
#          doesn't exist
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

	if [[ $1 == 'README.md' ]]; then
		echo "# Project Name" >> $1
		echo "" >> $1
		echo "Write your project " >> $1
		echo "" >> $1
		echo "* First " >> $1
		echo "* Second " >> $1
		echo "* Third " >> $1
		echo "" >> $1
	fi
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


