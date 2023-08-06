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

function opal:std_error {
    echo "$@" 1>&2
}

function opal:arg_default {
    if [ -z "$2" ]; then
        opal:std_error "Invalid Argument Error: 2 arguments are required"
        return 1
    fi
    local value="$2"

}

function opal:is_set {
    [[ -n "$1" ]]
}

function opal:is_unset {
    [[ -z "$1" ]]
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
    local level="$1"
    local message="$2"
    local file=$(echo "$level" | tr '[:upper:]' '[:lower:]')

    local date_format="+%Y-%m-%dT%H:%M:%S%z"
    local log_date=$(date ${date_format})
    local log_file="${OPAL_LOG_DIR}/${file}.log"

    echo "${log_date} ${level} ${message}" >> $log_file
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
    opal:number_at_least $1 $2  && opal:number_at_most $1 $3
}

################################################################################
#
#   User Experience
#
#################################################################################

function opal:success() {
    local GREEN='\033[1;32m'
    local NOCOLOR='\033[0m'
    local MESSAGE="$1"

    echo -e "${GREEN}${MESSAGE}${NOCOLOR}"
}

function opal:failure() {
    local RED='\033[1;31m'
    local NOCOLOR='\033[0m'
    local MESSAGE="$1"

    echo -e "${RED}${MESSAGE}${NOCOLOR}"
}

function opal:message() {
    local CYAN='\033[1;36m'
    local NOCOLOR='\033[0m'
    local MESSAGE="$1"

    echo -e "${CYAN}${MESSAGE}${NOCOLOR}"
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
