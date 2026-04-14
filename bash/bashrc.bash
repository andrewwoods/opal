#
# bashrc.bash - provide suggested settings when bash shell is created
#
################################################################################

alias reload=". ~/.bashrc"

##
##  Opal Prefixed Functions
##
##  This subset of opal: prefix functions are aliased to make them
##  easier to use on the command line.
##
alias bak="opal:bak"
alias cdls="opal:cdls"
alias desc="opal:describe"
alias mkcd="opal:mkcd"
alias numseg="opal:numseg"
alias seg="opal:seg"
alias show="opal:show"
alias today="opal:today"
alias touchx="opal:touchx"
alias up="opal:up"

# @NOTE: the 'locate' command exists on many systems, hence the use of 'loc'
alias loc="opal:locate"
