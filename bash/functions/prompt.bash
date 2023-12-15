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



function opal:ps1_developer {
    local normal
    local bold
    local underline
    local bright_cyan
    local bright_white
    local bright_green

    normal="$(opal:color normal)"
    bold="$(opal:color normal bright)"
    underline="$(opal:color normal underline)"
    bright_green="$(opal:color green bright)"
    bright_cyan="$(opal:color cyan bright)"
    bright_white="$(opal:color white bright)"


    PS1="\n"
    PS1+="${bold}\$(parse_git_branch)${normal}\n"
    PS1+="${underline}\u"
    PS1+="@"
    PS1+="\h\n${normal}"
    PS1+="\[\D{$(opal:get_date_format opal-datetime)}\] "
    PS1+="${bold}\w\n"
    PS1+="\$${normal} "

    if [[ -n "$1" && "$1" == "color" ]]; then
        PS1="\n"
        PS1+="${bright_cyan}\$(parse_git_branch)\n"
        PS1+="${bright_green}\u"
        PS1+="@"
        PS1+="\h\n"
        PS1+="${bright_white}\[\D{$(opal:get_date_format opal-datetime)}\] "
        PS1+="${bright_cyan}\w\n"
        PS1+="${bright_white}\$${normal} "
    fi
}

