#
# .bashrc - this file runs when any news bash shell is created
#
################################################################################


if [[ $OPAL_NOOB -eq '1' ]]; then
    echo "Loading Noob Settings"
    source $OPAL_DIR/bash/noob.bash
fi


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
function opal:punch() {
    local DATESTAMP
    local MESG
    local MESG_OUT
    local OUTFILE

    DATESTAMP=$(date +"%a %Y-%m-%d %H:%M:%S")
    MESG_OUT="Recorded at $DATESTAMP"
    OUT_FILE="${OPAL_DATA_DIR}/timesheet.txt"

    opal:ensure_dir_exists "$OPAL_DATA_DIR" || \
        opal:log_error "opal:punch has a directory issue"

    if [[ $1 == "in" ]]; then
        MESG=$DATESTAMP
        MESG="$MESG IN"
        if [[ -n $2 ]]; then
            MESG="$MESG $2"
        fi
        echo "$MESG"
        echo $MESG >> "${OUT_FILE}"
        echo $MESG_OUT

    elif [[ $1 == "out" ]]; then
        MESG=$DATESTAMP
        MESG="$MESG OUT"
        if [[ -n $2 ]]; then
            MESG="$MESG $2"
        fi
        echo $MESG >> "$OUT_FILE"
        echo $MESG_OUT

    elif [[ $1 == "note" ]]; then
        MESG=$DATESTAMP
        MESG="$MESG NOTE"
        if [[ -n $2 ]]; then
            MESG="$MESG $2"
        fi
        echo $MESG >> "$OUT_FILE"
        echo $MESG_OUT

    elif [[ $1 == "switch" ]]; then
        MESG=$DATESTAMP
        MESG="$MESG OUT"
        echo $MESG >> "$OUT_FILE"

        MESG=$DATESTAMP
        MESG="$MESG IN"
        if [[ -n $2 ]]; then
            MESG="$MESG $2"
        fi
        echo $MESG >> "$OUT_FILE"
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

