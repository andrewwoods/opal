#!/usr/bin/env bash

## Enable Debugging Output.
#set -x

## Abort on errors.
set -e

## Detect unset variable usages
#set -u

## Abort on errors in a command line pipe e.g. cmd1 | cmd2 | cmd3
set -o pipefail

source ~/opal/bash/core.bash
# @todo Add any needed additional bash library functions.

function cmd:usage {
    local script
    script="$1"

    cat << HELP_MESSAGE

${script} [OPTION]... [FILE]...

This is my script template.

Options:
   -q, --quiet             Quiet (no output)
   -h, --help              Display this help and exit
   -v, --version           Output version information and exit

HELP_MESSAGE
}

##
## cmd:cleanup Function
##
## Any actions that should be taken if the script is prematurely
## exited. Always call this function at the top of your script.
##
function cmd:cleanup() {
    #
    # @todo Add operations you need to close/cleanup before exiting.
    #
    echo ""
    opal:message "Cleaned up."  # Edit this if you like.

    exit 1
}

##
## Exit this script.
##
function cmd:exit  {
   opal:message "Exiting safely"
   exit 0
}

##
## The starting point for your script.
##
function cmd:main() {
    #
    # @todo Add your program logic here.
    #

    return 0
}


##
## Sets script version.
##
## @see https://semver.org/
##
version="1.0.0"

##
## Read the location of this script.
##
script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

##
## Read the name of this script.
##
script_name="$( basename "${BASH_SOURCE[0]}")"


# Trap bad exits with your cleanup function
trap cmd:cleanup SIGHUP SIGINT SIGQUIT SIGABRT

##
## Set Flags.
##
## Flags which can be overridden by user input.
## Default values are below
##
quiet=0
strict=0
args=()
options=()


##
## Parse options and arguments.
##

# Iterate over options breaking -ab into -a -b when needed and --foo=bar into
# --foo bar
optstring=h
unset options
while (($#)); do
    case $1 in
        # If option is of type -ab
        -[!-]?*)
            # Loop over each character starting with the second
            for ((i=1; i < ${#1}; i++)); do
                c=${1:i:1}

                # Add current char to options
                options+=("-$c")

                # If option takes a required argument, and it's not the last char make
                # the rest of the string its argument
                if [[ $optstring = *"$c:"* && ${1:i+1} ]]; then
                    options+=("${1:i+1}")
                    break
                fi
            done
            ;;

        # If option is of type --foo=bar
        --?*=*) options+=("${1%%=*}" "${1#*=}") ;;
        # add --endopts for --
        --) options+=(--endopts) ;;
        # Otherwise, nothing special
        *) options+=("$1") ;;
    esac
    shift
done
set -- "${options[@]}"
unset options

# Print help if no arguments were passed.
# Uncomment to force arguments when invoking the script
#[[ $# -eq 0 ]] && set -- "--help"

# Read the options and set stuff
while [[ $1 = -?* ]]; do
    case $1 in
        -h|--help)
           cmd:usage "${script_name}" >&2;
           cmd:exit
             ;;
        --version)
           opal:label "${script_name} ${version}";
           cmd:exit
            ;;
        -q|--quiet)
            quiet=1
            ;;
        --endopts)
            shift;
            break
            ;;
        *) die "invalid option: '$1'." ;;
    esac
    shift
done

# Store the remaining part as arguments.
args+=("$@")

#
# ====[ Run Your Script ]====
#

# Run your main function and pass your arguments
cmd:main

