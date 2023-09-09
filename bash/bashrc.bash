#
# .bashrc - this file runs when any news bash shell is created
#
################################################################################

export cals=(/usr/share/calendar/calendar.computer
    /usr/share/calendar/calendar.history
    /usr/share/calendar/calendar.holiday
    /usr/share/calendar/calendar.usholiday
    /usr/share/calendar/calendar.music
    /usr/share/calendar/calendar.judaic
    /usr/share/calendar/calendar.christian)

if [[ $OPAL_NOOB -eq '1' ]]; then
    echo "Loading Noob Settings"
    source $OPAL_DIR/bash/noob.bash
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

# NOTE: any options specified on the command line override these values
LESS="-"
LESS+="N" # Causes a line number to be displayed at the beginning of each line
LESS+="g" # highlight only the particular string which was found
#   by the last search command.
LESS+="j.5" # .5 is the middle line. integer start from the top of screen
#
LESS+="w" # Temporarily highlights the first "new" line after a forward
#   movement of a full page.
LESS+="x4" # Set tab stops to 4 spaces

export EDITOR GIT_EDITOR SVN_EDITOR VISUAL LESS

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
function punch() {
    DATADIR=$(datadir /Users/awoods/src/work/notebook-cbsi)
    DATESTAMP=$(date +"%a %Y-%m-%d %H:%M:%S")
    MESG_OUT="Recorded at $DATESTAMP"

    if [[ $1 == "in" ]]; then
        MESG=$DATESTAMP
        MESG="$MESG IN"
        if [[ -n $2 ]]; then
            MESG="$MESG $2"
        fi
        echo $MESG >> $DATADIR/timesheet.txt
        echo $MESG_OUT

    elif [[ $1 == "out" ]]; then
        MESG=$DATESTAMP
        MESG="$MESG OUT"
        if [[ -n $2 ]]; then
            MESG="$MESG $2"
        fi
        echo $MESG >> $DATADIR/timesheet.txt
        echo $MESG_OUT

    elif [[ $1 == "note" ]]; then
        MESG=$DATESTAMP
        MESG="$MESG NOTE"
        if [[ -n $2 ]]; then
            MESG="$MESG $2"
        fi
        echo $MESG >> $DATADIR/timesheet.txt
        echo $MESG_OUT

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
        echo $MESG_OUT

    else
        echo 'punch in OR punch out OR punch note OR punch switch'
    fi
}

#
# say_done - Tell the user when a command is done
#
# @param String Optional $message the message to be read out loud
#
function say_done() {
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
# set_prompt - set the style of bash prompt used.
#
# @see http://www.gnu.org/software/bash/manual/html_node/Controlling-the-Prompt.html#Controlling-the-Prompt
#
#
# @param String $type Allowed values: brief, full, root, compact, basic or files
#
function set_prompt() {
    use_color=$2

    case "$1" in
        brief)

            if [[ -z "$use_color" || "$use_color" == "no" ]]; then
                brief_prompt
            else
                brief_prompt color
            fi
            ;;

        brief-no-color)
            PS1="\[\e[1m\]\u" # username
            PS1+="\[\e[0m\]@" # @
            PS1+="\h "        # host
            PS1+="\[\e[4m\]\W\[\e[0m\]" # base directory name
            PS1+="\[\e[1m\] \$(parse_git_branch) \$ \[\e[0m\]"
            ;;

        full)
            if [[ -z "$use_color" || "$use_color" == "no" ]]; then
                # andrewwoods@tardis.local ~/opal
                # Sat Jan 18 22:37:10 [626]$
                full_prompt
            else
                # andrewwoods@tardis.local ~/opal
                # Sat Jan 18 22:37:10 [626]$
                full_prompt color
            fi
            ;;

        vertical)
            if [[ -z "$use_color" || "$use_color" == "no" ]]; then
                vertical_prompt
            else
                vertical_prompt color
            fi
            ;;

        root)
            if [[ -z "$use_color" || "$use_color" == "no" ]]; then
                root_prompt
            else
                root_prompt color
            fi
            ;;

        compact)
            if [[ -z "$use_color" || "$use_color" == "no" ]]; then
                compact_prompt
            else
                compact_prompt color
            fi
            ;;

        basic)
            PS1="\$ "
            ;;

        files)
            if [[ -z "$use_color" || "$use_color" == "no" ]]; then
                PS1="\n"
                PS1+="\[\033[1m\][\w]\[\e[0m\]\n"
                PS1+="\[\033[4m\]\u@\h\[\e[0m\] "
                PS1+="\[\033[1m\](\$(ls -1 | wc -l | sed 's: ::g') files)\[\e[0m\] "
                PS1+="\$ "
            else
                PS1="\n"
                PS1+="\[\033[1;31m\][\w]\[\e[0m\]\n"
                PS1+="\[\033[1;37m\]\u@\h\[\e[0m\] "
                PS1+="\[\033[1;36m\](\$(ls -1 | wc -l | sed 's: ::g') files)\[\e[0m\] "
                PS1+="\$ "
            fi
            ;;

        *)
            echo 'Whoops! brief, full, root, compact, basic, or files'
            ;;
    esac
}

#
# lskeys - Display a list of your ssh keys.
#
function lskeys() {
    type_line "My SSH Keys"
    ls -1 ~/.ssh/*.pub
}

#
# define - lookup the dictionary definition of a word
#
# @param String $word the term you want to define
#
function define() {
    curl dict://dict.org/d:"$@"
}

#
# calc - a floating point calculator
#
# @param String $equation the equation you want to execute
#
function calc() {
    awk 'BEGIN { OFMT="%f"; print '"$*"'; exit}'
}

#
# country - lookup country code to retrieve the country name
#
# @param String $code the 2-letter or 3-letter country code
#
function country() {
    awk -F "\t" -f $OPAL_DIR/country_lookup.awk -v country=$1 $OPAL_DIR/data/iso-country-codes.txt
}

#
# tabname - assign a name to the active terminal tab
#
# @param String $name the desired tab name. if more than 1 word, enclose with quotes
#
function tabname() {
    printf "\e]1;$1\a"
}

#
# winname - assign a name to the window your active terminal window
#
# @param String $name the desired window name. if more than 1 word, enclose with quotes
#
function winname() {
    printf "\e]2;$1\a"
}

#
# show_dotfiles - turn on/off OS X Finders ability to display hidden files
#
# @param Boolean $view determines if hidden files should be displayed.
#        Allowed values: yes, true, no, false
#
function show_dotfiles() {
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
function note() {
    NOW=$(today iso)
    DATADIR=$(datadir)

    if [[ $1 == "work" ]]; then
        MESG="$NOW "
        if [[ -n $2 ]]; then
            MESG="$MESG $@"
        fi
        echo $MESG >> $DATADIR/notes.work.txt

    elif [[ $1 == "dev" ]]; then
        MESG="$NOW "
        if [[ -n $2 ]]; then
            MESG="$MESG $@"
        fi
        echo $MESG >> $DATADIR/notes.development.txt

    elif [[ $1 == "home" ]]; then
        MESG="$NOW "
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
# matrix - Display the Matrix code in your terminal
#
function matrix() {
    echo -e "\e[1;40m"
    clear
    characters=$(jot -c 94 33 | tr -d '\n')
    while :; do
        echo $LINES $COLUMNS $(($RANDOM % $COLUMNS)) $(($RANDOM % 72)) $characters
        sleep 0.05
    done | awk '{ letters=$5; c=$4; letter=substr(letters,c,1);a[$3]=0;for (x in a) {o=a[x];a[x]=a[x]+1; printf "\033[%s;%sH\033[2;32m%s",o,x,letter; printf "\033[%s;%sH\033[1;37m%s\033[0;0H",a[x],x,letter;if (a[x] >= $1) { a[x]=0; } }}'
}

#
# strlen - get the length of a string
#
# @param string
#
function strlen {
    echo ${#1}
}
