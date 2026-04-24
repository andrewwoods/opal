#!/usr/bin/env bash
################################################################################
#
# Logging Testing
#
################################################################################

source ~/opal/bash/core.bash
source ~/opal/bash/util.bash
source ~/opal/bash/functions/directory.bash

log_file=''

if opal:is_unset "$1"; then
    opal:std_error "You forgot to write a message for the logger"
    exit 1
fi

opal:message "$1"
if opal:is_unset "$2"; then
    opal:message "The default log file will be used"
    echo "Using default location: $(opal:state_dir)/error.log"
fi

if opal:is_set "$2"; then
    log_file="$2"
    log_dir="$(dirname $log_file)"
    opal:ensure_dir_exists "$log_dir"
fi

opal:log_debug "$1" "$log_file"
opal:log_info "$1" "$log_file"
opal:log_notice "$1" "$log_file"
opal:log_warning "$1" "$log_file"
opal:log_error "$1" "$log_file"
opal:log_critical "$1" "$log_file"
opal:log_alert "$1" "$log_file"
opal:log_emergency "$1" "$log_file"

