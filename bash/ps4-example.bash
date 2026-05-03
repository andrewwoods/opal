#!/usr/bin/env bash

#
# This is a test script for when you want to experiment with
# changing the value of PS4 prompt, which is used in debugging
# bash script. It also demonstrates how to enable and disable
# debug mode.
#
# NOTE: To limit the amount of noise in the debugging output,
# enable debugging on the line before your function, and disable
# it on the after your function - as opposed to the top and bottom
# of your script.
#

# Every Script I write should include this
source ~/opal/bash/core.bash

# switch on debugging
set -x

# define a simple function
main() {
   echo "The first line"
   opal:message "The second line is the message"
   level_one
   echo "The last line"
}

level_one() {
    echo "This starts level one"
    level_two
    echo "This ends level one"
}

level_two() {
    echo "Two levels deep."
}

# a normal statement
echo something normal

# function call
main

# a pipeline of commands running in a subshell
( ls -l | grep -v '^d' )

# switch off debugging
set +x

opal:success "Complete!"

