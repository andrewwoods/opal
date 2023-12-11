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

    if opal:is_set "$2"; then
        style="$2"
    fi

    opal:ps2_default_dark
    opal:ps3_minimal
    opal:ps4_default
    case ${1} in
        brief)
            opal:ps1_brief $style
            opal:ps4_simple
            ;;

        minimal)
            opal:ps1_minimal $style
            opal:ps4_minimal
            ;;

        developer)
            opal:ps1_developer $style
            ;;

        default)
            opal:ps1_default_dark $style
            ;;

        *)
            opal:std_error "Sorry, but '${1}' is not a valid prompt name"
            opal:std_error "Try brief, minimal, developer, or default"
            return 1
            ;;
    esac
}

function opal:ps1_default_dark() {
    local normal
    local bright_cyan
    local bright_white

    normal="$(opal:color normal)"
    bright_blue="$(opal:color blue bright)"
    bright_cyan="$(opal:color cyan bright)"
    bright_white="$(opal:color white bright)"

    PS1="\n"
    PS1+="${bright_white}"
    PS1+="\t >"  # base directory name
    PS1+="${bright_cyan}"
    PS1+=" \w >" # base directory name
    PS1+="${bright_blue}"
    PS1+=" \! >${normal}\n"
    PS1+="${bright_white}\$${normal} "
}

#
#
#
function opal:ps1_brief() {
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

function opal:ps1_minimal() {
    #
    # Primary Prompt
    #
    PS1="\n"
    PS1+="\[\e[1;36m\]"    # Color: Cyan
    PS1+="\W"              # base directory name
    PS1+="\[\e[1;36m\]"    # Color: Cyan
    PS1+=" \!:\$"
    PS1+="\[\e[1;37m\]"    # Color: Bright White
    PS1+=">"         # Prompt
    PS1+="\[\e[0m\] "      # Color: Default
}

#
# Secondary / Continuation Prompt
#
function opal:ps2_default_dark {
   PS2=""
   PS2+="\[\e[1;37m\]"    # Color: Bright White
   PS2+="\$"              #
   PS2+="\[\e[1;36m\]"    # Color: Cyan
   PS2+=" >"              #
   PS2+="\[\e[0m\] "
}

function opal:ps3_default {
    PS3=""
    PS3+="Choose a #> "

    export PS3
}

function opal:ps3_minimal {
    PS3=""
    PS3+="Select: "

    export PS3
}

function opal:ps4_default {
    PS4="\n"
    PS4+='source-file: ${BASH_SOURCE}\n'
    PS4+='Function: ${FUNCNAME[0]:+${FUNCNAME[0]}} \n'
    PS4+='Line: ${LINENO} \n'
    PS4+="${BRIGHT_WHITE}>${NORMAL} "                 #
    export PS4
}

function opal:ps4_simple {
    PS4+="\n\[\e[1;37m\]"    # Color: Bright White
    PS4='${BASH_SOURCE}:${LINENO}> '
    PS4+="\[\e[0m\]"         # Color: Reset
    export PS4
}

function opal:ps4_minimal {
    PS4='> '

    export PS4
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function bold_branch_prompt() {
    PS1="\[\e[1;36m\]\u"    # username
    PS1+="@"    # @
    PS1+="\h "  # host
    PS1+="\W"   # base directory name
    PS1+=" \$(parse_git_branch)\$\[\e[0m\] "
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
    opal:std_error "use opal:ps1_minimal instead"
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

function opal:ps1_vertical() {

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
