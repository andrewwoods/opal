################################################################################
# @package Opal
#
# Core
#
# Provides the essential functions available to any Opal function. So this file
# must be included if you want to use an Opal function. So while Opal strives
# to be modular, this file is the only real dependency.
#
# Copyright (C) 2023 Andrew Woods
################################################################################

export OPAL_VERSION="3.0.0-alpha"

export OPAL_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/opal"
export OPAL_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/opal"
export OPAL_STATE_DIR="${XDG_DATA_HOME:-$HOME/.local/state}/opal"
export OPAL_LOG_DIR="${OPAL_STATE_DIR}"

export NORMAL RED BRIGHT_RED GREEN BRIGHT_GREEN YELLOW BRIGHT_YELLOW
export BLUE BRIGHT_BLUE PURPLE BRIGHT_PURPLE CYAN BRIGHT_CYAN WHITE BRIGHT_WHITE

NORMAL=$(echo -e '\033[0m')
RED=$(echo -e '\033[31m')
BRIGHT_RED=$(echo -e '\033[1;31m')
GREEN=$(echo -e '\033[0;32m')
BRIGHT_GREEN=$(echo -e '\033[1;32m')
YELLOW=$(echo -e '\033[0;33m')
BRIGHT_YELLOW=$(echo -e '\033[1;33m')
BLUE=$(echo -e '\033[0;34m')
BRIGHT_BLUE=$(echo -e '\033[1;34m')
PURPLE=$(echo -e '\033[0;35m')
BRIGHT_PURPLE=$(echo -e '\033[1;35m')
CYAN=$(echo -e '\033[0;36m')
BRIGHT_CYAN=$(echo -e '\033[1;36m')
WHITE=$(echo -e '\033[0;37m')
BRIGHT_WHITE=$(echo -e '\033[1;37m')

function opal:color {
    local color
    local style
    local code

    if opal:is_unset "$1"; then
        opal:std_error 'You forgot to specify a color name'
        return 1
    fi
    color="$1"
    code=""
    style=""

    if opal:is_set "$2"; then
        style="$2"
    fi

    if opal:string_equals "$color" "normal"; then
        code="0"
    fi

    if opal:string_equals "$color" "red"; then
        code="31"
    fi

    if opal:string_equals "$color" "green"; then
        code="32"
    fi

    if opal:string_equals "$color" "yellow"; then
        code="33"
    fi

    if opal:string_equals "$color" "blue"; then
        code="34"
    fi

    if opal:string_equals "$color" "purple"; then
        code="35"
    fi

    if opal:string_equals "$color" "cyan"; then
        code="36"
    fi

    if opal:string_equals "$color" "white"; then
        code="37"
    fi

    if opal:string_equals "$style" "bright"; then
        code="1;${code}"
        if opal:string_equals "$color" "normal"; then
            code="1"
        fi
    fi

    if opal:string_equals "$style" "underline"; then
        code="4;${code}"
        if opal:string_equals "$color" "normal"; then
            code="4"
        fi
    fi

    if opal:string_equals "$style" "reverse"; then
        code="7;${code}"
        if opal:string_equals "$color" "normal"; then
            code="7"
        fi
    fi

    echo -e "\[\e[${code}m\]"
}

function opal:std_error {
    echo "$@" 1>&2
}

function opal:is_set {
    [[ -n "$1" ]]
}

function opal:is_unset {
    [[ -z "$1" ]]
}

function opal:command_exists {
    local type_result
    if opal:is_unset "$1"; then
        opal:std_error "You forgot to specify which command you wish to check"
    fi

    type_result=$(type -t "$1")

    [[ "$type_result" = "file" ]]
}

function opal:function_exists {
    local type_result
    if opal:is_unset "$1"; then
        opal:std_error "You forgot to specify which function you wish to check"
    fi

    type_result=$(type -t "$1")

    [[ "$type_result" == "function" ]]
}

function opal:ensure_dir_exists {
    local dir
    if opal:is_unset "$1"; then
        opal:std_error "You forgot to specify which directory you need"
        return 1
    fi
    dir="${1}"

    if ! opal:dir_exists "$dir"; then
        opal:std_error "Creating directory ${dir}"
        mkdir -p "$dir"
    else
        opal:std_error "directory exists ${dir}"
    fi
}

################################################################################
#
#   Logging
#
#################################################################################

function opal:log_emergency {
    opal:log EMERGENCY "${1}"
}

function opal:log_alert {
    opal:log ALERT "${1}"
}

function opal:log_critical {
    opal:log CRITICAL "${1}"
}

function opal:log_error {
    opal:log ERROR "${1}"
}

function opal:log_warning {
    opal:log WARNING "${1}"
}

function opal:log_notice {
    opal:log NOTICE "${1}"
}

function opal:log_info {
    opal:log INFO "${1}"
}

function opal:log_debug {
    opal:log DEBUG "${1}"
}

function opal:log {
    local log_date
    local log_file
    local file
    local date_format

    local level="$1"
    local message="$2"

    local LOG_DIR=${XDG_STATE_HOME:-$HOME/.local/state}
    file="error.log"
    date_format="iso-timestamp"

    log_date="$(opal:today ${date_format})"
    log_file="${LOG_DIR}/opal/${file}"

    if ! opal:dir_exists "${LOG_DIR}/opal"; then
        opal:std_error "Creating dir: ${LOG_DIR}/opal"
        mkdir -p "${LOG_DIR}/opal"
    fi

    echo "${log_date} ${level} ${message}" >> "${log_file}"
}

################################################################################
#
#   String
#
################################################################################

function opal:string_equals {
    [[ $1 == $2 ]]
}

function opal:string_unequal {
    [[ $1 != $2 ]]
}

################################################################################
#
#   Numeric
#
#################################################################################

function opal:number_equals {
    [[ $1 -eq $2 ]]
}

function opal:number_at_least {
    [[ $1 -ge $2 ]]
}

function opal:number_is_above {
    [[ $1 -gt $2 ]]
}

function opal:number_at_most {
    [[ $1 -le $2 ]]
}

function opal:number_is_below {
    [[ $1 -lt $2 ]]
}

function opal:number_between {
    opal:number_at_least "$1" "$2" && opal:number_at_most "$1" "$3"
}

################################################################################
#
#   Operating System
#
#################################################################################

function opal:about_macos {
    opal:label "About MacOS"

    if opal:command_exists "neofetch"; then
        neofetch
    else
        opal:about_macos_fallback
    fi
}

function opal:about_macos_fallback {
    system_profiler -detailLevel mini SPSoftwareDataType SPHardwareDataType
}

function opal:about_popos {

    if opal:command_exists "neofetch"; then
        neofetch
    else
        opal:about_popos_fallback
    fi
}

function opal:about_popos_fallback {
    about_me="$(whoami)@$(hostname)"
    opal:label "${about_me}"
    _n
    inxi
    _n
    hostnamectl | grep -e 'Hardware' -e 'Architecture' -e 'Chassis'
    _n
    opal:message "Memory"
    free -h
    _n

}

function opal:about_ubuntu {
    opal:label "About Ubuntu"

    if opal:command_exists "neofetch"; then
        neofetch
    elif opal:command_exists "lshw"; then
        lshw
    else
        # Fallback to generic ubuntu commands
        hwinfo
        lscpu
        lspci
        df -h
        free -h
    fi
}

################################################################################
#
#   User Experience
#
#################################################################################

function opal:success() {
    local MESSAGE="$1"
    local green
    local normal

    green="\033[1;32m"
    normal="\033[0m"
    echo -e "${green}${MESSAGE}${normal}"
}

function opal:failure() {
    local MESSAGE="$1"
    local red
    local normal

    red="\033[1;31m"
    normal="\033[0m"
    echo -e "${red}${MESSAGE}${normal}"
}

function opal:message() {
    local MESSAGE="$1"
    local cyan
    local normal

    cyan="\033[1;36m"
    normal="\033[0m"
    echo -e "${cyan}${MESSAGE}${normal}"
}

function opal:label() {
    local MESSAGE="$1"
    local yellow
    local normal

    yellow="\033[1;33m"
    normal="\033[0m"
    echo -e "${yellow}${MESSAGE}${normal}"
}

function opal:speak {
    if opal:is_unset "$1"; then
        opal:std_error 'What message do you like spoken?'
        return 1
    fi
    say --interactive="cyan/black" "$@"
}

function opal:ask {
    local prompt

    if opal:is_unset "$1"; then
        opal:std_error 'You forgot to specify a prompt'
        return 1
    fi

    prompt="$(opal:label "$1")"

    read -p "${prompt}: " input

    echo "${input}"
}

function opal:sleep {
    local -i seconds

    seconds="$1"
    if opal:number_equals "$seconds" 0; then
        opal:std_error "Using default value."
        seconds=5
    fi
    opal:message "Sleeping for ${seconds} seconds"
    sleep $seconds
}

################################################################################
#
#   File Checks
#
#################################################################################

function opal:dir_exists {
    [[ -d "$1" ]]
}

function opal:file_exists {
    [[ -f "$1" ]]
}

function opal:symlink_exists {
    [[ -L "$1" ]]
}

function opal:file_has_read {
    [[ -r "$1" ]]
}

function opal:file_has_write {
    [[ -w "$1" ]]
}

function opal:file_has_execute {
    [[ -x "$1" ]]
}

function opal:file_has_set_uid {
    [[ -u "$1" ]]
}

function opal:file_has_set_gid {
    [[ -g "$1" ]]
}

################################################################################
#
#   Date Functions
#
################################################################################

function opal:get_date_format {
    local format_name

    format_name="$1"
    if [[ $format_name == "unix" ]]; then
        echo "%s"
    elif [[ $format_name == "opal-date" ]]; then
        echo "%Y %b %d %a"
    elif [[ $format_name == "opal-datetime" ]]; then
        echo "%Y %b %d %a %H:%M"
    elif [[ $format_name == "opal-timestamp" ]]; then
        echo "%Y %b %d %a %H:%M:%S%z"
    elif [[ $format_name == "iso-date" ]]; then
        echo "%Y-%m-%d"
    elif [[ $format_name == "iso-datetime" ]]; then
        echo "%Y-%m-%dT%H:%M%z"
    elif [[ $format_name == "iso-timestamp" ]]; then
        echo "%Y-%m-%dT%H:%M:%S%z"
    elif [[ $format_name == "world-date" ]]; then
        echo "%d/%m/%Y"
    elif [[ $format_name == "world-datetime" ]]; then
        echo "%d/%m/%Y %H:%M"
    elif [[ $format_name == "world-timestamp" ]]; then
        echo "%d/%m/%Y %H:%M:%S%z"
    elif [[ $format_name == "us-date" ]]; then
        echo "%m/%d/%Y"
    elif [[ $format_name == "us-datetime" ]]; then
        echo "%m/%d/%Y %l:%M%p"
    elif [[ $format_name == "us-timestamp" ]]; then
        echo "%m/%d/%Y %l:%M:%S%p %z"
    elif [[ $format_name == "filename-date" ]]; then
        echo "%Y-%m-%d"
    elif [[ $format_name == "filename-datetime" ]]; then
        echo "%Y-%m-%d-%H-%M"
    elif [[ $format_name == "filename-timestamp" ]]; then
        echo "%Y-%m-%d-%H-%M-%S"
    else
        opal:std_error "Your specified format name is not available"
        return 1
    fi
}

function opal:today {
    local format_name
    local date_format

    format_name="opal-datetime"
    if opal:is_set $1; then
        format_name="$1"
    fi

    date_format=$(opal:get_date_format "$format_name")
    echo "$(date +"${date_format}")"
}

function opal:someday() {
    local unix_time
    local format_name
    local date_format

    if opal:is_unset "$1"; then
        echo "You forgot to the time in unix seconds"
        return 1
    fi
    unix_time=$1

    format_name="opal-datetime"
    if opal:is_set "$2"; then
        format_name="$2"
    fi
    date_format="+$(opal:get_date_format "${format_name}")"

    date -r "${unix_time}" "${date_format}"
}

##
## Calculate the duration of two epoch times.
##
## @param int start_time
##   The starting UNIX timestamp.
##
## @param int end_time The
##   The ending UNIX timestamp.
##
## @return string
##
function opal:duration {
    if opal:is_unset "$1"; then
        opal:std_error "What is your start time in epoch seconds (UNIX time)"
        return 1
    fi

    if opal:is_unset "$2"; then
        opel:std_error "What is your end time in epoch seconds (UNIX time)"
        return 2
    fi

    duration=$(($2 - $1))

    # Create Time Intervals
    let minute_in_seconds=60
    let hour_in_seconds=60*$minute_in_seconds
    let day_in_seconds=24*$hour_in_seconds
    let year_in_seconds=$((365*$day_in_seconds))

    let seconds=0
    let minutes=0
    let hours=0
    let days=0
    let years=0
    let temp=0

    if [[ $duration -gt $year_in_seconds ]]; then
        years=$(expr $duration / $year_in_seconds)
        temp=$(expr $years \* $year_in_seconds)
        duration=$(expr $duration - $temp)
    fi

    if [[ $duration -gt $day_in_seconds ]]; then
        days=$(expr $duration / $day_in_seconds)
        temp=$(expr $days \* $day_in_seconds)
        duration=$(expr $duration - $temp)
    fi

    if [[ $duration -gt $hour_in_seconds ]]; then
        hours=$(expr $duration / $hour_in_seconds)
        temp=$(expr $hours \* $hour_in_seconds)
        duration=$(expr $duration - $temp)
    fi

    if [[ $duration -gt $minute_in_seconds ]]; then
        minutes=$(expr $duration / $minute_in_seconds)
        temp=$(expr $minutes \* $minute_in_seconds)
        duration=$(expr $duration - $temp)
    fi
    seconds=$duration

    opal:message "${years} years ${days} days ${hours} hours ${minutes} minutes ${seconds} seconds"
}

##
##  Get the number of seconds for a given quantity of time.
##
##  Many tools use the number of seconds for their operation. It can be useful
##  to know number of seconds in a duration of time. This function makes it easy
##  to calculate time intervals like 3 days or 2 weeks.
##
##  @param string $unit
##      The unit of time you wish to convert to seconds
##
##  @param integer $quantity
##      The number of time units time you wish to convert to seconds
##
##  @output integer
##      The calculation result in seconds
##
##  @return error
##      1: Argument is missing
##
##  @example opal:interval_to_seconds days 2
##      output: 172800
##
function opal:interval_to_seconds {
    local unit
    local -i quantity
    local -i duration
    local -i base_value

    # Time "Constants"
    local MINUTE_IN_SECONDS=60
    local HOUR_IN_SECONDS=60*$MINUTE_IN_SECONDS
    local DAY_IN_SECONDS=24*$HOUR_IN_SECONDS
    local WEEK_IN_SECONDS=7*$DAY_IN_SECONDS
    local MONTH_IN_SECONDS=30*$DAY_IN_SECONDS

    if opal:is_unset "$1"; then
        opal:std_error "Please specify the units you want (minutes, hours, days, weeks, months)"
        return 1
    fi
    unit="$1"

    if opal:is_unset "$2"; then
        opal:std_error "Please specify how many ${unit}"
        return 1
    fi
    quantity="$2"

    if opal:string_equals "$unit" "minutes"; then
        base_value="$MINUTE_IN_SECONDS"
    elif opal:string_equals "$unit" "hours"; then
        base_value="$HOUR_IN_SECONDS"
    elif opal:string_equals "$unit" "days"; then
        base_value="$DAY_IN_SECONDS"
    elif opal:string_equals "$unit" "weeks"; then
        base_value="$WEEK_IN_SECONDS"
    elif opal:string_equals "$unit" "months"; then
        base_value="$MONTH_IN_SECONDS"
    else
        opal:std_error "$(opal:failure "Uh oh. '${unit}' is not a valid choice")"
        return 1
    fi

    duration=$(($quantity * $base_value))

    echo "$duration"
}

################################################################################
#
#   Documentation
#
################################################################################

function opal:version {
    echo "Opal version: ${OPAL_VERSION}"
}

function opal:about {
    opal:message "$(opal:version)"

    cat <<-EOF

    Opal is a command line framework. It's a foundation to provide a consistent
    foundation across machines and users. It's meant to be extended. Version 3
    improves the scripting experience.

    For the most up-to-date version, and the full documentation, visit the
    Github repo at https://github.com/andrewwoods/opal

    Copyright (C) 2023 Andrew Woods
EOF
}
