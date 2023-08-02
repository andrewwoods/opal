#
# utils - a collection of functions, a base to be used for multiple scripts
#
################################################################################

export PAD="    "
export LINE_LENGTH=80

#
# _e - echo text with padding
#
# @param string
function _e {
    echo "${PAD}$1"
}

#
# _l - Create a line prepended with padding.
#
# @param char  Optional. the character used to construc the line
# @param int Optional. The length of the line
#
function _l {
    max_length=$LINE_LENGTH
    char="-"
    line=""

    if [[ $1 != "" ]]; then
        char=$1
    fi

    if [[ $2 != "" ]]; then
        max_length=$2
    fi

    for ((i = ${#PAD}; i <= $max_length; i++)); do
        line+=$char
    done
    _e $line
}

#
# _n - echo a blank line
#
function _n {
    echo ""
}

#
# _p - write out the text with padding
#
function _p {
    type_line "${PAD}$1"
}

#
# _s - Speak the text aloud and highlight as it progresses
#
function _s {
    say -v Fred --interactive="cyan/black" "$@"
}

#
# cal3 - Display the previous month, current month, and next month
#        in vertical format. running 'cal -3' displays the months horizontally
#
function cal3() {
    cal $(date -v-1m "+%m %Y")
    cal
    cal $(date -v+1m "+%m %Y")
}

#
# datadir - Detect where to save your data.
#
function datadir() {
    if [[ -d "$HOME/Dropbox" && -w "$HOME/Dropbox" ]]; then
        echo "$HOME/Dropbox"
    elif [[ -d "$HOME/data" && -w "$HOME/data" ]]; then
        echo "$HOME/data"
    else
        echo $HOME
    fi
}

#
# get_context - Are you in work hours, or personal time
#
get_context() {
    current_hour=$(date "+%H")

    if [ $current_hour -ge '08' ]; then
        if [ $current_hour -le '17' ]; then
            echo 'work'
        else
            echo 'home'
        fi
    fi
}

#
# mach - displays the basic information about the machine/system you're using.
#
function mach() {
    echo -e "\nMachine information:"
                                    uname -a
    echo -e "\nUsers logged on:"
                                w -h
    echo -e "\nCurrent date :"
                              date
    echo -e "\nMachine status :"
                                uptime
    echo -e "\nFilesystem status :"
                                  df -h
}

#
# ncal3 - Display the previous month, current month, and next month vertically
#
function ncal3() {
    ncal -my $(date -v-1m "+%m %Y")
    _n
    ncal
    _n
    ncal -my $(date -v+1m "+%m %Y")
}

#
# preamble - Display a block message to the user about who and where they are
#
function preamble() {
    name=$(whoami)
    host=$(hostname -f)
    thisday=$(today default)

    echo '###########################################################'
    echo '# '
    type_line "# Hello ${name}"
    type_line "# You are logged into ${host}"
    echo '# '
    type_line "# Today is ${thisday}"
    echo '# '
    echo '###########################################################'
}

#
# prompt - an wrapper for type_line
#
# @deprecated 2.1.0
# @param String $content multiple-word prompts must be enclosed in quotes
#
function prompt() {
    type_line "$1"
    echo "The prompt function is deprecated, please use type_line instead" >&2
}

#
# type_file - Display an entire file, as if being typed quickly.
#
# @todo rename type_file as scribe. Fold prompt into scribe.
# @param String $filename
#
function type_file() {
    $OPAL_DIR/typer -f $1
}

#
# type_line - display a dynamic prompt, in the interactive sense.
#
# @param String $content multiple-word prompts must be enclosed in quotes
#
function type_line() {
    $OPAL_DIR/bin/typer "$1"
}

#
# Create a number of blank lines. Default = 1.
#
function spacer {
    max=1
    if [[ $1 != "" ]]; then
        max=$1
    fi

    for ((i = 1; i <= $max; i++)); do
        echo ""
    done
}

#
# today - display a date using the specified format
#
# @param String $style Allowed values: unix, iso, world, us, default
# @param String Optional $type Allowed values: text, numeric
#
function today() {

    case $1 in
    'unix')
        echo $(date +"%s")
        ;;
    'custom')
          :
        if [[ $2 == "date" ]]; then
            echo $(date +"%Y %b %d %a")
        else
            echo $(date +"%Y %b %d %H:%M %z")
        fi
        ;;
    'iso')
        :
        if [[ $2 == "date" ]]; then
            echo $(date +"%Y-%m-%d")
        else
            echo $(date +"%Y-%m-%dT%H:%M:%S%z")
        fi
        ;;
    'world')
         :
        if [[ $2 == "text" ]]; then
            echo $(date +"%d %b %Y %H:%M:%S")
        else
            echo $(date +"%d/%m/%Y %H:%M:%S")
        fi
        ;;
    'us')
        :
        if [[ $2 == "text" ]]; then
            echo $(date +"%b %d, %Y %l:%M %p")
        else
            echo $(date +"%m/%d/%Y %l:%M %p")
        fi
        ;;
    *)
        echo $(date +"%Y %b %d %a %k:%M")
        ;;
    esac
}

function filedate() {

    if [[ $1 == "time" ]]; then
        echo $(date +"%Y-%m-%d-%H-%M-%S")
    else
        echo $(date +"%Y-%m-%d")
    fi
}

#
# filedate_to_day - Convert file stamp to determine the day of the week
#
function filedate_to_day {
    if [[ $1 == "time" ]]; then
        date -j -f '%Y-%m-%d-%H-%M-%S' $2 '+%a'
    else
        date -j -f '%Y-%m-%d' $1 '+%a'
    fi
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

#
# termbg - set the terminal background to 'dark' or 'light',
#          and display LS_COLORS accordinly
#
termbg() {
    if [[ -z $TERM_BG ]]; then
        TERM_BG="dark"
        echo "the terminal background is ${TERM_BG}"
    else
        TERM_BG=$1
    fi
    export TERM_BG

    if [[ $TERM_BG == "dark" ]]; then

        # for a dark terminal background
        LS_DIR=Cx
        LS_SYMLINK=fx
        LS_SOCKET=cx
        LS_PIPE=dx
        LS_EXEC=Gx
        LS_BLOCK=fx
        LS_CHAR=ex
        LS_SETUID=HB
        LS_SETGID=HB
        LS_WDIR_STICKY=HF
        LS_WDIR=bx

        LSCOLORS="${LS_DIR}${LS_SYMLINK}${LS_SOCKET}${LS_PIPE}${LS_EXEC}${LS_BLOCK}${LS_CHAR}${LS_SETUID}${LS_SETGID}${LS_WDIR_STICKY}${LS_WDIR}"

        export LSCOLORS

    elif [[ $TERM_BG == "light" ]]; then
        TERM_BG="light"
        # for a dark terminal background
        LS_DIR=Fx
        LS_SYMLINK=Cx
        LS_SOCKET=cx
        LS_PIPE=cx
        LS_EXEC=ex
        LS_BLOCK=fx
        LS_CHAR=gx
        LS_SETUID=HB
        LS_SETGID=HB
        LS_WDIR_STICKY=HF
        LS_WDIR=bH

        LSCOLORS="${LS_DIR}${LS_SYMLINK}${LS_SOCKET}${LS_PIPE}${LS_EXEC}${LS_BLOCK}${LS_CHAR}${LS_SETUID}${LS_SETGID}${LS_WDIR_STICKY}${LS_WDIR}"

        export LSCOLORS

    else
        echo "the TERM_BG must be 'dark' or 'light'"
    fi
}

#
# monday_date - Determine the date for Mon of the current week
#
function monday_date {
    day_of_week=$(date '+%a')
    format='+%Y %b %d %a'

    if [[ $day_of_week == "Tue" ]]; then
        date -v-1d "$format"
    elif [[ $day_of_week == "Wed" ]]; then
        date -v-2d "$format"
    elif [[ $day_of_week == "Thu" ]]; then
        date -v-3d "$format"
    elif [[ $day_of_week == "Fri" ]]; then
        date -v-4d "$format"
    elif [[ $day_of_week == "Sat" ]]; then
        date -v-5d "$format"
    elif [[ $day_of_week == "Sun" ]]; then
        date -v-6d "$format"
    else
        # Today is Monday
        date "$format"
    fi
}

#
# sunday_date - Determine the date for Sunday of the current week
#
function sunday_date {
    day_of_week=$(date '+%a')
    format='+%Y %b %d %a'

    if [[ $day_of_week == "Mon" ]]; then
        date -v+6d "$format"
    elif [[ $day_of_week == "Tue" ]]; then
        date -v+5d "$format"
    elif [[ $day_of_week == "Wed" ]]; then
        date -v+4d "$format"
    elif [[ $day_of_week == "Thu" ]]; then
        date -v+3d "$format"
    elif [[ $day_of_week == "Fri" ]]; then
        date -v+2d "$format"
    elif [[ $day_of_week == "Sat" ]]; then
        date -v+1d "$format"
    else
        # Today is Sunday
        date "$format"
    fi
}
