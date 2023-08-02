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

function opal:emergency {
    opal:log "EMERGENCY ${1}"
}

function opal:alert {
    opal:log "ALERT ${1}"
}

function opal:critical {
    opal:log "CRITICAL ${1}"
}

function opal:error {
    opal:log "ERROR ${1}"
}

function opal:warning {
    opal:log "WARNING ${1}"
}

function opal:notice {
    opal:log "NOTICE ${1}"
}

function opal:info {
    opal:log "INFO ${1}"
}

function opal:debug {
    opal:log "DEBUG ${1}"
}

function opal:log {
    local level="$1"
    local message="$2"

    local date_format="+%Y-%m-%dT%H:%M:%S%z"
    local log_date=$(date ${date_format})

    echo "${log_date} ${level} ${message}"
}
