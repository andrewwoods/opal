#
# Prompt Functions
#


#
# Determine which PS1 prompt format and style to use.
#
# @global PS1
#
# @param string format
#   Determine the content/format of the prompt.
#
# @param string style
#   There can be more than one style of prompt. Color is a typical style, but
#   there could be others in the future.
#
function opal:prompt() {
    local style="default"

    if [ -n "$2" ]; then
        style="$2"
    fi

    case ${1} in
        brief)
            opal:brief_prompt $style
            ;;

        minimal)
            opal:minimal_prompt $style
            ;;

        *)
            opal:std_error "Sorry, but '${1}' is not a valid prompt name"
            ;;
    esac
}

#
#
#
function opal:brief_prompt() {
    local style="$1"

    PS1="\[\e[1m\]\u"
    PS1+="\[\e[0m\]@"
    PS1+="\h "
    PS1+="\[\e[4m\]\W\[\e[0m\]"
    PS1+="\[\e[1m\] \$(parse_git_branch) \$ \[\e[0m\]"

    if [[ -n "${style}" && "${style}" == "color" ]]; then
        PS1="\[\e[1;33m\]\u"
        PS1+="\[\e[1;37m\]@"
        PS1+="\[\e[1;32m\]\h "
        PS1+="\[\e[1;31m\]\W"
        PS1+="\[\e[1;36m\] \$(parse_git_branch) \$ \[\e[0m\]"
    fi
}

function opal:minimal_prompt() {
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
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function bold_branch_prompt() {
    PS1="\[\e[1;36m\]\u"    # username
    PS1+="@"    # @
    PS1+="\h "  # host
    PS1+="\W"   # base directory name
    PS1+=" \$(parse_git_branch)\$\[\e[0m\] "
}

function brief_prompt {
    opal:std_error 'Use opal:brief_prompt or opal:prompt instead'
    return 1
}

function compact_prompt() {
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

function default_prompt_dark() {
    PS1="\n"
    PS1+="\[\e[1m\]"
    PS1+="\u"             # username
    PS1+="@"              # @
    PS1+="\h"             # host
    PS1+="\[\e[0m\] "
    PS1+="\n"
    PS1+="\[\e[1;36m\]"
    PS1+="\W"             # base directory name
    PS1+="\[\e[1;36m\] "
    PS1+="> "
    PS1+="\[\e[0m\]"
}

function default_prompt_light() {
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

function full_prompt() {

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

function minimal_prompt {
    opal:std_error "use opal:minimal_prompt instead"
    return 1
}

function reverse_brief_prompt() {
    PS1="\[\e[7m\]\u"    # username
    PS1+=" on "    # @
    PS1+="\h "  # host
    PS1+="\W"   # base directory name
    PS1+=" \$(parse_git_branch)\$\[\e[0m\] "
}

function root_prompt() {

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

function vertical_prompt() {

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
