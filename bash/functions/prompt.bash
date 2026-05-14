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

    if opal:str_equals "${TERM_BG}" 'light'; then
        opal:ps2_default_light $style
    else
        opal:ps2_default_dark $style
    fi
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
            if opal:str_equals "${TERM_BG}" 'light'; then
                opal:ps1_developer_light $style
            else
                opal:ps1_developer $style
            fi
            ;;

        default)
            if opal:str_equals "${TERM_BG}" 'light'; then
                opal:ps1_default_light $style
            else
                opal:ps1_default_dark $style
            fi
            ;;

        *)
            opal:std_error "Sorry, but '${1}' is not a valid prompt name"
            opal:std_error "Try brief, minimal, developer, or default"
            return 1
            ;;
    esac
}

##
## Define the default PS1 prompt using 2 lines, for a dark theme
##
## This style of prompt uses two lines. Most people use a single user account on a
## single machine. Due to this idea, the username and hostname are not included in
## the prompt. The prompt starts with the time in 24-hour format. This is followed
## by the base directory name. A ``~`` (tilde) will be used to represent the home
## directory. This relies upon a dark terminal theme being used. The final piece
## of data is the history number.
##
## On the second line, there is only the ``$`` (dollar symbol) which shows that
## you're a normal user. This will be changed to a ``#`` if you're root. The nice
## this about this style of prompt, is that it provides some detail about your
## session, while providing a lot of space for you to write your command.
##
## @uses PS1
##
## @uses opal:color
##
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
    PS1+="\t>"
    PS1+="${bright_cyan}"
    PS1+=" \W>"
    PS1+="${bright_blue}"
    PS1+=" \!>${normal}\n"
    PS1+="${bright_white}\$${normal} "
}

##
## This is the light theme companion to ``opal:ps1_default_dark``.
##
## @uses PS1
##
## @see opal:ps1_default_dark.
##
function opal:ps1_default_light() {
    local normal
    local cyan
    local green
    local blue

    normal="$(opal:color normal)"
    blue="$(opal:color blue)"
    cyan="$(opal:color cyan)"
    green="$(opal:color green)"

    PS1="\n"
    PS1+="${green}"
    PS1+="\t>"  # base directory name
    PS1+="${cyan}"
    PS1+=" \w>" # base directory name
    PS1+="${blue}"
    PS1+=" \!>${normal}\n"
    PS1+="${green}\$${normal} "
}

##
## use a typical username@host style prompt that includes the Git branch
##
## This style of prompt is quite common. It shows the username, name, and the
## base directory. The home directory is displayed as a `~` (tilde). If you're
## a Git user, the branch name is also included after the directory. There's a
## design assumption that a dark terminal theme is being used when color is
## passed as an argument. The default is to use text formatting like bold or
## underline .
##
## @param style Optional.
##    The value `color` is currently the only option.
##
## @uses opal:color
##
## @uses opal:parse_git_branch
##
## @uses PS1
##
function opal:ps1_brief() {
    local normal
    local blue
    local cyan
    local green
    local red
    local yellow
    local white
    local style="$1"

    normal="$(opal:color normal)"
    bold="$(opal:color normal bright)"
    uline="$(opal:color normal underline)"
    reverse="$(opal:color normal reverse)"

    blue="$(opal:color blue bright)"
    cyan="$(opal:color cyan bright)"
    green="$(opal:color green bright)"
    red="$(opal:color red bright)"
    white="$(opal:color white bright)"
    yellow="$(opal:color yellow bright)"

    PS1="${bold}\u"
    PS1+="${normal}@"
    PS1+="\h "
    PS1+="${bold}\W${normal} "
    PS1+="${uline}\$(opal:parse_git_branch)${normal} ${bold}\$${normal} "

    if [[ -n "${style}" && "${style}" == "color" ]]; then
        PS1="${yellow}\u"
        PS1+="${white}@"
        PS1+="${green}\h "
        PS1+="${red}\W"
        PS1+="${cyan} \$(opal:parse_git_branch) \$${normal} "
    fi
}

##
## This is the light theme companion to `opal:ps1_brief`.
##
## @param style Optional.
##    The value `color` is currently the only option.
##
## @uses opal:color
##
## @uses opal:parse_git_branch
##
## @uses PS1
##
## @see opal:ps1_brief.
##
function opal:ps1_brief_light() {
    local style="$1"

    local normal
    local cyan
    local yellow
    local blue
    local red

    normal="$(opal:color normal)"
    bold="$(opal:color normal bright)"
    underline="$(opal:color normal underline)"
    blue="$(opal:color blue)"
    cyan="$(opal:color cyan bright)"
    red="$(opal:color red bright)"
    yellow="$(opal:color yellow )"
    green="$(opal:color green bright)"

    PS1="${bold}\u"
    PS1+="${normal}@"
    PS1+="\h "
    PS1+="${underline}\W${normal}"
    PS1+="${bold} \$(opal:parse_git_branch) \$${normal} "

    if [[ -n "${style}" && "${style}" == "color" ]]; then
        PS1="${yellow}\u"
        PS1+="${normal}@"
        PS1+="${green}\h "
        PS1+="${red}\W"
        PS1+="${cyan} \$(opal:parse_git_branch) \$${normal} "
    fi
}

##
## A minimal prompt that shows the current working directory with $HOME abbreviated
## with a tilde. The history number of this command is shown for ease of command reuse.
## The $ symbol is used to reflect you're a normal user, where the # is used for root.
##
## The username and hostname are not shown in this prompt because the most common
## use case is for a person to always use their personal account on their own machine.
## Also the git branch is not used in this prompt.
##
## @param style Optional.
##    The value `color` is currently the only option.
##
## @uses opal:color
##
## @uses PS1
##
function opal:ps1_minimal() {
    local style="$1"

    normal="$(opal:color normal)"
    bold="$(opal:color normal bright)"
    cyan="$(opal:color cyan bright)"
    white="$(opal:color white bright)"

    PS1="\n"
    PS1+="${bold}"
    PS1+="\W"
    PS1+="${normal}"
    PS1+=" \!:"
    PS1+="${bold}"
    PS1+="\$>"
    PS1+="${normal} "
    if [[ -n "${style}" && "${style}" == "color" ]]; then
        PS1="\n"
        PS1+="${cyan}"
        PS1+="\W"
        PS1+="${white}"
        PS1+=" \!:"
        PS1+="${cyan}"
        PS1+=">"
        PS1+="${normal} "
    fi
}

##
## Secondary / Continuation Prompt
##
## This prompt is designed to connect with `opal:ps1_default_dark`, so that it
## looks like a continuation of the PS1 command. So it's purposefully minimal.
##
function opal:ps2_default_dark {
   PS2=""
   PS2+="\[\e[1;37m\]"    # Color: Bright White
   PS2+="\$"              #
   PS2+="\[\e[1;36m\]"    # Color: Cyan
   PS2+=" >"              #
   PS2+="\[\e[0m\] "
}

##
## This is the light theme companion to `opal:ps2_default_dark`.
##
## @uses opal:color
##
## @see opal:ps2_default_dark.
##
function opal:ps2_default_light {

    normal="$(opal:color normal)"
    blue="$(opal:color blue bright)"
    green="$(opal:color green bright)"

    PS2=""
    PS2+="${blue}"
    PS2+="\$"
    PS2+="${green}"
    PS2+=" >"
    PS2+="${normal} "
}

##
## The selection prompt, which is used when presenting a list of choices.
##
## @uses PS3
##
function opal:ps3_default {
    PS3=""
    PS3+="Choose a #> "

    export PS3
}

##
## The selection prompt, which is used when presenting a list of choices.
##
## @uses PS3
##
function opal:ps3_minimal {
    PS3=""
    PS3+="Select: "

    export PS3
}

##
## This prompt function tries to help you by vertically displaying of function
## name file, and line number for each line of the script executed.
##
## @uses PS4
##
function opal:ps4_default {

    PS4="\n"
    PS4+='source-file: ${BASH_SOURCE}\n'
    PS4+='Function: ${FUNCNAME[0]:+${FUNCNAME[0]}} \n'
    PS4+='Line: ${LINENO} \n'
    PS4+="> "
    export PS4
}

##
## This prompt function tries to help you by displaying on a single line, the
## filename and line number for each line of the script executed.
##
function opal:ps4_simple {


    PS4='${BASH_SOURCE}:${LINENO}> '
    PS4+=""
    export PS4
}

##
## This prompt function tries to help you by displaying on a single chevron
## for each line of the script executed.
##
## @uses PS4
##
function opal:ps4_minimal {
    PS4='> '

    export PS4
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

##
## This prompt provides the most information to the user. Sometimes a git branch
## name can be quite long. With that in mind, this prompt style displays the
## current git branch on the top line when available. The second line displays the
## common ``username@hostname`` pattern. The third line displays the current date
## and time using the `opal-datetime` format, followed by the directory base name.
##
## @param String $style
##
## @uses opal:color
##
## @uses opal:parse_git_branch
##
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
    PS1+="${bold}\$(opal:parse_git_branch)${normal}\n"
    PS1+="${underline}\u"
    PS1+="@"
    PS1+="\h\n${normal}"
    PS1+="\[\D{$(opal:get_date_format opal-datetime)}\] "
    PS1+="${bold}\w\n"
    PS1+="\$${normal} "

    if [[ -n "$1" && "$1" == "color" ]]; then
        PS1="\n"
        PS1+="${bright_cyan}\$(opal:parse_git_branch)\n"
        PS1+="${bright_green}\u"
        PS1+="@"
        PS1+="\h\n"
        PS1+="${bright_white}\[\D{$(opal:get_date_format opal-datetime)}\] "
        PS1+="${bright_cyan}\w\n"
        PS1+="${bright_white}\$${normal} "
    fi
}

##
## This is the light theme companiion of opal:ps1_developer
##
## @uses opal:color
##
## @uses opal:get_date_format
##
function opal:ps1_developer_light {
    local normal
    local bold
    local underline
    local cyan
    local blue
    local bright_green

    normal="$(opal:color normal)"
    bold="$(opal:color normal bright)"
    underline="$(opal:color normal underline)"
    green="$(opal:color green bright )"
    cyan="$(opal:color cyan bright)"
    blue="$(opal:color blue bright)"


    PS1="\n"
    PS1+="${bold}\$(opal:parse_git_branch)${normal}\n"
    PS1+="${underline}\u"
    PS1+="@"
    PS1+="\h\n${normal}"
    PS1+="\[\D{$(opal:get_date_format opal-datetime)}\] "
    PS1+="${bold}\w\n"
    PS1+="\$${normal} "

    if [[ -n "$1" && "$1" == "color" ]]; then
        PS1="\n"
        PS1+="${cyan}\$(opal:parse_git_branch)\n"
        PS1+="${green}\u"
        PS1+="@"
        PS1+="\h\n"
        PS1+="${blue}\[\D{$(opal:get_date_format opal-datetime)}\] "
        PS1+="${green}\w\n"
        PS1+="${blue}\$${normal} "
    fi
}
