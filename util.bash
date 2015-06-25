#
# utils - a collection of functions, a base to be used for multiple scripts
#
################################################################################


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
# today - display a date using the specified format
#
# @param String $style Allowed values: unix, iso, world, us, default
# @param String Optional $type Allowed values: text, numeric
#
function today()
{
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



