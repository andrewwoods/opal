#
# Prompt Functions
#

NORMAL=`echo -e '\033[0m'`

RED=`echo -e '\033[31m'`
BRIGHT_RED=`echo -e '\033[1;31m'`
GREEN=`echo -e '\033[0;32m'`
BRIGHT_GREEN=`echo -e '\033[1;32m'`
YELLOW=`echo -e '\033[0;33m'`
BRIGHT_YELLOW=`echo -e '\033[1;33m'`
BLUE=`echo -e '\033[0;34m'`
BRIGHT_BLUE=`echo -e '\033[1;34m'`
PURPLE=`echo -e '\033[0;35m'`
BRIGHT_PURPLE=`echo -e '\033[1;35m'`
CYAN=`echo -e '\033[0;36m'`
BRIGHT_CYAN=`echo -e '\033[1;36m'`
WHITE=`echo -e '\033[0;37m'`
BRIGHT_WHITE=`echo -e '\033[1;37m'`


function bold_branch_prompt()
{
    PS1="\[\e[1;36m\]\u"    # username
    PS1+="@"    # @
    PS1+="\h "  # host
    PS1+="\W"   # base directory name
    PS1+=" \$(parse_git_branch)\$\[\e[0m\] "
}

function brief_prompt()
{

    PS1="\[\e[1m\]\u"    # username
    PS1+="\[\e[0m\]@"    # @
    PS1+="\h "  # host
    PS1+="\[\e[4m\]\W\[\e[0m\]"   # base directory name
    PS1+="\[\e[1m\] \$(parse_git_branch) \$ \[\e[0m\]"

    if [[ -n "$1" && "$1" == "color" ]]; then
        PS1="\[\e[1;33m\]\u"    # username
        PS1+="\[\e[1;37m\]@"    # @
        PS1+="\[\e[1;32m\]\h "  # host
        PS1+="\[\e[1;31m\]\W"   # base directory name
        PS1+="\[\e[1;36m\] \$(parse_git_branch) \$ \[\e[0m\]"
    fi
}

function compact_prompt()
{
    PS1="\n"
    PS1+="\[\033[1m\]\u\[\e[0m\]"
    PS1+="@"
    PS1+="\[\033[1m\]\h\[\e[0m\]\n"
    PS1+="\[\033[1m\]\A\[\e[0m\] "
    PS1+="\[\033[4m\]\W\[\e[0m\]"
    PS1+="\[\033[1m\]\n\$(parse_git_branch)\n\[\e[0m\]\$ "

    if [[ -n "$1" || "$1" == "color" ]]; then
        PS1="\n"
        PS1+="\[\033[1;32m\]\u\[\e[0m\]"
        PS1+="@"
        PS1+="\[\033[1;35m\]\h\[\e[0m\]\n"
        PS1+="\[\033[1;36m\]\A \W\$(parse_git_branch)\[\e[0m\] \$ "
    fi
}

function default_prompt_dark()
{
    PS1="\n"
    PS1+="\[\e[1m\]"
    PS1+="\u"             # username
    PS1+="@"              # @
    PS1+="\h"             # host
    PS1+="\[\e[0m\] "
    PS1+="\n"
    PS1+="\[\e[1;35m\]"
    PS1+="\W"             # base directory name
    PS1+="\[\e[1;36m\] "
    PS1+="> "
    PS1+="\[\e[0m\]"
}


function default_prompt_light()
{
    PS1="\n"
    PS1+="\[\e[1m\]"
    PS1+="\u"             # username
    PS1+="@"              # @
    PS1+="\h"             # host
    PS1+="\[\e[0m\] "
    PS1+="\n"
    PS1+="\[\e[1;34m\]"
    PS1+="\W"             # base directory name
    PS1+="\[\e[1;32m\] "
    PS1+="> "
    PS1+="\[\e[0m\]"

}

function full_prompt()
{

    PS1="\n"
    PS1+="\[\033[1m\]\W\[\e[0m\]\n" # /path/to/dir
    PS1+="\u@\h\\n" # username@host.domain.com
    PS1+="\[\033[1m\]\d \$(parse_git_branch)\$\[\e[0m\] "

    if [[ -n "$1" || "$1" == "color" ]]; then
        PS1="\n"
        PS1+="\[\033[1;35m\]\W\[\e[0m\]\n" # /path/to/dir
        PS1+="\[\033[1;37m\]\u@\h\[\e[0m\]\n" # username@host.domain.com
        PS1+="\[\033[1;36m\]\d\$(parse_git_branch) \$\[\e[0m\] "
    fi
}


function minimal_prompt()
{
    #
    # Primary Prompt
    #
    PS1="\n"
    PS1+="\[\e[1;36m\]"    # Color: Cyan
    PS1+="\u"              # username
    PS1+="@"               # @
    PS1+="\h"              # host
    PS1+="\n"
    PS1+="\[\e[1;37m\]"    # Color: Bright White
    PS1+="\W"              # base directory name
    PS1+="\[\e[1;36m\]"    # Color: Cyan
    PS1+=" >"              # Prompt
    PS1+="\[\e[0m\] "      # Color: Default

    #
    # Secondary / Continuation Prompt
    #
    PS2=""
    PS2+="\[\e[1;37m\]"    # Color: Bright White
    PS2+="\W"              # base directory name
    PS2+="\[\e[1;36m\]"    # Color: Cyan
    PS2+=" >"              # PS1 prompt
    PS2+="\[\e[1;33m\]"    # Yellow color: on
    PS2+=" >"              # Prompt
    PS2+="\[\e[0m\] "

    #
    # Use in select lists
    #
    PS3=""
    PS3+="Choose a #>"
    PS3+=" "

    #
    # Debug Prompt - The default is ‘+ ’.
    #
    PS4=""
    PS4+="+>"
    PS4+=" "
}


function reverse_brief_prompt()
{
    PS1="\[\e[7m\]\u"    # username
    PS1+=" on "    # @
    PS1+="\h "  # host
    PS1+="\W"   # base directory name
    PS1+=" \$(parse_git_branch)\$\[\e[0m\] "
}

function root_prompt()
{

    PS1="\n"
    PS1+="\[\033[1m\]\u@\h\[\e[0m\]\n" # username@host
    PS1+="\w\n"    # /path/to/dir
    PS1+="\[\033[1m\]\D{%b %d %H:%M:%S}\[\e[0m\]"  # Sat Dec 19 16:23:24
    PS1+=" \$ "

    if [[ -n "$1" || "$1" == "color" ]]; then
        PS1="\n"
        PS1+="\[\033[1;31m\]\u@\h\[\e[0m\]\n" # username@host
        PS1+="\[\033[1;36m\]\w\[\e[0m\]\n"    # /path/to/dir
        PS1+="\[\033[1;37m\]\D{%b %d %H:%M:%S}\[\e[0m\]"  # Sat Dec 19 16:23:24
        PS1+=" \$ "
    fi
}


function vertical_prompt()
{

    PS1="\n"
    PS1+="\[\033[1m\]\u\[\e[0m\]"
    PS1+="@"
    PS1+="\[\033[1m\]\h\[\e[0m\]\n"
    PS1+="\[\033[1m\]\$(parse_git_branch)\[\e[0m\]\n"
    PS1+="\[\033[1m\]\D{%b %d %H:%M:%S}\e[0m\] \[\033[4m\]\W\e[0m\]\n"
    PS1+="\$ "

    if [[ -n "$1" || "$1" == "color" ]]; then
        PS1="\n"
        PS1+="\[\033[1;32m\]\u\[\e[0m\]"
        PS1+="@"
        PS1+="\[\033[1;35m\]\h\[\e[0m\]\n"
        PS1+="\[\033[1;37m\]\$(parse_git_branch)\[\e[0m\]\n"
        PS1+="\[\033[1;37m\]\w\[\e[0m\]\n"    # /path/to/dir
        PS1+="\[\033[1;36m\]\D{%b %d %H:%M:%S}\[\e[0m\]\n"
        PS1+="\$ "
    fi
}

