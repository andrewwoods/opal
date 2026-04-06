
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

#
# Return the path to the directory $XDG_DATA_HOME.
#
# There is a single base directory relative to which user-specific data files
# should be written. $XDG_DATA_HOME defines the base directory relative to which
# user-specific data files should be stored.
#
# @return string $directory
#
# @see https://specifications.freedesktop.org/basedir/latest/
#
function opal:xdg_data_dir {
    local data_dir
    local xdg_default="$HOME/.local/share"

    data_dir="${XDG_DATA_HOME:-$xdg_default}"

    opal:ensure_dir_exists "$data_dir"

    echo "$data_dir"
}

#
# Return the path to the directory $XDG_STATE_HOME.
#
# $XDG_STATE_HOME defines the base directory relative to which user-specific
# state files should be stored.
#
# @return string $directory
#
# @see https://specifications.freedesktop.org/basedir/latest/
#
function opal:xdg_state_dir {
    local data_dir
    local xdg_default="$HOME/.local/state"
    local create_dir
    data_dir="${XDG_STATE_HOME:-$xdg_default}"

    opal:ensure_dir_exists "$data_dir"

    echo "$data_dir"
}

#
# Return the directory path to the opal subdirectory under XDG_CACHE_HOME.
#
# @return string $directory
#
# @see https://specifications.freedesktop.org/basedir/latest/
#
function opal:xdg_cache_dir {
    local data_dir
    local xdg_default="$HOME/.cache"
    local create_dir
    data_dir="${XDG_CACHE_HOME:-$xdg_default}"

    opal:ensure_dir_exists "$data_dir"

    echo "$data_dir"
}

#
# Return the directory path defined by XDG_CONFIG_HOME.
#
# $XDG_CONFIG_HOME defines the base directory relative to which user-specific
# configuration files should be stored.
#
# @return string $directory
#
# @see https://specifications.freedesktop.org/basedir/latest/
#
function opal:xdg_config_dir {
    local data_dir
    local xdg_default="$HOME/.config"
    local create_dir
    data_dir="${XDG_CONFIG_HOME:-$xdg_default}"

    opal:ensure_dir_exists "$data_dir"

    echo "$data_dir"
}

#
# Return the directory path to the opal subdirectory under $XDG_DATA_HOME.
#
# @return string $directory
#
# @see opal:xdg_data_dir
#
function opal:data_dir {
    local data_dir

    data_dir="$(opal:xdg_data_dir)"
    if opal:is_unset "$data_dir"; then
        return 1
    fi
    data_dir="${data_dir}/opal"

    opal:ensure_dir_exists "$data_dir"

    echo "$data_dir"
}

#
# Return the directory path to the opal subdirectory under $XDG_DATA_HOME.
#
# @return string $directory
#
# @see opal:xdg_data_dir
#
function opal:state_dir {
    local data_dir

    data_dir="$(opal:xdg_state_dir)"
    if opal:is_unset "$data_dir"; then
        return 1
    fi
    data_dir="${data_dir}/opal"

    opal:ensure_dir_exists "$data_dir"

    echo "$data_dir"
}

#
# Return the directory path to the opal subdirectory under XDG_CACHE_HOME.
#
# @return string $directory
#
# @see opal:xdg_cache_dir
#
function opal:cache_dir {
    local data_dir

    data_dir="$(opal:xdg_cache_dir)"
    if opal:is_unset "$data_dir"; then
        return 1
    fi
    data_dir="${data_dir}/opal"

    opal:ensure_dir_exists "$data_dir"

    echo "$data_dir"
}

#
# Return the directory path to the opal subdirectory under XDG_CONFIG_HOME.
#
# @return string $directory
#
# @see opal:xdg_config_dir
#
function opal:config_dir {
    local data_dir

    data_dir="$(opal:xdg_config_dir)"
    if opal:is_unset "$data_dir"; then
        return 1
    fi
    data_dir="${data_dir}/opal"

    opal:ensure_dir_exists "$data_dir"

    echo "$data_dir"
}
