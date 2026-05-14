#
# utils - a collection of functions, a base to be used for multiple scripts
#
################################################################################

export PAD="    "
export LINE_LENGTH=80

##
## Write the file header bash comment to the top of a bash file.
##
## @param String $filename
##
## @output void
##
function opal:bash_intro() {
    echo "#" >$1
    echo "# Generator: Opal <https://github.com/andrewwoods/opal>" >>$1
    echo "# Date-Created: $(opal:today opal-datetime)" >>$1
    echo "# Author: $(whoami)" >>$1
    echo "#" >>$1
    echo "" >>$1
    echo "" >>$1

}

##
## Write the file header bash comment to the top of a Vim file.
##
## @param String $filename
##
## @output void
##
function opal:vim_intro() {
    echo '"' >$1
    echo '" Generator: Opal <https://github.com/andrewwoods/opal>' >>$1
    echo '" Date-Created:' $(opal:today opal-datetime) >>$1
    echo '" Author:' $(whoami) >>$1
    echo '"' >>$1
    echo '' >>$1
    echo '' >>$1
}

##
## Write the file header bash comment to the top of a Vim file.
##
## This utility for creating a section header is best used in a script for
## creating new files.
##
## @param String $heading
##
## @param String $filename
##
## @output void
##
function opal:bash_heading_box() {
    cLine="################################################################################"

    echo "" >>$2
    echo $cLine >>$2
    echo "#" >>$2
    echo "# $1" >>$2
    echo "#" >>$2
    echo $cLine >>$2
    echo "" >>$2
}

##
## Display a current 3-month span. The previous month, current month, and the next
## month. The output is displayed vertically. The command `cal -3` can be used
## to display the calendars positioned horizontaly.
##
function opal:cal3 {
    cal $(date -v-1m "+%m %Y")
    cal
    cal $(date -v+1m "+%m %Y")
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

##
## Display a current 3-month span. The previous month, current month, and the next
## month. The output is displayed vertically. The command `ncal -3` can be used
## to display the calendars positioned horizontaly.
##
function opal:ncal3 {
    ncal -m $(date -v-1m "+%m %Y")
    opal:spacer
    ncal
    opal:spacer
    ncal -m $(date -v+1m "+%m %Y")
}

##
## Greet the user based on the time of day.
##
## @output String $greeting
##
## @uses opal:preamble
##
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

##
## Display a system message to the user about who and where they are
##
## @output string
##
function opal:preamble {
    name="$(whoami)"
    host="$(hostname -f)"
    thisday="$(opal:today opal-datetime)"
    greet="$(opal:greeting)"

    echo '###########################################################'
    echo '# '
    opal:type_line "# ${greet} ${name}"
    opal:type_line "# You are logged into ${host}"
    echo '# '
    opal:type_line "# Today is ${thisday}"
    echo '# '
    echo '###########################################################'
}


##
## Dynamically display a text file.
##
## An animated version of echo. Gives the sense of typing the file text to STDOUT.
##
## @param String $filename
##
## @uses bin/typer
##
function opal:type_file {
    $OPAL_DIR/bin/typer -f $1
}

##
## Dynamically display a line of text.
##
## An animated version of echo. Gives the sense of typing the text to STDOUT.
##
## @param String $content
##   A piece to text to display like it's being typed.
##
## @uses bin/typer
##
function opal:type_line {
    $OPAL_DIR/bin/typer "$1"
}

##
## Create a number of blank lines. By default, creates a single blank line.
##
## Sometimes you need to create vertical white space. This makes is easier to
## add multiple blank lines with a single call.
##
## @param Integer $quantity
##   The number of blank lines to create. Default = 1.
##
## @output string
##
function opal:spacer {
    max=1
    if [[ $1 != "" ]]; then
        max=$1
    fi

    for ((i = 1; i <= $max; i++)); do
        echo ""
    done
}

##
## Sometimes, you need to know the day of the week for a given date.
##
## Convert the output of `opal:today filename-date` and `opal:today
## filename-timestamp to a weekday. This is use for when you want to create a
## report title based on the the use of dates.
##
## @param String $date
##   The date must be formatted in YYYY-MM-DD for YYYY-MM-DD-hh-mm-ss format
##
## @output String
##
function opal:filedate_to_day {
    if [[ $1 == "time" ]]; then
        date -j -f '%Y-%m-%d-%H-%M-%S' $2 '+%a'
    else
        date -j -f '%Y-%m-%d' $1 '+%a'
    fi
}

##
## Determine the Operating System. hat tip @alrra
##
## @output String
##  The type of operating system.
##
## @uses uname
##
## @note The options of uname might mean different things across operating systems
##
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
     TERM_BG="dark"
    if opal:is_set "$TERM_BG"; then
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

##
## Monday is the first day of the current week. Get Monday's date.
##
## @output String
##
## @uses date
##
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

##
## Sunday is the last day of the current week. Get Sunday's date.
##
## @output String
##
## @uses date
##
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



##
## Use Mac's say command to read the message aloud
##
## By default, the message will say "It is Done!". This is useful when completing
## a long running command, and you don't want to stare at your terminal.
##
## @param String $message
##   *Optional*. The custom message to read aloud
##
## @output Audio | String
##   If the say command is not available, echo will display the message.
##
## @uses say | echo
##
function opal:say_done() {
    message="It is Done!"
    if opal:is_set "$1"; then
        message=$@
    fi

    if opal:command_exists "say"; then
        say $message
    else
        echo $message
    fi
}


##
## Go up the directory tree a number of levels. default=1.
##
## Often you want to travel up a number of directory levels.
##
## @param Integer $level
##   Determine how many levels up the directory tree you want to go
##
## @output Void
##
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

##
## Lookup the definitions for an English word using dict.org
##
## @param String $word
##   The term you want to define
##
## @output String
##
function opal:define() {
    curl dict://dict.org/d:"$@"
}

##
## A floating point calculator
##
## Enter a mathematical calculation and display the result to 4 decimal places
##
## @param string $equation
##   the equation you want to calculate
##
## @output Float
##
## @uses awk
##
function opal:calc() {
    awk 'BEGIN { OFMT="%0.4f"; print '"$*"'; exit}'
}

##
## Lookup country code to retrieve the country name
##
## @param String $code the 2-letter or 3-letter ISO country code
##
## @output string
##
## @return 0 | 1
##
function opal:country() {
    if opal:is_empty "$1"; then
        opal:std_error "Please enter a 2-letter or 3-letter country code"
        return 1
    fi

    awk -F "\t" -f $OPAL_DIR/bin/country_lookup -v country=$1 $OPAL_DIR/data/iso-country-codes.txt
}


##
## Allow you to turn on and off the display of hidden files in Apples Finder.
##
## Note: This doesn't affect the ls command.
##
## @param Boolean $view
##   determines if hidden files should be displayed.
##   Allowed values: yes, true, no, false
##
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


