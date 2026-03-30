
################################################################################
#
# Directory Functions
#
################################################################################


#
# cdls - change to a directory and list its content
#
# @param String $directory
#
function opal:cdls {
    cd "$1" && ls -F --color=auto
}

#
# lsd - get a recursive list of all directories under 'directory'.
#   defaults to cwd.
#
# @param String $directory the directory for which you want to recursively list
#   the contents.
#
function opal:lsd {
    if [[ $1 ]]; then
        dir=$1
    else
        dir="."
    fi

    find $dir -type d \
      | grep -v '/.git/' \
      | grep -v '/.node_modules/' \
      | grep -v '/vendor/'
}

#
# mkcd - make a directory and go into it. For more than one directory
#        go into the last one
#
# @param String $directory
#
function opal:mkcd {
    last="${@: -1}"
    mkdir -p "$@" && cd "${last}"
}

