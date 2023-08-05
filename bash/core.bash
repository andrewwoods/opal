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

function opal:success() {
    local GREEN='\033[0;32m'
    local NOCOLOR='\033[0m'
    local MESSAGE="$1"

    echo -e "${GREEN}${MESSAGE}${NOCOLOR}"
}

function opal:failure() {
    local RED='\033[0;31m'
    local NOCOLOR='\033[0m'
    local MESSAGE="$1"

    echo -e "${RED}${MESSAGE}${NOCOLOR}"
}

function opal:message() {
    local CYAN='\033[0;36m'
    local NOCOLOR='\033[0m'
    local MESSAGE="$1"

    echo -e "${CYAN}${MESSAGE}${NOCOLOR}"
}
