#
# Developer related functions
#
################################################################################

#
# check_site - determine if a website is available yet. keep checking until it is
#
# @param String $url the address of the website you want to check
# @param Integer $interval the number of seconds to wait
#
function check_site() {
    declare -i i=0

    if opal:is_unset "$2"; then
        # set the default interval, in seconds
        interval=10
    else
        interval=$2
    fi

    # the -m option limits a connection attempt to  number of seconds on OS X
    while ! curl -m 5 $1 2>/dev/null; do
        sleep $interval
        ans=$((i % 5))
        if [ $ans == 0 ]; then
            ts=$(date)
            opal:std_error "Still down at $ts "
        fi
        i=$((i + 1))
        echo -n "."
    done

    opal:speak 'OK! The site is up now!'
}

#
# htstatus - lookup the http status code by number to refresh your memory
#
# @param Integer $code the numeric status code. e.g. 200
#
# Examples:
#
# $ htstatus 200
#
# $ htstatus 416
#
function htstatus() {
    grep -A 1 ^$1 $OPAL_DIR/data/http-status-codes.txt
    echo " "
    echo "see http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html for more information"
}

#
# parse_git_branch - get the current git branch your on
#
function parse_git_branch() {
    branch_name=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    # @todo Trim white space.
    branch_name=$(echo -n "${branch_name}")

    if opal:is_set "$branch_name"; then
        echo -n "$branch_name"
    fi
}

#
# sha1 - Create a SHA1 digest of a file
#
# @param String $filename the filename for which you want to know/generate it's sha1
#
function sha1() {
    if opal:is_set "$(which openssl)"; then
        openssl sha1 "$@"
    else
        opal:std_error "openssl is required, but not installed"
    fi
}

#
# traceurl - decode/unfurl a short url recursively to it's final destination
#
# @param String $url the address of the website you want to check
#
function traceurl() {
    if opal:is_set "$1"; then
        curl --location --head $1
    else
        opal:std_error 'Whoops! You forgot to specify a short URL'
    fi
}

#
# calc_time_diff - Calculate the duration of two epoch times.
#
# @param int start_time
# @param int end_time
#
function calc_time_diff() {
    if opal:is_unset "$1"; then
        opal:std:error "What is your start time in epoch seconds (UNIX time)"
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

    let seconds=0
    let minutes=0
    let hours=0
    let days=0
    let temp=0

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

    opal:message "${days} days ${hours} hours ${minutes} minutes ${seconds} seconds"
}
