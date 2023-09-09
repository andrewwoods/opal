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

export OPAL_VERSION
export OPAL_LOG_DIR
export OPAL_LOG_LEVEL

OPAL_VERSION="3.0.0-alpha"
OPAL_LOG_DIR="${HOME}/logs"
OPAL_LOG_LEVEL="error"

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

    file="error.log"
    date_format="+%Y-%m-%dT%H:%M:%S%z"

    log_date="$(date ${date_format})"
    log_file="${OPAL_LOG_DIR}/${file}"

    echo "${log_date} ${level} ${message}" >> "${log_file}"
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
        system_profiler -detailLevel mini SPSoftwareDataType SPHardwareDataType
    fi
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

    echo -e "${GREEN}${MESSAGE}${NORMAL}"
}

function opal:failure() {
    local MESSAGE="$1"

    echo -e "${RED}${MESSAGE}${NORMAL}"
}

function opal:message() {
    local MESSAGE="$1"

    echo -e "${CYAN}${MESSAGE}${NORMAL}"
}

function opal:label() {
    local MESSAGE="$1"

    echo -e "${BRIGHT_YELLOW}${MESSAGE}${NORMAL}"
}

function opal:speak {
    say --interactive="cyan/black" "$@"
}

function opal:ask {
    local prompt
    prompt="${BRIGHT_YELLOW}${1}${NORMAL}"

    read -p "${prompt}: " input

    echo "${input}"
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
    elif [[ $format_name == "iso-timestamp" ]]; then
        echo "%Y-%m-%dT%H:%M:%S%z"
    elif [[ $format_name == "world-date" ]]; then
        echo "%d.%m.%Y"
    elif [[ $format_name == "world-datetime" ]]; then
        echo "%d.%m.%Y %H:%M"
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
