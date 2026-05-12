#
# Opal Bash Profile
#

export cals=(/usr/share/calendar/calendar.computer
    /usr/share/calendar/calendar.history
    /usr/share/calendar/calendar.holiday
    /usr/share/calendar/calendar.usholiday
    /usr/share/calendar/calendar.music
    /usr/share/calendar/calendar.judaic
    /usr/share/calendar/calendar.christian)

EDITOR="vim"
GIT_EDITOR=$EDITOR
SVN_EDITOR=$EDITOR
VISUAL=$EDITOR

export EDITOR GIT_EDITOR SVN_EDITOR VISUAL

# NOTE: any options specified on the command line override these values
LESS="-"
LESS+="g"   # highlight only the particular string which was found
            #   by the last search command.
LESS+="j.5" # .5 is the middle line. integer start from the top of screen
LESS+="w"   # Temporarily highlights the first "new" line after a forward
            #   movement of a full page.
LESS+="x4"  # Set tab stops to 4 spaces
PAGER="less"
export PAGER LESS

export BASH_SILENCE_DEPRECATION_WARNING=1


export HISTSIZE=5000
export HISTFILESIZE=1000000
export HISTTIMEFORMAT="%m-%d %a %H:%M:%S "

#
# Update the $PATH based on common directory conventions
#
if [ -d $HOME/opal/bin ]; then
    PATH="$PATH:$HOME/opal/bin"
fi

if [ -d $HOME/.local/bin ]; then
    PATH="$PATH:$HOME/.local/bin"
fi

