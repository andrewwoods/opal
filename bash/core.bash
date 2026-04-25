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

export OPAL_VERSION="3.0.0-beta-0406"

# The $OPAL_CONFIG_DIR is not meant to replace the XDG_CONFIG_HOME directory.
# Rather it's an additional directory - one that could be used in the
# XDG_CONFIG_DIRS list of directories.
export OPAL_CONFIG_DIR="${OPAL_DIR}/config"

# This makes the log file accessible as a variable. However, it's preferred that
# the opal:data_dir, opal:state_dir, opal:cache_dir and opal:config_dir
export OPAL_XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}/opal"
export OPAL_LOG_FILE="${OPAL_XDG_STATE_HOME}/error.log"


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

    if opal:str_equals "$color" "normal"; then
        code="0"
    fi

    if opal:str_equals "$color" "red"; then
        code="31"
    fi

    if opal:str_equals "$color" "green"; then
        code="32"
    fi

    if opal:str_equals "$color" "yellow"; then
        code="33"
    fi

    if opal:str_equals "$color" "blue"; then
        code="34"
    fi

    if opal:str_equals "$color" "purple"; then
        code="35"
    fi

    if opal:str_equals "$color" "cyan"; then
        code="36"
    fi

    if opal:str_equals "$color" "white"; then
        code="37"
    fi

    if opal:str_equals "$style" "bright"; then
        code="1;${code}"
        if opal:str_equals "$color" "normal"; then
            code="1"
        fi
    fi

    if opal:str_equals "$style" "underline"; then
        code="4;${code}"
        if opal:str_equals "$color" "normal"; then
            code="4"
        fi
    fi

    if opal:str_equals "$style" "reverse"; then
        code="7;${code}"
        if opal:str_equals "$color" "normal"; then
            code="7"
        fi
    fi

    echo -e "\[\e[${code}m\]"
}

function opal:std_error {
    echo "$@" 1>&2
}

function opal:std_log {
     opal:log_error "$1"
     opal:std_error "$1"
}

function opal:is_set {
    [[ -n "$1" ]]
}

function opal:is_unset {
    [[ -z "$1" ]]
}

##
## Provide a human message for numeric exit status codes provided by $?
##
## @param int $err_number
##   The value captured by $?
##
## @return string
##
## @uses opal:std_log
##
## @see man errno
##
function opal:error_message {
    local err_number
    local message

    if opal:is_unset $1; then
        opal:std_log "The error status code was not passed to opal:error_message()"
        return 1
    fi

    err_number="$1"
    if ! [[ $err_number =~ [0-9]+ ]]; then
        opal:std_log "The argument is not an integer."
        return 22
    fi

    if opal:number_equals $err_number 0; then
        return 0;
    fi

    if opal:number_equals $err_number 1; then
        message="General Error."
    elif opal:number_equals $err_number 2; then
        message="Called incorrectly."
    elif opal:number_equals $err_number 13; then
        message="Permission Denied: cannot execute."
    elif opal:number_equals $err_number 17; then
        message="File already exists."
    elif opal:number_equals $err_number 20; then
        message="Not a directory."
    elif opal:number_equals $err_number 21; then
        message="Directory already exists."
    elif opal:number_equals $err_number 22; then
        message="Invalid argument."
    elif opal:number_equals $err_number 126; then
        message="Permission Denied: cannot execute."
    elif opal:number_equals $err_number 127; then
        message="Not available in PATH."
    elif opal:number_equals $err_number 130; then
        message="Script terminated by CTRL+C."
    elif opal:number_equals $err_number 255 ; then
        message="Exit status out of range."
    elif opal:number_is_above $err_number 127 ; then
        message="Fatal error occurred."
    else
        message="Failure occurred."
    fi

    echo "${message} Error code=${err_number}"
    return 0
}

#
# Determine if a value has no content or just white space.
#
function opal:is_empty {
    local trimmed

    # Remove leading white spaces
    trimmed="$(echo "$1" | sed -E 's/^[[:blank:]]+//g')"
    # Remove trailing white spaces
    trimmed="$(echo "$trimmed" | sed -E 's/[[:blank:]]+$//g')"

    [[ -z "$1" || -z "$trimmed" ]]
}

#
# Check that a command is available on your system.
#
# @return bool
#
# @uses type
#
function opal:command_exists {
    local type_result
    if opal:is_unset "$1"; then
        opal:std_error "You forgot to specify which command you wish to check"
    fi

    type_result=$(type -t "$1")

    [[ "$type_result" = "file" ]]
}

#
# Check that a function is available on your shell.
#
# @return bool
#
# @uses type
#
function opal:function_exists {
    local type_result
    if opal:is_unset "$1"; then
        opal:std_error "You forgot to specify which function you wish to check"
    fi

    type_result=$(type -t "$1")

    [[ "$type_result" == "function" ]]
}

#
# Create a directory if it doesn't exist
#
# When you need a directory to be avaialable, this will create it if need be.
#
# @return bool
#
# @uses type
#
function opal:ensure_dir_exists {
    local dir
    if opal:is_unset "$1"; then
        opal:std_error "You forgot to specify which directory you need"
        return 1
    fi
    dir="${1}"

    if ! opal:dir_exists "$dir"; then
        mkdir -p "$dir"
    fi
}

################################################################################
#
#   Logging
#
#################################################################################

#
# Writes an EMERGENCY-level message to the log.
#
# @param string $message
#
# @param string $filepath
#
function opal:log_emergency {
    opal:log EMERGENCY "${1}" "${2}"
}

#
# Writes a ALERT-level message to the log.
#
# @param string $message
#
# @param string $filepath
#
function opal:log_alert {
    opal:log ALERT "${1}" "${2}"
}

#
# Writes a CRITICAL-level message to the log.
#
# @param string $message
#
# @param string $filepath
#
function opal:log_critical {
    opal:log CRITICAL "${1}" "${2}"
}

#
# Writes a ERROR-level message to the log.
#
# @param string $message
#
# @param string $filepath
#
function opal:log_error {
    opal:log ERROR "${1}" "${2}"
}

#
# Writes a WARNING-level message to the log.
#
# @param string $message
#
# @param string $filepath
#
function opal:log_warning {
    opal:log WARNING "${1}" "${2}"
}

#
# Writes a NOTICE-level message to the log.
#
# @param string $message
#
# @param string $filepath
#
function opal:log_notice {
    opal:log NOTICE "${1}" "${2}"
}

#
# Writes a INFO-level message to the log.
#
# @param string $message
#
# @param string $filepath
#
function opal:log_info {
    opal:log INFO "${1}" "${2}"
}

#
# Writes a DEBUG-level message to the log.
#
# @param string $message
#
# @param string $filepath
#
# @uses opal:log
#
function opal:log_debug {
    opal:log DEBUG "${1}" "${2}"
}

#
# @param string $level
#   The logging level of the message. The RFC 5424 determines the levels.
#
# @param string $message
#   The message you want to write to the error log.
#
# @param string $filepath
#   Optional. The log file $HOME/.local/state/opal/error.log will be
#   if not specified.
#
function opal:log {
    local log_date
    local log_file
    local file
    local date_format

    local level="$1"
    local message="$2"
    local user_log_file="$3"

    local LOG_DIR="$(opal:state_dir)"
    file="error.log"
    date_format="iso-timestamp"

    log_date="$(opal:today ${date_format})"
    log_file="${LOG_DIR}/${file}"

    if opal:is_set "$user_log_file"; then
        log_file="$user_log_file"
    fi

    if ! opal:dir_exists "${LOG_DIR}"; then
        opal:std_error "Creating dir: ${LOG_DIR}"
        mkdir -p "${LOG_DIR}"
    fi

    echo "${log_date} ${level} ${message}" >> "${log_file}"
}

################################################################################
#
#   String
#
################################################################################

function opal:str_equals {
    [[ $1 == $2 ]]
}

function opal:str_unequals {
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
    say --interactive="cyan/black" -v Nathan "$@"
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

    # @see man strftime for details.
    # Designed on MacOS.
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
## Get the UNIX epoch seconds for a given Gregorian date in YYYY-MM-DD.
##
## @param string $date
##   The desired date in YYYY-MM-DD format.
##
## @return int $seconds
##   The corresponding date in UNIX epoch seconds
##
## @exit 0 | 1
##
function opal:epoch() {
    local somedate
    local iso_format
    local unix_format

    if opal:is_unset "$1"; then
        opal:std_log "You forgot to specify the date in YYYY-MM-DD"
        return 1
    fi
    if ! [[ "$1" =~ ^[1-2][0-9]{3}\-[0-9]{2}\-[0-9]{2} ]]; then
        opal:std_log "The date must be in YYYY-MM-DD"
        return 1
    fi
    somedate=$1

    iso_format="$(opal:get_date_format "iso-timestamp")"
    iso_format="%Y-%m-%dT%H:%M:%S"
    unix_format="+$(opal:get_date_format "unix")"

    date -j -f "${iso_format}" "${somedate}T00:00:00" "${unix_format}"
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
    local -i start_time
    local -i end_time

    start_time="$1"

    if opal:is_unset "$2"; then
        opal:std_error "What is your end time in epoch seconds (UNIX time)"
        return 2
    fi
    end_time="$2"

    duration=$(($end_time - $start_time))

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

    if opal:str_equals "$unit" "minutes"; then
        base_value="$MINUTE_IN_SECONDS"
    elif opal:str_equals "$unit" "hours"; then
        base_value="$HOUR_IN_SECONDS"
    elif opal:str_equals "$unit" "days"; then
        base_value="$DAY_IN_SECONDS"
    elif opal:str_equals "$unit" "weeks"; then
        base_value="$WEEK_IN_SECONDS"
    elif opal:str_equals "$unit" "months"; then
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
    echo "Bash version: ${BASH_VERSION}"
}

function opal:about {
    opal:message "$(opal:version)"
    local year="$(date '+%Y')"

    cat <<-EOF

    Opal is a command line framework. It's a foundation to provide a consistent
    foundation across machines and users. It's meant to be extended. Version 3
    improves the scripting experience.

    For the most up-to-date version, and the full documentation, visit the
    Github repo at https://github.com/andrewwoods/opal

    Copyright (C) 2023-${year} Andrew Woods
EOF
}
