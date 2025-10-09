#
# Developer related functions
#
################################################################################

#
#  check_site - determine if a website is available yet. keep checking until it is
#
#  @param String $url the address of the website you want to check
#  @param Integer $interval the number of seconds to wait
#
function opal:check_site() {
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
function opal:http_status {
    grep -A 1 ^$1 $OPAL_DIR/data/http-status-codes.txt
    echo " "
    echo "see http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html for more information"
}

#
# opal:parse_git_branch - get the current git branch your on
#
function opal:parse_git_branch {
    local branch_name
    branch_name="$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"
    # @todo Trim white space.
    branch_name="$(echo -n "${branch_name}")"

    if opal:is_set "$branch_name"; then
        echo -n "$branch_name"
    fi
}


#
# traceurl - decode/unfurl a short url recursively to it's final destination
#
# @param String $url the address of the website you want to check
#
function opal:trace_url() {
    if opal:is_set "$1"; then
        curl --location --head $1
    else
        opal:std_error 'Whoops! You forgot to specify a short URL'
    fi
}

