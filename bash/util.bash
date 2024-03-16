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
# @param char  Optional. the character used to construct the line
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
function opal:cal3 {
    cal $(date -v-1m "+%m %Y")
    cal
    cal $(date -v+1m "+%m %Y")
}

#
# datadir - Detect where to save your data.
#
function opal:data_dir {
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
function opal:get_context {
    current_hour=$(date "+%H")

    if  opal:number_between ${current_hour} 8 17 ; then
        echo 'work'
    else
        echo 'home'
    fi
}

#
# mach - displays the basic information about the machine/system you're using.
#
function opal:mach() {
    opal:label "\nMachine information:"
    # @todo Replace "uname -a" with a function to determine OS type and use it
    #       to call most applicable about function e.g. opal:about_macos().
    uname -a

    opal:label "\nUsers logged on:"
    w -h

    opal:label "\nCurrent date :"
    date

    opal:label "\nMachine status :"
    uptime

    opal:label "\nFilesystem status :"
    df -h
}

#
# ncal3 - Display the previous month, current month, and next month vertically
#
function ooal:ncal3 {
    opal:std_error 'Deprecated. Will be moving to the "opal:" namespace for v3'
    ncal -my $(date -v-1m "+%m %Y")
    _n
    ncal
    _n
    ncal -my $(date -v+1m "+%m %Y")
}

function opal:greeting {
    local hour

    hour=$(date +'%k')
    if opal:number_is_below "$hour" 7; then
        echo "You should be sleeping"

    elif opal:number_between "$hour" 7 12 ; then
        echo "Good morning"

    elif opal:number_between "$hour" 12 18 ; then
        echo "Good afternoon"
    else
        echo "Good evening"
    fi

}

#
# preamble - Display a block message to the user about who and where they are
#
function opal:preamble {
    opal:std_error 'Deprecated. Will be moving to the "opal:" namespace for v3'
    name=$(whoami)
    host=$(hostname -f)
    thisday=$(today default)
    greet=$("greeting")

    echo '###########################################################'
    echo '# '
    type_line "# ${greet} ${name}"
    type_line "# You are logged into ${host}"
    echo '# '
    type_line "# Today is ${thisday}"
    echo '# '
    echo '###########################################################'
}


#
# type_file - Display an entire file, as if being typed quickly.
#
# @todo rename type_file as scribe. Fold prompt into scribe.
# @param String $filename
#
function opal:type_file {
    $OPAL_DIR/typer -f $1
}

#
# type_line - display a dynamic prompt, in the interactive sense.
#
# @param String $content multiple-word prompts must be enclosed in quotes
#
function opal:type_line {
    $OPAL_DIR/bin/typer "$1"
}

#
# Create a number of blank lines. Default = 1.
#
function opal:spacer {
    max=1
    if [[ $1 != "" ]]; then
        max=$1
    fi

    for ((i = 1; i <= $max; i++)); do
        echo ""
    done
}

#
# filedate_to_day - Convert file stamp to determine the day of the week
#
function opal:filedate_to_day {
    if [[ $1 == "time" ]]; then
        date -j -f '%Y-%m-%d-%H-%M-%S' $2 '+%a'
    else
        date -j -f '%Y-%m-%d' $1 '+%a'
    fi
}

#
# get_os - Determine the Operating System. hat tip @alrra
#
opal:get_os() {

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
# Set the terminal background to 'dark' or 'light'.
#
# Some color combinations don't provide enough contrast when the background
# color changes. This function sets the value of LS_COLORS accordingly, so file
# listins can display with enough default contrast.
#
opal:term_bg() {
    if [[ -z $TERM_BG ]]; then
        TERM_BG="dark"
    else
        TERM_BG="$1"
    fi
    export TERM_BG

    if [[ $TERM_BG == "dark" ]]; then
        LS_DIR=Cx
        LS_SYMLINK=fx
        LS_SOCKET=cx
        LS_PIPE=dx
        LS_EXEC=Ex
        LS_BLOCK=fx
        LS_CHAR=ex
        LS_SETUID=HB
        LS_SETGID=HB
        LS_WDIR_STICKY=HF
        LS_WDIR=bx

        LSCOLORS="${LS_DIR}${LS_SYMLINK}${LS_SOCKET}${LS_PIPE}${LS_EXEC}${LS_BLOCK}${LS_CHAR}${LS_SETUID}${LS_SETGID}${LS_WDIR_STICKY}${LS_WDIR}"

        export LSCOLORS

    elif [[ $TERM_BG == "light" ]]; then
        LS_DIR=Cx
        LS_SYMLINK=Fx
        LS_SOCKET=fx
        LS_PIPE=cx
        LS_EXEC=Ex
        LS_BLOCK=ex
        LS_CHAR=gx
        LS_SETUID=HB
        LS_SETGID=HB
        LS_WDIR_STICKY=HF
        LS_WDIR=HC

        LSCOLORS="${LS_DIR}${LS_SYMLINK}${LS_SOCKET}${LS_PIPE}${LS_EXEC}${LS_BLOCK}${LS_CHAR}${LS_SETUID}${LS_SETGID}${LS_WDIR_STICKY}${LS_WDIR}"

        export LSCOLORS

    else
        opal:std_error "the TERM_BG must be 'dark' or 'light'"
        return 1
    fi

    echo "the terminal background is ${TERM_BG}"
}

#
# monday_date - Determine the date for Mon of the current week
#
function opal:monday_date {
    opal:std_error 'Deprecated. Will be moving to the "opal:" namespace for v3'
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
function opal:sunday_date {
    opal:std_error 'Deprecated. Will be moving to the "opal:" namespace for v3'
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
