#
# utils - a collection of functions, a base to be used for multiple scripts
#
################################################################################

export PAD="    ";
export LINE_LENGTH=80;


#
# echo text with padding
#
function _e
{
	echo "${PAD}$1"
}

#
# Create a number of blank lines. Default = 1.
#
function _l
{
	max_length=$LINE_LENGTH
	char="-"
	line=""

	if [[ $1 != "" ]]
	then
		char=$1
	fi

	if [[ $2 != "" ]]
	then
		max_length=$2
	fi

	for (( i=${#PAD}; i <= $max_length; i++ ))
	do
		line+=$char
	done
	_e $line
}

#
# echo a blank line
#
function _n
{
	echo ""
}


#
# echo text with padding
#
function _s
{
	prompt "${PAD}$1"
}


#
# datadir - Detect if dropbox is available
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
# prompt - display a dynamic prompt, in the interactive sense.
#
# @param String $content multiple-word prompts must be enclosed in quotes
#
function prompt()
{
	$OPAL_DIR/typer "$1"
}


#
# type_file - Display an entire file, as if being typed quickly.
#
# @todo rename type_file as scribe. Fold prompt into scribe.
# @param String $filename
#
function type_file()
{
	$OPAL_DIR/typer -f $1
}

function scribe()
{
	$OPAL_DIR/typer -f $1
}


#
# Create a number of blank lines. Default = 1.
#
function spacer
{
	max=1
	if [[ $1 != "" ]]
	then
		max=$1
	fi

	for (( i=1; i <= $max; i++ ))
	do
		echo ""
	done
}


#
# today - display a date using the specified format
#
# @param String $style Allowed values: unix, iso, world, us, default
# @param String Optional $type Allowed values: text, numeric
#
function today()
{

	case $1 in
	'unix')
		echo $(date +"%s")
		;;
	'iso'):
		if [[ $2 == "date" ]]; then
			echo $(date +"%Y-%m-%d")
		else
			echo $(date +"%Y-%m-%dT%H:%M:%S%z")
		fi
		;;
	'filedate'):
		echo $(date +"%Y%b%d%a")
		;;
	'world'):
		if [[ $2 == "text" ]]; then
			echo $(date +"%d %b %Y %H:%M:%S")
		else
			echo $(date +"%d/%m/%Y %H:%M:%S")
		fi
		;;
	'us'):
		if [[ $2 == "text" ]]; then
			echo $(date +"%b %d, %Y %l:%M %p")
		else
			echo $(date +"%m/%d/%Y %l:%M %p")
		fi
		;;
	*)
		echo $(date +"%a %Y %b %d %l:%M %p")
		;;
	esac


}


#
# get_os - Determine the Operating System. hat tip @alrra
#
get_os() {

	declare -r OS_NAME="$(uname -s)"
	local os=''

	if [ "$OS_NAME" == "Darwin" ]; then
		os='osx'
	elif [ "$OS_NAME" == "Linux" ]; then

		if [ -e "/etc/lsb-release" ]; then
			os='ubuntu'
		else
			os='linux'
		fi

	else
		os="$OS_NAME"
	fi

	printf "%s" "$os"
}


	fi
}

