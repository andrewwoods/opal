#
# utils - a collection of functions, a base to be used for multiple scripts
#
################################################################################

export PAD="    "
export LINE_LENGTH=80



#
# bash_intro()
#
function opal:bash_intro() {
    echo "#" >$1
    echo "# Created by Opal on $(date)" >>$1
    echo "#" >>$1
    echo "" >>$1
    echo "" >>$1
}

#
# vim_intro ( filename )
#
function opal:vim_intro() {
    echo '' >>$1
    echo '"' >>$1
    echo '" Created by Opal on' $(date) >>$1
    echo '"' >>$1
    echo '' >>$1
}

#
# heading_box ( title, filename )
#
function opal:heading_box() {
    cLine="################################################################################"

    echo "" >>$2
    echo $cLine >>$2
    echo "#" >>$2
    echo "# $1" >>$2
    echo "#" >>$2
    echo $cLine >>$2
    echo "" >>$2
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
# Return the path to the directory $XDG_DATA_HOME.
#
# There is a single base directory relative to which user-specific data files
# should be written. $XDG_DATA_HOME defines the base directory relative to which
# user-specific data files should be stored.
#
# @return string $directory
#
function opal:xdg_data_dir {
    local data_dir
    local xdg_default="$HOME/.local/share"

    data_dir="${XDG_DATA_HOME:-$xdg_default}"

    opal:ensure_dir_exists "$data_dir"

    echo "$data_dir"
}

#
# Return the path to the directory $XDG_STATE_HOME.
#
# $XDG_STATE_HOME defines the base directory relative to which user-specific
# state files should be stored.
#
# @return string $directory
#
function opal:xdg_state_dir {
    local data_dir
    local xdg_default="$HOME/.local/state"
    local create_dir
    data_dir="${XDG_STATE_HOME:-$xdg_default}"

    opal:ensure_dir_exists "$data_dir"

    echo "$data_dir"
}

#
# Return the directory path to the opal subdirectory under XDG_CACHE_HOME.
#
# @return string $directory
#
# @see opal:xdg_cache_dir
#
function opal:xdg_cache_dir {
    local data_dir
    local xdg_default="$HOME/.cache"
    local create_dir
    data_dir="${XDG_CACHE_HOME:-$xdg_default}"

    opal:ensure_dir_exists "$data_dir"

    echo "$data_dir"
}

#
# Return the directory path to the opal subdirectory under $XDG_DATA_HOME.
#
# @return string $directory
#
# @see opal:xdg_data_dir
#
function opal:data_dir {
    local data_dir

    data_dir="$(opal:xdg_data_dir)"
    if opal:is_unset "$data_dir"; then
        return 1
    fi
    data_dir="${data_dir}/opal"

    opal:ensure_dir_exists "$data_dir"

    echo "$data_dir"
}

#
# Return the directory path to the opal subdirectory under $XDG_DATA_HOME.
#
# @return string $directory
#
# @see opal:xdg_data_dir
#
function opal:state_dir {
    local data_dir

    data_dir="$(opal:xdg_state_dir)"
    if opal:is_unset "$data_dir"; then
        return 1
    fi
    data_dir="${data_dir}/opal"

    opal:ensure_dir_exists "$data_dir"

    echo "$data_dir"
}

#
# Return the directory path to the opal subdirectory under XDG_CACHE_HOME.
#
# @return string $directory
#
# @see opal:xdg_cache_dir
#
function opal:cache_dir {
    local data_dir

    data_dir="$(opal:xdg_cache_dir)"
    if opal:is_unset "$data_dir"; then
        return 1
    fi
    data_dir="${data_dir}/opal"

    opal:ensure_dir_exists "$data_dir"

    echo "$data_dir"
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
#         If you want the calendars horizontally, use `ncal -3`
function opal:ncal3 {
    ncal -m $(date -v-1m "+%m %Y")
    _n
    ncal
    _n
    ncal -m $(date -v+1m "+%m %Y")
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
    name=$(whoami)
    host=$(hostname -f)
    thisday=$(opal:today opal-datetime)
    greet=$("opal:greeting")

    echo '###########################################################'
    echo '# '
    opal:type_line "# ${greet} ${name}"
    opal:type_line "# You are logged into ${host}"
    echo '# '
    opal:type_line "# Today is ${thisday}"
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
    $OPAL_DIR/bin/typer -f $1
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
    day_of_week=$(date '+%a')
    format_name='opal-date'
    if opal:is_set "$1"; then
        format_name="$1"
    fi
    format="+$(opal:get_date_format $format_name)"

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
    day_of_week=$(date '+%a')
    format_name='opal-date'
    if opal:is_set "$1"; then
        format_name="$1"
    fi
    format="+$(opal:get_date_format $format_name)"

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



#
# say_done - Tell the user when a command is done
#
# @param String Optional $message the message to be read out loud
#
function opal:say_done() {
    message="It is Done!"
    if [[ -n $1 ]]; then
        message=$@
    fi

    if [[ -n $(which say) ]]; then
        say $message
    else
        echo $message
    fi
}


#
# Go up the directory tree a number of levels. default=1.
#
function opal:up {
    declare -i level=1
    declare path="$(pwd)"
    if opal:is_set "$1"; then
       level="$1"
    fi

    for i in $(seq 1 $level); do
        path=$(dirname "${path}")
    done
    cd "$path"
}

#
# lskeys - Display a list of your ssh keys.
#
function opal:list_keys() {
    opal:type_line "My SSH Keys"
    ls -1 ~/.ssh/*.pub
}

#
# define - lookup the dictionary definition of a word
#
# @param String $word the term you want to define
#
function opal:define() {
    curl dict://dict.org/d:"$@"
}

#
# calc - a floating point calculator
#
# @param String $equation the equation you want to execute
#
function opal:calc() {
    awk 'BEGIN { OFMT="%f"; print '"$*"'; exit}'
}

#
# country - lookup country code to retrieve the country name
#
# @param String $code the 2-letter or 3-letter country code
#
function opal:country() {
    awk -F "\t" -f $OPAL_DIR/country_lookup.awk -v country=$1 $OPAL_DIR/data/iso-country-codes.txt
}

#
# tabname - assign a name to the active terminal tab
#
# @param String $name the desired tab name. if more than 1 word, enclose with quotes
#
function opal:tab_name() {
    printf "\e]1;$1\a"
}

#
# winname - assign a name to the window your active terminal window
#
# @param String $name the desired window name. if more than 1 word, enclose with quotes
#
function opal:win_name() {
    printf "\e]2;$1\a"
}

#
# show_dotfiles - turn on/off OS X Finders ability to display hidden files
#
# @param Boolean $view determines if hidden files should be displayed.
#        Allowed values: yes, true, no, false
#
function opal:show_dotfiles() {
    case "$1" in
        true | yes)
            defaults write com.apple.finder AppleShowAllFiles $1
            killall Finder
            ;;
        false | no)
            defaults write com.apple.finder AppleShowAllFiles $1
            killall Finder
            ;;

        *) echo "usage: show_dotfiles yes|no|true|false" 1>&2 ;;

    esac
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
function opal:note {
    NOW=$(opal:today opal-datetime)

    DATADIR="${OPAL_DATA_HOME:=$HOME/.local/state/opal}"

    if ! opal:dir_exists "$DATADIR"; then
        mkdir -p "$DATADIR"
    fi

    MESG="$NOW "
    if [[ $1 == "work" ]]; then
        shift
        echo "$MESG $@" >> $DATADIR/notes.work.txt

    elif [[ $1 == "dev" ]]; then
        shift
        MESG="$MESG $@"
        echo $MESG >> $DATADIR/notes.development.txt

    elif [[ $1 == "home" ]]; then
        shift
        MESG="$MESG $@"
        echo $MESG >> $DATADIR/notes.home.txt

    else
        MESG="$MESG $@"
        echo $MESG >> $DATADIR/notes.txt
    fi
}

